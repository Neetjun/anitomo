package com.anitomo.dto;

import java.util.Arrays;

public class OrderDTO
{
    String orderCode, orderStatusCode, orderStatus, itemCode, itemName, itemPrice, orderQuantity, orderDate, paymentMethod, userCode, userId, addressCode;
    String[] itemCodeArr, itemNameArr, itemPriceArr, orderQuantityArr;

    @Override
    public String toString()
    {
        return "OrderDTO{" +
                "orderCode='" + orderCode + '\'' +
                ", orderStatusCode='" + orderStatusCode + '\'' +
                ", orderStatus='" + orderStatus + '\'' +
                ", itemCode='" + itemCode + '\'' +
                ", itemName='" + itemName + '\'' +
                ", itemPrice='" + itemPrice + '\'' +
                ", orderQuantity='" + orderQuantity + '\'' +
                ", orderDate='" + orderDate + '\'' +
                ", paymentMethod='" + paymentMethod + '\'' +
                ", userCode='" + userCode + '\'' +
                ", userId='" + userId + '\'' +
                ", addressCode='" + addressCode + '\'' +
                ", itemCodeArr=" + Arrays.toString(itemCodeArr) +
                ", itemNameArr=" + Arrays.toString(itemNameArr) +
                ", itemPriceArr=" + Arrays.toString(itemPriceArr) +
                ", orderQuantityArr=" + Arrays.toString(orderQuantityArr) +
                '}';
    }

    public String getOrderCode()
    {
        return orderCode;
    }

    public void setOrderCode(String orderCode)
    {
        this.orderCode = orderCode;
    }

    public String getOrderStatusCode()
    {
        return orderStatusCode;
    }

    public void setOrderStatusCode(String orderStatusCode)
    {
        this.orderStatusCode = orderStatusCode;
    }

    public String getOrderStatus()
    {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus)
    {
        this.orderStatus = orderStatus;
    }

    public String getItemCode()
    {
        return itemCode;
    }

    public void setItemCode(String itemCode)
    {
        this.itemCode = itemCode;
    }

    public String getItemName()
    {
        return itemName;
    }

    public void setItemName(String itemName)
    {
        this.itemName = itemName;
    }

    public String getItemPrice()
    {
        return itemPrice;
    }

    public void setItemPrice(String itemPrice)
    {
        this.itemPrice = itemPrice;
    }

    public String getOrderQuantity()
    {
        return orderQuantity;
    }

    public void setOrderQuantity(String orderQuantity)
    {
        this.orderQuantity = orderQuantity;
    }

    public String getOrderDate()
    {
        return orderDate;
    }

    public void setOrderDate(String orderDate)
    {
        this.orderDate = orderDate;
    }

    public String getPaymentMethod()
    {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod)
    {
        this.paymentMethod = paymentMethod;
    }

    public String getUserCode()
    {
        return userCode;
    }

    public void setUserCode(String userCode)
    {
        this.userCode = userCode;
    }

    public String getUserId()
    {
        return userId;
    }

    public void setUserId(String userId)
    {
        this.userId = userId;
    }

    public String getAddressCode()
    {
        return addressCode;
    }

    public void setAddressCode(String addressCode)
    {
        this.addressCode = addressCode;
    }

    public String[] getItemCodeArr()
    {
        return itemCodeArr;
    }

    public void setItemCodeArr(String[] itemCodeArr)
    {
        this.itemCodeArr = itemCodeArr;
    }

    public String[] getItemNameArr()
    {
        return itemNameArr;
    }

    public void setItemNameArr(String[] itemNameArr)
    {
        this.itemNameArr = itemNameArr;
    }

    public String[] getItemPriceArr()
    {
        return itemPriceArr;
    }

    public void setItemPriceArr(String[] itemPriceArr)
    {
        this.itemPriceArr = itemPriceArr;
    }

    public String[] getOrderQuantityArr()
    {
        return orderQuantityArr;
    }

    public void setOrderQuantityArr(String[] orderQuantityArr)
    {
        this.orderQuantityArr = orderQuantityArr;
    }
}