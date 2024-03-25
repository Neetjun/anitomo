package com.anitomo.dto;

public class CartDTO
{
    String userCode, userId, itemCode, itemName, itemPrice, cartQuantity;

    @Override
    public String toString()
    {
        return "CartDTO{" +
                "userCode='" + userCode + '\'' +
                ", userId='" + userId + '\'' +
                ", itemCode='" + itemCode + '\'' +
                ", itemName='" + itemName + '\'' +
                ", itemPrice='" + itemPrice + '\'' +
                ", cartQuantity='" + cartQuantity + '\'' +
                '}';
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

    public String getCartQuantity()
    {
        return cartQuantity;
    }

    public void setCartQuantity(String cartQuantity)
    {
        this.cartQuantity = cartQuantity;
    }
}
