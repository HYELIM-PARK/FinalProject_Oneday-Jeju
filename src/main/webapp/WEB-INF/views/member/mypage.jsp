<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<c:import url="/WEB-INF/views/layout/header.jsp" />

<!-- mypage css -->
<link rel="stylesheet" href="/resources/css/mypage.css" type="text/css">

<!-- 나의일정, 북마크 css -->
<style type="text/css">
/* 나의 일정 부분 */
.mypage_myplan {
	text-align: center;
}
.myplan_list {
	width: 900px;
	height: 600px;
	margin-top: 20px;
	overflow: auto;
}
/* 북마크 부분 */
.plan {
	width: 359px;
	height: 320px;
	border: 1px solid #dfdfdf;
	display: inline-block;
	float: left;
	margin: 30px 40px;
	cursor: pointer;
}
.plan_img_box img {
	width: 358px;
	height: 220px;
	
}
.like_views, .nick{
	margin: 7px;
}
.plan_info {
	overflow: hidden;
}
.plan_info .like_views span {
	margin: 10px 10px 10px 3px;
}
.inline {
	display: inline-block;
}
#days {
	color: #49C6E5;
	font-weight: 500;
}
#planTitle {
	font-weight: 600;
}
.mypage_bookmark {
	text-align: center; 
}
.list_box {
	width: 900px;
	height: 600px;
	margin-top: 20px;
	overflow: auto;
	border: 1px solid #ccc;
}
</style>

<script type="text/javascript">
$(document).ready(function(){

	//'닉네임 변경' 버튼 클릭 시 (input창 토글)
	$("#updateNick").click(function (){
	  	$(".divToggle").toggle();
	});
	
	
	//settings 모달의 '변경하기' 버튼 클릭 시
	$("#modalSubmit").click(function() {
		console.log("settings 모달 내 변경 버튼");
		
		//전화번호 정규식
		$r1 = /^[0-9]*$/;
		
		//이메일 정규식
		$r2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
		//주소 정규식
		$r3 = /^[a-zA-Z0-9가-힣_ ]*$/;
		
		if ( $("#newPhone").val() == '' || $("#newPhone").val().length != 11 || !$r1.test($("#newPhone").val()) ) {
			alert("휴대폰번호를 숫자로만 11자리 입력하세요");
			$("#newPhone").focus();
			return false;
		}
		if ( $("#newEmail").val() == '' || $("#newPhone").val().length > 30 || !$r2.test($("#newEmail").val()) ) {
			alert("이메일 형식(@)으로 30자 이내로 입력하세요");
			$("#newEmail").focus();
			return false;
		}
		if ( $("#newAddress").val() == '' || !$r3.test($("#newAddress").val()) ) {
			alert("주소는 한글, 숫자, 영어만 입력하세요");
			$("#newAddress").focus();
			return false;
		}
		if ( $("#newAddressDetail").val() == '' || !$r3.test($("#newAddressDetail").val()) ) {
			alert("상세 주소는 한글, 숫자, 영어만 입력하세요");
			$("#newAddressDetail").focus();
			return false;
		}
		
		
		$.ajax ({
			url: "/member/mypage/settings"
			, type: "POST"
			, data: {"newPhone": $("#newPhone").val()
					, "newEmail": $("#newEmail").val()
					, "newAddress": $("#newAddress").val()
					, "newAddressDetail": $("#newAddressDetail").val()}
			, dataType: "json"
			, success: function(res) {
// 				alert("변경되었습니다.");
				location.href=res.redirectUrl;
			}
			, error: function(res) {
// 				alert("!! 변경 실패 !!");
			}
		})
// 		location.reload(true);
	});
	
	
	
	//pw변경 모달의 '변경하기' 버튼 클릭 시
	$("#pwmodalSubmit").click(function() {
		console.log("비밀번호 변경 모달 내 변경 버튼");
		
		$.ajax ({
			url: "/member/mypage/updatepw"
			, type: "POST"
			, data: {"oldPw": $("#oldPw").val()
					, "newPw": $("#newPw").val()
					, "newPwRe": $("#newPwRe").val()}
			, dataType: "json"
			, success: function(res) {

				alert(res.msg)
				if(res.redirect) {
					location.href=res.url
				}
			}
			, error: function(res) {
// 				alert("!! 변경 실패 !!");
			}
		})
// 		location.reload(true);
	});

});


