package com.anitomo.service;

import com.anitomo.dao.ItemDAO;
import com.anitomo.dto.ItemDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class ItemService
{
    private ItemDAO itemDAO;

    public ItemService(ItemDAO itemDAO)
    {
        this.itemDAO = itemDAO;
    }

    public List<ItemDTO> mainNewstList()
    {
        return itemDAO.mainNewestList();
    }

    public List<ItemDTO> mainPopularList()
    {
        return itemDAO.mainPopularList();
    }

    public ItemDTO showItemDetail(String itemCode)
    {
        return itemDAO.showItemDetail(itemCode);
    }
}
