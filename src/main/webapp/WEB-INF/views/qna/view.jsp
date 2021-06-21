<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="/WEB-INF/views/layout/header.jsp"/>
<style type="text/css">
/*질문글 css*/
.qstWrapper{
	width : 100%;
	border-top : 3px solid #8bd7d2;
	border-bottom : 3px solid #8bd7d2;
	border-radius : 25px;
	background: #fffbfa;
}
.question{
	width : 80%;
	text-align: right;
	padding : 15px;
}
.question .qstInfo{
	float : right;
	margin : 0 0 0 40px;
}
.question #content{
	text-align : left;
	line-height :  27px;
}
.question .qstInfo #qstCnt{
	margin-right : 18px;
	color : #00a388;
}
.question .tag span{
	line-height : 85px;
}
.makeAnswer{
	background: #00bd9d;
	color : #fffbfa;
}
/*답변글 css  */
.ansWrapper{
	width : 100%;
	margin-top : 20px;
}
.ansWrapper > div{
	margin-bottom: 25px;
}

.answers{
	width : 80%;
	border : 1px solid #8bd7d2;
	height : 350px;
	border-radius: 15px;
	padding: 15px;
	text-align: right;
}
.like{
	background: transparent;
	border : none;
	color : #f25c54;
}

.answers #ansInfo{
	text-align: left;
}
.answers #userid{
	line-height: 56px;
   	vertical-align: text-top;
   	font-size: 23px;
}

.answers #divider{
	margin-top : 5px;
	margin-bottom : 20px;
}
.ansContent{
	height : 53%;
	text-align: left;
}
/* 답변글 작성 폼 */
.writeAnswer{
	width : 50%;
	padding : 20px;
	border-radius: 15px;
	/* background: #00a388; */
	border : 1px solid #ccc;
}
.writeAnswer h4{
	display : inline-block;
}
.filename{
	min-height : 30px;
}
.filename span{
	padding-right : 15px;
}
/* 답변글 수정 폼  */
.updateAnswer{
	 width : 80%;
	 padding : 20px;
	 display : none; 
	 border : 1px solid #ccc;
	 border-radius : 15px;
}
.updateAnswer h4{
	display : inline-block;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	$('.deleteQst').click(function(){
		var confirmDelete = confirm('삭제하시겠습니까?')
		if(confirmDelete){location.href="/qna/delete/question?qstNo=${QST_NO}"}
	})
	 $('.makeAnswer').click(function(){
		 var login = ${sessionScope.login}
		 console.log(login)
		 if(login == null){
			 console.log("로그인 상태 아님")
			 alert("로그인이 필요합니다")
			 location.href='/member/login'
		 } else {
			 var offset = $('.writeAnswer').offset()
			 $('html').animate({scrollTop : offset.top},500)
		 }
	}) 
	$('.ansImg').click(function(){
		$('#ansFiles').click()
	})
	$('#ansFiles').change(function(){
		var files = $(this)[0].files
		for(var i = 0; i< files.length; i++){
			$('.filename').append($('<span></span>').html(files[i].name))
		}
	})
	
	$('#submitAnswer').click(function(){
		$('#ansCreateForm').submit()
	})
	$('.deleteAns').click(function(){
		var confirmDelete = confirm('답변을 삭제하시겠습니까?')
		var ansNo = ($(this).parent().attr('id'))
		if(confirmDelete){location.href='/qna/delete/answer?qstNo=${QST_NO}&ansNo='+ansNo}
	})
	
	$('.updateImg').click(function(){
		$(this).next().children('.updateFiles').click()
	})
	/*답변글 수정 폼 보이기  */
	$('.updateAns').click(function(){
		$(this).parent().next().fadeIn(500)
	})
	/*답변글 수정 폼 숨기기 */
	$('.hideForm').click(function(){
		$(this).parent().fadeOut(500)
	})
	
	$('.updateFiles').change(function(){
		console.log("업로드 파일 변경됨")
		$(this).parent().next('.upload').children('span').remove()
		var files = $(this)[0].files
		for(var i = 0; i< files.length; i++){
			$('.upload').append($('<span></span>').html(files[i].name))
		}
	})
	$('.subAns').click(function(){
		$(this).parent().children('.ansUpdateForm').submit()
	})
	
	
	
	const url = new URL(window.location.href)
	const qrParam = url.searchParams
	/* 좋아요 ajax  */
	$('.like').click(function(){
		//qstNo 파라미터 값 얻어오기
		var id = $(this).parent().attr("id")
		var $th = $(this) 
		var qstNo = qrParam.get('qstNo')
		  $.ajax({
			type : "get"
			, url : "/qna/answer/like"
			, data : {
				'ansNo' : id
				, 'qstNo' : qstNo
			}
			, dataType : "json"
			, success : function(res){
				console.log("ajax 성공" )
				console.log(res)
				if(res.result){
					$th.children('i').removeClass('far')
					$th.children('i').addClass('fas')
								
				}else{
					$th.children('i').removeClass('fas')
					$th.children('i').addClass('far')					
										
				}
				$th.parent().children('.float').children('.cntLikes').html(res.cntLikes)
			}
			, error : function(){
				console.log("ajax실패")
				
			}
			})
				
		})
})
</script>
<!-- 질문글 -->
<div class="qstWrapper">
<div class="question">
	<p>${QST_NO}</p>
	<!-- 기본정보(조회수, 작성자 아이디) -->
	<div id="content">
		<div class="qstInfo">
			<span id="qstCnt">조회수 ${QST_CNT}</span>
			<c:choose>
			<c:when test="${USER_STORED eq null}">
			<img src="/resources/image/user.png" alt="profile" style="width: 45px; height : 45px;"/> 
			</c:when>
			<c:otherwise>
			<img src="/resources/upload/${USER_STORED}" alt="profile" style="width: 45px; height : 45px;" class="img-circle"/> 			
			</c:otherwise>
			</c:choose>
			<span style="line-height : 45px;">${USER_ID}</span>
		</div>
		<h4 style="font-weight : bold; font-size : 22px;">${TITLE}</h4>
		<p style="margin-top: 30px;">${QST_CONTENT}</p>
		<c:forEach items="${files}" var="file">
		<img src="/qna/${file.QST_STORED}" alt="첨부이미지" style="width : 200px; height : 200px;"/>
		</c:forEach>
	</div>
