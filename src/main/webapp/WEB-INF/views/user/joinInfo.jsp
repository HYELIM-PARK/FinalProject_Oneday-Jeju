<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/WEB-INF/views/layout/header.jsp" />

<link rel="stylesheet" type="text/css" href="/resources/css/join.css" />

<!-- 다음 우편api 적용 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- joinInfo.js 적용 -->
<script src="/resources/js/joinInfo.js"></script>


<div class="container" id="infocontainer">
	<div class="pageHeader">
		<h2>회원가입</h2>
	</div><!-- End pageHeader -->
	
	<div class="pageContent" id="infoPageContent">
		
		<!-- 회원정보입력 폼 -->
		<form id="infoForm" class="form-horizontal" role="form" action="/user/joinInfo" method="post">
			<span id="requiredMsg" class="pull-right"><span id="required">*</span>필수입력사항</span><br>
			
			<!-- 정보 입력 테이블 -->
			<table id="tbInfo" class="table">
				<tr>
					<th><span id="required">*</span>아이디</th>
					<td>
						<input type="text" class="col-md-5 form-control" id="userId" name="userId" maxlength="12" placeholder="5~12자리의 영문, 숫자" required>
						<span id="msgId" class="msg"></span>
					</td>
				</tr>
				<tr>
					<th><span id="required">*</span>비밀번호</th>
					<td>
						<input type="password" class="form-control" id="userPw" name="userPw" maxlength="15" placeholder="8~15자리의 영문, 숫자" required>
						<span id="msgPw" class="msg"></span>
					</td>
				</tr>	
				<tr>
					<th><span id="required">*</span>비밀번호 확인</th>
					<td>
						<input type="password" class="form-control" id="checkPw" maxlength="15" placeholder="비밀번호를 한 번 더 입력해주세요" required>
						<span id="msgChkPw1" class="msg"></span>
						<span id="msgChkPw2"></span>
					</td>
				</tr>	
				<tr>
					<th><span id="required">*</span>이름</th>
					<td>
						<input type="text" class="form-control" id="userName" name="userName" maxlength="20" placeholder="실명으로 입력해주세요" required>
						<span id="msgName" class="msg"></span>	
					</td>
				</tr>
				<tr>
					<th><span id="required">*</span>닉네임</th>
					<td>
						<input type="text" class="form-control" id="userNick" name="userNick" maxlength="20" placeholder="20자 이내의 한글, 영문, 숫자" required>
						<span id="msgNick" class="msg"></span>
					</td>
				</tr>
				<tr>
					<th><span id="required">*</span>생년월일</th>
					<td><input type="date" class="form-control" id="userBirthDate" name="userBirthDate" required></td>
				</tr>
				<tr>
					<th><span id="required">*</span>이메일</th>
					<td><input type="email" class="form-control" id="userEmail" maxlength="30" name="userEmail" required></td>
				</tr>
				<tr>
					<th><span id="required">*</span>휴대전화번호</th>
					<td>
						<input type="tel" class="form-control" id="userPhone" name="userPhone" maxlength="11" placeholder="숫자만 입력해주세요" required>
						<span id="msgPhone" class="msg"></span>
					</td>
				</tr>
				<tr>
					<th rowspan="3"><span id="required">*</span>주소</th>
					<td>
						<input type="text" class="form-control" id="userZipcode" name="userZipcode" required readonly="readonly">
						<button type="button" class="btn" id="btnZipcode" onclick="openDaumPostcode()">우편번호</button>
					</td>
				<tr>	
					<td><input type="text" class="form-control" id="userAddress" name="userAddress" maxlength="50" required readonly="readonly"></td>
				</tr>
				<tr>
					<td><input type="text" class="form-control" id="userAddressDetail" name="userAddressDetail" maxlength="50" placeholder="상세주소"></td>
				</tr>				
			</table>
			
			<div id="btnGroupInfo" align="center">
				<button type="submit" class="btn" id="btnJoin">가입하기</button>
			</div><!-- End btn -->
		</form><!-- End inputForm -->
		
	</div><!-- End pageContent -->
</div><!-- End container -->

<c:import url="/WEB-INF/views/layout/footer.jsp" />
