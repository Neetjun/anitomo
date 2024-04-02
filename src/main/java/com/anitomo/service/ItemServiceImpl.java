package com.anitomo.service;

import com.anitomo.dao.ItemDAO;
import com.anitomo.dto.ItemDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class ItemServiceImpl implements ItemService
{
    private ItemDAO itemDAO;

    public ItemServiceImpl(ItemDAO itemDAO)
    {
        this.itemDAO = itemDAO;
    }

    @Override
    public List<ItemDTO> mainNewstList()
    {
        return itemDAO.mainNewestList();
    }

    @Override
    public List<ItemDTO> mainPopularList()
    {
        return itemDAO.mainPopularList();
    }

    @Override
    public ItemDTO showItemDetail(String itemCode)
    {
        return itemDAO.showItemDetail(itemCode);
    }
}
