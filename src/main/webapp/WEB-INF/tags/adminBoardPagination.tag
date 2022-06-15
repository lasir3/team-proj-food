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
      		<span aria-hidden="true">&laquo;</span>
    	</a>
 	</li>
   
   <!--  페이지 번호 나열 -->
	<c:forEach begin="${pageInfo.left }" end="${pageInfo.right }" var="pageNum">   
 		<c:url value="${path }" var="link">
   			<c:param name="page" value="${pageNum }"></c:param>
		</c:url>
		<li class="page-item">
			<a class="page-link" href="${link }">${pageNum }</a>
		</li>
	</c:forEach>
	

	
  	<!-- 끝으로  -->
  	
  	<c:url value="${path }" var="toLast">
  		<c:param name="page" value="${pageInfo.last}"></c:param>
  	</c:url>
 	<li class="page-item">
    	<a class="page-link" href="${toLast }" aria-label="Next">
      		<span aria-hidden="true">&raquo;</span>
    	</a>
	</li>
</ul>
