<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<link rel="stylesheet" type="text/css" href="/resources/css/join.css" />

<div class="container" id="sendMailcontainer">
	<div class="pageHeader">
		<h1>Welcome!</h1>
	</div><!-- End pageHeader -->
	
	<div class="pageContent">
		<div class="msgBox">
			<div class="msg">
				<p>${userId }님, 환영합니다!</p>
				<br><br>
				<p>
				회원가입 신청이 완료되었습니다.<br>
				입력하신 이메일(${userEmail })로 인증메일이 발송되었습니다.<br>
				이메일에 포함된 인증 링크를 통해 회원가입이 완료됩니다.<br>
				</p>
			</div><!-- End msg -->
		</div><!-- End msgBox -->
		
		<div id="btnGroupMain" align="center">
			<button type="button" class="btn" id="btnMain" onclick="location.href='/'">메인으로</button>
		</div><!-- End btn -->
		
	</div><!-- End pageContent -->
</div><!-- End container -->

<c:import url="/WEB-INF/views/layout/footer.jsp" />
