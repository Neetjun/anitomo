package com.anitomo.dto;

import org.springframework.stereotype.Component;

import java.util.Arrays;

public class UserDTO
{
    String userCode, userType, userId, userPw, userName, userBirth, userStatus, userTelResult;
    String[] userTel;


    @Override
    public String toString()
    {
        return "UserDTO{" +
                "userCode='" + userCode + '\'' +
                ", userType='" + userType + '\'' +
                ", userId='" + userId + '\'' +
                ", userPw='" + userPw + '\'' +
                ", userName='" + userName + '\'' +
                ", userBirth='" + userBirth + '\'' +
                ", userStatus='" + userStatus + '\'' +
                ", userTelResult='" + userTelResult + '\'' +
                '}';
    }

    public void userTelHandler()
    {
        userTelResult = "";
        for (int i = 0; i < userTel.length; i++)
        {
            userTelResult += userTel[i];
            if(i < 2)
                userTelResult += "-";
        }
    }

    public String getUserCode()
    {
        return userCode;
    }

    public void setUserCode(String userCode)
    {
        this.userCode = userCode;
    }

    public String getUserType()
    {
        return userType;
    }

    public void setUserType(String userType)
    {
        this.userType = userType;
    }

    public String getUserId()
    {
        return userId;
    }

    public void setUserId(String userId)
    {
        this.userId = userId;
    }

    public String getUserPw()
    {
        return userPw;
    }

    public void setUserPw(String userPw)
    {
        this.userPw = userPw;
    }

    public String getUserName()
    {
        return userName;
    }

    public void setUserName(String userName)
    {
        this.userName = userName;
    }

    public String getUserBirth()
    {
        return userBirth;
    }

    public void setUserBirth(String userBirth)
    {
        this.userBirth = userBirth;
    }

    public String getUserStatus()
    {
        return userStatus;
    }

    public void setUserStatus(String userStatus)
    {
        this.userStatus = userStatus;
    }

    public String getUserTelResult()
    {
        return userTelResult;
    }

    public void setUserTelResult(String userTelResult)
    {
        this.userTelResult = userTelResult;
    }

    public String[] getUserTel()
    {
        return userTel;
    }

    public void setUserTel(String[] userTel)
    {
        this.userTel = userTel;
    }
}