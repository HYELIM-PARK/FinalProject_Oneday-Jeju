package jeju.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import jeju.dto.JejuUser;
import jeju.service.face.LoginService;

@Controller
@RequestMapping(value = "/member")
public class LoginController {
	
	@Autowired private LoginService loginService;
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	
	//로그인 폼
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void login( Model model, @CookieValue(value = "cId", required = false) Cookie idCookie) {
		
		logger.info("/member/login [GET]");
		
//		JejuUser loginInfo = new JejuUser();
//		
//		if(idCookie != null) {
//			loginInfo.setUserId(idCookie.getValue());
//		}
//		model.addAttribute("loginInfo", loginInfo);
		
	}
	
	
	//로그인 처리
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView loginProc(
			JejuUser login
			, HttpSession session
			, HttpServletResponse response
			
			) {
		
		logger.info("/member/login [POST]");
		
		ModelAndView mav = new ModelAndView();

		//로그인 확인
		boolean isLogin = loginService.login(login);
		
		//메일 인증여부 확인
		boolean isMail = loginService.mailAuth(login);
		
		

		//쿠키 생성 및 설정
		Cookie idCookie = new Cookie("userInputId", login.getUserId()); //쿠키이름을 userInputId로 생성
		idCookie.setPath("/");
		
		
		//세션 설정
		if (isLogin == true && isMail == true) { //로그인 성공
			
			mav.setViewName("redirect:/");
			
			session.setAttribute("login", true);
			session.setAttribute("id", login.getUserId());
			session.setAttribute("nick", loginService.getNickData(login));
			session.setAttribute("grade", loginService.getGradeData(login));
			session.setAttribute("uno", loginService.getUsernoData(login));
			session.setAttribute("profile", loginService.getProfileData(login));
			
			idCookie.setMaxAge(60*60*24*7); //쿠키 유지 기간을 7일로 지정
			
			
		} else if (isLogin == true && isMail == false) {
			
			mav.setViewName("member/login");
			mav.addObject("msg", "mailfail");
			
		} else {
			mav.setViewName("member/login");
			mav.addObject("msg", "failure");
			
			idCookie.setMaxAge(0);
			
		}
//		response.addCookie(idCookie); //response에 Cookie 추가
		logger.info((String) session.getAttribute("id"));
		logger.info((String) session.getAttribute("profile"));
		return mav;
	}
	
	
	//로그아웃 처리
	@RequestMapping(value = "/logout")
	public String logout(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:/";
	}
	
	
	
	//아이디 찾기
	@RequestMapping(value = "/findid", method = RequestMethod.GET)
	public String findIdView(Model model) {
		logger.info("/member/findid [GET]");
		
		return "member/findid";
	}
	
	
	//아이디 찾기 처리
	@RequestMapping(value = "/findid", method = RequestMethod.POST)
	public String findId(
			@RequestParam("inputName_1") String name
			, @RequestParam("inputPhone_1") String phone
			, Model model
			) {
		
		logger.info("/member/findid [POST]");
		
		//아이디 찾기
		String resultid = loginService.getSearchId(name, phone);
		logger.info(resultid);
		
		model.addAttribute("findId", resultid);
		
		return "member/resultid";
	}
	
	
	//비밀번호 찾기
	@RequestMapping(value = "/findpw", method = RequestMethod.GET)
	public String findPwView(Model model) {
		logger.info("/member/findpw [GET]");
		
		return "member/findpw";
	}
	
	
	//비밀번호 찾기 처리
	@RequestMapping(value = "/findpw", method = RequestMethod.POST)
	public String findPw(
			@RequestParam("inputId_2") String id
			, @RequestParam("inputEmail_2") String email
			, Model model
			) {
		
		logger.info("/member/findpw [POST]");
		
		//비밀번호 찾기
		String resultpw = loginService.getSearchPw(id, email);
		logger.info("findPw controller - 비밀번호 찾기: {}", resultpw);
		
		model.addAttribute("findPw", resultpw);
		
		
		return "member/resultpw";
	}
	
	
//	@RequestMapping(value="/kakaologinForm")
//	public String kakaoLogin(HttpSession session) {
//		String url = "https://kauth.kakao.com/oauth/authorize?client_id=bb1bf9279e4ad4e32eca330dc95e24fd&redirect_uri=http://localhost:8088/member/kakaologin&response_type=code";
//		
//		return "redirect:"+url;
//	}
	
//	@RequestMapping(value="/kakaologin")
//	public String kakaoLogin(String code, HttpSession session) {
//		logger.info("/kakaologin code: {}", code);
//		boolean isJoin = false;
//		
//		String accessToken = loginService.kakaoGetAccessToken(code);
//		logger.info("accessToken: {}", accessToken);
//		HashMap<String, Object> userInfo = loginService.getUserInfo(accessToken);
//		for (String e : userInfo.keySet()) {
//			logger.info("{}: {}", e, userInfo.get(e));
//		}
//		
//		
//		return "redirect:/";
//	}

	


}
