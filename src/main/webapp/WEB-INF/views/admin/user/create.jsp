<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- <c:import url="/WEB-INF/views/layout/adminHeader.jsp" /> --%>

<link rel="stylesheet" type="text/css" href="/resources/css/adminUser.css" />

<script type="text/javascript">
$(document).ready(function() {
	
	$("#userId").focus(); //아이디 최초 포커스
	
	$("#msgId").hide();
	$("#msgPw").hide();
	$("#msgChkPw1").hide();
	$("#msgChkPw2").hide();
	$("#msgNick").hide();
	
	
	//아이디 중복확인
	$("#userId").blur(function() {
		var id = $("#userId").val();
		
		$.ajax({
			type: "get"
			, url: "/admin/user/create/checkId"
			, data: { id }
			, dataType: "json"
			, success: function(data) {
//				console.log("성공")
//				console.log(data)
				
				if(data >= 1) { //아이디 중복값이 있을 때
					$("#msgId").show();
					$("#msgId").html("이미 사용중인 아이디입니다.");
					$("#btnInsert").prop("disabled", true);
				
				} else if(data == 0){ //아이디 중복값이 없을 때
					if (id == "") { //아이디 입력값이 없을 때
						$("#msgId").show();
						$("#msgId").html("아이디를 입력하세요.");
						$("#btnInsert").prop("disabled", true);
					
					} else { //아이디 입력값이 있을 때
						$("#msgId").show();
						$("#msgId").html("사용 가능한 아이디입니다.");
						$("#btnInsert").prop("disabled", false);
					}			
				
				} else {
					$("#msgId").hide();
					$("#btnInsert").prop("disabled", true);
				}
			
			} //End success
			, error: function() { //AJAX 실패 시 콜백함수
				console.log("실패")
			} //End error
		}) //End ajax
	}); //End change fn
	
	
	//닉네임 중복확인
	$("#userNick").blur(function() {
		var nick = $("#userNick").val();
		
		$.ajax({
			type: "get"
			, url: "/admin/user/create/checkNick"
			, data: { nick }
			, dataType: "json"
			, success: function(data) {
//				console.log("성공")
//				console.log(data)
							
				if(data >= 1) { //닉네임 중복값이 있을 때
					$("#msgNick").show();
					$("#msgNick").html("이미 사용중인 닉네임입니다.");
					$("#btnInsert").prop("disabled", true);
				
				} else if(data == 0) { //닉네임 중복값이 없을 때
					if(nick == "") { //닉네임 입력값이 없을 때
						$("#msgNick").show();
						$("#msgNick").html("닉네임을 입력하세요.");
						$("#btnInsert").prop("disabled", true);
						
					} else { //닉네임 입력값이 있을 때
						$("#msgNick").show();
						$("#msgNick").html("사용 가능한 닉네임입니다.");
						$("#btnInsert").prop("disabled", false);						
					}

				} else {
					$("#msgNick").hide();
					$("#btnInsert").prop("disabled", true);
				}
				
			} //End success
			, error: function() { //AJAX 실패 시 콜백함수
				console.log("실패")
			} //End error
		}) //End ajax
	}); //End change fn
	
	
	//비밀번호 입력값 확인
	$("#userPw").blur(function() {
		var upw = $("#userPw").val();
		
		if(upw != "") { //비밀번호 입력값이 있을 때
			$("#msgPw").hide();
			$("#btnInsert").prop("disabled", false);
		
		} else { //비밀번호 입력값이 없을 때
			$("#msgPw").show();
			$("#msgPw").html("비밀번호를 입력하세요.");
			$("#btnInsert").prop("disabled", true);
		}
	});
	
	//비밀번호 일치여부 확인
	$("#checkPw").blur(function() {
		var upw = $("#userPw").val();
		var cpw = $("#checkPw").val();
		
		if(upw != "" && cpw == "" ) { //비밀번호 확인 입력값이 없을 때
			$("#msgChkPw1").show();
			$("#msgChkPw2").hide();
			$("#msgChkPw1").html("비밀번호를 한 번 더 입력하세요.");
			$("#btnInsert").prop("disabled", true);
		
		} else if(upw != "" && cpw != "") { //둘 다 입력값이 있을 때
			if(upw == cpw) { //입력값이 일치할 때
				$("#msgChkPw2").show();
				$("#msgChkPw1").hide();
				$("#msgChkPw2").html("비밀번호가 일치합니다.");
				$("#btnInsert").prop("disabled", false);
			
			} else { //입력값이 일치하지 않을 때
				$("#msgChkPw1").show();
				$("#msgChkPw2").hide();
				$("#msgChkPw1").html("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
				$("#btnInsert").prop("disabled", true);
			}
		
		} else {  //비밀번호 입력값이 없을 때
			$("#msgChkPw1").hide();
			$("#msgChkPw2").hide();
			$("#btnInsert").prop("disabled", true);
		}
	});
	
	
	//모달창 닫으면 목록페이지 새로고침(모달창 입력값 리셋하기 위한 처리)
	$("#create").on('hidden.bs.modal', function (e) {
		location.href="./list";
	});
	
});
</script>


<div class="modal-container">
	<div class="title">
		<h3>관리자 계정 생성</h3>
	</div><!-- End title -->
	
	<div class="modal-body">
		<%-- 정보 입력 폼 --%>
		<form id="createForm" role="form" action="/admin/user/create" method="post">
							
			<%-- 정보 입력 테이블 --%>
			<table id="tbCreate" class="table">
				<tr>
					<th>관리자 아이디</th>
					<td>
						<input type="text" class="form-control" id="userId" name="userId" maxlength="12" placeholder="관리자 아이디" required>
						<span id="msgId" class="msg"></span>
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" class="form-control" id="userPw" name="userPw" maxlength="15" placeholder="비밀번호" required>
						<span id="msgPw" class="msg"></span>
					</td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td>
						<input type="password" class="form-control" id="checkPw" name="checkPw" maxlength="15" placeholder="비밀번호 확인" required>
						<span id="msgChkPw1" class="msg"></span>
						<span id="msgChkPw2"></span>
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" class="form-control" id="userName" name="userName" maxlength="20" placeholder="이름" required></td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td>
						<input type="text" class="form-control" id="userNick" name="userNick" maxlength="20" placeholder="닉네임" required>
						<span id="msgNick" class="msg"></span>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="email" class="form-control" id="userEmail" maxlength="30" name="userEmail" placeholder="이메일" required></td>
				</tr>
			</table>

			<div class="modal-footer">
				<button type="button" class="btn" id="btnCancleCreate" data-dismiss="modal">취 소</button>
				<button type="submit" class="btn" id="btnInsert">등 록</button>
			</div><!-- End modal-footer -->
			
		</form><!-- End createForm -->
	</div><!-- End modal-body -->
</div><!-- End modal-container -->
