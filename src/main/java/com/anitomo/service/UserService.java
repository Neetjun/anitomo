package com.anitomo.service;

import com.anitomo.dto.AddressDTO;
import com.anitomo.dto.OrderDTO;
import com.anitomo.dto.ReviewDTO;
import com.anitomo.dto.UserDTO;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface UserService
{
    // 회원가입
    String registerUser(UserDTO userDTO);

    // 아이디 중복검사
    String checkId(String userId);

    // 비밀번호 검사
    String checkPw(String userPw);

    UserDTO login(UserDTO userDTO);

    UserDTO showUserInfo(UserDTO loginUser);

    void addAddress(AddressDTO addressDTO);

    void updateAddress(AddressDTO addressDTO);

    List<AddressDTO> getAddressList(UserDTO loginUser);

    AddressDTO getAddress(String addressCode);

    void deleteAddress(AddressDTO addressDTO);

    AddressDTO getDefaultAddress(UserDTO loginUser);

    Integer getReviewCount(OrderDTO orderDTO);

    String postReview(ReviewDTO reviewDTO, MultipartFile[] fileArr);

    ReviewDTO getReview(String orderCode);

    List<Integer> getRate(String reviewCode);

    List<String> getReviewImageList(String reviewCode);

    String updateReview(ReviewDTO reviewDTO, MultipartFile[] fileArr, String[] deleteFileArr);

    void deleteReview(ReviewDTO reviewDTO);
}
