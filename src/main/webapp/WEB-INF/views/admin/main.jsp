<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*"%>
<%request.setCharacterEncoding("utf-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<style type="text/css">
	h3{
		color: black;
	}
	a{
		text-decoration: none;
	}
</style>
<title>Insert title here</title>
</head>
<body>
	
	<!-- 보여줄 게시글 개수 -->
	<c:set var="numOfView" value="7"></c:set>
	
	<div class="container">
		<div class="row">
		
			<!-- 공지사항  -->
			
			<div class="col mt-3 mb-3">
				
				<a href="${appRoot }/admin/notice" >
					<h3>공지사항</h3>
				</a>

				<ul class="list-group">		
					<c:forEach items="${noticeBoardList }" var="board" begin="0" end="${numOfView }">
						
						
						<c:url value="/admin/getNotice" var="getNoticeUrl">
							<c:param name="id" value="${board.id }"></c:param>
						</c:url>
						
						<li class="list-group-item">
							<span>${board.shortInserted }</span>					
							<a href="${getNoticeUrl }">
								${board.title }
							</a>
						</li>
						
					</c:forEach>
				</ul>
			</div>
			
			<hr />
			
			<!-- 쉼터  -->
			
			<div class="col mb-3">
			
				<a href="${appRoot }/admin/restArea">
					<h3>쉼터</h3>
				</a>
				
				<ul class="list-group">		
					<c:forEach items="${restAreaBoardList }" var="board" begin="0" end="${numOfView }">
						
						<c:url value="/admin/getRestArea" var="getRestAreaUrl">
							<c:param name="id" value="${board.id }"></c:param>
						</c:url>
						
						<li class="list-group-item">	
							<span>${board.shortInserted }</span>				
							<a href="${getRestAreaUrl }">${board.title }</a>
						</li>
						
					</c:forEach>
				</ul>
			</div>
			
			<hr />
			
			<!-- 문의 -->
			
			<div class="col mb-3">
			
				<a href="${appRoot }/admin/ask">
					<h3>문의 게시판</h3>
				</a>
				
				<ul class="list-group">		
					<c:forEach items="${askBoardList }" var="board" begin="0" end="${numOfView }">
						
						<c:url value="/admin/getAsk" var="getAskUrl">
							<c:param name="id" value="${board.id }"></c:param>
						</c:url>
						
						<li class="list-group-item">	
							<span>${board.shortInserted }</span>				
							<a href="${getAskUrl }">${board.title }</a>
						</li>
						
					</c:forEach>
				</ul>
			</div>
			
			<hr />
			
			<!-- 신고 -->
			
			<div class="col mb-3">
			
				<a href="${appRoot }/admin/report">
					<h3>신고 게시판</h3>
				</a>
				
				<ul class="list-group">		
					<c:forEach items="${reportBoardList }" var="board" begin="0" end="${numOfView }">
						
						<c:url value="/admin/getReport" var="getReportUrl">
							<c:param name="id" value="${board.id }"></c:param>
						</c:url>
						
						<li class="list-group-item">	
							<span>${board.shortInserted }</span>				
							<a href="${getReportUrl }">${board.title }</a>
						</li>
						
					</c:forEach>
				</ul>
			</div>
			
		</div> <!-- end of .row  -->
	</div> <!-- end of .container  -->
	
	
</body>
</html>