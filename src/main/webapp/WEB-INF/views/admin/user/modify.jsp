<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/WEB-INF/views/layout/adminHeader.jsp" />

<link rel="stylesheet" type="text/css" href="/resources/css/adminUser.css" />

<script type="text/javascript"></script>

<div class="container">
	<div class="pageHeader">
		<span class="pull-left"><span id="title">회원정보</span> ＞ 정보수정</span><br>
		<hr>
	</div><!-- End pageHeader -->
	
	<div class="pageContent">
		<%-- 정보 수정 폼 --%>
		<form id="modifyForm" role="form" action="/admin/user/modify" method="post">
			<input type="hidden" name="userNo" value="${user.userNo}">
			
			<%-- 정보 테이블 --%>
			<table id="tbInfoModify" class="table">
				<tr>
					<th>아이디</th>
					<td><input type="text" class="form-control" id="userId" name="userId" value="${user.userId}" readonly> </td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" class="form-control" id="userPw" name="userPw" placeholder="비밀번호를 입력해주세요"></td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" class="form-control" id="userName" name="userName" value="${user.userName}"></td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td><input type="text" class="form-control" id="userNick" name="userNick" value="${user.userNick}" readonly></td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td><input type="date" class="form-control" id="userBirhDate" name="userBirthDate" value="<fmt:formatDate value="${user.userBirthDate}" pattern="yyyy-MM-dd"/>"></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="email" class="form-control" id="userEmail" name="userEmail" value="${user.userEmail}"></td>
				</tr>
				<tr>
					<th>휴대전화번호</th>
					<td><input type="tel" class="form-control" id="userPhone" name="userPhone" value="${user.userPhone}"></td>
				</tr>
				<tr>
					<th>주소</th>
					<td>
						<input type="text" class="form-control" id="userAddress" name="userAddress" value="${user.userAddress}"><br>
						<input type="text" class="form-control" id="userAddressDetail" name="userAddressDetail" value="${user.userAddressDetail}">
					</td>
				</tr>
			</table>
		
			<div id="btnGroupInfoModify" align="center">
				<button type="button" class="btn" id="btnCancle" onclick="location.href='info?userNo='+${user.userNo}">취소</button>
				<button type="submit" class="btn" id="btnUpdate">등록</button>
			</div><!-- End btn -->
		</form><!-- End modifyForm -->
		
	</div><!-- End pageContent -->
</div><!-- End container -->

<c:import url="/WEB-INF/views/layout/adminFooter.jsp" />
