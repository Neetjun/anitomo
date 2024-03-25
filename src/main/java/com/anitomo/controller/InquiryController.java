package com.anitomo.controller;


import com.anitomo.dto.InquiryDTO;
import com.anitomo.dto.UserDTO;
import com.anitomo.service.InquiryService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@Slf4j
@RequestMapping("inquiry")
public class InquiryController
{

    InquiryService inquiryService;

    public InquiryController(InquiryService inquiryService)
    {
        this.inquiryService = inquiryService;
    }

    @GetMapping
    @ResponseBody
    public List<InquiryDTO> showInquiryList()
    {
        List<InquiryDTO> inquiryList = inquiryService.showInquiryList();

        return inquiryList;
    }

    @PostMapping
    public String postInquiry(InquiryDTO inquiryDTO, HttpServletRequest request, HttpSession session, RedirectAttributes ra)
    {
        String referer = request.getHeader("referer");
        UserDTO loginUser;

        // session을 통해 문의 등록 유저 정보 삽입
        try
        {
            loginUser = (UserDTO)session.getAttribute("loginUser");

            if(loginUser == null)
                throw new NullPointerException();
        }
        catch (NullPointerException e)
        {
            ra.addFlashAttribute("errorType", "loginRequired");
            return "redirect:" + referer;
        }

        inquiryDTO.setInquiryUserCode(loginUser.getUserCode());
        inquiryDTO.setInquiryUserId(loginUser.getUserId());

        log.info(inquiryDTO.toString());

        inquiryService.postInquiry(inquiryDTO);

        return "redirect:" + referer;
    }
}
