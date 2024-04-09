package com.anitomo.controller;


import com.anitomo.dto.CartDTO;
import com.anitomo.dto.ImageDTO;
import com.anitomo.dto.UserDTO;
import com.anitomo.service.CartService;
import com.anitomo.service.ItemService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("/cart")
@Slf4j
public class CartController
{

    private CartService cartService;
    private ItemService itemService;

    public CartController(CartService cartService, ItemService itemService)
    {
        this.itemService = itemService;
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
    public HashMap<String,Object> getCartMap(HttpSession session)
    {
        UserDTO loginUser = (UserDTO)session.getAttribute("loginUser");
        List<CartDTO> cartList = cartService.getCartList(loginUser);
        List<ImageDTO> thumbnailList = itemService.getThumbnailList();

        HashMap<String,Object> cartMap = new HashMap<>();
        cartMap.put("cartList",cartList);
        cartMap.put("thumbnailList",thumbnailList);

        return cartMap;
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
