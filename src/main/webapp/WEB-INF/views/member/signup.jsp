<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
	integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css"
	integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<title>Insert title here</title>
<script>
	$(document).ready(function() {
		// 중복,암호 확인 변수
		let idOk = false;
		let pwOk = false;
		/* let emailOk = false; */
		let nickNameOk = false;
		
		$("#checkIdButton1").click(function(e) {
			e.preventDefault();

			$(this).attr("disabled", "");
			const data = {
				id : $("#form1").find("[name=id]").val()
			};

			$.ajax({
				url : "${pageContext.request.contextPath }/member/check",
				type : "get",
				data : data,
				success : function(data) {
					switch (data) {
					case "ok":
						$("#idMessage1").text("사용 가능한 아이디입니다.");
						idOk = true;
						break;
					case "notOk":
						$("#idMessage1").text("사용 불가능한 아이디입니다.");
						break;
					}
				},
				error : function() {
					$("#idMessage1").text("중복 확인 중 문제 발생, 다시 시도해 주세요.");
				},
				complete : function() {
					$("#checkIdButton1").removeAttr("disabled");
					enableSubmit();
				}
			});
		});

		//이메일 중복확인 예전버전
/* 		$("#checkEmailButton1").click(function(e) {
			e.preventDefault();

			$(this).attr("disabled", "");
			const data = {
				email : $("#form1").find("[name=email]").val()
			};
			$.ajax({
				url : "${pageContext.request.contextPath }/member/check",
				type : "get",
				data : data,
				success : function(data) {
					switch (data) {
					case "ok":
						$("#emailMessage1").text("사용 가능한 이메일입니다.");
						emailOk = true;
						break;
					case "notOk":
						$("#emailMessage1").text("사용 불가능한 이메일입니다.");
						break;
					}
				},

				error : function() {
					$("#emailMessage1").text("중복 확인 중 문제 발생, 다시 시도해 주세요.");
				},
				complete : function() {
					$("#checkEmailButton1").removeAttr("disabled");
					enableSubmit();
				}
			});
		}); */
		$('#mail-Check-Btn').click(function() {
			const eamil = $('#userEmail1').val() + $('#userEmail2').val(); // 이메일 주소값 얻어오기!
			console.log('완성된 이메일 : ' + eamil); // 이메일 오는지 확인
			const checkInput = $('.mail-check-input') // 인증번호 입력하는곳 
			
			$.ajax({
				type : 'get',
				url : '<c:url value ="/member/confirmemail?email="/>'+eamil, // GET방식이라 Url 뒤에 email을 뭍힐수있다.
				success : function (data) {
					console.log("data : " +  data);
					checkInput.attr('disabled',false);
					code =data;
					alert('인증번호가 전송되었습니다.')
				}			
			}); // end ajax
		}); // end send eamil
		
		// 인증번호 비교 
		// blur -> focus가 벗어나는 경우 발생
		$('.mail-check-input').blur(function () {
			const inputCode = $(this).val();
			const $resultMsg = $('#mail-check-warn');
			
			if(inputCode === code){
				$resultMsg.html('인증번호가 일치합니다.');
				$resultMsg.css('color','green');
				$('#mail-Check-Btn').attr('disabled',true);
				$('#userEamil1').attr('readonly',true);
				$('#userEamil2').attr('readonly',true);
				$('#userEmail2').attr('onFocus', 'this.initialSelect = this.selectedIndex');
		         $('#userEmail2').attr('onChange', 'this.selectedIndex = this.initialSelect');
			}else{
				$resultMsg.html('인증번호가 불일치 합니다. 다시 확인해주세요!.');
				$resultMsg.css('color','red');
			}
		});
		
		
		$("#checkNickNameButton1").click(function(e) {
			e.preventDefault();
			
			const data = {
				nickName : $("#form1").find("[name=nickName]").val()
			};
			
			nickNameOk = false;
			$.ajax({
				url : "${appRoot}/member/check",
				type : "get",
				data : data,
				success : function(data) {
					switch (data) {
					case "ok" :
						$("#nickNameMessage1").text("사용 가능한 닉네임입니다.");
						nickNameOk = true;
						break;
					case "notOk" :
						$("#nickNameMessage1").text("사용 불가능한 닉네임입니다.");
						break;
					}
				}, 
				error : function() {
					$("#nickNameMessage1").text("닉네임 중복 확인 중 오류 발생, 다시 시도해 주세요.");
				},
				complete : function() {
					$("#checkNickNameButton1").removeAttr("disabled", "");
					enableSubmit();
				}
			});
		});
		
	    $("#passwordInput1, #passwordInput2").keyup(function() {
            const pw1 = $("#passwordInput1").val();
            const pw2 = $("#passwordInput2").val();
           
            if (pw1==pw2) {
                $("#passwordMessage1").text("패스워드가 일치합니다.");
                pwOk = true;
            } else {
                $("#passwordMessage1").text("패스워드가 일치하지 않습니다.");
                enableSubmit();
            }
        });
	    
		 // 회원가입 submit 버튼 활성화/비활성화 함수
		const enableSubmit = function () {
			if (idOk && pwOk && nickNameOk) {
				$("#submitButton1").removeAttr("disabled");
			} else {
				$("#submitButton1").attr("disabled", "");
			}
		}
   	
});

