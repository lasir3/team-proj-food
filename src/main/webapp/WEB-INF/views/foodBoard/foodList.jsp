<%@ page import="com.team1.food.domain.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<title>Insert title here</title>

<style>
   .catetext {
       font-size: 48px;
   }
   
   .maintext {
       font-size: 15px;
   }
</style>

</head>
<body>
	<my:navBar></my:navBar>
	<div class="container mt-5">
		<div class="row">
			<div class="col-8">
				<div class="catetext" >${cateDto.cateName }</div>
				<div class="maintext">&nbsp;<a href="foodCateList">메인 페이지로 이동</a></div>
			</div>
			<!-- 카테고리 수정, 삭제 버튼 -->
			<sec:authorize access="hasRole('ADMIN')">
				<div class="col d-md-flex justify-content-md-end mt-5" >
					<div class="btn-group btn-group-toggle" data-toggle="buttons">
						<button type="button" class="btn btn-warning" data-bs-toggle="modal"
							data-bs-target="#modifyModal">카테고리 수정</button>
						<button type="button" class="btn btn-danger" data-bs-toggle="modal"
							data-bs-target="#deleteModal">카테고리 삭제</button>
					</div>
				</div>
			</sec:authorize>
			<div class="mb-5"> - 이 위키는 ${cateDto.cateName }에 관한 페이지입니다.</div>
			<div class="mb-5"> ${cateDto.content }</div>
			<!-- 카테고리 수정 여부에 따른 메시지 띄우기 -->
			<!-- Modal로 수정 예정 -->
			<c:if test="${not empty message }">
				<div class="alert alert-danger alert-dismissible fade show" role="alert">
					<strong>${message }</strong>
					<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
				</div>
			</c:if>
			<c:if test="${not empty cateFail }">
				<div class="alert alert-danger alert-dismissible fade show" role="alert">
					<strong>${cateFail }</strong>
					<button type="button" class="btn-close" data-bs-dismiss="alert"	aria-label="Close"></button>
				</div>
			</c:if>
			<c:if test="${not empty cateSuccess }">
				<div class="alert alert-primary alert-dismissible fade show" role="alert">
					<strong>${cateSuccess }</strong>
					<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
				</div>
			</c:if>
		
			<div class="d-grid gap-2 d-md-flex justify-content-md-end mb-4" >
				<form id="form1" action="${appRoot }/foodBoard/modifyCate" method="post" enctype="multipart/form-data">
					<!-- 카테고리 수정용 dto hidden 타입으로 입력 -->
					<input type="hidden" name="cateIndex" value="${cateDto.cateIndex }" />
					<input type="hidden" name="fileName" value="${cateDto.fileName }" />
					
					<div class="modal fade" id="modifyModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">카테고리 수정</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<div class="mb-3">
										<label for="category-name" class="col-form-label">카테고리명:</label>
										<input type="text" class="form-control" id="category-name" name="cateName" value="${cateDto.cateName }"/>
									</div>
									<div class="mb-3">
										<label for="file-text" class="col-form-label">배경이미지:</label>
										<input type="file" accept="image/*" name="modifyFile" id="file-text"/>
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"	data-bs-dismiss="modal">취소</button>
									<button type="submit" class="btn btn-primary" id="add-submit1">수정</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>

			<!-- 삭제버튼 클릭시 modal -->
			<form id="form1" action="${appRoot }/foodBoard/deleteCate" method="post" >
				<!-- 카테고리 수정용 dto hidden 타입으로 입력 -->
				<input type="hidden" name="cateIndex" value="${cateDto.cateIndex }" />
				<input type="hidden" name="fileName" value="${cateDto.fileName }" />
				<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title">카테고리 삭제</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"	aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<p>카테고리를 삭제하시겠습니까?</p>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"	data-bs-dismiss="modal">취소</button>
								<button type="submit" class="btn btn-danger" id="remove1">삭제</button>
							</div>
						</div>
					</div>
				</div>
			</form>

			<h2 class="mb-4">요리 목록</h2>

			<!-- 음식 추가 버튼 -->
			<div class="d-grid gap-2 d-md-flex justify-content-md-end mb-4" >
				<sec:authorize access="hasRole('ADMIN')">
					<button type="button" class="btn btn-primary me-md-0 mb-1"
						id="CateAdd-Button1" data-bs-toggle="modal"
						data-bs-target="#addFoodModal" data-bs-whatever="@mdo">음식 추가</button>
				</sec:authorize>
				<form id="form1" action="${appRoot }/foodBoard/addFood" method="post">
					<input type="hidden" name="cateIndex" value="${cateDto.cateIndex }" />
					<div class="modal fade" id="addFoodModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">음식 추가</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<div class="mb-3">
										<label for="category-name" class="col-form-label">음식명:</label>
										<input type="text" class="form-control" id="food-name" name="foodName"/>
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"	data-bs-dismiss="modal">취소</button>
									<button type="submit" class="btn btn-primary" id="add-submit1">추가</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="col">
				<c:forEach items="${foodListPage }" var="list">
				<c:if test="${not empty list.foodName }">
					<div class="card-body">
						<a href="foodPage?foodIndex=${list.foodIndex }" class="btn btn-primary">${list.foodName }</a>
						<div>${list.content }</div>
					</div>
				</c:if>
				</c:forEach>
			</div>
		</div>
	</div>
</body>
</html>