<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
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
</head>
<style>
.one{
display:inline; }
</style>
<body>
<my:navBar2></my:navBar2>
<my:navBar current="login"></my:navBar>
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-12 col-lg-6">
				<h1>로그인 </h1>
				<form action="${pageContext.request.contextPath }/login" method="post" class="one">
					<label for="usernameInput1" class="form-label">
						아이디 
					</label>
					<input id="usernameInput1" class="form-control" type="text" name="username" />
					
					<label for="passwordInput1" class="form-label">
						패스워드
					</label>
					<input class="form-control" id="passwordInput1" type="password" name="password" />
					
					<div class="form-check">
						<input class="form-check-input" type="checkbox" name="remember-me" id="rememberMeCheck1" />
						
						<label for="rememberMeCheck1" class="form-check-label">
							로그인 상태 유지
						</label>
					</div>
					<input class="btn btn-primary" type="submit" value="로그인" />


				</form>
			<form action="${pageContext.request.contextPath }/member/signup" id="signup1" class="one">
				<button class="btn btn-primary" form="signup1">
					회원가입
				</button>
			</form>
			<p>${message }</p>
			</div>
		</div>
	</div>
</body>
</html>