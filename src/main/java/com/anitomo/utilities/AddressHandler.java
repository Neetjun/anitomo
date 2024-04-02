package com.anitomo.utilities;

import org.springframework.stereotype.Component;

@Component
public class AddressHandler
{
    public String combineAddress(String[] addressArr)
    {
        String result = "";

        if(addressArr[1].toString().equals(""))
            return addressArr[0];

        result = addressArr[0] + ", " + addressArr[1];

        return result;
    }

    public String[] splitAddress(String address)
    {
        String[] result = address.split(", ");

        return result;
    }
}
