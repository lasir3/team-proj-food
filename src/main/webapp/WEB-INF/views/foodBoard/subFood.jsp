<%@ page import="com.team1.food.domain.*"%>
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

<script src="./summernote-lite.js"></script>
<script src="./summernote-ko-KR.js"></script>
<link rel="stylesheet" href="./summernote-lite.css">

<style>
.center {
  justify-content:center;
  align-items:center;
}

.arrow {
	font-size:xx-large;
	text-align: center;
}
</style>

<script>
	$(document).ready(function() {
		
	});
</script>

</head>
<body>
<my:navBar2></my:navBar2>
	<div class="container mt-5">
		<c:forEach items="${subFoodDto }" var="subList">
			<div class="row center">
				<div class="col-1">
				<div class="row">
					<i class="arrow fa-solid fa-square-caret-up"></i><br />
				</div>
				<div style="font-size:large; text-align: center; font-weight:bold">${subIndexMap[subList.subRecipeIndex] }</div>
				<div class="row">
					<i class="arrow fa-solid fa-square-caret-down"></i>
				</div>
				</div>
				<div class="col-11">
					<h1>${subList.subRecipeName }</h1>
					<h3>${subList.content }</h3>
				</div>
			</div>
			<hr />
		</c:forEach>
	</div>
</body>
</html>