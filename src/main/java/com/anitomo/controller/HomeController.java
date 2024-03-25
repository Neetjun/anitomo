package com.anitomo.controller;

import com.anitomo.utilities.FileUploadHandler;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Controller
@Slf4j
public class HomeController
{
    @GetMapping("/")
    public String home()
    {
        return "main";
    }

    @GetMapping("uploadtest")
    public String uploadTest()
    {
        return "fileUpload";
    }

    @PostMapping("uploadtest")
    public String uploadTest(List<MultipartFile> fileList)
    {
        FileUploadHandler fileUploadHandler = new FileUploadHandler();

        fileUploadHandler.fileUpload(fileList);

        return "uploadResult";
    }
}
