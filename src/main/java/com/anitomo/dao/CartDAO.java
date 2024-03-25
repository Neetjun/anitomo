package com.anitomo.dao;


import com.anitomo.dto.CartDTO;
import com.anitomo.dto.UserDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository
public class CartDAO
{
    private SqlSession session;
    private String namespace = "com.anitomo.dao.CartDAO.";

    public CartDAO(SqlSession session)
    {
        this.session = session;
    }

    public Integer addCart(CartDTO cartDTO)
    {
        return session.insert(namespace+"addCart", cartDTO);
    }

    public Integer checkDuplication(CartDTO cartDTO)
    {
        return session.selectOne(namespace+"checkDuplication", cartDTO);
    }

    public List<CartDTO> getCartList(UserDTO loginUser)
    {
        return session.selectList("getCartList", loginUser);
    }

    public void updateCart(CartDTO cartDTO)
    {
        session.update("updateCart", cartDTO);
    }

    public void deleteCart(CartDTO cartDTO)
    {
        session.delete(namespace+"deleteCart",cartDTO);
    }
}
