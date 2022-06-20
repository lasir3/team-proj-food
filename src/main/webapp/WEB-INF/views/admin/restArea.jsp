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
</style>
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
	
	<my:adminBoardPagination path="/admin/restArea"></my:adminBoardPagination>
</body>
</html>