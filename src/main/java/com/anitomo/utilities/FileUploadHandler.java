package com.anitomo.utilities;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.List;

@Slf4j
public class FileUploadHandler
{
    public String fileUpload(List<MultipartFile> fileList)
    {
        try
        {
            String path = "C:\\Development\\Anitomo\\";
            File file = null;

            for (MultipartFile multipartFile : fileList)
            {
                String originalFileName = multipartFile.getOriginalFilename();
                file = new File(path + originalFileName);
                multipartFile.transferTo(file);
                log.info(file.toString());
            }
        }
        catch (Exception e)
        {
            log.warn(e.toString());
            return "fail";
        }

        return "ok";
    }
}
