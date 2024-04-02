package com.anitomo.dao;


import com.anitomo.dto.AddressDTO;
import com.anitomo.dto.OrderDTO;
import com.anitomo.dto.ReviewDTO;
import com.anitomo.dto.UserDTO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository
public class UserDAO
{
    private SqlSession session;
    private String namespace = "com.anitomo.dao.UserDAO.";

    public UserDAO(SqlSession session)
    {
        this.session = session;
    }

    public int registerUser(UserDTO userDTO)
    {
        return session.insert(namespace+"registerUser",userDTO);
    }
    public int countUser()
    {
        return session.selectOne(namespace+"countUser");
    }
    public int checkId(String userId) {return session.selectOne(namespace+"checkId",userId);}

    public UserDTO login(UserDTO userDTO)
    {
        UserDTO loginUser = session.selectOne(namespace+"login",userDTO);
        return loginUser;
    }
    public UserDTO showUserInfo(UserDTO loginUser)
    {
        return session.selectOne(namespace+"showUserInfo",loginUser);
    }
    public void addAddress(AddressDTO addressDTO)
    {
        session.insert(namespace+"addAddress", addressDTO);
    }
    public void updateAddress(AddressDTO addressDTO)
    {
        session.update(namespace+"updateAddress", addressDTO);
    }

    public List<AddressDTO> getAddessList(UserDTO loginUser)
    {
        return session.selectList(namespace+"getAddressList",loginUser);
    }

    public AddressDTO getAddress(String addressCode)
    {
        return session.selectOne(namespace+"getAddress",addressCode);
    }

    public void unCheckDefaultAddress(AddressDTO addressDTO)
    {   session.update(namespace+"unCheckDefaultAddress", addressDTO);}

    public void deleteAddress(AddressDTO addressDTO)
    {
        session.delete(namespace+"deleteAddress",addressDTO);
    }

    public AddressDTO getDefaultAddress(UserDTO loginUser)
    {
        return session.selectOne(namespace+"getDefaultAddress", loginUser);
    }

    public Integer getReviewCount(OrderDTO orderDTO)
    {
        return session.selectOne(namespace+"getReviewCount", orderDTO);
    }
    public String getMyReviewCode(ReviewDTO reviewDTO)
    {
        return session.selectOne(namespace+"getMyReviewCode",reviewDTO);
    }
    public Integer postReview(ReviewDTO reviewDTO)
    {
        return session.insert(namespace+"postReview",reviewDTO);
    }

    public Integer postRate(HashMap<String, Object> ratingMap)
    {
        return session.insert(namespace+"postRate",ratingMap);
    }

    public ReviewDTO getReview(String orderCode)
    {
        return session.selectOne(namespace+"getReview",orderCode);
    }

    public List<Integer> getRate(String reviewCode)
    {
        return session.selectList(namespace+"getRate",reviewCode);
    }

    public List<String> getReviewImageList(String reviewCode)
    {
        return session.selectList(namespace+"getReviewImageList",reviewCode);
    }

    public Integer postReviewImage(HashMap<String, String> imageMap)
    {
        return session.insert(namespace+"postReviewImage",imageMap);
    }

    public void updateReview(ReviewDTO reviewDTO)
    {
        session.update(namespace+"updateReview",reviewDTO);
    }

    public void deleteReview(ReviewDTO reviewDTO)
    {
        session.delete(namespace+"deleteReview",reviewDTO);
    }

    public Integer updateRate(HashMap<String, Object> ratingMap)
    {
        return session.update(namespace+"updateRate",ratingMap);
    }

    public void deleteReviewImage(HashMap<String, String> imageMap)
    {
        session.delete(namespace+"deleteReviewImage",imageMap);
    }
}
