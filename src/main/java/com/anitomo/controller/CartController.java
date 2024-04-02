package com.anitomo.controller;


import com.anitomo.dto.CartDTO;
import com.anitomo.dto.UserDTO;
import com.anitomo.service.CartService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/cart")
@Slf4j
public class CartController
{

    private CartService cartService;

    public CartController(CartService cartService)
    {
        this.cartService = cartService;
    }

    @GetMapping
    public String showCart(HttpSession session, RedirectAttributes ra)
    {
        UserDTO loginUser;

        // session을 통해 문의 등록 유저 정보 삽입
        try
        {
            loginUser = (UserDTO)session.getAttribute("loginUser");

            if(loginUser == null)
                throw new NullPointerException();
        }
        catch (NullPointerException e)
        {
            ra.addFlashAttribute("errorType", "loginRequired");
            return "redirect:/";
        }
        return "cartForm";
    }

    @GetMapping("list")
    @ResponseBody
    public List<CartDTO> getCartList(HttpSession session)
    {
        UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");
        List<CartDTO> cartList = cartService.getCartList(loginUser);

        return cartList;
    }

    @PostMapping
    @ResponseBody
    public String addCart(@RequestBody CartDTO cartDTO)
    {
        String resultMessage = cartService.addCart(cartDTO);

        return resultMessage;
    }

    @PostMapping("update")
    @ResponseBody
    public void updateCart(@RequestBody CartDTO cartDTO, HttpSession session)
    {
        UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");
        cartDTO.setUserCode(loginUser.getUserCode());
        cartDTO.setUserId(loginUser.getUserId());
        cartService.updateCart(cartDTO);
    }

    @PostMapping("delete")
    @ResponseBody
    public void deleteCart(@RequestBody CartDTO cartDTO, HttpSession session)
    {
        UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");
        cartDTO.setUserCode(loginUser.getUserCode());
        cartDTO.setUserId(loginUser.getUserId());
        cartService.deleteCart(cartDTO);
    }
}
