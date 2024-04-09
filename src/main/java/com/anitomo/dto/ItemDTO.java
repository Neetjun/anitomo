package com.anitomo.dto;

public class ItemDTO
{
    String itemCode, itemName,itemPrice, itemSize, itemDescription, itemDate, makerName, seriesName, itemType, makerCode, seriesCode, itemTypeCode;

    @Override
    public String toString()
    {
        return "ItemDTO{" +
                "itemCode='" + itemCode + '\'' +
                ", itemName='" + itemName + '\'' +
                ", itemPrice='" + itemPrice + '\'' +
                ", itemSize='" + itemSize + '\'' +
                ", itemDescription='" + itemDescription + '\'' +
                ", itemDate='" + itemDate + '\'' +
                ", makerName='" + makerName + '\'' +
                ", seriesName='" + seriesName + '\'' +
                ", itemType='" + itemType + '\'' +
                ", makerCode='" + makerCode + '\'' +
                ", seriesCode='" + seriesCode + '\'' +
                ", itemTypeCode='" + itemTypeCode + '\'' +
                '}';
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

    public String getItemSize()
    {
        return itemSize;
    }

    public void setItemSize(String itemSize)
    {
        this.itemSize = itemSize;
    }

    public String getItemDescription()
    {
        return itemDescription;
    }

    public void setItemDescription(String itemDescription)
    {
        this.itemDescription = itemDescription;
    }

    public String getItemDate()
    {
        return itemDate;
    }

    public void setItemDate(String itemDate)
    {
        this.itemDate = itemDate;
    }

    public String getMakerName()
    {
        return makerName;
    }

    public void setMakerName(String makerName)
    {
        this.makerName = makerName;
    }

    public String getSeriesName()
    {
        return seriesName;
    }

    public void setSeriesName(String seriesName)
    {
        this.seriesName = seriesName;
    }

    public String getItemType()
    {
        return itemType;
    }

    public void setItemType(String itemType)
    {
        this.itemType = itemType;
    }

    public String getMakerCode()
    {
        return makerCode;
    }

    public void setMakerCode(String makerCode)
    {
        this.makerCode = makerCode;
    }

    public String getSeriesCode()
    {
        return seriesCode;
    }

    public void setSeriesCode(String seriesCode)
    {
        this.seriesCode = seriesCode;
    }

    public String getItemTypeCode()
    {
        return itemTypeCode;
    }

    public void setItemTypeCode(String itemTypeCode)
    {
        this.itemTypeCode = itemTypeCode;
    }
}