//프로필 사진 변경/삭제
function mysubmit(sub) {
	if(sub == 1) {
		console.log("'변경'버튼 클릭")
		document.upProfileForm.action="/member/mypage/profile";
	}
	if(sub == 2) {
		console.log("'삭제'버튼 클릭")
		document.upProfileForm.action="/member/mypage/delprofile";
	}
	document.upProfileForm.submit();
}

</script>


<!-- 나의일정/북마크 버튼 자바스크립트 -->
<script type="text/javascript">
$(document).ready(function (){
	
	//일정만들기 버튼 클릭
	$('.createPlanBtn').click(function(){
		//일정 생성 페이지로 이동
		$(location).attr('href', '/plan/create');
	})
	
	//나의 일정 버튼 클릭
	$('#myplanBtn').click(function(){
		console.log("나의 일정 클릭");
		$.ajax({
			type: "get"
			, url: "/plan/list"
			, dataType: "json"
			, success: function( res ){
				console.log('나의일정 ajax 성공');
				
				$('.user_board_content').empty(); //일정 목록이 들어갈 태그의 내용을 비웁니다.
				
				var html = ''; //추가할 html 내용을 담을 변수입니다.
				
				if(res.planList.length == 0) {
					//생성한 일정이 없는 경우
					html = '<tr><td colspan="6">생성한 일정이 없습니다. 나만의 일정을 만들어 보세요 :)</td></tr>';
				} else {
					//생성한 일정이 있는 경우
					html = ''; 
					
					for(var plan of res.planList){
						var innerhtml = '<tr>'
									+	'<td>'+plan.pNo+'</td>'
									+	'<td><a href="/plan/update?pNo='+plan.pNo+'">'+plan.pTitle+'</a></td>'
									+	'<td>'+getFormatDate(plan.pDepartureDate)+'</td>'
									+	'<td>'+plan.pNumDays+'일</td>'
									+	'<td>'+plan.pNumPeople+'명</td>'
									+	'<td>'+getFormatDate(plan.pCDate)+'</td>'
									+	'</tr>';
						html += innerhtml;
					}
				}
				
				//일정목록 태그 생성
				var parent = $('<div class="mypage_myplan">');
				var parentHtml = '<h3>나의 일정 목록</h3>'
						+	'<div class="myplan_list">'
						+	'<table class="table table-striped">'
						+	'<thead>'
						+	'<tr>'
						+	'<th class="text-center" style="width: 10%">일정번호</th>'
						+	'<th class="text-center" style="width: 40%">일정명</th>'
						+	'<th class="text-center" style="width: 15%">여행출발일</th>'
						+	'<th class="text-center" style="width: 10%">여행일수</th>'
						+	'<th class="text-center" style="width: 10%">여행인원</th>'
						+	'<th class="text-center" style="width: 15%">생성일</th>'
						+	'</tr>'
						+	'</thead>'
						+	'<tbody class="text-center">'
						+	html
						+	'</tbody>'
						+	'</table>'
						+	'</div>';
				//최상위 요소에 html 추가
				parent.html(parentHtml);

				//원래 있던 내용 틀에 서버에서 받아온 데이터 추가
				$('.user_board_content').html(parent);
				
			}
			, error: function(){
				console.log('나의일정 ajax 실패');
			}
		})
	}) //나의 일정 클릭 이벤트 끝
	
	//북마크 버튼 클릭 이벤트
	$('#bookmarkBtn').click(function(){
		console.log("나의 일정 클릭");
		$.ajax({
			type: "get"
			, url: "/bookmark/list"
			, dataType: "json"
			, success: function( res ){
				console.log('북바크 ajax 성공');
				
				$('.user_board_content').empty(); //일정 목록이 들어갈 태그의 내용을 비웁니다.
				
				var html = ''; //추가할 html 내용을 담을 변수입니다.
				
				if(res.bookmarkList.length == 0) {
					//북마크한 게시글이 없는 경우
					html = '<h4>북마크한 게시글이 없습니다.</h4>';
				} else {
					//북마크한 게시글이 있는 경우
					html = ''; 
					
					for(var bookmark of res.bookmarkList){
						var eachHtml = '<div class="plan" data-pbno="'+ bookmark.pbno +'">'
									+	'<div class="plan_img_box"><img src="/getImg?filename='+ bookmark.filename +'"></div>'
									+	'<div class="plan_info text-center">'
									+	'<div class="like_views">'
									+	'<div class="inline pull-left">좋아요:<span id="likeNum">'+ bookmark.likenum +'</span></div>'
									+	'<div class="inline pull-left">조회수:<span id="views">'+ bookmark.views +'</span></div>'
									+	'<div class="inline pull-left">작성일:<span id="createDate">'+ getFormatDate(bookmark.cdate) +'</span></div>'
									+	'</div>'
									+	'<div class="clearfix"></div>'
									+	'<div class="nick inline pull-left">'
									+	'<span id="nick">닉네임: '+ bookmark.nick +'</span>'
									+	'</div>'
									+	'<div class="clearfix"></div>'
									+	'<div class="planboard_title">'
									+	'<span id="days">['+ bookmark.days +'일]</span>'
									+	'<span id="planTitle">'+ bookmark.title +'</span>'
									+	'</div>'
									+	'</div>'
									+	'</div>';
						html += eachHtml;
					}
				}
				//북마크목록 태그 생성
				var child = $('<div class="list_box">');
				
				//child 요소에 html 추가
				child.html(html);
				
				//parent 요소 생성
				var parent = $('<div class="mypage_bookmark">').html('<h3>북마크 목록</h3>');
				
				//parent에 내부 요소를 추가합니다.
				parent.append(child);

				//원래 있던 내용 틀에 서버에서 받아온 데이터 추가
				$('.user_board_content').html(parent);
				
			}
			, error: function(){
				console.log('북마크 ajax 실패');
			}
		})
	})//북마크 버튼 클릭 이벤트 끝
	
	//마이페이지 들어왔을 때 나의일정이 보이도록 트리거 설정
	$('#myplanBtn').css('background-color', '#8bd7d2');
	$('#myplanBtn').trigger('click');
	
	//버튼 클릭 -> 배경색 변경
	$('.user_board_btn > button').click(function(){
		$('.user_board_btn > button').each(function(i, e){
			$(this).css('background-color', '#ddd');
		})
		$(event.target).css('background-color', '#8bd7d2');
	})
	
	
})
//북마크 클릭 시 해당 글의 상세보기 페이지로 이동
$(document).on('click', '.plan', function(){
	var pbno = $(this).attr('data-pbno');
	//상세보기 url
	var url = '/planboard/view?pbNo='+ pbno;
	//게시글 상세보기 페이지로 이동 
	$(location).attr("href", url);
});
/**
 *  yyyyMMdd 포맷으로 반환
 */
