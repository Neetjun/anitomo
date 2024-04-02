package com.anitomo.service;


import com.anitomo.dao.CartDAO;
import com.anitomo.dto.CartDTO;
import com.anitomo.dto.UserDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class CartServiceImpl implements CartService
{
    CartDAO cartDAO;

    public CartServiceImpl(CartDAO cartDAO)
    {
        this.cartDAO = cartDAO;
    }

    @Override
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
            
            // 비회원이 장바구니 담기를 클릭한 경우
            if(cartDTO.getUserId().equals("") || cartDTO.getUserCode().equals(""))
                throw new NullPointerException();
            else
                addCount = cartDAO.addCart(cartDTO);

            if (addCount == 1)
                resultMessage = "success";
            else
                resultMessage = "fail";


            return  resultMessage;
        }
        catch (NullPointerException e)
        {
            resultMessage = "loginRequired";

            return resultMessage;
        }
    }


    @Override
    public List<CartDTO> getCartList(UserDTO loginUser)
    {
        return cartDAO.getCartList(loginUser);
    }

    @Override
    public void updateCart(CartDTO cartDTO)
    {
        cartDAO.updateCart(cartDTO);
    }

    @Override
    public void deleteCart(CartDTO cartDTO)
    {
        cartDAO.deleteCart(cartDTO);
    }
}
