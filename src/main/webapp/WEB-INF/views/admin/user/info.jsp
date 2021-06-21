<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/WEB-INF/views/layout/adminHeader.jsp" />

<link rel="stylesheet" type="text/css" href="/resources/css/adminUser.css" />

<script type="text/javascript">
$(document).ready(function() {
	//이전 버튼 클릭
	$("#btnList").click(function() {
		location.href='list';
	})
	//수정 버튼 클릭
	$("#btnModify").click(function() {
		location.href='modify?userNo='+${info.userNo}; //수정페이지로 이동
	})
	//삭제 버튼 클릭
	$("#btnDelete").click(function() {
		var result = confirm('계정을 삭제하시겠습니까? 삭제된 계정은 복원할 수 없습니다.');
		if(result){
			//확인버튼 클릭하면 삭제
			location.href='delete?userNo='+${info.userNo};
		} else { } //취소
	})
});
</script>

<div class="container">
	<div class="pageHeader">
		<span class="pull-left"><span id="title">회원관리</span> ＞ 회원정보</span><br>
		<hr>
	</div><!-- End pageHeader -->
	
	<div class="pageContent">
		<%-- 정보 테이블 --%>
		<table id="tbInfo" class="table">
			<tr>
				<th>번호</th>
				<td><input type="text" class="form-control" id="userNo" name="userNo" value="${info.userNo}" readonly></td>
			</tr>
			<tr>
				<th>아이디</th>
				<td><input type="text" class="form-control" id="userId" name="userId" value="${info.userId}" readonly> </td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" class="form-control" id="userName" name="userName" value="${info.userName}" readonly></td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td><input type="text" class="form-control" id="userNick" name="userNick" value="${info.userNick}" readonly></td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td><input type="date" class="form-control" id="userBirhDate" name="userBirthDate" value="<fmt:formatDate value="${info.userBirthDate}" pattern="yyyy-MM-dd"/>" readonly></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="email" class="form-control" id="userEmail" name="userEmail" value="${info.userEmail}" readonly></td>
			</tr>
			<tr>
				<th>휴대전화번호</th>
				<td><input type="tel" class="form-control" id="userPhone" name="userPhone" value="${info.userPhone}" readonly></td>
			</tr>
			<tr>
				<th>주소</th>
				<td>
					<input type="text" class="form-control" id="userAddress" name="userAddress" value="${info.userAddress}" readonly><br>
					<input type="text" class="form-control" id="userAddressDetail" name="userAddressDetail" value="${info.userAddressDetail}" readonly>
				</td>
			</tr>
		</table>
		
		<div id="btnGroupInfo" align="center">
			<button type="button" class="btn" id="btnList">이전</button>
			<button type="button" class="btn" id="btnModify">수정</button>
			<button type="button" class="btn" id="btnDelete">삭제</button>
		</div><!-- End btn -->

	</div><!-- End pageContent -->
</div><!-- End container -->

<c:import url="/WEB-INF/views/layout/adminFooter.jsp" />