function getFormatDate(value){
	var date = new Date(value);
    var year = date.getFullYear();              //yyyy
    var month = (1 + date.getMonth());          //M
    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
    var day = date.getDate();                   //d
    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
    return  year + '.' + month + '.' + day;       //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
}
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment-with-locales.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/locale/ko.min.js"></script>
<script type="text/javascript">
$(document).ready(function (){
	
	//여행후기 버튼 클릭
	$('#rvmyBtn').click(function(){
		console.log("여행후기클릭");
		$.ajax({
			type: "get"
			, url: "/review/mypageList"
			, dataType: "json"
			, success: function( res ){
				console.log('여행후기 마이페이지');								
				 
				var html = ''; 
				
				if(res.length == 0) {
					//여행후기 게시글이 없는 경우
					html = '<tr><td colspan="6">여행후기 게시글이 없습니다. 여행을 갔다온 후기를 만들어 보세요 </td></tr>';
				} else {
					//생성한 일정이 있는 경우 
					html = ''; 
					
					for(var i=0; i<res.length; i++){
						var innerhtml = '<tr>'
									+	'<td>'+res[i].rvNo+'</td>'
									+	'<td><a href="/review/view?rvNo='+res[i].rvNo+'">'+res[i].rvTitle+'</a></td>'
									+	'<td>'+ moment(res[i].rvCreateDate).format('YYYY-MM-DD') +'</td>'
									+	'<td>'+res[i].rvHit+'</td>'
									+	'</tr>';
						html += innerhtml;
					}
				} 
				
				//일정목록 태그 생성
				var parent = $('<div class="mypage_myreview">');
				var parentHtml = '<h3>여행후기 목록</h3>'
						+	'<div class="myreview_list">'
						+	'<table class="table table-striped">'
						+	'<thead>'
						+	'<tr>'
						+	'<th class="text-center" style="width: 10%">글번호</th>'
						+	'<th class="text-center" style="width: 40%">글제목</th>'
						+	'<th class="text-center" style="width: 15%">작성일</th>'
						+	'<th class="text-center" style="width: 10%">조회수</th>'
						+	'</tr>'
						+	'</thead>'
						+	'<tbody class="text-center">'
						+	 html
						+	'</tbody>'
						+	'</table>'
						+	'</div>';
				//부모 요소에 html 추가
				parent.html(parentHtml);

				//원래 있던 내용 틀에 서버에서 받아온 데이터 추가
				$('.user_board_content').html(parent);
			}
			, error: function(){
				console.log('여행후기 실패');
			}
		})
	}); //여행후기 클릭 이벤트 끝
});
</script>

