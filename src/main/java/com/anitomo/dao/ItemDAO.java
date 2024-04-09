package com.anitomo.dao;


import com.anitomo.dto.*;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository
public class ItemDAO
{
    private SqlSession session;
    private String namespace = "com.anitomo.dao.ItemDAO.";

    public ItemDAO(SqlSession session)
    {
        this.session = session;
    }

    public List<ItemDTO> mainNewestList()
    {
        return session.selectList(namespace+"mainNewestList");
    }

    public List<ItemDTO> mainPopularList()
    {
        return session.selectList(namespace+"mainPopularList");
    }

    public ItemDTO showItemDetail(String itemCode)
    {
        return session.selectOne(namespace+"getItemDetail", itemCode);
    }

    public List<ItemDTO> getItemList(HashMap<String, Object> searchMap)
    {
        return session.selectList(namespace+"getItemList", searchMap);
    }

    public List<SeriesDTO> getSeriesList()
    {
        return session.selectList(namespace+"getSeriesList");
    }

    public List<ItemTypeDTO> getItemTypeList()
    {
        return session.selectList(namespace+"getItemTypeList");
    }

    public List<MakerDTO> getMakerList()
    {
        return session.selectList(namespace+"getMakerList");
    }

    public Integer postItem(ItemDTO itemDTO)
    {
        return session.insert(namespace+"postItem",itemDTO);
    }

    public String getNewItemCode()
    {
        return session.selectOne(namespace+"getNewItemCode");
    }

    public void postItemImage(HashMap<String, String> imageMap)
    {
        session.insert(namespace+"postItemImage",imageMap);
    }

    public void setThumbnail(String newItemCode)
    {
        session.update(namespace+"setThumbnail", newItemCode);
    }

    public List<ImageDTO> getThumbnailList()
    {
        return session.selectList(namespace+"getThumbnailList");
    }

    public String getThumbnail(String itemCode)
    {
        return session.selectOne(namespace+"getThumbnail",itemCode);
    }

    public void deleteItem(ItemDTO itemDTO)
    {
        session.update(namespace+"deleteItem", itemDTO);
    }

    public Integer updateItem(ItemDTO itemDTO)
    {
        return session.update(namespace+"updateItem",itemDTO);
    }

    public Integer countItemImage(String url)
    {
        return session.selectOne(namespace+"countItemImage",url);
    }

    public List<String> getitemImageUrlList(String itemCode)
    {
        return session.selectList(namespace+"getItemImageUrlList",itemCode);
    }

    public void deleteItemImage(HashMap<String, String> imageMap)
    {
        session.delete(namespace+"deleteItemImage",imageMap);
    }

    public Integer countItemList(HashMap<String, Object> searchMap)
    {
        return session.selectOne(namespace+"countItemList",searchMap);
    }

    public String getLastItemCode()
    {
        return session.selectOne(namespace+"getLastItemCode");
    }
}
