package com.anitomo.service;

import com.anitomo.dto.ItemDTO;

import java.util.List;

public interface ItemService
{
    List<ItemDTO> mainNewstList();

    List<ItemDTO> mainPopularList();

    ItemDTO showItemDetail(String itemCode);
}
