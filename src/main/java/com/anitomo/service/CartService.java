package com.anitomo.service;

import com.anitomo.dto.CartDTO;
import com.anitomo.dto.UserDTO;

import java.util.List;

public interface CartService
{
    String addCart(CartDTO cartDTO);

    List<CartDTO> getCartList(UserDTO loginUser);

    void updateCart(CartDTO cartDTO);

    void deleteCart(CartDTO cartDTO);
}
