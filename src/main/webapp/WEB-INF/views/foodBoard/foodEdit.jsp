<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<title>Insert title here</title>
</head>
<body>
<my:navBar></my:navBar>
	<div class="container mt-5">
		<div class="col">
			<div class="row">
				<form action="${appRoot}/foodBoard/modifyFoodPage" method="post">
					<input type="hidden" name="foodIndex" value="${foodDto.foodIndex }" />

					<div>
						<label class="form-label" for="input1">요리 이름 : </label>
						<input class="form-control" type="text" name="foodName" required
							id="foodName" value="${foodDto.foodName}" />
					</div>


			
					<div>
						<label class="form-label mt-5" for="textarea1">레시피 : </label>
						<textarea class="form-control" name="content" id="content" 
							cols="100" rows="10">${foodDto.content }</textarea>
					</div>
					<div class="mt-3">
						<button type="submit" class="btn btn-secondary" id="editButton1">수정</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<a href="/wiki/debate/list?type=all&keyword=${foodDto.foodName }">
	<button type="button" class="btn btn-success">${foodDto.foodName } 토론검색</button>
	</a>

</body>
</html>