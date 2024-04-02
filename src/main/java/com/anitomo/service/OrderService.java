package com.anitomo.service;

import com.anitomo.dto.OrderDTO;

import java.util.HashMap;
import java.util.List;

public interface OrderService
{
    String makeOrder(OrderDTO orderDTO);

    List<OrderDTO> getOrderList(HashMap<String, Object> loginUser);

    List<OrderDTO> getOrderDetailList(HashMap<String, Object> orderCode);

    String deleteOrder(String orderCode);

    String updateOrder(String orderCode, String mode);

    List<String> getOrderDateList(HashMap<String, Object> loginUser);
}