<script type="text/javascript" src="/resources/js/mypageQnA.js"></script>
<div class="container">

<div class="sub_title">${nick} 님 마이페이지</div>

<div class="user_info">

	<div class="user_profile" align="center">
		<div class="profile">
			<c:choose>
				<c:when test="${sessionScope.profile ne null}">
					<img class="img-circle" alt="user" src="../resources/upload/${sessionScope.profile}" style="width:120px; height:120px;">
				</c:when>
				<c:otherwise>
					<img class="img-circle" alt="user" src="../resources/upload/user.png" style="width:120px; height:120px;">
				</c:otherwise>
			</c:choose>
		</div>
		
		<button class="openFileBtn" onclick="onclick=document.all.file.click();">프로필 사진 선택</button>
		
		<form method="post" name="upProfileForm" enctype="multipart/form-data">
			<input type="file" id="file" name="file" style="display:none;"/>
			<button onclick="mysubmit(1)">변경</button>
			<button onclick="mysubmit(2)">삭제</button>
			<p style="font-size: 0.8em; color:#00BD9D; font-weight:500;">변경 버튼을 눌러야 적용됩니다</p>
		</form>
	</div>
	
	<div class="user_data">
		<button id="setBtn" type="button" data-toggle="modal" data-target="#settingsModal"><i class="fas fa-cog fa-2x"></i></button>
		<table class="data_table">
			<tr>
				<td>가입일: </td>
				<td><fmt:formatDate value="${userData.userJoinDate}" pattern="yyyy-MM-dd"/> 가입</p>
			</tr>
			<tr>
				<td>닉네임: </td>
				<td><button id="updateNick">닉네임 변경</button>
				<div class="divToggle" style="display:none; margin: 3px;">
				<form action="/member/mypage" method="post" name="updateForm">
					<input type="text" id="newNick" name="userNick" class="effect-5" />
					<span class="focus-border"></span>
					<button id="okNickBtn">변경</button>
				</form>
				</div>
				</td>
			</tr>
			<tr>
				<td class="phone">전화번호: </td>
				<td>${userData.userPhone}</td>
			</tr>
			<tr>
				<td>이메일: </td>
				<td>${userData.userEmail}</td>
			</tr>
			<tr>
				<td>주소: </td>
				<td>${userData.userAddress} ${userData.userAddressDetail}</td>
			</tr>
		</table>
		<button class="createPlanBtn"><span>일정 만들기</span></button>
	</div>
