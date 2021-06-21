<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>어느 날, 제주</title>
<link rel="shortcut icon" href="/resources/image/MAuJqhWr.ico">
<!-- jQuery 2.2.4 -->
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>

<!-- Bootstrap 3.3.2 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<!--FontAwsome 아이콘  -->
<script src="https://kit.fontawesome.com/5e1e2577f7.js" crossorigin="anonymous"></script>
<!--웹폰트(Spoqa Han Sans Neo )  -->
<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css' rel='stylesheet' type='text/css'>
<!--메인 css -->
<link rel="stylesheet" href="/resources/css/layout.css" type="text/css">

<!-- 카카오 api -->
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>



<script type="text/javascript">
$(document).ready(function(){
	//프로필 마이페이지 말풍선 설정
	 $('#mypage').click(function(){
		if($('.balloon').hasClass("hidden")){
			$('.balloon').toggleClass("hidden show")
		}
	})
	$('.balloon').mouseleave(function(){
		if($('.balloon').hasClass("show")){
			$('.balloon').toggleClass("show hidden")
		}
	})
	 
})
</script>
</head>
<body>

<header>
	<a href="/" class="logo"><img src="/resources/image/logo2.png" alt="어느 날, 제주 로고" ></a>
	
	
	<c:if test="${empty login }">
		<div class="nologin" style="right: 40px; position : absolute">
			<a href="/member/login">로그인</a>
			| 
			<a href="/user/joinAgree">회원가입</a>
		</div>
	</c:if>
	<c:if test="${login}">
		<span class="welcome" style="margin-top: 20px;"><strong>${nick} </strong>님 환영합니다!</span>
		
		<div class="login" style="margin: 20px 20px 0 0;">
			
			<c:choose>
				<c:when test="${sessionScope.profile ne null}">
					<img id="mypage" class="img-circle" alt="user" src="../resources/upload/${sessionScope.profile}" style="width:70px; height:70px;">
				</c:when>
				<c:otherwise>
					<img id="mypage" class="img-circle" alt="user" src="../resources/upload/user.png" style="width:70px; height:70px;">
				</c:otherwise>
			</c:choose>
<%-- 			<img id="mypage" class="img-circle" alt="user" src="../resources/upload/${sessionScope.profile}" style="width:70px; height:70px;"> --%>
			
			<c:if test="${grade eq '2' }">
				<div class="balloon hidden">	
				<p><a href="/member/mypage">마이페이지</a></p>
				<p><a href="/member/logout">로그아웃</a></p>
				</div>
			</c:if>
			<c:if test="${grade ne '2' }">
				<div class="balloon hidden">	
				<p><a href="/admin">관리자 페이지</a></p>
				<p><a href="/member/logout">로그아웃</a></p>
				</div>
			</c:if>
			
		</div>
	</c:if>
<nav>
	<ul class="nav_first">
	<li >
	<a href="/plan/create">여행일정</a>
	</li>
	<li >
	<a href="/expenses/plist">여행경비</a>
	</li>
	<li>
	<a href="#">커뮤니티</a>
		<ul class="nav_second">
			<li><a href="/planboard/list">일정 공유</a></li>
			<li class="devide">|</li>
			<li><a href="/review/list">여행 후기</a></li>
			<li class="devide">|</li>
			<li><a href="/notice/list">공지사항</a></li>
			<li class="devide">|</li>
			<li><a href="/qna/list">Q & A</a></li>
		</ul>
	</li>
	</ul>
</nav>
</header>

<article>

	