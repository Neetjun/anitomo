package com.anitomo.utilities;

import org.springframework.stereotype.Component;

@Component
public class TelHandler
{
    public String combineTel(String[] telArr)
    {
        String result = "";

        for (int i = 0; i < telArr.length; i++)
        {
            result += telArr[i];

            if(i < 2)
                result += "-";
        }

        return result;
    }

    public String[] splitTel(String tel)
    {
        String[] result = tel.split("-");

        return result;
    }
}
