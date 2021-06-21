$(document).ready(function() {
	
	$("#userId").focus(); //아이디 최초 포커스

	$("#msgId").hide();
	$("#msgPw").hide();
	$("#checkPwMsg1").hide();
	$("#checkPwMsg2").hide();
	$("#msgName").hide();
	$("#msgNick").hide();
	$("#msgPhone").hide();
	
	
	//아이디 정규식 & 중복확인
	$("#userId").blur(function() {
		var regId = /^[a-zA-Z0-9]{5,12}$/ //5~12자리의 영문, 숫자
		var id = $("#userId").val();
		
		$.ajax({
			type: "get"
			, url: "/user/joinInfo/checkId"
			, data: { id }
			, dataType: "json"
			, success: function(data) {
//				console.log("성공")
//				console.log(data)
							
				if(data >= 1) { //아이디 중복값이 있을 때
					$("#msgId").show();
					$("#msgId").html("이미 사용중인 아이디입니다.");
					$("#btnJoin").prop("disabled", true);
				
				} else if(data == 0) { //아이디 중복값이 없을 때
					if(id == "") { //아이디 입력값이 없을 때
						$("#msgId").show();
						$("#msgId").html("아이디를 입력하세요.");
						$("#btnJoin").prop("disabled", true);
					
					} else if( id != "" && regId.test(id) ) { //아이디 입력값이 있고, 정규식에 맞을 때
						$("#msgId").show();
						$("#msgId").html("사용 가능한 아이디입니다.");
						$("#btnJoin").prop("disabled", false);
					
					} else { //아이디 입력값 있고, 정규식에 맞지 않을 때
						$("#msgId").show();
						$("#msgId").html("5~12자리의 영문, 숫자만 가능합니다.");
						$("#btnJoin").prop("disabled", true);
					}
					
				} else {
					$("#msgId").hide();
					$("#btnJoin").prop("disabled", true);
				}
			} //End success
			, error: function() { //AJAX 실패 시 콜백함수
				console.log("실패")
			} //End error
		}) //End ajax
	}); //End change fn

	
	//닉네임 정규식 & 중복확인
	$("#userNick").blur(function() {
		var regNick = /^[가-힣a-zA-Z0-9]{1,20}$/; //20자 이내의 한글, 영문, 숫자
		var nick = $("#userNick").val();
		
		$.ajax({
			type: "get"
			, url: "/user/joinInfo/checkNick"
			, data: { nick }
			, dataType: "json"
			, success: function(data) {
//				console.log("성공")
//				console.log(data)
							
				if(data >= 1) { //닉네임 중복값이 있을 때
					$("#msgNick").show();
					$("#msgNick").html("이미 사용중인 닉네임입니다.");
					$("#btnJoin").prop("disabled", true);
				
				} else if(data == 0) { //닉네임 중복값이 없을 때
					if(nick == "") { //닉네임 입력값 없을 때
						$("#msgNick").show();
						$("#msgNick").html("닉네임을 입력하세요.");
						$("#btnJoin").prop("disabled", true);
					
					} else if( regNick.test(nick) ) { //닉네임 입력값이 있고, 정규식에 맞을 때
						$("#msgNick").show();
						$("#msgNick").html("사용 가능한 닉네임입니다.");
						$("#btnJoin").prop("disabled", false);
					
					} else { //닉네임 입력값이 있고, 정규식에 맞지 않을 때
						$("#msgNick").show();
						$("#msgNick").html("20자 이내의 한글, 영문, 숫자만 가능합니다.");
						$("#btnJoin").prop("disabled", true);
					}
				
				} else {
					$("#msgNick").hide();
					$("#btnJoin").prop("disabled", true);
				}
			} //End success
			, error: function() { //AJAX 실패 시 콜백함수
				console.log("실패")
			} //End error
		}) //End ajax
	}); //End change fn

	
	//비밀번호 정규식 & 입력값 확인	
	$("#userPw").blur(function() {
		var regPw = /^[a-zA-Z0-9]{8,15}$/; //8~15자리의 영문, 숫자
		var upw = $("#userPw").val();
		
		if(upw == "") { //비밀번호 입력값이 없을 때
			$("#msgPw").show();
			$("#msgPw").html("비밀번호를 입력하세요.");
			$("#btnJoin").prop("disabled", true);
			
		} else if(upw != "") { //비밀번호 입력값이 있을 때
			if( !regPw.test(upw) ) { //정규식에 맞지 않을 때
				$("#msgPw").show();
				$("#msgPw").html("8~15자리의 영문, 숫자만 가능합니다.");
				$("#btnJoin").prop("disabled", true);
			} else { //정규식에 맞을 때
				$("#msgPw").hide();
				$("#btnJoin").prop("disabled", false);
			}
			
		} else {
			$("#msgPw").hide();
			$("#btnJoin").prop("disabled", true);
		}
	});
	
	
	//비밀번호 일치여부 확인
	$("#checkPw").blur(function() {
		var regPw = /^[a-zA-Z0-9]{8,15}$/; //8~15자리의 영문, 숫자
		var upw = $("#userPw").val();
		var cpw = $("#checkPw").val();
		
		if(upw != "" && cpw == "") { //비밀번호 확인 입력값이 없을 때
			$("#msgChkPw1").show();
			$("#msgChkPw2").hide();
			$("#msgChkPw1").html("비밀번호를 한 번 더 입력하세요.");
			$("#btnJoin").prop("disabled", true);
		
		} else if(upw != "" && cpw != "") { //둘 다 입력값이 있을 때
			if(upw == cpw && regPw.test(cpw)) { //입력값이 일치하면서 cpw도 정규식에 맞는 경우
				$("#msgChkPw2").show();
				$("#msgChkPw1").hide();
				$("#msgChkPw2").html("비밀번호가 일치합니다.");
				$("#btnJoin").prop("disabled", false);
			
			} else if(upw == cpw && !regPw.test(cpw)) { //입력값이 일치하는데 cpw가 정규식에 맞지 않는 경우
				$("#msgChkPw1").show();
				$("#msgChkPw2").hide();
				$("#msgChkPw1").html("8~15자리의 영문, 숫자만 가능합니다.");
				$("#btnJoin").prop("disabled", true);
					
			} else { //입력값이 일치하지 않을 때
				$("#msgChkPw1").show();
				$("#msgChkPw2").hide();
				$("#msgChkPw1").html("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
				$("#btnJoin").prop("disabled", true);
			}
			
		} else { //비밀번호 입력값이 없을 때
			$("#msgChkPw1").hide();
			$("#msgChkPw2").hide();
			$("#btnJoin").prop("disabled", true);
		}
	});

	
	//이름 정규식
	$("#userName").blur(function() {
		var regNameKor = /^[가-힣]{1,20}$/;
		var regNameEng = /^[a-zA-Z]{1,20}$/; //20자 이내의 한글 또는 영문
		var name = $("#userName").val();
		
		if(name == "") { //입력값이 없을 때
			$("#msgName").show();
			$("#msgName").html("이름을 실명으로 입력하세요.");
			$("#btnJoin").prop("disabled", true);
		
		} else if(name != "") { //입력값이 있을 때
			if(regNameKor.test(name) || regNameEng.test(name)) { //정규식에 맞을 때
				$("#msgName").hide();
				$("#btnJoin").prop("disabled", false);
			
			} else { //정규식에 맞지 않을 때
				$("#msgName").show();
				$("#msgName").html("20자 이내의 한글 또는 영문만 가능합니다.");
				$("#btnJoin").prop("disabled", true);
			}

		} else {
			$("#msgName").hide();
			$("#btnJoin").prop("disabled", true);
		}
	});
	
	
	//휴대전화번호 정규식
	$("#userPhone").blur(function() {
		var regPhone = /^[0-9]{11}$/; //11자리의 숫자
		var phone = $("#userPhone").val();
		
		if(phone == "") { //입력값이 없을 때
			$("#msgPhone").show();
			$("#msgPhone").html("전화번호를 입력하세요.");
			$("#btnJoin").prop("disabled", true);
		} else if( phone != "" && !regPhone.test(phone) ) { //입력값이 있고, 정규식에 맞지 않을 때
			$("#msgPhone").show();
			$("#msgPhone").html("11자리의 숫자만 가능합니다.");
			$("#btnJoin").prop("disabled", true);
		} else { //입력값이 있고, 정규식에 맞을 때
			$("#msgPhone").hide();
			$("#btnJoin").prop("disabled", false);
		}
	});

}); //End ready fn


//Daum 우편번호 api 팝업
function openDaumPostcode(){
	new daum.Postcode({
		oncomplete: function(data){
			
			var userAddress = ''; //주소 변수
			var extraAddress = ''; //상세주소 변수
			
			if(data.userSelectedType === 'R'){ //사용자가 도로명 주소를 선택한 경우 
				userAddress = data.roadAddress; //선택한 도로명 주소 추가
				
			} else if(data.userSelectedType === 'J'){ //사용자가 지번 주소를 선택한 경우
				userAddress = data.roadAddress; //도로명 주소 추가
				if(data.roadAddress === ''){ //도로명 주소 선택값이 없는 경우
					userAddress = data.autoRoadAddress; //오토매핑된 도로명 주소 추가
				}
			} 
			
			if(data.noSelected === 'Y'){ //사용자가 선택 안 함을 선택한 경우
				userAddress = data.roadAddress; //도로명 주소 추가
				if(data.roadAddress === ''){ //도로명 주소 선택값이 없는 경우
					userAddress = data.autoRoadAddress; //오토매핑된 도로명 주소 추가
				}	
			}
			
			if(userAddress !== ''){ //선택된 주소값이 있을 경우
				if(data.bname !== '' && data.buildingName !== ''){ //법정동/법정리 이름이 있고, 건물명이 있을 경우 
					extraAddress += '(' + data.bname + ', ' + data.buildingName + ')'; //상세주소에 추가
					
				} else if(data.bname !== '' && data.buildingName === ''){ //법정동/법정리 이름이 있고, 건물명이 없을 경우
					extraAddress += '(' + data.bname + ')'; //상세주소에 법정동/법정리 이름 추가
					
				} else if(data.bname === '' && data.buildingName !== ''){ //법정동/법정리 이름이 없고, 건물명이 있을 경우
					extraAddress += '(' + data.buildingName + ')'; //상세주소에 건물명 추가
				}
			}				

			//우편번호와 주소 정보를 해당 필드에 넣는다
			document.getElementById("userZipcode").value = data.zonecode;
			document.getElementById("userAddress").value = userAddress;
			document.getElementById("userAddressDetail").value = extraAddress;
		
		}
	}).open({
		popupName: 'zipcodePopup' //팝업이름 설정(여러개의 팝업창 뜨는 것 방지)
	});
}; //End 우편번호 팝업
