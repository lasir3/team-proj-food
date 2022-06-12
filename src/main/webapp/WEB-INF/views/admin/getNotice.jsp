<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
	$("#modify-start1").click(function(e){
		e.preventDefault();
		$("#input1").removeAttr("readonly");
		$("#textarea1").removeAttr("readonly");
	});
});
</script>
</head>
<body>
	
	<div class="container">
		<div class="row">
			<div class="col">
				
				<form id="form1" action="${appRoot }/admin/modifyNotice" method="post">
					<input type="hidden" name="id" value="${notice.id }"/>
					
					<div>
						<label class="form-label" for="input1">제목</label>
						<input class="form-control" id="input1" type="text" name="title" 
							 value="${notice.title }" readonly required/>
					</div>
			
					<div>
						<label class="form-label" for="textarea1">본문</label>
						<textarea class="form-control" id="textarea1" name="content" 
							cols="30" rows="10" readonly>${notice.content }</textarea>
					</div>
					
					<div>
						<label class="form-label" for="input2" >작성일시</label>
						<input class="form-control" id="input2" type="datetime-local" value="${notice.inserted }" readonly/>
					</div> 
					
					<button id="modify-start1" class="btn btn-primary" >수정</button>
					<button id="delete-submit1" class="btn btn-danger">삭제</button>
				</form>
				
			</div>
		</div>
	</div>
	
</body>
</html>