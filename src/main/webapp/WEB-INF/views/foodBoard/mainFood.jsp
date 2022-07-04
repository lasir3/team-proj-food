<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<title>Insert title here</title>

<!-- include summernote for BootStrap5 css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.20/lang/summernote-ko-KR.min.js"></script>

<style>
   .foodname {
       font-size: 48px;
   }
   
   .catename {
       font-size: 15px;
   }
</style>
</head>
<body>

	<div class="row">
		<div class="mb-1 foodname">${foodDto.foodName}</div>
		<div class="mb-5 catename">&nbsp;<a href="foodList?cateIndex=${foodDto.cateIndex }">${foodDto.cateName}</a></div>
	</div>
	<div id="summernote"></div>
    <script>
	    $('#summernote').summernote({
			placeholder: '이 페이지는 ${foodDto.foodName}요리에 관한 위키 페이지입니다.',
			tabsize: 2,
			height: 120,
			lang : 'ko-KR',
			toolbar: [
			  ['style', ['style']],
			  ['font', ['bold', 'underline', 'clear']],
			  ['color', ['color']],
			  ['para', ['ul', 'ol', 'paragraph']],
			  ['table', ['table']],
			  ['insert', ['link', 'picture', 'video']],
			  ['view', ['codeview', 'help']]
			]
	    });
    </script>
</body>
</html>