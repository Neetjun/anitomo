package com.anitomo.service;

import com.anitomo.dto.*;

import java.util.HashMap;
import java.util.List;

public interface ItemService
{
    List<ItemDTO> mainNewstList();

    List<ItemDTO> mainPopularList();

    ItemDTO getItemDetail(String itemCode);

    List<ItemDTO> getItemList(HashMap<String,Object> searchMap);

    List<SeriesDTO> getSeriesList();

    List<ItemTypeDTO> getItemTypeList();

    List<MakerDTO> getMakerList();

    String postItem(ItemDTO itemDTO, String[] imageNameList, String mode);

    String getNewItemCode();

    List<ImageDTO> getThumbnailList();

    String getThumbnail(String itemCode);

    void deleteItem(ItemDTO itemDTO);

    Integer countItemList(HashMap<String, Object> searchMap);
}
