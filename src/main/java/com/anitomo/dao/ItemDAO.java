package com.anitomo.dao;


import com.anitomo.dto.ItemDTO;
import com.anitomo.dto.UserDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

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
        return session.selectOne(namespace+"itemDetail", itemCode);
    }
}
