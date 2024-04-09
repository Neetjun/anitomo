package com.anitomo.service;

import com.anitomo.dao.UserDAO;
import com.anitomo.dto.AddressDTO;
import com.anitomo.dto.OrderDTO;
import com.anitomo.dto.ReviewDTO;
import com.anitomo.dto.UserDTO;
import com.anitomo.utilities.AddressHandler;
import com.anitomo.utilities.FileUploadHandler;
import com.anitomo.utilities.TelHandler;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Pattern;

@Service
@Slf4j
public class UserServiceImpl implements UserService
{
    private UserDAO userDAO;
    private TelHandler telHandler;
    private AddressHandler addressHandler;

    public UserServiceImpl(UserDAO userDAO, TelHandler telHandler, AddressHandler addressHandler)
    {
        this.userDAO = userDAO;
        this.telHandler = telHandler;
        this.addressHandler = addressHandler;
    }

    // 회원가입
    @Override
    public String registerUser(UserDTO userDTO)
    {
        // 개발자 도구 등을 활용한 잘못된 회원가입 방지
        // 1. id검사 재수행
        String idCheckResult = checkId(userDTO.getUserId());
        if(idCheckResult.equals("fail"))
        {
            log.info("idErr -- id = {}", userDTO.getUserId());
            return "fail";
        }

        // 2. pw검사 재수행
        String pwCheckResult = checkPw(userDTO.getUserPw());
        if(pwCheckResult.equals("fail"))
        {
            log.info("pwErr -- pw = {}",userDTO.getUserPw());
            return "fail";
        }

        // 3. 전화번호 검사 재수행
        // 회원 전화번호 처리
        userDTO.setUserTel(telHandler.combineTel(userDTO.getUserTelArr()));
        String telRegex = "^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$";
        if(!Pattern.matches(telRegex, userDTO.getUserTel()))
        {
            log.info("telErr -- tel = {}", userDTO.getUserTel());
            return "fail";
        }
        // 4. 이름 검사 재수행
        String nameRegex = "^([가-힣]+|[a-zA-Z]+)$";
        if(!Pattern.matches(nameRegex, userDTO.getUserName()))
        {
            log.info("nameErr -- name = {}", userDTO.getUserName());
            return "fail";
        }
        // 5. 생일 검사 수행
        String birthRegex = "^\\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$";
        if(!Pattern.matches(birthRegex, userDTO.getUserBirth()))
        {
            log.info("birthErr -- birth = {}",userDTO.getUserBirth());
            return "fail";
        }

        // 모든 테스트 통과했으면 회원가입 로직 수행

        // 회원 타입코드 부여 (0 = 일반회원, 1 = 관리자)
        userDTO.setUserType("0");

        // 회원 상태코드 부여 (A = 활성화, B = 정지)
        userDTO.setUserStatus("A");

        // 유저 정보 db 입력
        int result = userDAO.registerUser(userDTO);

        log.info("회원가입 결과값 = {}",result);

        // 예외 처리를 위한 분기문
        if(result == 1)
            return "success";
        else
            return "fail";
    }

    // 아이디 중복검사
    @Override
    public String checkId(String userId)
    {
        String result;

        // 중복검사 이전에 정규식 패턴 검사 선행
        String regex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{5,15}$";

        log.info("userId = {}",userId);
        log.info("matchResult = {}", Pattern.matches(regex,userId));

        // matches(정규식,대상문자열) : 대상문자열을 정규식으로 검사해 통과면 true 반환
        if(!Pattern.matches(regex,userId))
        {
            result = "patternError";
            return result;
        }

        int count = userDAO.checkId(userId);

        if (count < 1)
            result = "success";
        else
            result = "fail";

        return result;
    }

    // 비밀번호 검사
    @Override
    public String checkPw(String userPw)
    {
        String result;

        // 비밀번호 검사 정규식
        String regex = "^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*?_]).{8,15}$";

        if(!Pattern.matches(regex, userPw))
            result = "fail";
        else
            result = "success";

        return result;
    }

    // 로그인
    @Override
    public UserDTO login(UserDTO userDTO)
    {
        UserDTO loginUser = userDAO.login(userDTO);

        if(loginUser != null)
            return loginUser;
        else
            return null;
    }

