package com.anitomo.service;

import com.anitomo.dto.InquiryDTO;

import java.util.List;

public interface InquiryService
{
    Integer postInquiry(InquiryDTO inquiryDTO);

    List<InquiryDTO> showInquiryList(String itemCode);

    Integer countInquiry(String itemCode);
}
