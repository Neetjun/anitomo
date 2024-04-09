package com.anitomo.controller;

import com.anitomo.dto.*;
import com.anitomo.service.ItemService;
import com.anitomo.service.UserService;
import com.google.gson.JsonObject;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("item")
@Slf4j
public class ItemController
{
    private ItemService itemService;
    private UserService userService;

    public ItemController(ItemService itemService, UserService userService)
    {
        this.itemService = itemService;
        this.userService = userService;
    }

    @GetMapping("{itemCode}")
    public String showItemDetail(@PathVariable String itemCode, Model model)
    {
        List<ReviewDTO> reviewList = userService.getItemReviewList(itemCode);
        HashMap<String, List<String>> imageMap = new HashMap<String, List<String>>(); // 리뷰코드, imageList 형태로 이미지 전달

        for (ReviewDTO reviewDTO : reviewList)
        {
            String reviewCode = reviewDTO.getReviewCode();
            List<String> imageList = userService.getReviewImageList(reviewCode);

            imageMap.put(reviewCode, imageList);
        }

        String thumbnailUrl = itemService.getThumbnail(itemCode);

        ItemDTO detailDTO = itemService.getItemDetail(itemCode);
        model.addAttribute("item", detailDTO);
        model.addAttribute("reviewList", reviewList);
        model.addAttribute("reviewCount", userService.getItemReviewCount(itemCode));
        model.addAttribute("imageMap", imageMap);
        model.addAttribute("thumbnailUrl", thumbnailUrl);

        return "itemDetail";
    }

    @PostMapping
    public String postItem(ItemDTO itemDTO, String[] imageNameList, String mode)
    {
        if(mode == null || mode.equals("update"))
            itemService.postItem(itemDTO,imageNameList, mode);
        else if(mode.equals("delete"))
            itemService.deleteItem(itemDTO);

        return "redirect:/admin/itemlist?page=1";
    }

    @GetMapping("list")
    public String showItemList(Model model, @RequestParam(defaultValue = "1") String page, String keyword
            , @RequestParam(defaultValue = "newest") String sort, ItemDTO itemDTO, String listType)
    {

        HashMap<String,Object> searchMap = new HashMap<>();
        searchMap.put("page", page);
        searchMap.put("keyword",keyword);
        searchMap.put("sort",sort);
        searchMap.put("code",itemDTO);
        searchMap.put("searchType",listType);

        System.out.println("searchMap = " + searchMap);

        List<ItemDTO> itemList = itemService.getItemList(searchMap);
        List<MakerDTO> makerList = itemService.getMakerList();
        List<SeriesDTO> seriesList = itemService.getSeriesList();
        List<ItemTypeDTO> itemTypeList = itemService.getItemTypeList();
        List<ImageDTO> thumbnailList = itemService.getThumbnailList();
        Integer countItemList = itemService.countItemList(searchMap);

        model.addAttribute("itemList", itemList);
        model.addAttribute("seriesList", seriesList);
        model.addAttribute("makerList", makerList);
        model.addAttribute("itemTypeList", itemTypeList);
        model.addAttribute("thumbnailList", thumbnailList);
        model.addAttribute("countItemList",countItemList);

        return "itemList";
    }

    @PostMapping("image")
    @ResponseBody
    public String uploadItemImage(MultipartHttpServletRequest multiFile, HttpServletResponse response, String itemCode) throws IOException
    {

        //Json 객체 생성
        JsonObject json = new JsonObject();
        // Json 객체를 출력하기 위해 PrintWriter 생성
        PrintWriter printWriter = null;
        OutputStream out = null;
        //파일을 가져오기 위해 MultipartHttpServletRequest 의 getFile 메서드 사용
        MultipartFile file = multiFile.getFile("upload");
        //파일이 비어있지 않고(비어 있다면 null 반환)
        if (file != null)
        {
            // 파일 사이즈가 0보다 크고, 파일이름이 공백이 아닐때
            if (file.getSize() > 0 && StringUtils.isNotBlank(file.getName()))
            {
                if (file.getContentType().toLowerCase().startsWith("image/"))
                {
                    try
                    {
                        log.info("itemCode = {}",itemCode);

                        // 저장될 폴더명
                        String folderName = "";

                        if(itemCode.equals(""))
                            folderName = itemService.getNewItemCode();
                        else
                            folderName = itemCode;

                        log.info(folderName);

                        //파일 이름 설정
                        String fileName = file.getOriginalFilename();
                        //파일 확장자
                        String extension = fileName.substring(fileName.lastIndexOf("."));
                        //바이트 타입설정
                        byte[] bytes;
                        //파일을 바이트 타입으로 변경
                        bytes = file.getBytes();
                        //파일이 실제로 저장되는 경로
                        String uploadPath = "C:\\development\\projects\\anitomo\\images\\items\\" + folderName + "\\";
                        //저장되는 파일에 경로 설정
                        File uploadFile = new File(uploadPath);

                        if (!uploadFile.exists())
                            uploadFile.mkdirs();

                        //파일이름을 랜덤하게 생성
                        fileName = UUID.randomUUID() + extension;

                        //폴더에 파일이 존재하지 않으면 첫 번째 파일이므로 썸네일로 등록
//                        if(uploadFile.list().length == 0)

                        //업로드 경로 + 파일이름을 줘서  데이터를 서버에 전송
                        uploadPath = uploadPath + "/" + fileName;
                        out = new FileOutputStream(new File(uploadPath));
                        out.write(bytes);

                        //클라이언트에 이벤트 추가
                        printWriter = response.getWriter();
                        response.setContentType("application/json");

                        //파일이 연결되는 Url 주소 설정
                        String fileUrl = "/img/items/" + folderName + "/" + fileName;

                        //생성된 jason 객체를 이용해 파일 업로드 + 이름 + 주소를 CkEditor에 전송
                        json.addProperty("uploaded", 1);
                        json.addProperty("fileName", fileName);
                        json.addProperty("url", fileUrl);
                        printWriter.println(json);
                        printWriter.flush();
                    } catch (IOException e)
                    {
                        e.printStackTrace();
                    } finally
                    {
                        if (out != null)
                        {
                            out.close();
                        }
                        if (printWriter != null)
                        {
                            printWriter.close();
                        }
                    }
                }
            }
        }
        return null;
    }

    @ResponseBody
    @GetMapping("mainlist")
    public HashMap<String, Object> showMainList()
    {
        HashMap<String, Object> itemListMap = new HashMap<String, Object>();

        itemListMap.put("newestList", itemService.mainNewstList());
        itemListMap.put("popularList", itemService.mainPopularList());
        itemListMap.put("thumbnailList", itemService.getThumbnailList());

        return itemListMap;
    }
}
