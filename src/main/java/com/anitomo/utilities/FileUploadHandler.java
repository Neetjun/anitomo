package com.anitomo.utilities;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Slf4j
public class FileUploadHandler
{
    private String path = "";
    private File file = null;

    public String fileUpload(MultipartFile[] fileArr, String boardType, String code)
    {
        try
        {
            if(boardType.equals("review"))
            {
                path = "C:\\development\\projects\\anitomo\\images\\reviews\\"+code+"\\";
                file = new File(path);

                if(!file.exists())
                    file.mkdirs();

                for (MultipartFile multipartFile : fileArr)
                {
                    String originalFileName = multipartFile.getOriginalFilename();
                    file = new File(path + originalFileName);
                    multipartFile.transferTo(file);
                    log.info(file.toString());
                }
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
            return "fail";
        }

        return "success";
    }

    public void deleteFile(String code, String[] fileNameArr, String boardType)
    {
        if(boardType.equals("review"))
        {
            for (String fileName : fileNameArr)
            {
                path = "C:\\development\\projects\\anitomo\\images\\reviews\\"+code+"\\"+fileName;
                file = new File(path);
                file.delete();
            }
        }
        else
        {
            path = "C:\\development\\projects\\anitomo\\images\\items\\"+code+"\\";
            file = new File(path);
            File[] fileArr = file.listFiles();
            List<String> fileNameList = Arrays.asList(fileNameArr);

            for (File tmpFile : fileArr)
                if(!fileNameList.contains(tmpFile.getName()))
                    tmpFile.delete();
        }
    }

    public void deleteDirectory(String code, String boardType)
    {
        if(boardType.equals("review"))
            path = "C:\\development\\projects\\anitomo\\images\\reviews\\"+ code +"\\";

        file = new File(path);

        if(file.isDirectory())
        {
            File[] fileArr = file.listFiles();

            // 폴더가 비어있지 않으면 삭제가 안 되므로 파일 삭제 수행
            if(fileArr != null)
                for (File deleteTarget : fileArr)
                    deleteTarget.delete();

            // 폴더 삭제
            file.delete();
        }
    }
}
