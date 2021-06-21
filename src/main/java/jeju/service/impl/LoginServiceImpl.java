package jeju.service.impl;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import jeju.dao.face.LoginDao;
import jeju.dto.JejuUser;
import jeju.service.face.LoginService;
import jeju.util.MailUtil;

@Service
public class LoginServiceImpl implements LoginService{
	
	@Autowired private LoginDao loginDao;
	
	private static final Logger logger = LoggerFactory.getLogger(LoginServiceImpl.class);


	@Override
	public boolean login(JejuUser login) {
		
		if (loginDao.selectCntUser(login) > 0) {
			
			return true;
		}
		return false;
	}
	
	@Override
	public boolean mailAuth(JejuUser login) {

		if (loginDao.selectMailAuth(login) == 1) {
			
			return true;
		}
		return false;
	}



	@Override
	public String getNickData(JejuUser login) {
		return loginDao.selectUserNick(login);
	}


	@Override
	public String getGradeData(JejuUser login) {
		return loginDao.selectUserGrade(login);
	}
	
	
	@Override
	public int getUsernoData(JejuUser login) {
		return loginDao.selectUserNo(login);
	}
	

	@Override
	public String getProfileData(JejuUser login) {
		return loginDao.selectUserStored(login);
	}


	@Override
	public String getSearchId(String name, String phone) {
		
		JejuUser userData = new JejuUser();
		userData.setUserName(name);
		userData.setUserPhone(phone);
		
		return loginDao.selectSearchId(userData);
	}


	@Override
	public String getSearchPw(String id, String email) {
		
		String result = null;
		
		JejuUser userData = new JejuUser();
		userData.setUserId(id);
		userData.setUserEmail(email);
		
		boolean isExist = loginDao.selectCntMem(userData);
		
		if(isExist) {
			
			//임시 비밀번호 생성
			int index = 0;
			char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
					'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a',
					'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
					'w', 'x', 'y', 'z' };
			
			StringBuffer sb = new StringBuffer();
			
			for (int i = 0; i < 8; i++) {
				index = (int) (charSet.length * Math.random());
				sb.append(charSet[index]);
			}
			
			String tempPw = sb.toString();
//			logger.info("임시 비밀번호 확인: " + tempPw);
			
			
			//회원 객체에 임시 비밀번호 담기
			userData.setUserPw(tempPw);
			
			//메일 전송
			MailUtil mail = new MailUtil();
			mail.sendMail(userData);
			
			//비밀번호 변경
			loginDao.updatePw(userData);
			
			result = "Success";
		
		} else {
			
			result = "Fail";
		}
		
		return result;
	}

	
//	@Override
//	public String kakaoGetAccessToken(String authoriz_code) {
//		
//		String access_Token = "";
//		String refresh_Token = "";
//        String reqURL = "https://kauth.kakao.com/oauth/token";
//        
//        
//		try {
//			logger.info("카카오 토큰 가져오기");
//			URL url = new URL(reqURL);
//			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//			
//			//POST 요청을 위해 기본값이 false인 setDoOutput을 true로
//			conn.setRequestMethod("POST");
//			conn.setDoOutput(true);
//			
//			//POST요청에 필요로 요구하는 파라미터 스트림을 통해 전송
//			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
//			StringBuilder sb = new StringBuilder();
//			sb.append("grant_type=authorization_code");
//			sb.append("&client_id=bb1bf9279e4ad4e32eca330dc95e24fd");
//			sb.append("&redirect_uri=http://localhost:8088/member/kakaologin");
//			sb.append("&code=" + authoriz_code);
//			bw.write(sb.toString());
//			bw.flush();
//			
//			//결과 코드가 200이면 성공
//			int responseCode = conn.getResponseCode();
//			logger.info("responseCode: {}", responseCode);
//			
//			//요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
//			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
//			String line = "";
//			String result = "";
//			
//			while( (line = br.readLine()) != null) {
//				result += line;
//			}
//			logger.info("response body: {}", result);
//			
//			//Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
//			JsonParser parser = new JsonParser();
//            JsonElement element = parser.parse(result);
//            
//            access_Token = element.getAsJsonObject().get("access_token").getAsString();
//            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
//            
//           
//            logger.info("access_token : {}", access_Token);
//            logger.info("refresh_token : {}", refresh_Token );
//            
//            
//            br.close();
//            bw.close();
//			
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//		
//		return access_Token;
//	}

//	@Override
//	public HashMap<String, Object> getUserInfo(String accessToken) {
//		//요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
//		HashMap<String, Object> userInfo = new HashMap<>();
//		String reqURL = "https://kapi.kakao.com/v2/user/me";
//		
//		try {
//			logger.info("유저 정보 가져오기");
//			URL url = new URL(reqURL);
//			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//			conn.setRequestMethod("POST");
//			
//			//요청에 필요한 Header에 포함될 내용
//			conn.setRequestProperty("Authorization", "Bearer " + accessToken);
//			
//			int responseCode = conn.getResponseCode();
//			logger.info("responseCode: {}", responseCode);
//			
//			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
//			
//			String line = "";
//			String result = "";
//			
//			while ((line = br.readLine()) != null) {
//				result += line;
//			}
//			logger.info("response body: {}", result);
//			
//			 
//            JsonParser parser = new JsonParser();
//            JsonElement element = parser.parse(result);
//            
//            JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
//            JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
//            
//            String nickname = properties.getAsJsonObject().get("nickname").getAsString();
//            String email = kakao_account.getAsJsonObject().get("email").getAsString();
//            String gender = kakao_account.getAsJsonObject().get("gender").getAsString();
//            String id = element.getAsJsonObject().get("id").getAsString();
//            
//            userInfo.put("nickname", nickname);
//            userInfo.put("email", email);
//            userInfo.put("gender", gender);
//            userInfo.put("id", id);
//			
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//		
//		return userInfo;
//	}






}