<!-- 해시태그  -->
	<div class="tag">
		<c:forEach items = "${tagList}" var="tag">
			<span>#${tag.get("TAG_NAME")}</span>
		</c:forEach>
	</div>
	<!-- 작성자와 로그인한 아이디 비교하여 버튼 구분하기  -->
		<c:if test="${id eq USER_ID}">
		<c:choose>
		<c:when test="${TITLE ne '이 글은 관리자에 의해 삭제되었습니다'}">
		<button type="button" class="btn updateQst" data-toggle="modal" data-target="#updateQstModal" id="updateQst">수정</button>
		<button type="button" class="btn deleteQst">삭제</button>
		</c:when>
		<c:when test="${TITLE eq '이 글은 관리자에 의해 삭제되었습니다'}">
		<button type="button" class="btn deleteQst">삭제</button>		
		</c:when>
		</c:choose>
		</c:if>
		<c:if test="${id ne USER_ID}">
		<button type="button" class="btn btn-lg makeAnswer">답변하기</button>
		</c:if>
</div>
</div>
<div class="ansWrapper">
 <h4>${ansTotal}개의 답변</h4>
 <hr>
<!-- 답변글 -->
	<c:forEach items="${answers}" var="answer" >
	<div class="answers" id="${answer.ansNo}">
		<div class="float" style="float : right;">
		<span><i class="fas fa-heart"></i></span>
		<!-- 좋아요수  -->
		<span style="margin-right : 15px;" class="cntLikes">${answer.ansLikeCnt }</span>
		<p style="float:right;"><fmt:formatDate value="${answer.ansTime}" pattern="yyyy-MM-dd hh:mm:ss"/> </p>
		</div>
		<div id="ansInfo">
		<c:choose>
		<c:when test="${answer.userStored eq null}">
		<img src="/resources/image/user.png" alt="profile" style="width: 62px; height : 62px;"/> 
		</c:when>
		<c:otherwise>
		<img src="/resources/upload/${answer.userStored}" alt="profile" style="width: 62px; height : 62px;" class="img-circle"/> 		
		</c:otherwise>
		</c:choose>
		<span id="userid">${answer.userId}님의 답변</span>
		</div>
		<hr id="divider">
		<!-- 답변글 본문  -->
		<div class="ansContent">
		<p>${answer.ansContent}</p>
		<c:forEach items="${answer.filenames}" var="filenames">
		<img src="/qna/${filenames.ANS_STORED}" style="width : 110px; height : 110px;"/>
		</c:forEach>
		</div>
		<c:if test="${id eq answer.userId}">
		<c:choose>
		<c:when test="${answer.ansContent ne '관리자에 의해 삭제된 글입니다'}">
		<button type="button"  class="btn updateAns">수정</button>
		<button type="button"  class="btn deleteAns">삭제</button>
		</c:when>
		<c:when test="${answer.ansContent eq '관리자에 의해 삭제된 글입니다'}">		
		<button type="button"  class="btn deleteAns">삭제</button>
		</c:when>		
		</c:choose>
		</c:if>
		<c:if test="${id ne answer.userId}">
		
			<c:if test="${answer.ansLikeCheck eq 0 }">
			<button type="button" class="like"><i class="far fa-heart fa-3x"></i></button>
			</c:if>
			<c:if test="${answer.ansLikeCheck eq 1 }">
			<button type="button" class="like"><i class="fas fa-heart fa-3x"></i></button>
			</c:if>
		
		</c:if>
	</div>
	<!-- 답변글 수정 Form  -->
	<c:if test="${id eq answer.userId}">
	<div class="updateAnswer">
	<h4>답변수정</h4>
	<img src="/resources/image/image.png" style="width : 45px; height : 45px;" class="updateImg">
	<form action="/qna/update/answer" method="post" class="ansUpdateForm" enctype="multipart/form-data">
		<textarea rows="6" name="ansContent" placeholder="내용을 입력하세요" class="form-control">${answer.ansContent}</textarea>
		<input type="file" name="ansFiles" multiple="multiple" style="display:none;" class="updateFiles">
		<input type="hidden" name="qstNo" value="${QST_NO}"/>
		<input type="hidden" name="ansNo" value="${answer.ansNo}"/>
	</form>
	<div class="upload">
	<c:forEach items="${answer.filenames}" var="filenames">
	<span>${filenames.ANS_ORIGIN}</span>
	</c:forEach>
	</div>
	<button type="button" class="btn hideForm">취소</button>
	<button type="button" class="btn subAns">수정제출</button>
	</div>
	</c:if>
	</c:forEach>
	
	<!--답변글 작성 Form  -->
	<c:if test="${id ne USER_ID}">
	<div class="writeAnswer">
	<h4>답변하기</h4>
	<img src="/resources/image/image.png" style="width : 45px; height : 45px;" class="ansImg">
	<form action="/qna/write/answer" method="post" id="ansCreateForm" enctype="multipart/form-data">
	<textarea rows="6" name="ansContent" placeholder="내용을 입력하세요" class="form-control" style="border : none;"></textarea>
	<input type="file" name="ansFiles" multiple="multiple" style="display:none;" id="ansFiles">
	<input type="hidden" name="qstNo" value="${QST_NO}"/>
	</form>
	<div class="filename">
	</div>
	<button id="submitAnswer" type="button" class="btn btn-lg btn-block">답변하기</button>
	</div>
	</c:if>
	
</div>
<c:import url="/WEB-INF/views/qna/qstUpdateModal.jsp"/>
<c:import url="/WEB-INF/views/layout/footer.jsp"/>