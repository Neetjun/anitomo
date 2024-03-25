package com.anitomo.controller;

import com.anitomo.dto.ItemDTO;
import com.anitomo.service.ItemService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;

@Controller
@RequestMapping("/item")
public class ItemController
{
    ItemService itemService;

    public ItemController(ItemService itemService)
    {
        this.itemService = itemService;
    }

    @GetMapping("{itemCode}")
    public String showItemDetail(@PathVariable String itemCode, Model model)
    {
        ItemDTO detailDTO = itemService.showItemDetail(itemCode);
        model.addAttribute("item",detailDTO);

        return "itemDetail";
    }

    @GetMapping("list")
    public String showItemList()
    {
        return "itemList";
    }

    @ResponseBody
    @GetMapping("mainlist")
    public HashMap<String, Object> showMainList()
    {
        HashMap<String, Object> itemListMap = new HashMap<String, Object>();

        itemListMap.put("newestList", itemService.mainNewstList());
        itemListMap.put("popularList",itemService.mainPopularList());

        return itemListMap;
    }
}
