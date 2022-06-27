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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>


<title>Insert title here</title>
</head>
<body>
	<my:navBar current="close" />
	<div class="container">
		<div class="row">
			<div class="col">
				<h5>닫힌 토론</h5> 
				<c:if test="${not empty message }">
					<div class="alert alert-primary">
						${message }
					</div>
				</c:if>
				
				<!-- table.table>thead>tr>th*3^^tbody -->
				<table class="table table-hover">
					<thead>
						<tr>
							<th><i class="fa-solid fa-hashtag"></i></th>
							<th>항목</th>
							<th><i class="fa-solid fa-calendar"></i></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${closeDebate }" var="close">
							<c:if test="${close.close == true }" >
								<tr>
									<td>${close.id }</td>
									<td>
														
										<c:url value="closeget" var="getUrl">
											<c:param name="id" value="${close.id }"></c:param>
										</c:url>
										
										<a href="${getUrl }" class="text-decoration-none">
											<div style="height:100%; width=100%">
										<span class="badge rounded-pill text-bg-success">닫힌토론</span>
											<span class="text-body">${close.title }</span>
											<span class="numOfReply">[${close.numOfReply }]</span>
											</div>
										</a>
						
										
									</td>
								<%--   <td>${debate.memberId }</td>   --%>
									<td>${close.prettyInserted }</td>
								</tr>
							</c:if>
						</c:forEach>
					</tbody>
				</table>
				<my:closePageNation path="close" />
				<my:closeSearch search="close" />
			</div>
		</div>
</body>
</html>