package com.anitomo.dao;


import com.anitomo.dto.OrderDTO;
import com.anitomo.dto.UserDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;

@Repository
public class OrderDAO
{
    private SqlSession session;
    private String namespace = "com.anitomo.dao.OrderDAO.";

    public OrderDAO(SqlSession session)
    {
        this.session = session;
    }

    @Transactional
    public Integer makeOrder(OrderDTO orderDTO)
    {
        return session.insert(namespace+"makeOrder",orderDTO);
    }

    @Transactional
    public Integer makeOrderDetail(OrderDTO orderDTO)
    {
        return session.insert(namespace+"makeOrderDetail",orderDTO);
    }

    @Transactional
    public String getMyOrderCode(OrderDTO orderDTO)
    {
        return session.selectOne(namespace+"getMyOrderCode", orderDTO);
    }

    public List<OrderDTO> getOrderList(HashMap<String,Object> paramMap)
    {
        return session.selectList(namespace+"getOrderList",paramMap);
    }

    public List<OrderDTO> getOrderDetailList(HashMap<String, Object> paramMap)
    {
        return session.selectList(namespace+"getOrderDetailList",paramMap);
    }

    public Integer deleteOrder(String orderCode)
    {
        return session.update(namespace+"deleteOrder",orderCode);
    }

    public Integer updateOrder(HashMap<String, String> orderUpdateMap)
    {
        return session.update(namespace+"updateOrder", orderUpdateMap);
    }

    public List<String> getOrderDateList(HashMap<String, Object> paramMap)
    {
        return session.selectList(namespace+"getOrderDateList",paramMap);
    }
}


