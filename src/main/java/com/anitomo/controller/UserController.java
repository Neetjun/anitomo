package com.anitomo.controller;

import com.anitomo.dto.AddressDTO;
import com.anitomo.dto.OrderDTO;
import com.anitomo.dto.ReviewDTO;
import com.anitomo.dto.UserDTO;
import com.anitomo.service.OrderService;
import com.anitomo.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("/user")
@Slf4j
public class UserController
{
    private UserService userService;
    private OrderService orderService;

    public UserController(UserService userService, OrderService orderService)
    {
        this.userService = userService;
        this.orderService = orderService;
    }

    // 회원가입 폼
    @GetMapping
    public String userRegister()
    {
        return "userRegistrationForm";
    }

    // 회원가입
    @PostMapping
    public String userRegister(UserDTO userDTO, RedirectAttributes ra)
    {
        String result = userService.registerUser(userDTO);

        if(result.equals("success"))
            return "redirect:/user/result";
        else
        {
            ra.addFlashAttribute("errorType", "userRegistrationError");
            return "redirect:/";
        }

    }

    // 회원가입 결과 페이지
    @GetMapping("result")
    public String showUserRegisterResult()
    {
        return "userRegistrationResult";
    }

    // 아이디 중복검사
    @GetMapping("idcheck")
    @ResponseBody
    public String checkId(@RequestParam String userId)
    {
        String result;

        result = userService.checkId(userId);

        return result;
    }

    // 비밀번호 유효성 검사
    @GetMapping("pwcheck")
    @ResponseBody
    public String checkPw(@RequestParam String userPw)
    {
        String result;

        result = userService.checkPw(userPw);

        return result;
    }

    // 로그인 폼
    @GetMapping("login")
    public String login(HttpServletRequest request, HttpSession session)
    {
        String referer = request.getHeader("referer");

        if(session.getAttribute("referer") == null)
            session.setAttribute("referer", referer);


        return "loginForm";
    }

    // 로그인
    @PostMapping("login")
    public String login(UserDTO userDTO, HttpSession session, RedirectAttributes ra)
    {
        UserDTO loginUser = userService.login(userDTO);

        if(loginUser == null)
        {
            ra.addFlashAttribute("errorType", "loginError");
            return "redirect:/user/login";
        }
        else
        {
            session.setAttribute("loginUser",loginUser);
            return "redirect:" + session.getAttribute("referer");
        }
    }

    // 로그아웃
    @GetMapping("logout")
    public String logout(HttpSession session, HttpServletRequest request)
    {
        session.invalidate();

        return "redirect:"+request.getHeader("referer");
    }
    
    // 마이페이지
    @GetMapping("mypage/{page}")
    public String showMyPage(HttpSession session, Model model, RedirectAttributes ra, @PathVariable String page, String reviewOrderCode)
    {
        try
        {
            UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");
            HashMap<String,Object> paramMap = new HashMap<String,Object>();
            paramMap.put("page",page);

            if(loginUser == null)
                throw new NullPointerException();

            if(page.equals("orderlist") || page.equals("reviewlist"))
            {
                paramMap.put("loginUser",loginUser);

                List<OrderDTO> orderList = orderService.getOrderList(paramMap);
                List<String> orderDateList = orderService.getOrderDateList(paramMap);
                HashMap<String, Integer> reviewCountMap = new HashMap<String, Integer>();
                HashMap<String, List> orderDetailMap = new HashMap<String, List>();

                for (OrderDTO orderDTO : orderList)
                {
                    String orderCode = orderDTO.getOrderCode();

                    if(page.equals("reviewlist"))
                        reviewCountMap.put(orderCode,userService.getReviewCount(orderDTO));

                    paramMap.put("order",orderDTO);

                    List<OrderDTO> orderItemList = orderService.getOrderDetailList(paramMap);

                    orderDetailMap.put(orderCode,orderItemList);
                }

                model.addAttribute("orderList", orderList);
                model.addAttribute("orderDateList",orderDateList);
                model.addAttribute("orderDetailMap",orderDetailMap);
                model.addAttribute("reviewCountMap", reviewCountMap);

                paramMap.clear();
            }
            else if(page.equals("review"))
            {
                paramMap.put("orderCode",reviewOrderCode);
                List<OrderDTO> orderItemList = orderService.getOrderDetailList(paramMap);
                model.addAttribute("orderItemList", orderItemList);
                model.addAttribute("orderCode", reviewOrderCode);
            }

        }
        catch (NullPointerException e)
        {
            ra.addFlashAttribute("errorType", "loginRequired");
            return "redirect:/";
        }

        model.addAttribute("page",page);

        return "mypage";
    }

