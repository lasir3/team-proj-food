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
					<a href="${appRoot }/admin/insertRestArea">글 쓰기</a>
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