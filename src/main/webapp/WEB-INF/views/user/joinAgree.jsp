<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<link rel="stylesheet" type="text/css" href="/resources/css/join.css" />

<script type="text/javascript">
$(document).ready(function() {
	$("#btnNext").click(function() { 
		
		var form = termsForm; //#termsForm
		console.log(form.agree1.checked ); //첫번째 checkbox 체크여부 true = checked, false = not checked
		console.log(form.agree2.checked ); //두번째 checkbox 체크여부 true = checked, false = not checked
		
		if( form.agree1.checked == true && form.agree2.checked == true ) { //체크박스 둘 다 체크된 경우(true, ture)
			location.href = './joinInfo'; //정보입력페이지로 이동
	
		} else { //체크박스 하나라도 체크 안 된 경우
			alert("이용약관 및 개인정보 수집 및 이용에 대한 안내 모두 동의해주세요.");
		}
	})
});
</script>


<div class="container" id="agreecontainer">
	<div class="pageHeader">
		<h2>약관동의</h2>
	</div><!-- End pageHeader -->
	
	<div class="pageContent" id="agreePageContent">
		<form id="termsForm" name="agreement" role="form" onsubmit="return send(this)">
			<div class="terms">
				<label>이용약관 <span id="required">(필수)</span></label>
				<br>
				<div class="termsBox">
					<p>
					제1조 목적<br>
					본 이용약관은 “어느 날, 제주”(이하 "사이트")의 서비스의 이용조건과 운영에 관한 제반 사항 규정을 목적으로 합니다.<br><br>
					제2조 용어의 정의<br>
					본 약관에서 사용되는 주요한 용어의 정의는 다음과 같습니다.<br>
					① 회원 : 사이트의 약관에 동의하고 개인정보를 제공하여 회원등록을 한 자로서, 사이트와의 이용계약을 체결하고 사이트를 이용하는 이용자를 말합니다.<br>
					② 이용계약 : 사이트 이용과 관련하여 사이트와 회원간에 체결 하는 계약을 말합니다.<br>
					③ 회원 아이디(이하 "ID") : 회원의 식별과 회원의 서비스 이용을 위하여 회원별로 부여하는 고유한 문자와 숫자의 조합을 말합니다.<br>
					④ 비밀번호 : 회원이 부여받은 ID와 일치된 회원임을 확인하고 회원의 권익 보호를 위하여 회원이 선정한 문자와 숫자의 조합을 말합니다.<br>
					⑤ 운영자 : 서비스에 홈페이지를 개설하여 운영하는 운영자를 말합니다.<br>
					⑥ 해지 : 회원이 이용계약을 해약하는 것을 말합니다.
					</p>
				</div><!-- End termsBox -->
			</div><!-- End terms -->
			
			<label id="checkbox1" class="checkbox-inline">
				<input type="checkbox" style="width: 15px; height: 15px;" id="checkbox1" name="agree1" value="">
				<span id="agreeMsg">사이트 이용약관에 동의합니다.</span>
			</label>
			
			<br><br><br>
		    
		    <div class="terms">
		    	<label>개인정보 수집 및 이용에 대한 동의 <span id="required">(필수)</span></label> 
				<br>	
				<div class="termsBox">
					<p>
					어느 날, 제주(이하 ‘회사’라 한다)는 개인정보 보호법 제30조에 따라 정보 주체의 개인정보를 보호하고 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리지침을 수립, 공개합니다.<br><br>
					1. 개인정보 수집목적 및 이용목적<br>
					(1) 홈페이지 회원 가입 및 관리<br>
					회원 가입 의사 확인, 회원제 서비스 제공에 따른 본인 식별․인증, 회원자격 유지․관리, 제한적 본인확인제 시행에 따른 본인확인, 서비스 부정 이용 방지, 만 14세 미만 아동의 개인정보 처리시 법정대리인의 동의 여부 확인, 각종 고지․통지, 고충 처리 등의 목적<br>
					(2) 재화 또는 서비스 제공<br>
					물품 배송, 서비스 제공, 계약서․청구서 발송, 콘텐츠 제공, 맞춤 서비스 제공, 본인인증, 연령인증, 요금 결제 및 정산, 채권추심 등의 목적<br>
					(3) 고충 처리<br>
					민원인의 신원 확인, 민원사항 확인, 사실조사를 위한 연락․통지, 처리 결과 통보 등<br>
					2. 수집하는 개인정보 항목<br><br>
					ID, 성명, 비밀번호, 주소, 휴대폰 번호, 이메일, 14세 미만 가입자의 경우 법정대리인 정보<br>
					3. 개인정보 보유 및 이용기간<br>
					<em>회원탈퇴 시까지</em> (단, 관계 법령에 보존 근거가 있는 경우 해당 기간 시까지 보유, 개인정보처리방침에서 확인 가능)
					</p>
				</div><!-- End termsBox -->
			</div><!-- End terms -->
			
			<label id="checkbox2" class="checkbox-inline">
				<input type="checkbox" style="width: 15px; height: 15px;" id="checkbox2" name="agree2" value="">
				<span id="agreeMsg">개인정보 수집 및 이용에 동의합니다.</span>
			</label>
			
			<br><br>

			<div id="btnGroupAgree" align="center">
				<button type="reset" class="btn" id="btnBack" onclick="location.href='/'">이전</button>
				<button type="button" class="btn" id="btnNext">다음</button>
			</div><!-- End btn -->
		</form><!-- End termsForm -->
		
	</div><!-- End pageContent -->
</div><!-- End container -->

<c:import url="/WEB-INF/views/layout/footer.jsp" />
