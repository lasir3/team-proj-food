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

<title>음식페이지 수정</title>
</head>
<body>
<my:navBar2></my:navBar2>
<my:navBar></my:navBar>
	<div class="container mt-5">
		<div class="col">
			<div class="row">
				<form action="${appRoot}/foodBoard/modifyFoodPage" method="post">
	

					<div>
						<label class="form-label" for="input1">요리 이름 : </label>
						<input class="form-control" type="text" name="foodName" required id="foodName" value="${foodDto.foodName}" />
					</div>

					<div>
						<label class="form-label mt-3" for="textarea1">개요 : </label>
						<textarea class="form-control" name="content" id="content"  cols="100" rows="10">${foodDto.content }</textarea>
					</div>

					<div class="d-grid gap-2 d-md-flex justify-content-md-first mb-4" >
						<!-- 요리 수정용 dto hidden 타입으로 입력 -->
						<input type="hidden" name="foodIndex" value="${foodDto.foodIndex }" />
						<div class="modal fade" id="modifyModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="exampleModalLabel">요리페이지 수정</h5>
										<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body">
										<p>요리페이지를 수정하시겠습니까?</p>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-secondary"	data-bs-dismiss="modal">취소</button>
										<button type="submit" class="btn btn-primary" id="modify-submit1">수정</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
				
				<div class="mt-3">
				<sec:authorize access="hasRole('ADMIN')">
					<div class="col">
						<button type="submit" class="btn btn-warning me-md-0 mb-1"
							id="edit-Button1" data-bs-toggle="modal"
							data-bs-target="#modifyModal" 
							data-bs-whatever="@mdo">수정</button>
						<button type="button" class="btn btn-danger me-md-0 mb-1" 
							id="delete-Button1"  
							data-bs-toggle="modal" 
							data-bs-target="#deleteModal">삭제</button>
					</div>
				</sec:authorize>
				</div>
			</div>
		</div>
	</div>

</body>
</html>