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

<!-- jquery ui  -->
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
<!--  -->
<title>Insert title here</title>	
<script type="text/javascript">
$(document).ready(function(){
	/* 데이트 피커 한글화  */
	$.datepicker.setDefaults({
        dateFormat: 'yy-mm-dd',
        prevText: '이전 달',
        nextText: '다음 달',
        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
        showMonthAfterYear: true,
        yearSuffix: '년'
    });
	
	$( "#datepicker1" ).datepicker();
	$( "#datepicker2" ).datepicker();
	
	let break1, break2;
	
	$("#datepicker1").change(function(){
		break1 = $( "#datepicker1" ).datepicker("getDate");
		
		if(break2 != null && break1 > break2){
			$("#datepicker2").datepicker("setDate", break1);
			break2 = $( "#datepicker2" ).datepicker("getDate");
		}
	});
	
	$("#datepicker2").change(function(){
		break2 = $( "#datepicker2" ).datepicker("getDate");
		if(break1 != null && break1 > break2){
			$("#datepicker2").datepicker("setDate", break1);
			break2 = $( "#datepicker2" ).datepicker("getDate");
		}
		
	});

	/* 현재 state 값 1일때에만 '휴가 기간' 폼 보이기 */
	let state = $("#stateSelect1").val();
	if(state == 1){		
		$("#leaveForm1").removeClass('d-none');
	}
	
	$("#stateSelect1").change(function(){
		state = $("#stateSelect1").val();
		if(state == 1){		
			$("#leaveForm1").removeClass('d-none');
		} else{
			$("#leaveForm1").addClass('d-none');
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
			
				<h1>쉼터 글 작성</h1>
				<form action="${appRoot }/admin/insertRestArea" method="post">
					<!-- 글 세분류  -->
					<select id="stateSelect1" name="state" class="form-select">
						<option value="1" ${param.state != 1 && param.state != 2 ? 'selected' : '' }>휴가</option>
						<option value="2" ${param.state == 1 ? 'selected' : '' }>사퇴</option>
						<option value="3" ${param.state == 2 ? 'selected' : '' }>경고</option>
					</select>
					<!-- 제목 -->
					<div>
						<label class="form-label" for="input1" >제목</label>
						<input class="form-control" id="input1" name="title" type="text" required/>
					</div>
					
					
					<!-- 휴가 기간 -->
					<div class="row d-none" id="leaveForm1">
						<label class="form-label" for="datepicker1" >기간</label>
						<div class="col">
							<input class="form-control" type="text" id="datepicker1" name="datepicker1"/>
						</div>
						<div class="col col-lg-1 text-center">-</div>
						<div class="col">
							<input class="form-control" type="text" id="datepicker2" name="datepicker2"/>
						</div>
					</div>	
					
					<!-- 본문 -->
					<div>
						<label class="form-label" for="textarea1" >본문</label>
						<textarea  class="form-control" id="textarea1" name="content" cols="30" rows="10"></textarea>
					</div>
					
					<button class="btn btn-primary">작성</button>
				</form>
				
			</div>
		</div>
	</div>
</body>
</html>