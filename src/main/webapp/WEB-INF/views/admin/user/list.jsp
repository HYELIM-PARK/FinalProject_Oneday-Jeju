<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/WEB-INF/views/layout/adminHeader.jsp" />

<link rel="stylesheet" type="text/css" href="/resources/css/adminUser.css" />

<script type="text/javascript">
$(document).ready(function() {
	
	//검색어 입력칸에서 엔터키 누르면 검색버튼 클릭되는 효과
	$("input[name='search']").keydown(function(e) {
//		console.log('test')
		if( e.keyCode == 13 ) {
//			console.log("enterkey")
			$("#btnSearch").click()
		}
	});
	
	//검색버튼 클릭
	$("#btnSearch").click(function() {
		location.href="./list?condition="+$("#condition").val()+"&search="+$("#search").val();
	});
	
	//관리자계정생성 모달창 열기
	$(".modal-content").load("./create");

});
</script>

<div class="container">
	<div class="pageHeader">
		<span class="pull-left"><span id="title">회원관리</span> ＞ 전체회원</span><br>
		<hr>
	</div><!-- End pageHeader -->
	
	<div class="pageContent">
		<%-- 사용자 검색 --%>
		<div id="inputSearch" class="form-inline pull-right">
			<select class="form-control" id="condition" name="condition">
				<option value="null" <c:out value="${param.condition == null ? 'selected' : ''}"/>>선택</option>
				<option value="userId" <c:out value="${param.condition eq 'userId' ? 'selected' : ''}"/>>아이디</option>
				<option value="userName" <c:out value="${param.condition eq 'userName' ? 'selected' : ''}"/>>이름</option>
				<option value="userNick" <c:out value="${param.condition eq 'userNick' ? 'selected' : ''}"/>>닉네임</option>
				<option value="userEmail" <c:out value="${param.condition eq 'userEmail' ? 'selected' : ''}"/>>이메일</option>
			</select>
			<input type="text" id="search" name="search" class="form-control" value="${param.search}">
			<button type="button" id="btnSearch" class="btn">검색</button>
		</div><!-- End search -->
		<br>
		
		<%-- 총 사용자 수 --%>
		<span id="total" class="pull left">Total : ${paging.totalCount}</span>

		<%-- 목록 테이블 --%>
		<table id="tbList" class="table table-hover" >
			<thead>
				<tr>
					<th style="width: 7%">번호</th>
					<th style="width: 13%">아이디</th>
					<th style="width: 12%">이름</th>
					<th style="width: 15%">닉네임</th>
					<th style="width: 20%">이메일</th>
					<th style="width: 15%">가입일</th>
					<th style="width: 8%">상태</th>
					<th style="width: 10%">등급</th>
				</tr>
			</thead>
		
			<tbody>
			<c:forEach items="${list}" var="list">
				<tr>
					<td>${list.userNo}</td>
					<td><a href="/admin/user/info?userNo=${list.userNo}">${list.userId}</a></td>
					<td>${list.userName}</td>
					<td>${list.userNick}</td>
					<td>${list.userEmail}</td>
					<td><fmt:formatDate value="${list.userJoinDate}" pattern="yyyy-MM-dd"/></td>
					<td>
						<c:if test="${list.userMailAuth eq null || list.userMailAuth eq ''}">-</c:if>
						<c:if test="${list.userMailAuth == 0}">미인증</c:if>
						<c:if test="${list.userMailAuth == 1}">인증</c:if>
					</td>
					<td>
						<c:if test="${list.userGrade eq null || list.userGrade eq ''}">-</c:if>
						<c:if test="${list.userGrade == 0}">최고관리자</c:if>
						<c:if test="${list.userGrade == 1}">관리자</c:if>
						<c:if test="${list.userGrade == 2}">회원</c:if>
					</td>
				</tr>
			</c:forEach>	
			</tbody>
		</table>
		
		<%-- 관리자계정 생성 버튼 --%>
		<%-- 최고관리자(userGrade == 0)계정으로 로그인했을 때만 버튼 표시 --%>
		<c:if test="${grade eq '0'}">
			<div class="pull-right">
				<button type="button" class="btn" id="btnCreate" data-toggle="modal" data-target="#create">관리자계정 생성</button>
			</div>
		</c:if>			
	
		<%-- 페이징 JSP --%>
		<jsp:include page="./paging.jsp" />
		
	</div><!-- End pageContent -->
</div><!-- End container -->

<c:import url="/WEB-INF/views/layout/adminFooter.jsp" />

<!-- #create Modal -->
<div class="modal fade" id="create" tabindex="-1" role="dialog" aria-labelledby="createLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
		</div><!-- End modal-content -->
	</div><!-- End modal-dialog -->
</div><!-- End myModal -->