    // 유저정보 조회
    @Override
    public UserDTO showUserInfo(UserDTO loginUser)
    {
        return userDAO.showUserInfo(loginUser);
    }

    // 배송지 목록 조회
    @Override
    public List<AddressDTO> getAddressList(UserDTO loginUser)
    {
        return userDAO.getAddessList(loginUser);
    }

    // 배송지 조회
    @Override
    public AddressDTO getAddress(String addressCode)
    {
        AddressDTO addressDTO = userDAO.getAddress(addressCode);

        String[] addressArr = addressHandler.splitAddress(addressDTO.getAddress());
        addressDTO.setAddressArr(addressArr);

        String[] telArr = telHandler.splitTel(addressDTO.getRecipientTel());
        addressDTO.setRecipientTelArr(telArr);

        return addressDTO;
    }

    // 배송지 등록
    @Override
    public void addAddress(AddressDTO addressDTO)
    {
        addressDTO.setAddress(addressHandler.combineAddress(addressDTO.getAddressArr()));
        addressDTO.setRecipientTel(telHandler.combineTel(addressDTO.getRecipientTelArr()));
        userDAO.addAddress(addressDTO);
    }

    // 배송지 변경
    @Override
    public void updateAddress(AddressDTO addressDTO)
    {
        addressDTO.setAddress(addressHandler.combineAddress(addressDTO.getAddressArr()));
        addressDTO.setRecipientTel(telHandler.combineTel(addressDTO.getRecipientTelArr()));

        if(addressDTO.getDefaultDeliveryAddress().equals("Y"))
            userDAO.unCheckDefaultAddress(addressDTO);

        userDAO.updateAddress(addressDTO);
    }

    // 배송지 삭제
    @Override
    public void deleteAddress(AddressDTO addressDTO)
    {
        userDAO.deleteAddress(addressDTO);
    }

    // 기본 배송지 불러오기 (주문 페이지용)
    @Override
    public AddressDTO getDefaultAddress(UserDTO loginUser)
    {
        return userDAO.getDefaultAddress(loginUser);
    }

    @Override
    public Integer getReviewCount(OrderDTO orderDTO)
    {
        Integer reviewCount = userDAO.getReviewCount(orderDTO);
        return reviewCount;
    }

    @Override
    @Transactional
    public String postReview(ReviewDTO reviewDTO, MultipartFile[] fileArr)
    {
        Integer result;
        HashMap<String,Object> ratingMap = new HashMap<String,Object>();

        // 1. 리뷰 등록
        result = userDAO.postReview(reviewDTO);

        log.info("리뷰 등록 통과");

        if(result < 1)
            return "fail";

        // 2. 리뷰 코드를 얻어와서 평점 정보 등록
        reviewDTO.setReviewCode(userDAO.getMyReviewCode(reviewDTO));
        Float[] rateArr = reviewDTO.getRateArr();
        String[] itemCodeArr = reviewDTO.getItemCodeArr();
        ratingMap.put("reviewCode", reviewDTO.getReviewCode());
        
//        // 회원이 평점을 선택하지 않았으면 생략
//        if(rateArr != null && itemCodeArr != null)
//        {
//            for (int i = 0; i < itemCodeArr.length; i++)
//            {
//                String itemCode = itemCodeArr[i];
//                Float rate = rateArr[i];
//                ratingMap.put("itemCode", itemCode);
//                ratingMap.put("itemRate",rate);
//
//                result = userDAO.postRate(ratingMap);
//
//                if (result < 1)
//                    return "fail";
//
//                log.info("평점등록 통과");
//            }
//        }

        String resultMessage = ratingItem(ratingMap, rateArr, itemCodeArr, "post");

        if(resultMessage.equals("fail"))
            return resultMessage;

        // 3. 평점까지 등록 완료했으면 이미지 업로드
        HashMap<String,String> imageMap = new HashMap<String,String>();
        resultMessage = uploadFiles(reviewDTO, fileArr, imageMap);

        log.info("이미지 등록 통과");

        return resultMessage;
    }

    @Override
    public ReviewDTO getReview(String orderCode)
    {
        return userDAO.getReview(orderCode);
    }

