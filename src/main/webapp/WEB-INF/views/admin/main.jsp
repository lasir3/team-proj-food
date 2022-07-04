<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%request.setCharacterEncoding("utf-8");%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<style type="text/css">
	h3{
		color: black;
	}
	a{
		color: black;
		text-decoration: none;
	}
	.back-to-top-css {
    cursor: pointer;
    position: fixed;
    bottom: 30px;
    right: 30px;
    display: none;
}
</style>
<script>
    $(document).ready(function () {
        $(window).scroll(function () {
            if ($(this).scrollTop() > 50) {
                $('#back-to-top').fadeIn();
            } else {
                $('#back-to-top').fadeOut();
            }
        });
        // scroll body to 0px on click
        $('#back-to-top').click(function () {
            $('#back-to-top').tooltip('hide');
            $('body,html').animate({
                scrollTop: 0
            }, 400);
            return false;
        });

        $('#back-to-top').tooltip('show');

    });
</script>
<title>Insert title here</title>
</head>
<body>
	<my:navBar2></my:navBar2>
	<my:navBar current="admin"></my:navBar>
	
	<!-- 각 구역이 보여줄 게시글 개수 -->
	<c:set var="numOfView" value="7"></c:set>
	
	<div class="container">
		<div class="row">
		
			<!-- 공지사항  -->
			
			<div class="col mt-3 mb-3">
				
				<a href="${appRoot }/admin/notice" >
					<span><h3>공지사항</h3></span>
				</a>

				<ul class="list-group">		
					<c:forEach items="${noticeBoardList }" var="board" begin="0" end="${numOfView }">
						
						
						<c:url value="/admin/getNotice" var="getNoticeUrl">
							<c:param name="id" value="${board.id }"></c:param>
						</c:url>
						
						<li class="list-group-item">
							<a href="${getNoticeUrl }">
								<div>
									<span>${board.shortInserted }</span>
									<span>${board.title }</span>
									<span>[${board.numOfReply }]</span>
								</div>
							</a>
							<%-- <span>${board.shortInserted }</span>					
							<a href="${getNoticeUrl }">
								${board.title }
							</a> --%>
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
							<a href="${getRestAreaUrl }">
								<div>
									<span>${board.shortInserted }</span>
									<span>${board.title }</span>
									<span>[${board.numOfReply }]</span>
								</div>
							</a>
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
							<a href="${getAskUrl }">
								<div>
									<span>${board.shortInserted }</span>
									<span>${board.title }</span>
									<span>[${board.numOfReply }]</span>
								</div>
							</a>
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
							<a href="${getReportUrl }">
								<div>
									<span>${board.shortInserted }</span>
									<span>${board.title }</span>
									<span>[${board.numOfReply }]</span>
								</div>
							</a>
						</li>
						
					</c:forEach>
				</ul>
			</div>
			
		</div> <!-- end of .row  -->
	</div> <!-- end of .container  -->
	
	<!-- 스크롤 맨위 버튼 -->
	<a id="back-to-top" href="#" class="btn btn-primary btn-sm back-to-top-css" role="button" title="맨위로" data-toggle="tooltip" data-placement="left"><span class="glyphicon glyphicon-chevron-up"><i class="fa-solid fa-angles-up"></i></span></a>
	
</body>
</html>