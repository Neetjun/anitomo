package com.anitomo.service;


import com.anitomo.dao.InquiryDAO;
import com.anitomo.dto.InquiryDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.List;

@Service
@Slf4j
public class InquiryService
{
    InquiryDAO inquiryDAO;

    public InquiryService(InquiryDAO inquiryDAO)
    {
        this.inquiryDAO = inquiryDAO;
    }

    public Integer postInquiry(InquiryDTO inquiryDTO)
    {
        return inquiryDAO.postInquiry(inquiryDTO);
    }

    public List<InquiryDTO> showInquiryList()
    {
        List<InquiryDTO> inquiryList = inquiryDAO.showInquiryList();

        return inquiryList;
    }
}
