package com.anitomo.utilities;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.ArrayList;
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

    public void deleteFile(String code, String fileName, String boardType)
    {
        if(boardType.equals("review"))
            path = "C:\\development\\projects\\anitomo\\images\\reviews\\"+code+"\\"+fileName;

        file = new File(path);

        log.info(path);

        file.delete();
    }
}
