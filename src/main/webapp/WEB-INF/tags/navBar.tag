<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
   uri="http://www.springframework.org/security/tags"%>
<%@ attribute name="current"%>

<c:url value="/foodBoard/foodCateList" var="foodBoard"></c:url>
<c:url value="/member/signup" var="signupUrl"></c:url>
<c:url value="/member/memberlist" var="memberlistUrl"></c:url>
<c:url value="/member/memberget" var="membergetUrl"></c:url>
<c:url value="/member/login" var="loginUrl"></c:url>
<c:url value="/logout" var="logoutUrl"></c:url>
<c:url value="/admin/main" var="adminUrl"></c:url>
<c:url value="/debate/list" var="debateUrl"></c:url>
<c:url value="/debate/write" var="debateWriteUrl"></c:url>
<c:url value="/debate/close" var="debateCloseUrl"></c:url>
<c:url value="/admin/main" var="adminMainUrl"></c:url>
<c:url value="/admin/notice" var="adminNoticeUrl"></c:url>
<c:url value="/admin/report" var="adminReportUrl"></c:url>
<c:url value="/admin/restArea" var="adminRestAreaUrl"></c:url>
<c:url value="/admin/ask" var="adminAskUrl"></c:url>

<!-- 수정 필요 -->
<c:url value="/foodBoard/foodList?cateIndex=38" var="foodList1"></c:url>
<c:url value="/foodBoard/foodList?cateIndex=40" var="foodList2"></c:url>
<c:url value="/foodBoard/foodList?cateIndex=41" var="foodList3"></c:url>
<c:url value="/foodBoard/foodList?cateIndex=46" var="foodList4"></c:url>
<c:url value="/foodBoard/foodList?cateIndex=47" var="foodList5"></c:url>


<%-- 회원정보링크 --%>
<sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal" var="principal" />
   <c:url value="/member/memberget" var="membergetUrl">
      <c:param name="id" value="${principal.username }" />
   </c:url>
</sec:authorize>

<nav class="navbar sticky-top navbar-expand-md navbar-light mb-3" style="background-color: #78E150;" >
   <div class="container-fluid container">

      <div class="collapse navbar-collapse" id="navbarSupportedContent">
         <ul class="navbar-nav me-auto mb-2 mb-lg-0">

            <li class="nav-item dropdown">
               <a class="nav-link dropdown-toggle ${current == 'foodCateList' ? 'active' : ''}" 
                  id="navbarDropdownMenuLink" role="button"
                  data-bs-toggle="dropdown" aria-expanded="false"> 카테고리 </a>
               <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                  <li>
                     <a class="dropdown-item" href="${foodList1 }">한국음식</a>
                  </li>
                  <li>
                     <a class="dropdown-item" href="${foodList2 }">중국음식</a>
                  </li>
                  <li>
                     <a class="dropdown-item" href="${foodList3 }">베트남음식</a>
                  </li>
                  <li>
                     <a class="dropdown-item" href="${foodList4 }">미국음식</a>
                  </li>
                  <li>
                     <a class="dropdown-item" href="${foodList5 }">프랑스요리</a>
                  </li>                  
               </ul>
            </li>


            <li class="nav-item dropdown">
               <a class="nav-link dropdown-toggle ${current == 'admin' ? 'active' : ''}" 
                  id="navbarDropdownMenuLink" role="button"
                  data-bs-toggle="dropdown" aria-expanded="false"> 커뮤니티 </a>
               <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
               	  <li>
                     <a class="dropdown-item" href="${adminMainUrl }">커뮤니티목록</a>
                  </li>
                  <li>
                     <a class="dropdown-item" href="${adminNoticeUrl }">공지사항</a>
                  </li>
                  <li>
                     <a class="dropdown-item" href="${adminAskUrl }">문의</a>
                  </li>
                  <li>
                     <a class="dropdown-item" href="${adminRestAreaUrl }">쉼터</a>
                  </li>
                  <li>
                     <a class="dropdown-item" href="${adminReportUrl }">신고</a>
                  </li>
               </ul>
            </li>


            <li class="nav-item dropdown">
               <a class="nav-link dropdown-toggle ${current == 'debate' ? 'active' : ''}" href="${debateUrl }"
                  id="navbarDropdownMenuLink" role="button"
                  data-bs-toggle="dropdown" aria-expanded="false"> 토론게시판 </a>
               <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                  <li>
                     <a class="dropdown-item" href="${debateUrl }">열린토론</a>
                  </li>
                  <li>
                     <a class="dropdown-item" href="${debateCloseUrl } ">닫힌토론</a>
                  </li>
                  <li>
                     <a class="dropdown-item" href="${debateWriteUrl }">토론글쓰기</a>
                  </li>

               </ul>
            </li>
           



         </ul>
      </div>
   </div>
</nav>