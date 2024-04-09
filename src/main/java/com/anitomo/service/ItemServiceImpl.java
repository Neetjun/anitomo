package com.anitomo.service;

import com.anitomo.dao.ItemDAO;
import com.anitomo.dto.*;
import com.anitomo.utilities.FileUploadHandler;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.HashMap;
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
    public ItemDTO getItemDetail(String itemCode)
    {
        return itemDAO.showItemDetail(itemCode);
    }

    @Override
    public List<ItemDTO> getItemList(HashMap<String, Object> searchMap)
    {
        return itemDAO.getItemList(searchMap);
    }

    @Override
    public List<SeriesDTO> getSeriesList()
    {
        return itemDAO.getSeriesList();
    }

    @Override
    public List<ItemTypeDTO> getItemTypeList()
    {
        return itemDAO.getItemTypeList();
    }

    @Override
    public List<MakerDTO> getMakerList()
    {
        return itemDAO.getMakerList();
    }

    @Override
    @Transactional
    public String postItem(ItemDTO itemDTO, String[] imageNameList, String mode)
    {
        FileUploadHandler fileUploadHandler = new FileUploadHandler();
        HashMap<String, String> imageMap = new HashMap<>();
        Integer result = 0;

        if(mode == null)
        {
            // 새로운 상품코드 세팅
            String newItemCode = itemDAO.getLastItemCode();
            itemDTO.setItemCode(newItemCode);
            // 상품 등록
            itemDAO.postItem(itemDTO);
        }
        else
            itemDAO.updateItem(itemDTO);

        // 제출된 상품 내용을 통해 삭제된 img 태그의 임시파일은 삭제처리
        if(imageNameList != null)
        {
            String itemCode = itemDTO.getItemCode();
            fileUploadHandler.deleteFile(itemCode, imageNameList,"item");

            imageMap.put("itemCode", itemCode);

            // 업로드된 이미지 db에 등록
            for (String name : imageNameList)
            {
                String url = "/img/items/"+ itemCode +"/" + name;
                imageMap.put("url",url);

                Integer imageCount = itemDAO.countItemImage(url);

                if(imageCount != null && imageCount == 0)
                    itemDAO.postItemImage(imageMap);
            }

            log.info("이미지 db등록 완료");

            // 가장 빨리 업로드된 이미지는 썸네일 취급
            itemDAO.setThumbnail(itemCode);
        }

            // 수정 요청 시 해당 상품의 이미지 리스트를 불러와 이미지 테이블 최신화
            if(mode != null && mode.equals("update"))
            {
                // db에 저장되어있는 상품 이미지 파일이름 리스트
                List<String> imageUrlList = itemDAO.getitemImageUrlList(itemDTO.getItemCode());

                // 수정 요청이 들어온 상품 내용의 img 파일이름 리스트
                List<String> updatedImgList = Arrays.asList(imageNameList);
                
                log.info(imageUrlList.toString());
                log.info(updatedImgList.toString());

                for (String name : imageUrlList)
                {
                    if(!updatedImgList.contains(name))
                    {
                        imageMap.put("name",name);
                        itemDAO.deleteItemImage(imageMap);
                    }
                }
                
                log.info("update 통과");
            }

        String resultMessage = "";

        return resultMessage;
    }

    @Override
    public String getNewItemCode()
    {
        return itemDAO.getNewItemCode();
    }

    @Override
    public List<ImageDTO> getThumbnailList()
    {
        return itemDAO.getThumbnailList();
    }

    @Override
    public String getThumbnail(String itemCode)
    {
        return itemDAO.getThumbnail(itemCode);
    }

    @Override
    public void deleteItem(ItemDTO itemDTO)
    {
        String[] itemCodeArr = itemDTO.getItemCode().split(" ");

        for (String itemCode : itemCodeArr)
        {
            itemDTO.setItemCode(itemCode);
            itemDAO.deleteItem(itemDTO);
        }
    }

    @Override
    public Integer countItemList(HashMap<String, Object> searchMap)
    {
        return itemDAO.countItemList(searchMap);
    }
}
