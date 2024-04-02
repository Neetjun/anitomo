package com.anitomo.service;


import com.anitomo.dao.InquiryDAO;
import com.anitomo.dto.InquiryDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class InquiryServiceImpl implements InquiryService
{
    InquiryDAO inquiryDAO;

    public InquiryServiceImpl(InquiryDAO inquiryDAO)
    {
        this.inquiryDAO = inquiryDAO;
    }

    @Override
    public Integer postInquiry(InquiryDTO inquiryDTO)
    {
        return inquiryDAO.postInquiry(inquiryDTO);
    }

    @Override
    public List<InquiryDTO> showInquiryList(String itemCode)
    {
        List<InquiryDTO> inquiryList = inquiryDAO.showInquiryList(itemCode);

        return inquiryList;
    }

    @Override
    public Integer countInquiry(String itemCode)
    {
        return inquiryDAO.countInquiry(itemCode);
    }
}
