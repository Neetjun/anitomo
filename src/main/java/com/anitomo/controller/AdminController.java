package com.anitomo.controller;

import com.anitomo.dto.*;
import com.anitomo.service.ItemService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("admin")
public class AdminController
{

    ItemService itemService;

    public AdminController(ItemService itemService)
    {
        this.itemService = itemService;
    }

    @GetMapping("{menuType}")
    public String showAdminPage(@PathVariable String menuType, Model model, String mode, String itemCode, @RequestParam(defaultValue = "1") String page, String keyword)
    {
        if(menuType.equals("itemlist"))
        {
            HashMap<String,Object> searchMap = new HashMap<>();
            searchMap.put("page",page);
            searchMap.put("keyword",keyword);
            searchMap.put("admin","admin");

            List<ItemDTO> itemList = itemService.getItemList(searchMap);
            List<ImageDTO> thumbnailList = itemService.getThumbnailList();
            Integer countItemList = itemService.countItemList(searchMap);

            model.addAttribute("itemList",itemList);
            model.addAttribute("thumbnailList", thumbnailList);
            model.addAttribute("countItemList",countItemList);
        }

        if(menuType.equals("item"))
        {
            List<MakerDTO> makerList = itemService.getMakerList();
            List<SeriesDTO> seriesList = itemService.getSeriesList();
            List<ItemTypeDTO> itemTypeList = itemService.getItemTypeList();

            model.addAttribute("makerList", makerList);
            model.addAttribute("seriesList", seriesList);
            model.addAttribute("itemTypeList", itemTypeList);

            if(mode != null && mode.equals("update"))
            {
                ItemDTO itemDTO = itemService.getItemDetail(itemCode);
                model.addAttribute("item",itemDTO);
            }
        }

        model.addAttribute("menuType",menuType);

        return "adminPage";
    }
}
