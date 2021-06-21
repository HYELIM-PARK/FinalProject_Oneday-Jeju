<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<!--로그인 css -->
<link rel="stylesheet" href="/resources/css/login.css" type="text/css">

<script type="text/javascript">
$(document).ready(function() {
	
	//회원가입 버튼 클릭 시
	$("#joinBtn").click(function() {
		console.log("#joinBtn clicked");
		location.href = "/user/joinAgree";
		
	})
	
	//로그인 버튼 클릭 시 값이 없을 때 처리
	$("#loginBtn").click(function() {
		var userId = $("#userId").val()
		var userPw = $("#userPw").val()
		
		if(userId == "") {
			alert("아이디를 입력하세요")
			$("#userId").focus();
			return;
		}
		if(userPw == "") {
			alert("비밀번호를 입력하세요")
			$("#userPw").focus();
			return;
		}
	})
	
	

	
	
	//'아이디 기억하기'
	//컨트롤러에 저장된 쿠키값을 가져와서 아이디 input태그 안에 넣어줌. 없으면 공백으로 들어감.
    var userInputId = getCookie("userInputId");
    $("input[name='userId']").val(userInputId); 
     
    if($("input[name='userId']").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
    	$("#idcheck").attr("checked", true); // '아이디 기억하기'를 체크 상태로 두기.
    }
     
    $("#idcheck").change(function(){ // 체크박스에 변화가 있다면,
        if($("#idcheck").is(":checked")){ // '아이디 기억하기' 체크했을 때,
            var userInputId = $("input[name='userId']").val(); //저장된 쿠키값을 가져옴
            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
        } else if ($("#idcheck").is(":checked") == false) { // '아이디 기억하기' 체크 해제 시,
            setCookie("userInputId", '', '-1'); //쿠키를 이전 상태로 돌려줌
        }
    });
     
    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우에도 쿠키 저장.
    $("input[name='userId']").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
        if($("#idcheck").is(":checked")){ // '아이디 기억하기' 를 체크한 상태라면,
            var userInputId = $("input[name='userId']").val();
            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
        }
    });
	
	
});
	

//쿠키를 위한 함수 
//쿠키 Set
function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}

//쿠키 삭제
function deleteCookie(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}

//쿠키 Get
function getCookie(cookieName) {
    cookieName = cookieName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';
    if(start != -1){
        start += cookieName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cookieValue = cookieData.substring(start, end);
    }
    return unescape(cookieValue);
}
		
	
	
	
    
	
	




</script>





<div class="container" align="center">



<div class="sub_title">로그인</div>

<form action="/member/login" method="post" class="form-signin" autocomplete="off">
	
	<div class="input-container">
		<input type="text" id="userId" name="userId"/>
		<label for="userId">Userid </label>
		<div class="bar"></div>
	</div>
	
	<div class="input-container">
		<input type="password" id="userPw" name="userPw"/>
		<label for="userPw">Password </label>
		<div class="bar"></div>
	</div>
	
	<c:if test="${msg eq 'failure'}">
		<div style="color:red; margin: 20px;">
			아이디 또는 비밀번호를 확인해주세요.
		</div>
	</c:if>
	<c:if test="${msg eq 'mailfail'}">
		<div style="color:red; margin: 20px;">
			이메일 인증을 완료해주세요.
		</div>
	</c:if>
	
	<div class="idcheck-container">
		<input type="checkbox" id="idcheck" >
		<label for="idcheck"><span>아이디 기억하기</span></label>
	</div>	
	
	<div class="button-container">
		<button type="button" id="joinBtn" ><span>회원가입 하기</span></button><br>
		<button id="loginBtn" ><span>로그인 <i class="fa fa-sign-in"></i></span></button>
<!-- 		<a href="/member/kakaologinForm"> -->
<!-- 			<img src="/resources/image/kakao_login_medium_narrow.png" width="250px"> -->
<!-- 		</a> -->
	</div>
	
	<div class="footer">
		<label>아이디를 잊으셨나요? <a href="/member/findid">아이디 찾기</a></label><br>
		<label>비밀번호를 잊으셨나요? <a href="/member/findpw">비밀번호 찾기</a></label>
	</div>

</form>


</div><!-- .container -->






<c:import url="/WEB-INF/views/layout/footer.jsp" />
