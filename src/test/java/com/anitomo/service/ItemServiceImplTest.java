package com.anitomo.service;

import com.anitomo.dao.ItemDAO;
import com.anitomo.dto.ItemDTO;
import junit.framework.TestCase;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
        locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"}
)
public class ItemServiceImplTest extends TestCase
{
    @Autowired
    ItemDAO itemDAO;
    ItemDTO itemDTO = new ItemDTO();


    private String namespace = "com.anitomo.dao.ItemDAO.";
    @Test
    public void testPostItem()
    {
        for (int i = 1; i <= 115; i++)
        {
            itemDTO.setItemCode("I"+i);
            itemDTO.setItemName("테스트 상품"+i);
            itemDTO.setItemPrice(Integer.toString((int)Math.floor(Math.random() * 10000) + 1000));
            itemDTO.setItemSize(Integer.toString((int)Math.floor(Math.random() * 50) + 1));
            itemDTO.setSeriesCode("S"+((int)Math.floor(Math.random() * 11) + 1));
            itemDTO.setMakerCode("M"+((int)Math.floor(Math.random() * 7) + 1));
            itemDTO.setItemTypeCode("IT"+((int)Math.floor(Math.random() * 7) + 1));
            itemDTO.setItemDescription("test코드");

            Integer result = itemDAO.postItem(itemDTO);

            Assert.assertTrue(result == 1);
        }
    }
}