    @Override
    public List<Integer> getRate(String reviewCode)
    {
        return userDAO.getRate(reviewCode);
    }

    @Override
    public List<String> getReviewImageList(String reviewCode)
    {
        return userDAO.getReviewImageList(reviewCode);
    }

    @Override
    @Transactional
    public String updateReview(ReviewDTO reviewDTO, MultipartFile[] fileArr, String[] deleteFileArr)
    {
        HashMap<String,Object> ratingMap = new HashMap<String,Object>();

        // 1. 리뷰 업데이트
        userDAO.updateReview(reviewDTO);

        // 2. 평점 업데이트
        String reviewCode = reviewDTO.getReviewCode();
        Float[] rateArr = reviewDTO.getRateArr();
        String[] itemCodeArr = reviewDTO.getItemCodeArr();
        ratingMap.put("reviewCode", reviewCode);

        String resultMessage = ratingItem(ratingMap, rateArr, itemCodeArr, "update");

        if(resultMessage.equals("fail"))
            return resultMessage;

        // 3. 삭제된 기존 이미지 파일 체크 및 신규 이미지 파일 추가
        FileUploadHandler fileUploadHandler = new FileUploadHandler();
        HashMap<String,String> imageMap = new HashMap<String,String>();
        imageMap.put("reviewCode", reviewCode);

        // 삭제된 파일 서버에서 삭제
        if(deleteFileArr != null)
        {
            for (String fileName : deleteFileArr)
            {
                imageMap.put("fileName",fileName);
                userDAO.deleteReviewImage(imageMap);

            }
            fileUploadHandler.deleteFile(reviewDTO.getOrderCode(), deleteFileArr, "review");

            imageMap.clear();
        }

        // 신규파일 추가
        resultMessage = uploadFiles(reviewDTO, fileArr, imageMap);

        return resultMessage;
    }

    @Override
    public void deleteReview(ReviewDTO reviewDTO)
    {
        userDAO.deleteReview(reviewDTO);

        FileUploadHandler fileUploadHandler = new FileUploadHandler();
        fileUploadHandler.deleteDirectory(reviewDTO.getOrderCode(), "review");
    }

    @Override
    public List<ReviewDTO> getItemReviewList(String itemCode)
    {
        return userDAO.getItemReviewList(itemCode);
    }

    @Override
    public Integer getItemReviewCount(String itemCode)
    {
        return userDAO.getItemReviewCount(itemCode);
    }


    // 서비스 내에서 사용하는 공통 코드 영역
    
    // 상품 평점
    private String ratingItem(HashMap<String, Object> ratingMap, Float[] rateArr, String[] itemCodeArr, String requestType)
    {
        Integer result;

        // 24.04.03 itemCode를 itemRates 테이블에 저장하므로 리뷰 출력을 위해 itemCode는 반드시 저장되어야 함.
        for (int i = 0; i < itemCodeArr.length; i++)
        {
            String itemCode = itemCodeArr[i];
            Float rate;

            rate = rateArr[i];
            ratingMap.put("itemRate",rate);
            ratingMap.put("itemCode", itemCode);

            if(requestType.equals("post"))
                result = userDAO.postRate(ratingMap);
            else if(requestType.equals("update"))
                result = userDAO.updateRate(ratingMap);
            else
                result = 0;

            if (result < 1)
                return "fail";

            log.info("평점등록 통과");
        }
        return "success";
    }
    
    // 파일 업로드
    private String uploadFiles(ReviewDTO reviewDTO, MultipartFile[] fileArr, HashMap<String, String> imageMap)
    {
        String url;
        Integer result;
        FileUploadHandler fileUploadHandler = new FileUploadHandler();
        if(fileArr != null)
        {
            for (MultipartFile multipartFile : fileArr)
            {
                url = "/img/reviews/"+ reviewDTO.getOrderCode()+"/"+multipartFile.getOriginalFilename();

                imageMap.put("reviewCode", reviewDTO.getReviewCode());
                imageMap.put("imageUrl",url);

                result = userDAO.postReviewImage(imageMap);

                if(result < 1)
                    return "fail";
            }

            fileUploadHandler.fileUpload(fileArr, "review", reviewDTO.getOrderCode());
        }
        return "success";
    }
}
