package com.anitomo.dto;

public class InquiryDTO
{
    String inquiryCode, inquiryTitle, inquiryContent, inquiryDate
            , inquiryAnswer, inquiryAnswerDate, inquiryStatus, inquiryUserCode, inquiryUserId, inquiryUserName, inquiryItemCode;

    @Override
    public String toString()
    {
        return "InquiryDTO{" +
                "inquiryCode='" + inquiryCode + '\'' +
                ", inquiryTitle='" + inquiryTitle + '\'' +
                ", inquiryContent='" + inquiryContent + '\'' +
                ", inquiryDate='" + inquiryDate + '\'' +
                ", inquiryAnswer='" + inquiryAnswer + '\'' +
                ", inquiryAnswerDate='" + inquiryAnswerDate + '\'' +
                ", inquiryStatus='" + inquiryStatus + '\'' +
                ", inquiryUserCode='" + inquiryUserCode + '\'' +
                ", inquiryUserId='" + inquiryUserId + '\'' +
                ", inquiryUserName='" + inquiryUserName + '\'' +
                ", inquiryItemCode='" + inquiryItemCode + '\'' +
                '}';
    }

    public String getInquiryCode()
    {
        return inquiryCode;
    }

    public void setInquiryCode(String inquiryCode)
    {
        this.inquiryCode = inquiryCode;
    }

    public String getInquiryTitle()
    {
        return inquiryTitle;
    }

    public void setInquiryTitle(String inquiryTitle)
    {
        this.inquiryTitle = inquiryTitle;
    }

    public String getInquiryContent()
    {
        return inquiryContent;
    }

    public void setInquiryContent(String inquiryContent)
    {
        this.inquiryContent = inquiryContent;
    }

    public String getInquiryDate()
    {
        return inquiryDate;
    }

    public void setInquiryDate(String inquiryDate)
    {
        this.inquiryDate = inquiryDate;
    }

    public String getInquiryAnswer()
    {
        return inquiryAnswer;
    }

    public void setInquiryAnswer(String inquiryAnswer)
    {
        this.inquiryAnswer = inquiryAnswer;
    }

    public String getInquiryAnswerDate()
    {
        return inquiryAnswerDate;
    }

    public void setInquiryAnswerDate(String inquiryAnswerDate)
    {
        this.inquiryAnswerDate = inquiryAnswerDate;
    }

    public String getInquiryStatus()
    {
        return inquiryStatus;
    }

    public void setInquiryStatus(String inquiryStatus)
    {
        this.inquiryStatus = inquiryStatus;
    }

    public String getInquiryUserCode()
    {
        return inquiryUserCode;
    }

    public void setInquiryUserCode(String inquiryUserCode)
    {
        this.inquiryUserCode = inquiryUserCode;
    }

    public String getInquiryUserId()
    {
        return inquiryUserId;
    }

    public void setInquiryUserId(String inquiryUserId)
    {
        this.inquiryUserId = inquiryUserId;
    }

    public String getInquiryItemCode()
    {
        return inquiryItemCode;
    }

    public void setInquiryItemCode(String inquiryItemCode)
    {
        this.inquiryItemCode = inquiryItemCode;
    }

    public String getInquiryUserName()
    {
        return inquiryUserName;
    }

    public void setInquiryUserName(String inquiryUserName)
    {
        this.inquiryUserName = inquiryUserName;
    }
}
