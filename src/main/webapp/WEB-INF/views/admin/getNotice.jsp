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
			let actionAttr = "${appRoot}/admin/deleteNotice";
			form1.attr("action", actionAttr);
			form1.submit();
		}
	});
	
	//댓글 입력 버튼 클릭시 ajax 요청
	$("#insertNoticeReplyButton").click(function(e){
		e.preventDefault();
		
		const data = $("#insertReplyForm1").serialize();
		
		console.log(data);
		
		$.ajax({
			url:"${appRoot}/adminReply/insertNoticeReply",
			type: "post",
			data: data,
			success: function(data){
				// 새 댓글 등록 메시지 출력
				$("#replyMessage1").show().text(data).fadeOut(3000);
				// 댓글 입력란 초기화
				$("#insertNoticeReplyInput1").val("");
				// 모든 댓글 가져오는 ajax요청
				listReply();
			},
			error: function(){
				$("#replyMessage1").show().text("댓글을 작성할 수 없습니다.").fadeOut(3000);
				console.log("문제 발생");
			},
			complete: function(){
				console.log("요청완료");
			}
		});
	});
	
	// 페이지 로딩 후 댓글 리스트 가져오는 ajax 요청
	const listReply = function(){
		const data = {boardId : ${board.id}};
		console.log(data);
		$.ajax({
			url : "${appRoot}/adminReply/noticeReplyList",
			type : "get",
			data : data,
			success : function(list){
				//console.log("댓글 가져오기 성공");
				//console.log(list);
				
				const replyListElement = $("#replyList1");
				replyListElement.empty();
				
				for(let i = 0; i < list.length; i++){
					const replyElement = $("<li class='list-group-item' />");
					replyElement.html(`
							
						<div id="replyDisplayContainer\${list[i].id}"> 
							\${list[i].prettyInserted}
							
							<span id="replyContent\${list[i].id}"></span>
						</div>
						
						<div id="replyEditFormContainer\${list[i].id}"
							style="display : none">
							<form action="${appRoot}/adminReply/updateNoticeReply">
								<div class="input-group">
									<input type="hidden" name="boardId" value="${board.id }" />
									<input type="hidden" name="id" value="\${list[i].id}" />
									<input class="form-control" value="\${list[i].content}"
										type="text" name="content" required />
									<button class="reply-modify-submit btn btn-outline-secondary"
										data-reply-id="\${list[i].id}">
										<i class="fa-solid fa-comment-dots"></i>
									</button>
								</div>	
							</form>

						</div>
					`);
					
					replyListElement.append(replyElement);
					$("#replyContent" + list[i].id).text(list[i].content);
					
					
					
				} // end of for
			}
		});
	}
	
	listReply();
	/*
	// 페이지 로딩 후 reply list 가져오는 ajax 요청
	const listReply = function(){
		const data = {boardId : ${board.id}};
		$.ajax({
			url : "${appRoot}/reply/list",
			type : "get",
			data : data,
			success : function(list) {
				// console.log("댓글 가져 오기 성공");
				console.log(list);
				
				const replyListElement = $("#replyList1");
				replyListElement.empty();
				
				//댓글 개수 표시
				$("#numOfReply1").text(list.length);
				
				for (let i = 0; i < list.length; i++) {
					const replyElement = $("<li class='list-group-item' />");
					replyElement.html(`
							
							<div id="replyDisplayContainer\${list[i].id }">
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
							
							<div id="replyEditFormContainer\${list[i].id }"
								style="display: none;">
								<form action="${appRoot }/reply/modify" method="post">
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
					
					// own이 true일 때만 수정, 삭제 버튼 보이기
					if(list[i].own){
						$("#modifyButtonWrapper" + list[i].id).html(`
							<span class="reply-edit-toggle-button badge bg-info text-dark"
							id="replyEditToggleButton\${list[i].id }"
							data-reply-id="\${list[i].id }">
								<i class="fa-solid fa-pen-to-square"></i>
							</span>
							<span class="reply-delete-button badge bg-danger"
								data-reply-id="\${list[i].id }">
								<i class="fa-solid fa-trash-can"></i>
							</span>
						`);
					}
					
				} // end of for
				
				$(".reply-modify-submit").click(function(e){
					e.preventDefault();
					
					const id = $(this).attr("data-reply-id");
					const formElem = $("#replyEditFormContainer" + id).find("form");
					// const data = formElem.serialize(); // put 방식은 controller에서 못 받음
					const data = {
							boardId : formElem.find("[name=boardId]").val(),
							id : formElem.find("[name=id]").val(),
							content : formElem.find("[name=content]").val()
					};
					
					$.ajax({
						url: "${appRoot}/reply/modify",
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
				
				// 삭제 버튼 클릭 이벤트 메소드 등록
				// reply-delete-button 클릭시
				$(".reply-delete-button").click(function() {
					const replyId = $(this).attr("data-reply-id");
					const message = "댓글을 삭제하시겠습니까?";
					
					if (confirm(message)) {
						//$("#replyDeleteInput1").val(replyId);
						//$("#replyDeleteForm1").submit();
						$.ajax({
							url: "${appRoot}/reply/delete/" + replyId,
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
			error : function() {
				console.log("댓글 가져오기 실패");
			}
		});
	}
	*/
	
});
</script>
</head>
<body>
	
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
				
				<form id="form1" action="${appRoot }/admin/updateNotice" method="post">
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
					
					<button id="modify-start1" class="btn btn-primary" >수정</button>
					<button id="modify-complete1" class="btn btn-success d-none" >완료</button>
					<button id="delete-submit1" class="btn btn-danger" >삭제</button>
				</form>
				
			</div>
		</div>
	</div>
	
	<!-- 댓글 추가  -->
	<div class="container mt-3">
		<div class="row">
			<div class="col">
			
				<form id="insertReplyForm1">
					<input type="hidden" name="boardId" value="${board.id }" />
					<input id="insertNoticeReplyInput1" type="text" name="content" required />
					<button id="insertNoticeReplyButton">댓글등록</button>					
				</form>
				
			</div>
		</div>
	</div>
	
	<!-- 댓글 리스트 -->
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