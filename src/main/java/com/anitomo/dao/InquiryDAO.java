package com.anitomo.dao;


import com.anitomo.dto.InquiryDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class InquiryDAO
{
    private SqlSession session;
    private String namespace = "com.anitomo.dao.InquiryDAO.";

    public InquiryDAO(SqlSession session)
    {
        this.session = session;
    }


    public Integer postInquiry(InquiryDTO inquiryDTO)
    {
        return session.insert(namespace+"postInquiry", inquiryDTO);
    }

    public List<InquiryDTO> showInquiryList()
    {
        return session.selectList(namespace+"showInquiryList");
    }
}
