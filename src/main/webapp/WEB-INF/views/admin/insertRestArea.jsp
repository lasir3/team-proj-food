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

	/* state 값에 따라 폼 보이기/숨기기 */
	let state = $("#stateSelect1").val();
	if(state == 1){		
		$("#leaveForm1").removeClass('d-none');
	}
	
	$("#stateSelect1").change(function(){
		
		//다른 폼의 값 비워주기
		$("#datepicker1").val("");
		$("#datepicker2").val("");
		$("#reportInput1").val("");
		$("#reportInput2").val("");
		
		state = $("#stateSelect1").val();
		// 휴가
		if(state == 1){		
			$("#leaveForm1").removeClass('d-none');
		} else{
			$("#leaveForm1").addClass('d-none');
		}
		
		// 경고
		if(state == 3){
			$("#reportForm1").removeClass('d-none');
		} else{
			$("#reportForm1").addClass('d-none');
		}
	});
	
	/* 경고 글 작성시 아이디 검색 버튼 클릭  */
	$("#userSearchButton1").click(function(){
		const data = {userId : $("#userSearchInput1").val()};
		
		$.ajax({
			url: "${appRoot}/admin/userSearch",
			type: "post",
			data: data,
			success: function(list){
				// 테이블 비우기
				console.log(list);
				const userTable = $("#userSearchTable1");
				userTable.empty();
				
				// 테이블 헤더 추가
				const userTableHead = $("<thead/>");
				userTableHead.html(`
						<tr>
							<th>아이디</th>
							<th>닉네임</th>
							<th>가입일</th>
							<th></th>
						</tr>
						`);
				userTable.append(userTableHead);
				
				// 테이블 바디 추가
				const userTableBody = $("<tbody id = 'userTableBody1' />");
				userTable.append(userTableBody);
				
				const userTableBodyElem = $("#userTableBody1");
				
				for(let i = 0; i < list.length; i++){
					const userTableRowElem = $("<tr/>");
					userTableRowElem.html(`
							<td>\${list[i].id}</td>
							<td>\${list[i].nickName}</td>
							<td>\${list[i].inserted}</td>
							<td>
								<button id="userSelectButton1" class="userSelectButton" 
								type="button" data-user-id="\${list[i].id}">
									선택
								</button>
							</td>
							`);
					userTableBodyElem.append(userTableRowElem);
					
					$(".userSelectButton").click(function(){
						const userId = $(this).attr("data-user-id");
						console.log(userId);
						$("#reportInput1").val(userId);
						$("#searchModal1").modal('hide');
						
					});
				} // end of for
			},
			error:function(){
				console.log("아이디 검색 실패");	
			}
			
		});
	});
	
}); 
</script>			
</head>
<body>
<my:navBar2></my:navBar2>
	<my:navBar></my:navBar>

	<div class="container">
		<div class="row">
			<div class="col">
			
				<h1>쉼터 글 작성</h1>
				<form action="${appRoot }/admin/insertRestArea" method="post" id="insertRestAreaForm1">
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
					
					
					<!-- 휴가 기간 전용 폼 -->
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
					
					<!-- 경고 전용 폼-->
					<div class="row d-none" id="reportForm1">
						<div class="row">
							<label for="reportInput1" class="form-label">경고 대상</label>
							<div class="col">
								<!-- 경고대상 아이디 인풋 -->
								<input class="form-control" id="reportInput1" name="userId" type="text"  readonly/>
							</div>
	
							<div class="col">
								<!-- 검색 버튼  -->
								<button class="btn btn-secondary" type="button" data-bs-toggle="modal" data-bs-target="#searchModal1">검색</button>
							</div>
							
							<div class="col">
								
								<!-- 아이디 검색 Modal -->
								<div class="modal fade" id="searchModal1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
								  <div class="modal-dialog">
								    <div class="modal-content">
								      <div class="modal-header">
								        <h5 class="modal-title" id="exampleModalLabel">ID 검색</h5>
								        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								      </div>
								      <!-- 아이디 검색 Modal body  -->
								      <div class="modal-body" id="modal-body1">
								      	<nav class="navbar navbar-light bg-light">
										 	<div class="container-fluid">
												<form class="d-flex">
										    		<span>
										    			<input class="form-control me-2" id="userSearchInput1" type="search" placeholder="아이디 입력" aria-label="Search">
										    		</span>
										    		<span>
											    		<button class="btn btn-outline-success" id="userSearchButton1" type="button">검색</button>
										    		</span>
												</form>
											</div>
										</nav>
										<!-- 유저 검색 결과 -->
										<div id="userSearchResultContainer1">
											<table class="table" id="userSearchTable1">
	
											</table>
										</div>
								      </div>
								      <div class="modal-footer">
								        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
								        <!-- <button type="button" class="btn btn-primary">Save changes</button> -->
								      </div>
								    </div>
								  </div>
								</div>
							</div>
						</div>
						
						<!-- 사유  -->
						<div class="row">
							<label for="reportInput2" class="form-label">사유</label>
							<div class="col">
								<input class="form-control" id="reportInput2" name="reason" type="text"  />
							</div>
						</div>
						
					</div>
					
					<!-- 본문  -->
					<div>
						<label class="form-label" for="textarea1" >본문</label>
						<textarea class="form-control" id="textarea1" name="content" cols="30" rows="10"
						placeholder="휴가 고지 글을 작성할 때에는 본문에도 기간을 작성해주세요." form="insertRestAreaForm1"></textarea>
					</div>
					
					<button class="btn btn-primary" form="insertRestAreaForm1">작성</button>
				</form>
				
			</div>
		</div>
	</div>
</body>
</html>