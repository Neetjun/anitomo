package com.anitomo.dto;

import java.util.Arrays;

public class ReviewDTO
{
    String reviewCode, reviewTitle, reviewContent, reviewDate, userCode, userId, userName, orderCode, itemCode;
    Float itemRate;
    Float[] rateArr;
    String[] itemCodeArr;

    @Override
    public String toString()
    {
        return "ReviewDTO{" +
                "reviewCode='" + reviewCode + '\'' +
                ", reviewTitle='" + reviewTitle + '\'' +
                ", reviewContent='" + reviewContent + '\'' +
                ", reviewDate='" + reviewDate + '\'' +
                ", userCode='" + userCode + '\'' +
                ", userId='" + userId + '\'' +
                ", userName='" + userName + '\'' +
                ", orderCode='" + orderCode + '\'' +
                ", itemCode='" + itemCode + '\'' +
                ", itemRate=" + itemRate +
                ", rateArr=" + Arrays.toString(rateArr) +
                ", itemCodeArr=" + Arrays.toString(itemCodeArr) +
                '}';
    }

    public String getReviewCode()
    {
        return reviewCode;
    }

    public void setReviewCode(String reviewCode)
    {
        this.reviewCode = reviewCode;
    }

    public String getReviewTitle()
    {
        return reviewTitle;
    }

    public void setReviewTitle(String reviewTitle)
    {
        this.reviewTitle = reviewTitle;
    }

    public String getReviewContent()
    {
        return reviewContent;
    }

    public void setReviewContent(String reviewContent)
    {
        this.reviewContent = reviewContent;
    }

    public String getReviewDate()
    {
        return reviewDate;
    }

    public void setReviewDate(String reviewDate)
    {
        this.reviewDate = reviewDate;
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

    public String getUserName()
    {
        return userName;
    }

    public void setUserName(String userName)
    {
        this.userName = userName;
    }

    public String getOrderCode()
    {
        return orderCode;
    }

    public void setOrderCode(String orderCode)
    {
        this.orderCode = orderCode;
    }

    public String getItemCode()
    {
        return itemCode;
    }

    public void setItemCode(String itemCode)
    {
        this.itemCode = itemCode;
    }

    public Float getItemRate()
    {
        return itemRate;
    }

    public void setItemRate(Float itemRate)
    {
        this.itemRate = itemRate;
    }

    public Float[] getRateArr()
    {
        return rateArr;
    }

    public void setRateArr(Float[] rateArr)
    {
        this.rateArr = rateArr;
    }

    public String[] getItemCodeArr()
    {
        return itemCodeArr;
    }

    public void setItemCodeArr(String[] itemCodeArr)
    {
        this.itemCodeArr = itemCodeArr;
    }
}