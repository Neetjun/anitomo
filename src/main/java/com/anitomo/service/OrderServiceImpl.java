package com.anitomo.service;

import com.anitomo.dao.OrderDAO;
import com.anitomo.dto.OrderDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;

@Service
@Slf4j
public class OrderServiceImpl implements OrderService
{
    OrderDAO orderDAO;

    public OrderServiceImpl(OrderDAO orderDAO)
    {
        this.orderDAO = orderDAO;
    }

    @Override
    @Transactional
    public String makeOrder(OrderDTO orderDTO)
    {
        String resultMessage = "";

        String paymentMethod = orderDTO.getPaymentMethod();

        // 결제수단에 따른 주문상태 세팅
        if(paymentMethod.equals("deposit"))
            orderDTO.setOrderStatusCode("OS1");
        else if(paymentMethod.equals("card") || paymentMethod.equals("transfer"))
            orderDTO.setOrderStatusCode("OS2");
        else
        {
            resultMessage = "paymentMethodErr";
            return resultMessage;
        }
        // 주문 테이블 데이터 입력
        Integer orderResult = orderDAO.makeOrder(orderDTO);

        if (orderResult != 1)
        {
            resultMessage = "orderErr";
            return resultMessage;
        }

        // 주문 상세 테이블 데이터 입력
        Integer orderDetailResult;

        // 주문에 담긴 상품코드,가격,수량 배열 얻기
        String[] itemCodeArr = orderDTO.getItemCodeArr();
        String[] itemNameArr = orderDTO.getItemNameArr();
        String[] itemPriceArr = orderDTO.getItemPriceArr();
        String[] orderQuantityArr = orderDTO.getOrderQuantityArr();

        String orderCode = orderDAO.getMyOrderCode(orderDTO);
        orderDTO.setOrderCode(orderCode);;

        for(int i = 0; i < itemCodeArr.length; i++)
        {
            String itemCode = itemCodeArr[i];
            String itemName = itemNameArr[i];
            String itemPrice = itemPriceArr[i];
            String orderQuantity = orderQuantityArr[i];

            orderDTO.setItemCode(itemCode);
            orderDTO.setItemName(itemName);
            orderDTO.setItemPrice(itemPrice);
            orderDTO.setOrderQuantity(orderQuantity);

            orderDetailResult = orderDAO.makeOrderDetail(orderDTO);

            if(orderDetailResult != 1)
            {
                resultMessage = "detailErr";
                return resultMessage;
            }
        }

        resultMessage = "success";

        return  resultMessage;
    }

    @Override
    public List<OrderDTO> getOrderList(HashMap<String, Object> paramMap)
    {
        List<OrderDTO> orderList = orderDAO.getOrderList(paramMap);

        return orderList;
    }

    @Override
    public List<OrderDTO> getOrderDetailList(HashMap<String, Object> paramMap)
    {
        List<OrderDTO> orderDetailList = orderDAO.getOrderDetailList(paramMap);
        return orderDetailList;
    }

    @Override
    public String deleteOrder(String orderCode)
    {
        String resultMessage = "";
        Integer result = orderDAO.deleteOrder(orderCode);

        if(result == 1)
            resultMessage = "success";
        else
            resultMessage = "fail";

        return resultMessage;
    }

    @Override
    public String updateOrder(String orderCode, String mode)
    {
        String resultMessage = "";

        String orderStatusCode = "";

        if(mode.equals("cancel"))
            orderStatusCode = "OS9";
        else if(mode.equals("refund"))
            orderStatusCode = "OS7";

        HashMap<String,String> orderUpdateMap = new HashMap<String,String>();

        orderUpdateMap.put("orderCode", orderCode);
        orderUpdateMap.put("orderStatusCode", orderStatusCode);

        Integer result = orderDAO.updateOrder(orderUpdateMap);

        if(result == 1)
            resultMessage = "success";
        else
            resultMessage = "fail";

        return resultMessage;
    }

    @Override
    public List<String> getOrderDateList(HashMap<String, Object> paramMap)
    {
        List<String> orderDateList = orderDAO.getOrderDateList(paramMap);
        return orderDateList;
    }
}