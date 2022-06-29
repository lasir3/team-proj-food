<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>


<title>Insert title here</title>
</head>
<body>
	<my:navBar current="list" />
	<div class="container mb-3">
		<div class="row">
			<div class="col">
				<h1>열린 토론</h1>
				<c:if test="${not empty message }">
					<div class="alert alert-primary">${message }</div>
				</c:if>

				<!-- table.table>thead>tr>th*3^^tbody -->
				<table class="table table-hover">
					<thead>
						<tr>
							<th>
								글 번호
							</th>
							<th>항목</th>
							<th>작성자</th>
							<th>
								<i class="fa-solid fa-calendar"></i>
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${allDebate }" var="all">
							<tr>
								<td>${all.id }</td>
								<td>
									<c:url value="/debate/get" var="getUrl">
										<c:param name="id" value="${all.id }"></c:param>
									</c:url>

									<a href="${getUrl }" class="text-decoration-none">
										<div style="height: 100%;">
										<c:choose>
										<c:when test="${all.close == 0 }">
													<span class="badge rounded-pill bg-secondary">열린토론</span>
												</c:when>
												<c:when test="${all.close == 1 }">
													<span class="badge rounded-pill bg-secondary">닫힌토론</span>
												</c:when>
										</c:choose>
											<span class="text-body">${all.title }</span>
											<span class="numOfReply">[${all.numOfReply }]</span>
										</div> 
									</a>


								</td>
								
							  <td>${all.writerNickName }</td>
								<td>${all.prettyInserted }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="d-inline-flex p-2">
				<my:search search="all" />
				</div>
				<my:pageNation path="all" />
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>