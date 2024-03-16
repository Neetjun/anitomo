package com.anitomo.user;

import com.anitomo.dto.UserDTO;
import com.anitomo.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
@Slf4j
public class UserController
{
    UserService userService;
    UserDTO userDTO;

    public UserController(UserService userService)
    {
        this.userService = userService;
    }

    // 회원가입 폼
    @GetMapping
    public String userRegister()
    {
        return "userRegistrationForm";
    }

    // 회원가입
    @PostMapping
    public String userRegister(UserDTO userDTO, RedirectAttributes ra)
    {
        String result = userService.registerUser(userDTO);

        log.info("회원가입 결과 메세지 조회 = {}",result);

        if(result.equals("success"))
            return "redirect:/user/result";
        else
        {
            ra.addFlashAttribute("errorType", "userRegistrationError");
            return "redirect:/";
        }

    }

    // 회원가입 결과 페이지
    @GetMapping("result")
    public String showUserRegisterResult()
    {
        return "userRegistrationResult";
    }

    // 아이디 중복검사
    @GetMapping("idcheck")
    @ResponseBody
    public String checkId(@RequestParam String userId)
    {
        String result;

        result = userService.checkId(userId);

        return result;
    }

    // 비밀번호 유효성 검사
    @GetMapping("pwcheck")
    @ResponseBody
    public String checkPw(@RequestParam String userPw)
    {
        String result;

        result = userService.checkPw(userPw);

        return result;
    }

    // 로그인 폼
    @GetMapping("login")
    public String login()
    {
        return "loginForm";
    }

    // 로그인
    @PostMapping("login")
    public String login(UserDTO userDTO, HttpSession session, RedirectAttributes ra)
    {
        UserDTO loginUser = userService.login(userDTO);

        if(loginUser == null)
        {
            ra.addFlashAttribute("errorType", "loginError");
            return "redirect:/user/login";
        }
        else
        {
            session.setAttribute("loginUser",loginUser);
            return "redirect:/";
        }
    }

    // 로그아웃
    @GetMapping("logout")
    public String logout(HttpSession session, HttpServletRequest request)
    {
        session.invalidate();
        log.info("referer = {}",request.getHeader("referer"));
        return "redirect:"+request.getHeader("referer");
    }
}
