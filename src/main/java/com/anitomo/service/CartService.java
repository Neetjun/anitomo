package com.anitomo.service;


import com.anitomo.dao.CartDAO;
import com.anitomo.dto.CartDTO;
import com.anitomo.dto.UserDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
@Slf4j
public class CartService
{
    CartDAO cartDAO;

    public CartService(CartDAO cartDAO)
    {
        this.cartDAO = cartDAO;
    }

    public String addCart(CartDTO cartDTO)
    {
        Integer duplicationCount = cartDAO.checkDuplication(cartDTO);
        Integer addCount;
        String resultMessage;

        try
        {
            // 이미 카트에 추가된 물품인 경우엔 추가 x
            if(duplicationCount >= 1 )
            {
                resultMessage = "duplication";
                return resultMessage;
            }

            log.info(cartDTO.toString());

            if(cartDTO.getUserId().equals("") || cartDTO.getUserCode().equals(""))
                throw new NullPointerException();
            else
                addCount = cartDAO.addCart(cartDTO);

            if (addCount == 1)
                resultMessage = "success";
            else
                resultMessage = "fail";

            log.info("resultMessage = {}", resultMessage);

            return  resultMessage;
        }
        catch (NullPointerException e)
        {
            resultMessage = "loginRequired";

            log.info("resultMessage = {}", resultMessage);

            return resultMessage;
        }
    }


    public List<CartDTO> getCartList(UserDTO loginUser)
    {
        return cartDAO.getCartList(loginUser);
    }

    public void updateCart(CartDTO cartDTO)
    {
        cartDAO.updateCart(cartDTO);
    }

    public void deleteCart(CartDTO cartDTO)
    {
        cartDAO.deleteCart(cartDTO);
    }
}
