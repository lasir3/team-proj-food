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
<title>검색결과</title>
<script>
//화면 맨위로 이동
$(document).ready(function () {
    $(window).scroll(function () {
        if ($(this).scrollTop() > 50) {
            $('#back-to-top').fadeIn();
        } else {
            $('#back-to-top').fadeOut();
        }
    });
    // scroll body to 0px on click
    $('#back-to-top').click(function () {
        $('#back-to-top').tooltip('hide');
        $('body,html').animate({
            scrollTop: 0
        }, 400);
        return false;
    });

    $('#back-to-top').tooltip('show');

});
</script>
</head>
<body>
	<my:navBar2></my:navBar2>
	<my:navBar></my:navBar>

	<div class="container">
		<h3>카테고리 겸색결과 : </h3>
		<table class="table">
			<thead>
			</thead>
			<tbody>
				<c:forEach items="${cateList }" var="cate">
					<tr>
						<td><a href="foodList?cateIndex=${cate.cateIndex }">${cate.cateName}</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<h3>음식 겸색결과 : </h3>
		<table class="table">
			<thead>
			</thead>
			<tbody>
				<c:forEach items="${foodList }" var="food">
					<tr>
						<td><a href="foodPage?foodIndex=${food.foodIndex }">${food.foodName}</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<h3>레시피 겸색결과 : </h3>
		<table class="table">
			<thead>
			<tbody>
				<c:forEach items="${recipeList }" var="recipe">
					<tr>
						<td><a href="foodPage?foodIndex=${recipe.foodIndex }">${recipe.subRecipeName}</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<a id="back-to-top" href="#"
		class="btn btn-primary btn-sm back-to-top-css" role="button"
		data-toggle="tooltip" data-placement="left">
		<span class="glyphicon glyphicon-chevron-up">
			<i class="fa-solid fa-angles-up"></i>
		</span>
	</a>
</body>
</html>