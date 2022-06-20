<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
   uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>

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
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>


<title>Insert title here</title>
</head>
<body>
	<my:navBar current="write"></my:navBar>
	<!-- .container>.row>.col>h1{글 작성} -->
	<div class="container">
		<div class="row">
			<div class="col">
				<h3>토론 작성</h3>
				
			
				<div class="alert alert-primary">주제와 맞는 토론을 입력해 주세요.</div>
				
				
				<form action="${appRoot }/debate/write" method="post" >
					<div>
						<label class="form-label" for="input1">주제 :</label>
						<input class="form-control mb-3" 
							placeholder="주제를 입력해 주세요." 
							type="text" name="title" required id="input1" cols="20" rows="5" />
					</div>
					
					 <div>
						<label class="form-label" for="textarea1">내용 :</label>
						<textarea style="resize: none;" placeholder="내용을 입력해 주세요." class="form-control mb-3" name="body" id="textarea1" cols="30" rows="10"></textarea>
					</div>
					 
					
					<button class="btn btn-primary">작성</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>