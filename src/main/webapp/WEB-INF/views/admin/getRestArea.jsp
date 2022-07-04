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
	
	
	
});
</script>
</head>
<body>
<my:navBar2></my:navBar2>
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