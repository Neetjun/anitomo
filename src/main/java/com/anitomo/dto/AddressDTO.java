package com.anitomo.dto;

import java.util.Arrays;

public class AddressDTO
{
    String addressCode, recipient, recipientTel, deliveryMessage, defaultDeliveryAddress, address, userCode, userId;
    String[] recipientTelArr, addressArr;

    @Override
    public String toString()
    {
        return "AddressDTO{" +
                "addressCode='" + addressCode + '\'' +
                ", recipient='" + recipient + '\'' +
                ", recipientTel='" + recipientTel + '\'' +
                ", deliveryMessage='" + deliveryMessage + '\'' +
                ", defaultDeliveryAddress='" + defaultDeliveryAddress + '\'' +
                ", address='" + address + '\'' +
                ", userCode='" + userCode + '\'' +
                ", userId='" + userId + '\'' +
                ", recipientTelArr=" + Arrays.toString(recipientTelArr) +
                ", addressArr=" + Arrays.toString(addressArr) +
                '}';
    }

    public String getAddressCode()
    {
        return addressCode;
    }

    public void setAddressCode(String addressCode)
    {
        this.addressCode = addressCode;
    }

    public String getRecipient()
    {
        return recipient;
    }

    public void setRecipient(String recipient)
    {
        this.recipient = recipient;
    }

    public String getRecipientTel()
    {
        return recipientTel;
    }

    public void setRecipientTel(String recipientTel)
    {
        this.recipientTel = recipientTel;
    }

    public String getDeliveryMessage()
    {
        return deliveryMessage;
    }

    public void setDeliveryMessage(String deliveryMessage)
    {
        this.deliveryMessage = deliveryMessage;
    }

    public String getDefaultDeliveryAddress()
    {
        return defaultDeliveryAddress;
    }

    public void setDefaultDeliveryAddress(String defaultDeliveryAddress)
    {
        this.defaultDeliveryAddress = defaultDeliveryAddress;
    }

    public String getAddress()
    {
        return address;
    }

    public void setAddress(String address)
    {
        this.address = address;
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

    public String[] getRecipientTelArr()
    {
        return recipientTelArr;
    }

    public void setRecipientTelArr(String[] recipientTelArr)
    {
        this.recipientTelArr = recipientTelArr;
    }

    public String[] getAddressArr()
    {
        return addressArr;
    }

    public void setAddressArr(String[] addressArr)
    {
        this.addressArr = addressArr;
    }
}