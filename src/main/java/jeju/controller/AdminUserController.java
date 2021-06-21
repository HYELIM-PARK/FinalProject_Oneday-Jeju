package jeju.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jeju.dto.JejuUser;
import jeju.service.face.AdminUserService;
import jeju.util.Paging;

@Controller
@RequestMapping("/admin/user")
public class AdminUserController {

	private static final Logger logger = LoggerFactory.getLogger(AdminUserController.class);

	@Autowired private AdminUserService adminUserService;
	
	@RequestMapping(value="/list")
	public void getList(Paging inData, Model model) {
//		logger.info("/admin/user/list [GET]");
		
		//페이징 계산
		Paging paging = adminUserService.getPaging(inData);	
		//검색조건 적용
		paging.setCondition(inData.getCondition());
		//검색어 적용
		paging.setSearch(inData.getSearch());
//		logger.info("페이징: {}", paging);		
		
		//목록 조회
		List<JejuUser> userList = adminUserService.getList(paging);
		for(int i=0; i < userList.size(); i++) {
//			logger.info(userList.get(i).toString());
		}
		//목록 전달
		model.addAttribute("list", userList);
		//페이징 적용
		model.addAttribute("paging", paging);
	}
	
	@RequestMapping(value = "/info")
	public String getInfo(JejuUser userInfo, Model model) {
//		logger.info("/admin/user/info [GET]");
//		logger.info("userNo : {}", userInfo.toString());
		
		//정보 조회
		userInfo = adminUserService.getInfo(userInfo);
//		logger.info("사용자정보 : {}", userInfo.toString());
		
		//정보 전달
		model.addAttribute("info", userInfo);
		
		return "admin/user/info";
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public String modify(JejuUser user, Model model) {
//		logger.info("/admin/user/modify [GET]");
//		logger.info("userNo : {}", user.toString());
		
		//정보 조회
		user = adminUserService.getInfo(user);
//		logger.info("사용자정보 : {}", user.toString());
		
		//정보 전달
		model.addAttribute("user", user);
		
		return "admin/user/modify";
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modifyProcess(JejuUser user) {
//		logger.info("/admin/user/modify [POST]");
//		logger.info("사용자정보 수정 : {}", user);
		
		//정보 수정
		adminUserService.modify(user); //정보 수정
		
		//정보조회 페이지로 이동
		return "redirect:/admin/user/info?userNo="+user.getUserNo();
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String delete(JejuUser user) {
//		logger.info("/admin/user/delete [GET]");
		
		//계정 삭제
		adminUserService.delete(user);
		
		//목록 페이지로 이동
		return "redirect:/admin/user/list";
	}
	
	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public String create() {
//		logger.info("/admin/user/create [GET]");
		return "/admin/user/create";
	}
	
	@ResponseBody
	@RequestMapping(value = "/create/checkId", method = RequestMethod.GET)
	public int checkId(@RequestParam("id") String userId) {
		
		//아이디 중복조회 결과값 전달
		return adminUserService.checkId(userId);
	}
	
	@ResponseBody
	@RequestMapping(value = "/create/checkNick", method = RequestMethod.GET)
	public int checkNick(@RequestParam("nick") String userNick) {
		
		//닉네임 중복조회 결과값 전달
		return adminUserService.checkNick(userNick);
	}
	
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	public String createProcess(JejuUser user) {
//		logger.info("/admin/user/create [POST]");
//		logger.info("생성할 관리자계정 정보 : {}", user.toString());
	
		//관리자 계정 생성
		adminUserService.createAdmin(user);
		
		//정보조회 페이지로 이동
		return "redirect:/admin/user/list";
	}
}