    // 주문내역 삭제 및 취소, 환불 요청
    @PostMapping("orderlist")
    public String editOrderList(String orderCode, String mode)
    {
        log.info(mode);
        String resultMessage = "";

        if(mode.equals("delete"))
            resultMessage = orderService.deleteOrder(orderCode);
        else if(mode.equals("cancel") || mode.equals("refund"))
            resultMessage = orderService.updateOrder(orderCode, mode);

        return "redirect:/user/mypage/orderlist";
    }

    // 리뷰 등록 및 수정, 삭제
    @PostMapping("review")
    @ResponseBody
    public String postReview(@RequestBody MultipartFile[] fileArr, ReviewDTO reviewDTO, String[] deleteFileArr, String mode, HttpSession session)
    {
        UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");

        reviewDTO.setUserCode(loginUser.getUserCode());
        reviewDTO.setUserId(loginUser.getUserId());

        log.info(mode);

        if(mode == null)
            userService.postReview(reviewDTO, fileArr);
        else if(mode.equals("update"))
            userService.updateReview(reviewDTO,fileArr,deleteFileArr);
        else if(mode.equals("delete"))
            userService.deleteReview(reviewDTO);

        log.info("postReview 통과");

        String orderCode = reviewDTO.getOrderCode();

        return orderCode;
    }

    // 리뷰 폼
    @GetMapping("/review/{orderCode}")
    public String showReview(@PathVariable String orderCode, Model model)
    {
        ReviewDTO reviewDTO = userService.getReview(orderCode);
        List<Integer> rateList = userService.getRate(reviewDTO.getReviewCode());

        model.addAttribute("review",reviewDTO);
        model.addAttribute("rateList",rateList);
        model.addAttribute("reviewCode",reviewDTO.getReviewCode());
        model.addAttribute("fileList", userService.getReviewImageList(reviewDTO.getReviewCode()));

        return "forward:/user/mypage/review?reviewOrderCode="+reviewDTO.getOrderCode();
    }

    // 배송지 목록
    @GetMapping("mypage/address")
    public String showAddressListPage(String order, Model model, HttpSession session)
    {
        try
        {
            UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");

            List<AddressDTO> addressList = userService.getAddressList(loginUser);

            model.addAttribute("addressList", addressList);

            if(order.equals("true"))
                model.addAttribute("order",order);
        }
        catch (NullPointerException e)
        {
            return "addressPage";
        }
        return "addressPage";
    }

    // 배송지 등록 및 수정 페이지
    @GetMapping("address")
    public String showAddressEditForm(String order, String mode, String addressCode, Model model)
    {
        AddressDTO addressDTO = null;

        if(mode.equals("update"))
        {
            addressDTO = userService.getAddress(addressCode);
            model.addAttribute("address",addressDTO);
        }

        model.addAttribute("order",order);
        model.addAttribute("mode", mode);

        return "addressEditForm";
    }

    // 배송지 등록 및 수정
    @PostMapping("address")
    public String postAddress(String mode, String order, AddressDTO addressDTO, HttpSession session)
    {
        try
        {
            UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");

            if(loginUser != null)
            {
                addressDTO.setUserCode(loginUser.getUserCode());
                addressDTO.setUserId(loginUser.getUserId());

                if(mode.equals("new"))
                    userService.addAddress(addressDTO);
                else if(mode.equals("update"))
                    userService.updateAddress(addressDTO);
                else if(mode.equals("delete"))
                    userService.deleteAddress(addressDTO);
            }
            else
                throw new NullPointerException();
        }
        catch (NullPointerException e)
        {
            return "redirect:/user/mypage/address?order="+order;
        }

        return "redirect:/user/mypage/address?order="+order;
    }
}
