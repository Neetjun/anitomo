package com.anitomo.service;

import com.anitomo.dao.UserDAO;
import com.anitomo.dto.UserDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.regex.Pattern;

@Service
@Slf4j
public class UserService
{
    private UserDAO userDAO;

    public UserService(UserDAO userDAO)
    {
        this.userDAO = userDAO;
    }

    // 회원가입
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
        userDTO.userTelHandler();
        String telRegex = "^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$";
        if(!Pattern.matches(telRegex, userDTO.getUserTelResult()))
        {
            log.info("telErr -- tel = {}", userDTO.getUserTelResult());
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

        // 회원 코드 생성 및 부여
        String userCode = "U"+(userDAO.countUser()+1);
        userDTO.setUserCode(userCode);

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

    public UserDTO login(UserDTO userDTO)
    {
        UserDTO loginUser = userDAO.login(userDTO);

        log.info("loginUser = {}",loginUser);

        if(loginUser != null)
            return loginUser;
        else
            return null;
    }
}
