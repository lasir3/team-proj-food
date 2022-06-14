<%@ page import="java.net.URLEncoder"%>
<%@ page import="com.team1.food.domain.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
<title>Insert title here</title>

<script>

</script>

</head>
<body>
	<div class="container mt-5">
		<div class="row">
			<h1 class="mb-4">요리위키에 오신것을 환영합니다!!</h1>
			<div class="mb-5">이 위키는 요리에 관한 위키입니다.</div>
			<h2 class="mb-4">카테고리 목록</h2>
			<!-- <div class="d-grid gap-2 d-md-flex justify-content-md-end mb-4" >
				<button class="btn btn-warning me-md-10 mb-1"  id="CateEdit-Button1">카테고리 추가</button>
				<button class="btn btn-warning me-md-10 mb-1"  id="CateEdit-Button1">카테고리 편집</button>
			</div> -->

			<c:forEach items="${foodCateList }" var="cateList">
				<%
				FoodCateDto dto = (FoodCateDto) pageContext.getAttribute("cateList");
				String encodedFileName = URLEncoder.encode(dto.getFileName(), "utf-8");
				pageContext.setAttribute("encodedFileName", encodedFileName);
				%>
				<div class="col-sm-4">
					<div class="card text-center mb-5 shadow bg-body rounded">
						<img
							src="${imageUrl }/foodWikiFile/CateFiles/${cateList.cateIndex }/${cateList.fileName }"
							class="card-img-top" alt="...">
						<div class="card-body">
							<h5 class="card-title">${cateList.cateName }</h5>
							<a href="foodList?cateName=${cateList.cateName }" class="btn btn-primary">카테고리로 이동</a>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</body>
</html>