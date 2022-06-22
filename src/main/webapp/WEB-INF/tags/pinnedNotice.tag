<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- 상단 고정 글 -->
<c:forEach items="${pinnedBoardList }" var="pinnedBoard">
	<tr class="bg-warning">
		<!-- 글번호  -->
		<%-- <td>${pinnedBoard.id }</td> --%>	
		<td><i class="fa-solid fa-bullhorn"></i></td>	
		
		<!--  제목 -->	
		<td>
			<c:url value="/admin/getNotice" var="getPinnedNoticeUrl">
				<c:param name="id" value="${pinnedBoard.id }"></c:param>
			</c:url>
			
			<a href="${getPinnedNoticeUrl }" class="text-decoration-none">
				<div style="height:100%; width:100%">
					<span class="text-body">${pinnedBoard.title }</span> 
					<span id="numOfReply">[${pinnedBoard.numOfReply }]</span>
				</div>
			</a>
		</td>		
		
		<!-- 작성자 -->
		<td>${pinnedBoard.writerNickName }</td>
		
		<!-- 작성시간 -->	
		<td>${pinnedBoard.prettyInserted }</td>					
	</tr>
</c:forEach>