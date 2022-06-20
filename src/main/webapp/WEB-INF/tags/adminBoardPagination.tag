<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="path" %>


<ul class="pagination justify-content-center">

	<!-- 처음으로 -->
	<c:url value="${path }" var="toFirst">
		<c:param name="page" value="1"></c:param>
	</c:url>
	<li class="page-item">
    	<a class="page-link" href="${toFirst }" aria-label="Previous">
      		<span aria-hidden="true">처음으로</span>
    	</a>
 	</li>
	
	<!-- 이전 페이지 묶음으로 -->
	<c:url value="${path }" var="toPrev">
		<!-- page 파라미터가 1보다 작아지지 않도록 함 -->
		<c:param name="page" 
		value="${pageInfo.lastNumOfPrevPageBundle > 1 ?
		 pageInfo.lastNumOfPrevPageBundle : 1 }"></c:param>
	</c:url>
	<li class="page-item">
    	<a class="page-link" href="${toPrev }" aria-label="Previous">
      		<span aria-hidden="true">&laquo;</span>
    	</a>
 	</li>
   
   <!--  페이지 번호 나열 -->
	<c:forEach begin="${pageInfo.left }" end="${pageInfo.right}" var="pageNum">   
 		<c:url value="${path }" var="link">
   			<c:param name="page" value="${pageNum }"></c:param>
		</c:url>
		<li class="page-item ${pageInfo.page == pageNum ? 'active' : ''}">
			<a class="page-link" href="${link }">${pageNum }</a>
		</li>
	</c:forEach>

	
  	<!-- 다음 페이지 묶음으로  -->
  	<c:url value="${path }" var="toNext">
  		<!-- page 파라미터가 last값을 넘어가지 않도록 함  -->
  		<c:param name="page" 
  		value="${pageInfo.firstNumOfNextPageBundle > pageInfo.last ?
  		 pageInfo.last : pageInfo.firstNumOfNextPageBundle }"></c:param>
  	</c:url>
 	<li class="page-item">
    	<a class="page-link" href="${toNext }" aria-label="Next">
      		<span aria-hidden="true">&raquo;</span>
    	</a>
	</li>
	
	<!-- 끝으로 -->
	<c:url value="${path }" var="toLast">
  		<c:param name="page" value="${pageInfo.last }"></c:param>
  	</c:url>
 	<li class="page-item">
    	<a class="page-link" href="${toLast }" aria-label="Next">
      		<span aria-hidden="true">끝으로</span>
    	</a>
	</li>
	
</ul>
