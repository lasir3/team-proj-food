<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<title>Insert title here</title>
<style type="text/css">
	#numOfReply{
		color: rgb(255, 127, 80);
	}
	.state-a{
		text-decoration: none;
		color: black;
		display: inline-block;
		width: 4em;
		height: 2.5em;
		text-align: center;
		padding-top: 0.4em;
	}
	.state-a:hover{
		color: black;
	}
	.state-li{
		padding: 0px;
	}
	.state-li:hover{
		box-shadow: 0px -6px 2px green inset;
	}
	.state-li-selected{
		box-shadow: 0px -6px 2px gold inset;
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		/* state 탭 스타일 초기화   */
		let stateNum = $("#currentState").val(); /* 초기값 0 */
		let stateElem = $("#state" + stateNum);
		stateElem.addClass("state-li-selected");
		/* state 탭 눌렀을 때 */
		$(".state-li").click(function(){
			stateElem.removeClass("state-li-selected");
			stateNum = $("#currentState").val();
			stateElem = $("#state" + stateNum);
			stateElem.addClass("state-li-selected");
		});
		
	});
</script>
</head>
<body>
	<my:navBar2></my:navBar2>
	<my:navBar current="admin"></my:navBar>
	
	
	
	<div class="container">
		<div class="row">
			<div class="col">
				<h1>쉼터</h1>
				
				<c:if test="${not empty updateMessage }">
					<div class="alert alert-primary">
						${updateMessage }
					</div>
				</c:if>
				
				<c:if test="${not empty deleteMessage }">
					<div class="alert alert-primary">
						${deleteMessage }
					</div>
				</c:if>
				
				<!-- 글 종류 탭  -->	
				<div class="row">
					<div class="col d-flex justify-content-start">
						<ul class="list-group list-group-horizontal">
							<c:url value="/admin/restArea" var="stateLink">
								<c:param name="type" value="all"></c:param>
								<c:param name="keyword" value="%%"></c:param>
								<c:param name="page" value="1"></c:param>
								<c:param name="state" value=""></c:param>
							</c:url>
							<li class="list-group-item state-li"  id="state0">
								<a href="${stateLink }0" class="state-a">전체</a>
							</li>
							<li class="list-group-item state-li"  id="state1">
								<a href="${stateLink }1" class="state-a">휴가</a>
					  		</li>
							<li class="list-group-item state-li"  id="state2">
								<a href="${stateLink }2" class="state-a">사퇴</a>
							</li>
							<li class="list-group-item state-li"  id="state3">
								<a href="${stateLink }3" class="state-a">경고</a>
							</li>
							<input type="hidden" id="currentState" value="${not empty param.state ? param.state : 0 }"/>
						</ul>
					</div>
					
					<!-- 내가 받은 경고 -->
					<sec:authorize access="isAuthenticated()">
						<sec:authentication property="principal" var="principal"/>
							<div class="col d-flex justify-content-end">
							<!-- Modal Button  -->
							<button type="button" 
							class="btn btn-danger" 
							data-bs-toggle="modal" 
							data-bs-target="#modal2">
								내가 받은 경고
							</button>
							
							<!-- Modal -->
							<div class="modal fade" id="modal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
							  <div class="modal-dialog">
							    <div class="modal-content">
							      <div class="modal-header">
							        <h5 class="modal-title" id="exampleModalLabel">내가 받은 경고내역</h5>
							        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							      </div>
							      <div class="modal-body">
							      <table class="table">
							      	<thead>
							      		<tr>
							      			<th>사유</th>
							      		</tr>
							      	</thead>
							      	<tbody>
										<c:forEach items="${WarningList }" var="warning">
											<c:if test="${warning.userId == principal.username}">
												<tr>
													<td>${warning.reason }</td>
												</tr>
											</c:if>
										</c:forEach>
							      	</tbody>
							      </table>
							      </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
							      </div>
							    </div>
							  </div>
							</div>
						</div>
					</sec:authorize>
				
					
					<!-- 휴가 현황  -->
					<sec:authorize access="hasRole('ADMIN')">
						<div class="col d-flex justify-content-end">
							<!-- Modal Button  -->
							<button type="button" 
							class="btn btn-secondary" 
							data-bs-toggle="modal" 
							data-bs-target="#modal1">
								휴가 현황
							</button>
							
							<!-- Modal -->
							<div class="modal fade" id="modal1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
							  <div class="modal-dialog">
							    <div class="modal-content">
							      <div class="modal-header">
							        <h5 class="modal-title" id="exampleModalLabel">현재 휴가중인 인원</h5>
							        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							      </div>
							      <div class="modal-body">
							      <table class="table">
							      	<thead>
							      		<tr>
							      			<th>휴가자</th>
							      			<th>기간</th>
							      		</tr>
							      	</thead>
							      	<tbody>
							      		<!-- 오늘 날짜 yyyy-MM-dd 형식으로 불러오기 -->
							      		<c:set var="now" value="<%=new java.util.Date()%>" />
							      		<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today"/> 
										
							      		<c:forEach items="${LeaveList }" var="leave">
							      			<!-- 아직 복귀하지 않은 휴가자만 표시 -->
							      			<c:if test="${leave.endDate > today }">
								      			<tr>
								      				<td>${leave.memberId }</td>
								      				<td>${leave.startDate } - ${leave.endDate }</td>
								      			</tr>
							      			</c:if>
							      		</c:forEach>
							      	</tbody>
							      </table>
							      </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
							      </div>
							    </div>
							  </div>
							</div>
						</div>
					</sec:authorize>
				</div>
				
				
				<!-- 테이블 시작 -->
				
				<table class="table table-hover">
					<thead>
						<tr>
							<th>글 번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성시간</th>
						</tr>
					</thead>
					<tbody>
						<!-- 상단 고정 공지 글 -->
						<my:pinnedNotice></my:pinnedNotice>
						
						<!-- 일반 글 -->
						<c:forEach items="${boardList }" var="board">
							<tr>
								<!-- 글번호  -->
								<td>${board.id }</td>	
								
								<!--  제목 -->	
								<td>
									<c:url value="/admin/getRestArea" var="getRestAreaUrl">
										<c:param name="id" value="${board.id }"></c:param>
									</c:url>
									
									<a href="${getRestAreaUrl }" class="text-decoration-none text-body">
										<div style="heigth:100%; width:100%">
											<c:choose>
												<c:when test="${board.state == 1 }">
													<span class="badge rounded-pill bg-secondary">휴가</span>
												</c:when>
												<c:when test="${board.state == 2 }">
													<span class="badge rounded-pill bg-dark">사퇴</span>
												</c:when>
												<c:when test="${board.state == 3 }">
													<span class="badge rounded-pill bg-danger">경고</span>
												</c:when>
											</c:choose>
											<span class="text-body">${board.title }</span>
											<span id="numOfReply">[${board.numOfReply }]</span>
										</div>
									</a>
								</td>		
								
								<!-- 작성자 -->
								<td>${board.writerNickName }</td>
								
								<!-- 작성시간 -->	
								<td>${board.prettyInserted }</td>					
							</tr>
						</c:forEach>
						
					</tbody>
				</table>
				
				<sec:authorize access="hasRole('ADMIN')">
					<a href="${appRoot }/admin/insertRestArea" 
					class="btn btn-primary">
						글 쓰기
					</a>
				</sec:authorize>
				
			</div>
		</div>
	</div>
	
	<!-- 페이지, 검색  -->
	<div class="d-flex justify-content-center">
		<my:adminBoardPagination path="/admin/restArea"></my:adminBoardPagination>
	</div>
	<div class="d-flex justify-content-center mb-3">
		<my:adminBoardSearch path="/admin/restArea"></my:adminBoardSearch>
	</div>
</body>
</html>