</div>

<div class="user_board_btn">
	<button id="myplanBtn">나의 일정</button>
	<button id="bookmarkBtn">북마크</button>
	<button id="rvmyBtn">여행 후기</button>
	<button id="qnaBtn">Q & A</button>
</div>

<div class="user_board_content">
	
</div>




<!-- settings 모달 -->
<div class="modal fade" id="settingsModal" role="dialog">
	<div class="modal-dialog">
		
		<!-- Modal Content -->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h3 id="modal-title" class="modal-title">회원정보 변경하기</h3>
			</div>
			
			<div class="modal-body">
				<table class="table modal-table">
					<tr>
						<td><label>아이디</label></td>
						<td>${userData.userId}</td>
					</tr>
					<tr>
						<td><label>생년월일</label></td>
						<td><fmt:formatDate value="${userData.userBirthDate}" pattern="yyyy년 MM월 dd일" /> </td>
					</tr>
					<tr>
						<td><label>비밀번호</label></td>
						<td><button id="setPwBtn" type="button" data-toggle="modal" data-target="#setPwModal">비밀번호 변경</button></td>
					</tr>
					<tr>
						<td><label for="newPhone">휴대폰번호</label></td>
						<td><input type="text" id="newPhone" name="newPhone" value="${userData.userPhone}" /></td>
					</tr>
					<tr>
						<td><label for="newEmail">이메일</label></td>
						<td><input type="text" id="newEmail" name="newEmail" value="${userData.userEmail}" /></td>
					</tr>
					<tr>
						<td><label for="newAddress">주소</label></td>
						<td><input type="text" id="newAddress" name="newAddress" value="${userData.userAddress}" /></td>
						<td><label for="newAddress">상세주소</label></td>
						<td><input type="text" id="newAddressDetail" name="newAddressDetail" value="${userData.userAddressDetail}" /></td>
					</tr>
					<tr>
						<td><a href="#" style="color:red; font-size:20px;">회원탈퇴</a><td>
					</tr>
				</table>
			</div>
			
			<div class="modal-footer">
				<button id="modalSubmit" type="submit">변경하기</button>
				<button type="button" data-dismiss="modal" class="cancel">취소</button>
			</div>
		</div>
	</div>
</div>


<!-- 비밀번호 변경 모달 -->
<div class="modal fade" id="setPwModal" role="dialog">
	<div class="modal-dialog">
		
		<!-- Modal Content -->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h3 id="modal-title" class="modal-title">비밀번호 변경하기</h3>
			</div>
			
			<div class="modal-body">
				<form action="/member/mypage/updatepw" method="post" >
				<table class="table modal-table">
					<tr>
						<td><label for="oldPw">현재 비밀번호</label></td>
						<td><input type="password" id="oldPw" name="oldPw" autocomplete="off" /></td>
					</tr>
					<tr>
						<td><label for="newPw">새 비밀번호</label></td>
						<td><input type="password" id="newPw" name="newPw" autocomplete="off" /></td>
					</tr>
					<tr>
						<td><label for="newPwRe">새 비밀번호 확인</label></td>
						<td><input type="password" id="newPwRe" name="newPwRe" autocomplete="off" /></td>
					</tr>
				</table>
				</form>
			</div>
			
			<div class="modal-footer">
				<button id="pwmodalSubmit" type="submit">변경하기</button>
				<button type="button" data-dismiss="modal" class="cancel">취소</button>
			</div>
		</div>
	</div>
</div>



</div><!-- .container -->

<c:import url="/WEB-INF/views/layout/footer.jsp" />