</script>
</head>
<body>
	<my:navBar current="signup"></my:navBar>​
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-12 col-lg-6">
				<h1>회원 가입</h1>

				<form id="form1"
					action="${pageContext.request.contextPath }/member/signup"
					method="post">
					<label for="idInput1" class="form-label"> 아이디 </label>

					<div class="input-group">
						<input id="idInput1" class="form-control" type="text" name="id" />
						<button class="btn btn-secondary" id="checkIdButton1"
							type="button">아이디 중복 확인</button>
					</div>
					<div class="form-text" id="idMessage1"></div>

					<label for="passwordInput1" class="form-label"> 패스워드 </label>
					<input class="form-control" id="passwordInput1" type="text"
						name="password" />

					<label for="passwordInput2" class="form-label"> 패스워드확인 </label>
					<input class="form-control" id="passwordInput2" type="text"
						name="passwordConfirm" />
					<div class="form-text" id="passwordMessage1"></div>

<!-- 					<label for="emailInput1" class="form-label"> 이메일 </label>
					<div class="input-group">
						<input id="emailInput1" class="form-control" type="email"
							name="email" />
						<button class="btn btn-secondary" id="checkEmailButton1"
							type="button">이메일 중복 확인</button>
					</div>
					<div class="form-text" id="emailMessage1"></div>
					<div class="form-group email-form"> -->
	 <label for="email">이메일</label>
	 <div class="input-group">
	<input type="text" class="form-control" name="userEmail1" id="userEmail1" placeholder="이메일" >
	<select class="form-control" name="userEmail2" id="userEmail2" >
	<option>@naver.com</option>
	<option>@daum.net</option>
	<option>@gmail.com</option>
	</select>
	   
<div class="input-group-addon">
	<button type="button" class="btn btn-primary" id="mail-Check-Btn">본인인증</button>
</div>
	<div class="mail-check-box">
<input class="form-control mail-check-input" placeholder="인증번호 6자리를 입력해주세요!" disabled="disabled" maxlength="6">
</div>
	<span id="mail-check-warn"></span>
</div>

					<label for="nickNameInput1" class="form-label"> 닉네임 </label>
					<div class="input-group">
						<input id="nickNameInput1" class="form-control" type="text"
							name="nickName" />
						<button class="btn btn-secondary" id="checkNickNameButton1"
							type="button">닉네임 중복 확인</button>
					</div>
					<div class="form-text" id="nickNameMessage1"></div>

					<button class="btn btn-primary" id="submitButton1" disabled>회원가입</button>
					
					<c:if test="${not empty message }">
						<div class="alert alert-primary">
							${message }
						</div>
					</c:if>
				</form>
			</div>
		</div>
	</div>

</body>
</html>