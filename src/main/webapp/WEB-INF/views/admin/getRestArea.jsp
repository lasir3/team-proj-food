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
<script>
$(document).ready(function(){
	
	/* 글 수정 버튼 클릭  */
	$("#modify-start1").click(function(e){
		e.preventDefault();
		$("#input1").removeAttr("readonly");
		$("#textarea1").removeAttr("readonly");
		$("#modify-complete1").removeClass("d-none");
		
		
		
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
		
		// 데이트 피커
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
		$("#stateSelect1").removeClass('d-none');
		let state = $("#stateSelect1").val();
		console.log(state);
		
		// 휴가, 경고 폼의 값 비우기
		$("#datepicker1").val("");
		$("#datepicker2").val("");
		$("#reportInput1").val("");
		$("#reportInput2").val("");
		
		//휴가
		if(state == 1){		
			$("#leaveForm1").removeClass('d-none');
			$("#datepicker1").val("${leave.startDate}");
			$("#datepicker2").val("${leave.endDate}");
		}
		
		//경고
		if(state == 3){
			$("#reportForm1").removeClass('d-none');
			$("#reportInput1").val("${warning.userId}");
			$("#reportInput2").val("${warning.reason}");
		}	
		
	});
	
	
	
	/* 글 삭제 버튼 클릭*/
	$("#delete-submit1").click(function(e){
		e.preventDefault();
		
		if(confirm("삭제하시겠습니까?")){
			let form1 = $("#form1");
			let actionAttr = "${appRoot}/admin/deleteRestArea";
			$("#reportInput1").val("${warning.userId}");
			$("#reportInput2").val("${warning.reason}");
			form1.attr("action", actionAttr);
			form1.submit();
		}
	});
	
	
	// 페이지 로딩 후 reply list 가져오는 ajax 요청
	const listReply = function(){
		const data = {boardId : ${board.id}};
		$.ajax({
			url : "${appRoot}/adminReply/restAreaReplyList",
			type : "get",
			data : data,
			success : function(list){
				//console.log("댓글 가져오기 성공");
				console.log(list)
				
				const replyListElement = $("#replyList1");
				replyListElement.empty();
				
				for(let i = 0; i < list.length; i++){
					const replyElement = $("<li class='list-group-item' />");
					replyElement.html(`
						
						<!-- 댓글 내용 -->
						<div class="listDisplayContainer\${list[i].id}">
							<div class="fw-bold">
								<i class="fa-solid fa-comment"></i>
								\${list[i].prettyInserted}
								
								<span id="modifyButtonWrapper\${list[i].id }">
								</span>
							</div>
							
							<span class="badge bg-light text-dark">
							<i class="fa-solid fa-user"></i>
							\${list[i].writerNickName}
							</span>
							
							<span id="replyContent\${list[i].id}"></span>
						</div>
						
						<!-- 댓글 수정 폼(숨김) -->
						<div id="replyEditFormContainer\${list[i].id }"
							style="display: none;">
							<form action="" method="post">
								<div class="input-group">
									<input type="hidden" name="boardId" value="${board.id }" />
									<input type="hidden" name="id" value="\${list[i].id }" />
									<input class="form-control" value="\${list[i].content }"
										type="text" name="content" required />
									<button data-reply-id="\${list[i].id }"
									class="reply-modify-submit btn btn-outline-secondary">
										<i class="fa-solid fa-comment-dots"></i>
									</button>
								</div>
							</form>
						</div>
						

					`);
					replyListElement.append(replyElement);
					$("#replyContent" + list[i].id).text(list[i].content);
					
					/* 댓글 수정, 삭제 버튼*/
					// own이 true일 때(본인의 댓글일 때)만 수정, 삭제 버튼 보이기
					if(list[i].own){
						$("#modifyButtonWrapper" + list[i].id).html(`
							<!-- 댓글 수정 시작 버튼 -->
							<span class="reply-edit-toggle-button badge bg-info text-dark" 
								id="replyEditToggleButton\${list[i].id }"
								data-reply-id="\${list[i].id }" >
								
								<i class="fa-solid fa-pen-to-square"></i>
							</span>
							
							<!-- 댓글 삭제 버튼 -->
							<span class="reply-delete-button badge bg-danger"
								data-reply-id="\${list[i].id }">
								<i class="fa-solid fa-trash-can"></i>
							</span>
						`);
					}
					
				} // end of for
				
				// 댓글 수정 폼의 제출 버튼 클릭
				$(".reply-modify-submit").click(function(e){
					e.preventDefault();
					
					const id = $(this).attr("data-reply-id");
					//컨테이너의 하위 요소 중 form 을 찾아서 선택
					const formElem = $("#replyEditFormContainer" + id).find("form");
					// const data = formElem.serialize(); // put 방식은 controller에서 못 받음
					const data = {
							boardId : formElem.find("[name=boardId]").val(),
							id : formElem.find("[name=id]").val(),
							content : formElem.find("[name=content]").val()
					};
					
					$.ajax({
						url: "${appRoot}/adminReply/updateReply",
						type: "put",
						data: JSON.stringify(data),
						contentType: "application/json",
						success: function(){
							console.log("수정 성공");
							// 댓글 리스트 refresh
							listReply();
						},
						error: function(){
							$("#replyMessage1").show().text("댓글을 수정할 수 없습니다.").fadeOut(3000);
							console.log("수정 실패");
						},
						complete: function(){
							console.log("수정 종료");
						}
					});
				});
				
				// reply-edit-toggle 버튼 클릭시 댓글 보여주는 div 숨기고,
				// 수정 form 보여주기
				$(".reply-edit-toggle-button").click(function() {
					console.log("버튼클릭");
					const replyId = $(this).attr("data-reply-id");
					const displayDivId = "#replyDisplayContainer" + replyId;
					const editFormId = "#replyEditFormContainer" + replyId;
					
					console.log(replyId);
					console.log(displayDivId);
					console.log(editFormId);
					
					$(displayDivId).hide();
					$(editFormId).show();
				});
				
				
				// 댓글 삭제 버튼 클릭
				$(".reply-delete-button").click(function() {
					const replyId = $(this).attr("data-reply-id");
					const message = "댓글을 삭제하시겠습니까?";
					
					if (confirm(message)) {
						//$("#replyDeleteInput1").val(replyId);
						//$("#replyDeleteForm1").submit();
						$.ajax({
							url: "${appRoot}/adminReply/deleteReply/" + replyId,
							type: "delete",
							success : function(data) {
								//console.log(replyId + "댓글 삭제");
								//댓글 리스트 refresh
								listReply();
								// 메세지 출력
								$("#replyMessage1").show().text(data).fadeOut(3000);
							},
							error : function() {
								$("#replyMessage1").show().text("댓글을 삭제할 수 없습니다.").fadeOut(3000);
								console.log(replyId + "댓글 삭제 중 문제 발생");
							},
							complete: function() {
								console.log(replyId + "댓글 삭제요청 끝");
							}
						});
					}
				});
				
			},
			error : function(){
				console.log("댓글 가져오기 실패");
			}
		});
	}
	// 최초 댓글 목록 출력
	listReply();
	
	
	//댓글입력(#addReplySubmitButton1) 버튼 클릭시 ajax 댓글 추가 요청
	$("#addReplySubmitButton1").click(function(e) {
		e.preventDefault();
		
		const data = $("#insertReplyForm1").serialize();
		console.log(data);
		$.ajax({
			url:"${appRoot }/adminReply/insertRestAreaReply",
			type: "post",
			data: data,
			success: function(data){
				//  새 댓글 등록 메시지 출력
				$("#replyMessage1").show().text(data).fadeOut(3000);
				
				// text input 초기화
				$("#insertReplyContentInput1").val("");
				// 모든 댓글 가져오는 ajax 요청
				listReply();
			},
			error: function(){
				$("#replyMessage1").show().text("댓글을 작성할 수 없습니다").fadeOut(3000);
				console.log("문제 발생");
			},
			complete: function(){
				console.log("요청 완료");
			}
			
		});
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
				
				<form id="form1" action="${appRoot }/admin/updateRestArea" method="post">
					<input type="hidden" name="id" value="${board.id }"/>
					<input type="hidden" name="leaveId" value="${leave.id }" />
					<input type="hidden" name="state" value="${board.state }" />
					<!-- 글 세분류  -->
					<select id="stateSelect1" name="state" class="form-select d-none" disabled>
						<c:if test="${board.state == 1 }">
							<option value="1" ${param.state != 1 && param.state != 2 ? 'selected' : '' } >휴가</option>
						</c:if>
						<c:if test="${board.state == 2 }">						
							<option value="2" ${param.state == 1 ? 'selected' : '' } >사퇴</option>
						</c:if>
						<c:if test="${board.state == 3 }">						
							<option value="3" ${param.state == 2 ? 'selected' : '' } >경고</option>
						</c:if>
					</select>
					
					<!-- 제목  -->
					<div>
						<label class="form-label" for="input1">제목</label>
						<input class="form-control" id="input1" type="text" name="title" 
							 value="${board.title }" readonly required/>
					</div>
					
					<!-- 휴가 기간 -->
					<div class="row d-none" id="leaveForm1">
						<label class="form-label" for="datepicker1" >기간</label>
						<div class="col">
							<%-- <input class="form-control" type="text" id="datepicker1" name="datepicker1" value="${leave.startDate}"/> --%>
							<input class="form-control" type="text" id="datepicker1" name="datepicker1"/>
						</div>
						<div class="col col-lg-1 text-center">-</div>
						<div class="col">
							<%-- <input class="form-control" type="text" id="datepicker2" name="datepicker2" value="${leave.endDate}"/> --%>
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
								<input class="form-control" id="reportInput2" name="reason" type="text" />
							</div>
						</div>
						
					</div>
					
					<!-- 본문  -->
					<div>
						<label class="form-label" for="textarea1">본문</label>
						<textarea class="form-control" id="textarea1" name="content" 
							cols="30" rows="10" form="form1" readonly>${board.content }</textarea>
					</div>
					
					<div>
						<label class="form-label" for="input2" >작성일시</label>
						<input class="form-control" id="input2" type="datetime-local" value="${board.inserted }" readonly/>
					</div> 
					
					<sec:authorize access="isAuthenticated()">
						<sec:authentication property="principal" var="principal"/>	
						<c:if test="${principal.username == board.memberId }"> 
							<button id="modify-start1" class="btn btn-primary" >수정</button>
							<button id="modify-complete1" class="btn btn-success d-none" form="form1" >완료</button>
							<button id="delete-submit1" class="btn btn-danger">삭제</button>
						</c:if>				
					</sec:authorize>
				</form>
				
			</div>
		</div>
	</div>
	
	<%-- 댓글 추가 form --%>
	<div class="container mt-3">
		<div class="row">
			<div class="col">
				<form id="insertReplyForm1">
					<div class="input-group">
						<input type="hidden" name="restAreaId" value="${board.id }" />
						<input id="insertReplyContentInput1" class="form-control" type="text" name="content" required /> 
						<button id="addReplySubmitButton1" class="btn btn-outline-secondary"><i class="fa-solid fa-comment-dots"></i></button>
					</div>
				</form>
			</div>
		</div>
		<div class="row">
			<div class="alert alert-primary" style="display:none;" id="replyMessage1"></div>
		</div>
	</div>
	
	<%-- 댓글 목록 --%>
	<div class="container mt-3">
		<div class="row">
			<div class="col">
				<ul id="replyList1" class="list-group">
				</ul>
			</div>
		</div>
	</div>
	
</body>

</html>