package jeju.service.face;

import java.util.HashMap;

import jeju.dto.JejuUser;

public interface LoginService {

	/**
	 * 회원 존재 유무 확인
	 * 
	 * @param login - 입력된 id, pw 정보
	 * @return 1: 존재하는 회원, 0: 존재하지 않는 회원
	 */
	public boolean login(JejuUser login);
	
	
	/**
	 * 로그인한 회원의 닉네임 가져오기
	 * 
	 * @param login - 로그인한 회원 정보 객체
	 * @return 로그인한 회원의 닉네임
	 */
	public String getNickData(JejuUser login);
	
	
	/**
	 * 로그인한 회원의 등급 정보 가져오기
	 * 
	 * @param login - 로그인한 회원 정보 객체
	 * @return 로그인한 회원의 등급 정보
	 */
	public String getGradeData(JejuUser login);
	
	
	/**
	 * 로그인한 회원의 회원번호 정보 가져오기
	 * 
	 * @param login - 로그인한 회원 정보 객체
	 * @return 로그인한 회원의 회원번호
	 */
	public int getUsernoData(JejuUser login);
	
	
	/**
	 * 로그인한 회원의 프로필 사진 정보 가져오기
	 * 
	 * @param login - 로그인한 회원 정보 객체
	 * @return 로그인한 회원의 프로필 사진 정보
	 */
	public String getProfileData(JejuUser login);
	
	
	/**
	 * 이름과 휴대폰 번호를 이용한 회원 id 찾기
	 * 
	 * @param name - 입력된 회원 이름
	 * @param phone - 입력된 회원 휴대폰 번호
	 * @return 이름, 휴대폰 번호가 일치하는 아이디 객체
	 */
	public String getSearchId(String name, String phone);
	
	
	/**
	 * id와 이메일을 이용한 회원 찾기
	 * 
	 * @param id - 입력된 id
	 * @param mail - 입력된 mail
	 * @return id, mail이 일치하는 회원 객체
	 */
	public String getSearchPw(String id, String email);


	/**
	 * 메일인증여부 확인
	 * 
	 * @param auth - 메일인증여부 컬럼 값을 담은 객체
	 * @return 1: 인증완료 0: 인증미완료
	 */
	public boolean mailAuth(JejuUser login);
	
	
	/**
	 * 카카오 접근 토큰 받아오기
	 * 
	 * @param authoriz_code - 코드
	 * @return - 토큰 반환
	 */
//	public String kakaoGetAccessToken(String authoriz_code);
	
	
	/**
	 * 카카오 유저 정보 가져오기
	 * @param accessToken - 접근 토큰
	 * @return - 유저 정보
	 */
//	public HashMap<String, Object> getUserInfo(String accessToken);
	
	
}
