<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<title>Insert title here</title>
<script>
$(document).ready(function(){
	
	/* 글 수정 버튼 클릭  */
	$("#modify-start1").click(function(e){
		e.preventDefault();
		$("#input1").removeAttr("readonly");
		$("#textarea1").removeAttr("readonly");
		$("#modify-complete1").removeClass("d-none");
	});
	
	/* 글 삭제 버튼 클릭*/
	$("#delete-submit1").click(function(e){
		e.preventDefault();
		
		if(confirm("삭제하시겠습니까?")){
			let form1 = $("#form1");
			let actionAttr = "${appRoot}/admin/deleteRestArea";
			form1.attr("action", actionAttr);
			form1.submit();
		}
	});
	
});
</script>
</head>
<body>

	<my:navBar></my:navBar>
	
	<div class="container">
		<div class="row">
			<div class="col">
				
				<!--  새 글 등록 메세지 -->
				<c:if test="${not empty createMessage }">
					<div class="alert alert-primary">
						${createMessage }
					</div>
				</c:if>
				
				<!-- 제목, 본문  -->
				
				<form id="form1" action="${appRoot }/admin/updateRestArea" method="post">
					<input type="hidden" name="id" value="${board.id }"/>
					
					<div>
						<label class="form-label" for="input1">제목</label>
						<input class="form-control" id="input1" type="text" name="title" 
							 value="${board.title }" readonly required/>
					</div>
			
					<div>
						<label class="form-label" for="textarea1">본문</label>
						<textarea class="form-control" id="textarea1" name="content" 
							cols="30" rows="10" readonly>${board.content }</textarea>
					</div>
					
					<div>
						<label class="form-label" for="input2" >작성일시</label>
						<input class="form-control" id="input2" type="datetime-local" value="${board.inserted }" readonly/>
					</div> 
					
					<sec:authorize access="isAuthenticated()">
						<sec:authentication property="principal" var="principal"/>	
						<c:if test="${principal.username == board.memberId }"> 
							<button id="modify-start1" class="btn btn-primary" >수정</button>
							<button id="modify-complete1" class="btn btn-success d-none" >완료</button>
							<button id="delete-submit1" class="btn btn-danger" >삭제</button>
						</c:if>				
					</sec:authorize>
				</form>
				
			</div>
		</div>
	</div>
	
</body>
</html>