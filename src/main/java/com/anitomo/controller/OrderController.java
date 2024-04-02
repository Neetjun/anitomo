package com.anitomo.controller;

import com.anitomo.dto.*;
import com.anitomo.service.CartService;
import com.anitomo.service.ItemService;
import com.anitomo.service.OrderService;
import com.anitomo.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/order")
@Slf4j
public class OrderController
{
    private ItemService itemService;
    private OrderService orderService;
    private UserService userService;
    private CartService cartService;

    public OrderController(ItemService itemService, OrderService oRderService, UserService userService, CartService cartService)
    {
        this.itemService = itemService;
        this.orderService = oRderService;
        this.userService = userService;
        this.cartService = cartService;
    }
    
    // 주문 페이지
    @GetMapping
    public String showOrderForm(String[] itemCodeList, Integer[] itemQuantityList, boolean cartOrder, RedirectAttributes ra, Model model, HttpSession session)
    {

        List<Object[]> orderInfoList = new ArrayList<>();
        UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");

        if(loginUser == null)
        {
            ra.addFlashAttribute("errorType", "loginRequired");
            return "redirect:/";
        }
        UserDTO userDTO = userService.showUserInfo(loginUser);

        for (int i = 0; i < itemCodeList.length; i++)
        {
            String itemCode = itemCodeList[i];

            ItemDTO itemDTO = itemService.showItemDetail(itemCode);
            Integer quantity = itemQuantityList[i];

            Object[] orderInfo = {itemDTO, quantity};

            orderInfoList.add(orderInfo);
        }

        model.addAttribute("orderInfoList",orderInfoList);
        model.addAttribute("userInfo",userDTO);
        model.addAttribute("cartOrder",cartOrder);

        return "orderForm";
    }

    // 주문 페이지 배송지 불러오기
    @GetMapping("address")
    @ResponseBody
    public AddressDTO drawAddress(String addressCode, HttpSession session)
    {
        UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");

        AddressDTO addressDTO;

        if(addressCode.equals(""))
            addressDTO = userService.getDefaultAddress(loginUser);
        else
            addressDTO = userService.getAddress(addressCode);

        return addressDTO;
    }

    // 주문하기
    @PostMapping
    public String makeOrder(OrderDTO orderDTO, boolean cartOrder, HttpSession session)
    {
        String resultMessage = "";
        String resultPage = "";

        UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");

        orderDTO.setUserCode(loginUser.getUserCode());
        orderDTO.setUserId(loginUser.getUserId());

        resultMessage = orderService.makeOrder(orderDTO);

        if (resultMessage != "success")
        {
            resultPage = "err";
            return resultPage;
        }

        // 주문이 장바구니로부터 발생한거라면 장바구니에서 해당 품목들 삭제
        if(cartOrder)
        {
            for(String itemCode : orderDTO.getItemCodeArr())
            {
                CartDTO cartDTO = new CartDTO();

                cartDTO.setItemCode(itemCode);
                cartDTO.setUserCode(loginUser.getUserCode());
                cartDTO.setUserId(loginUser.getUserId());

                cartService.deleteCart(cartDTO);
            }
        }
        resultPage = "redirect:/order/result";

        return resultPage;
    }
    
    // 주문 결과 페이지
    @GetMapping("result")
    public String showOrderResult()
    {
        return "orderResultForm";
    }
}
