<%@ page import="java.net.URLEncoder"%>
<%@ page import="com.team1.food.domain.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
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
<title>요리위키에 오신것을 환영합니다!!</title>

<style>
.back-to-top-css {
    cursor: pointer;
    position: fixed;
    bottom: 30px;
    right: 30px;
    display: none;
}

.btn-info {
	background-color: #78E150;
	border-color: #78E150;
	color: black;
	hover-color: black;
}
.btn-info:hover {
	background-color: #66b349;
	border-color: #66b349;
	color: black;
}

.imageContainer {
  position: relative;
  text-align: center;
  color: white;
}

/* Centered text */
.centered {
  position: absolute;
  top: 30%;
  left: 50%;
  transform: translate(-50%, -50%);
}

.centered2 {
  position: absolute;
  top: 70%;
  left: 50%;
  transform: translate(-50%, -50%);
}
</style>

<script>
	$(document).ready(function() {
		$("#add-submit1").click(function(e) {
			e.preventDefault();

			if (confirm("추가하시겠습니까?")) {
				let form1 = $("#form1");
				form1.submit();
			}
		});
	});
	
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
<my:navBar current="foodCateList"></my:navBar>
	<div class="container mt-5">
		<div class="row">
			<div class="imageContainer mb-4">
				<img src="${imageUrl }/foodWikiFile/FoodCateTable/mainPic.png" class="img-fluid" alt="...">
				<h1 class="centered mb-5">요리위키에 오신것을 환영합니다!!</h1>
				<div class="centered2 mb-5">요리위키는 누구나 레시피를 작성하고 공유할 수 있는 위키입니다.</div>
			</div>
		
			<div class="mt-4"></div>
			<h2 class="mb-4">카테고리 목록</h2>
			
			<sec:authorize access="hasRole('ADMIN')">
				<div class="col">
					<div class="d-grid gap-2 d-md-flex justify-content-md-end mb-4">
						<button type="button" class="btn btn-primary me-md-0 mt-3"
							id="CateAdd-Button1" data-bs-toggle="modal"
							data-bs-target="#addModal" data-bs-whatever="@mdo">카테고리 추가</button>
					</div>
				</div>
			</sec:authorize>

			<form id="form1" action="${appRoot }/foodBoard/addCate" method="post"
				enctype="multipart/form-data">
				<div class="modal fade" id="addModal" tabindex="-1"
					aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLabel">카테고리 추가</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<div class="mb-3">
									<label for="category-name" class="col-form-label">카테고리명:</label>
									<input type="text" class="form-control" id="category-name"
										name="cateName" />
								</div>
								<div class="mb-3">
									<label for="file-text" class="col-form-label">배경이미지:</label>
									<input type="file" accept="image/*" id="file-text"
										name="addFile" />
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal">취소</button>
								<button type="submit" class="btn btn-primary" id="add-submit1"
									data-dismiss="modal">추가</button>
							</div>
						</div>
					</div>
				</div>
			</form>

			<c:forEach items="${foodCateList }" var="cateList"
				varStatus="indexNum">
				<div class="col-sm-4">
					<div class="card text-center mb-5 shadow bg-body rounded">
						<img
							src="${imageUrl }/foodWikiFile/FoodCateTable/${cateList.cateIndex }/${cateList.fileName }"
							class="card-img-top embed-responsive-item" alt="...">
						<div class="card-body">
							<h5 class="card-title" >${cateList.cateName }</h5>
							<a href="foodList?cateIndex=${cateList.cateIndex }"	class="btn btn-info">카테고리로 이동</a>	
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>

	<!-- 카테고리 등록 여부에 따른 메시지 띄우기 -->
		<!-- 안내 메시지용 Modal -->
	<c:if test="${not empty cateMessage }">
		<!-- Modal -->
		<div class="modal fade" id="modalMessage1" tabindex="-1"
			aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="modalMessage1Label">알림</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<p>${cateMessage }</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>

		<script>
			let m = new bootstrap.Modal(document.getElementById('modalMessage1'), {});
			m.show();
		</script>
	</c:if>
	
	<!-- 페이지 상단으로 이동 -->
	<a id="back-to-top" href="#"
		class="btn btn-info btn-sm back-to-top-css" role="button"
		data-toggle="tooltip" data-placement="left">
		<span class="glyphicon glyphicon-chevron-up">
			<i class="fa-solid fa-angles-up"></i>
		</span>
	</a>
</body>
</html>