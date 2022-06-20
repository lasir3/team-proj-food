<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
   uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
	integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css"
	integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	referrerpolicy="no-referrer"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
<script>
$(document).ready(function() {
	$("#edit-button1").click(function() {
		$("#input1").removeAttr("readonly");
		$("#textarea1").removeAttr("readonly");
		$("#modify-submit1").removeClass("d-none");
		$("#delete-submit1").removeClass("d-none");
		$("#close-submit1").removeClass("d-none")
	});
	


	$("#delete-submit1").click(function(e) {
		e.preventDefault();

		if (confirm("삭제하시겠습니까?")) {
			let form1 = $("#form1");
			let actionAttr = "${appRoot}/debate/remove";
			form1.attr("action", actionAttr);

			form1.submit();
		}

	});
	
	$("#close-submit1").click(function(e){
		e.preventDefault();
		
		if(confirm("닫힌 토론으로 보내시겠습니까?")) {
			let form2 = $("#form2");
			let actionAttr = "${appRoot}/debate/close";
			form2.attr("action", actionAttr);
			
			form2.submit();
		}
	})
	
	// 페이지 로딩 후 reply list 가져오는 ajax 요청
	const listReply = function() {
			
			const data = {debateId : ${debate.id}};
			$.ajax({
				url : "${appRoot}/reply/list",
				type : "get",
				data : data,
				success : function(list) {
					// console.log("댓글 가져 오기 성공");
					console.log(list);
					
					const replyListElement = $("#replyList1");
					replyListElement.empty();
					
					// 댓글 개수 표시
					$("#numOfReply1").text(list.length);
					
					for (let i = 0; i < list.length; i++) {
						const replyElement = $("<li class='' />");
						replyElement.html(`
								<div class="card">
								  <div class="card-header" id="\${list[i].writerNickName}">\${list[i].writerNickName}
								  <i class="fa-solid fa-comment"></i>
									\${list[i].prettyInserted}
									<span id="modifyButtonWrapper\${list[i].id }">
									</span>								
								  </div>
								  <div class="card-body" id="replyContent\${list[i].id }"></div>
								  </div>
									<div class="fw-bold">
								<div id="replyDisplayContainer\${list[i].id }">
										
										
										
									</div>
									
								</div>
							<div id="replyEditFormContainer\${list[i].id }"
								style="display: none;">
								<form action="${appRoot }/reply/modify" method="post">
									<div class="input-group">
										<input type="hidden" name="debateId" value="${debate.id }" />
										<input type="hidden" name="id" value="\${list[i].id }" />
										<input class="form-control" value="\${list[i].board }"
											type="text" name="board" required />
										<button data-reply-id="\${list[i].id}" 
										        class="reply-modify-submit btn btn-outline-secondary">
											<i class="fa-solid fa-comment-dots"></i>
										</button>
									</div>
								</form>
							</div>
							
							`);
					replyListElement.append(replyElement);
					$("#replyContent" + list[i].id).text(list[i].board);
					
					// own이 true일 때만 수정,삭제 버튼 보이기
					if (list[i].own) {
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
				
				$(".reply-modify-submit").click(function(e) {
					e.preventDefault();
					
					const id = $(this).attr("data-reply-id");
					const formElem = $("#replyEditFormContainer" + id).find("form");
					// const data = formElem.serialize(); // put 방식은 못 controller에서 못받음
					const data = {
						debateId : formElem.find("[name=debateId]").val(),
						id : formElem.find("[name=id]").val(),
						board : formElem.find("[name=board]").val()
					};
					
					$.ajax({
						url : "${appRoot}/reply/modify",
						type : "put",
						data : JSON.stringify(data),
						contentType : "application/json",
						success : function(data) {
							console.log("수정 성공");
							
							// 메세지 보여주기
							$("#replyMessage1").show().text(data).fadeOut(3000);
							
							// 댓글 refresh
							listReply();
						},
						error : function() {
							$("#replyMessage1").show().text("댓글을 수정할 수 없습니다.").fadeOut(3000);
							console.log("수정 실패");
						},
						complete : function() {
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
						// $("#replyDeleteInput1").val(replyId);
						// $("#replyDeleteForm1").submit();
						
						$.ajax({
							url : "${appRoot}/reply/delete/" + replyId,
							type : "delete",
							success : function(data) {
								// console.log(replyId + "댓글 삭제됨");
								// 댓글 list refresh
								listReply();
								// 메세지 출력
								$("#replyMessage1").show().text(data).fadeOut(3000);
							},
							error : function() {
								$("#replyMessage1").show().text("댓글을 삭제할 수 없습니다.").fadeOut(3000);
								console.log(replyId + "댓글 삭제 중 문제 발생됨");
							},
							complete : function() {
								console.log(replyId + "댓글 삭제 요청 끝");
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
	
	// 댓글 가져오는 함수 실행
	listReply();
	
	// addReplySubmitButton1 버튼 클릭시 ajax 댓글 추가 요청
	$("#addReplySubmitButton1").click(function(e) {
		e.preventDefault();
		
		const data = $("#insertReplyForm1").serialize();
		
		$.ajax({
			url : "${appRoot }/reply/insert",
			type : "post",
			data : data,
			success : function(data) {
				// 새 댓글 등록되었다는 메시지 출력
				$("#replyMessage1").show().text(data).fadeOut(3000);
				
				// text input 초기화 
				$("#insertReplyContentInput1").val("");
				
				// 모든 댓글 가져오는 ajax 요청 
				// 댓글 가져오는 함수 실행
				listReply();
				
				// console.log(data);
			},
			error : function() {
				$("#replyMessage1").show().text("댓글을 작성할 수 없습니다.").fadeOut(3000);
				console.log("문제 발생");
			},
			complete : function() {
				console.log("요청 완료");
			}
		});
	});
});
</script>


<title>Insert title here</title>
</head>
<body>
	<my:navBar current="list" />
	<c:url value="/debate/list" var="listUrl"></c:url>

	<div class="container">
		<div class="row">
			<div class="col">
				<h6>${principal.username }</h6>
				<h1>${debate.memberId }</h1>
				<h5>
					<a href="${listUrl }" style="text-decoration-line: none">토론</a>
				
					<sec:authorize access="isAuthenticated()">
						<sec:authentication property="principal" var="principal" />

						<c:if test="${principal.username == debate.memberId }">
							<button id="edit-button1" class="btn btn-secondary">
								<i class="fa-solid fa-pen-to-square"></i>
							</button>
						</c:if>
					</sec:authorize>
				</h5>

				<c:if test="${not empty message }">
					<div class="alert alert-primary">${message }</div>
				</c:if>

				<form id="form1" action="${appRoot }/debate/modify" method="post"
					enctype="multipart/form-data">
					<input type="hidden" name="id" value="${debate.id }" />

					<%-- <div>
						제목
						<input class="form-control mb-3" type="text" name="title" required
							id="input1" value="${debate.title }" readonly />
					</div>
 --%>
 				<%-- <a href="#" style="text-decoration-line: none" name="title">${debate.title }</a>  --%>
 				<div>
						<label class="form-label" for="input1">제목</label>
						<input class="form-control mb-3" type="text" name="title" required
							id="input1" value="${debate.title }" readonly />
					</div>
 			
					<div class="card">
					<div class="card-header" type="text" value="${debate.writerNickName }" >
						${debate.writerNickName }
						
					<!-- 	<label for="input2" class="form-label">작성일시</label> -->
						<span type="readonly"	>${debate.prettyInserted }</span>
					</div>
					</div>
					<div>
						<label class="form-label" for="textarea1"></label>
						<textarea class="form-control mb-3" name="body" id="textarea1"
							cols="30" rows="10" readonly>${debate.body }</textarea>
					</div>
				
				<%-- 	<div>
						<label for="input3" class="form-label">작성자</label>
						<input id="input3" class="form-control mb-3" type="text"
							value="${debate.writerNickName }" readonly />
					</div> --%>

					
					<%-- <div>
						
						<label for="textarea1">본문</label>			
						<textarea  name="body" id="textarea1" readonly>${debate.body }</textarea>
					</div> --%> 
					<%-- <div>
						<label for="input2" class="form-label">작성일시</label>
						<input class="form-control mb-3" type="datetime-local"
							value="${debate.inserted }" readonly />
							${debate.writerNickName }/${debate.inserted }
					</div>
					 --%>
					
					<div class="container mt-3">
						<div class="row">
							<div class="col">
								<!-- <p>
									댓글
									<span id="numOfReply1"></span>
									개
								</p> -->

								<ul id="replyList1" class="list-group" style="list-style: none">
								</ul>
							</div>
						</div>
					</div>
					<button id="modify-submit1" class="btn btn-primary d-none">수정</button>
					<button id="delete-submit1" class="btn btn-danger d-none">삭제</button>
					<button id="close-submit1" class="btn btn-secondary d-none">토론 닫기</button>
				</form>

			</div>
		</div>
	</div>


	<div class="row">
		<div class="alert alert-primary" style="display: none;"
			id="replyMessage1"></div>
	</div>

	<div class="container mt-10">
		<div class="row">
			<div class="col">
				<h5>댓글 달기</h5>
				<form id="insertReplyForm1">
					<div class="input-group">
						<input type="hidden" name="debateId" value="${debate.id }" />
						<input id="insertReplyContentInput1" class="form-control"
							type="text" name="board" required />
						<button id="addReplySubmitButton1"
							class="btn btn-outline-secondary">
							<i class="fa-solid fa-comment-dots"></i>
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<%-- reply 삭제 form --%>
	<div class="d-none">
		<form id="replyDeleteForm1" action="${appRoot }/reply/delete"
			method="post">
			<input id="replyDeleteInput1" type="text" name="id" />
			<input type="text" name="debateId" value="${debate.id }" />
		</form>
	</div>
</body>
</html>