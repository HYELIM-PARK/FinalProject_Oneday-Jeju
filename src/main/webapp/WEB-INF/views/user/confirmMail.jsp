<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<link rel="stylesheet" type="text/css" href="/resources/css/join.css" />

<script type="text/javascript">
alert("회원가입이 최종적으로 완료되었습니다. 이제 로그인이 가능합니다.")
document.location.href="/member/login";
</script>

<div class="container">
<!-- 	<div class="pageHeader">
		<span></span>
	</div>End pageHeader
	
	<div class="pageContent">
		<div class="msgBox">
			<div class="msg">
				<h1></h1>
				<br><br>
				<p>
				</p>
				<br><br><br><br>
				<button type="button" class="btn" id="btnMain" onclick="location.href='/'">메인으로</button>
			</div>End msg
		</div>End msgBox
	</div>End pageContent -->
	
</div><!-- End container -->

<c:import url="/WEB-INF/views/layout/footer.jsp" />
