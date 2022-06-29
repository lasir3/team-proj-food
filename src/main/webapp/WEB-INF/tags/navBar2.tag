<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
   uri="http://www.springframework.org/security/tags"%>
<%@ attribute name="current"%>


<c:url value="/member/login" var="loginUrl"></c:url>
<c:url value="/logout" var="logoutUrl"></c:url>
<c:url value="/member/signup" var="signupUrl"></c:url>
<c:url value="/foodBoard/foodCateList" var="foodBoard"></c:url>
<c:url value="/member/memberlist" var="memberlistUrl"></c:url>
<c:url value="/member/memberget" var="membergetUrl"></c:url>

<%-- 회원정보링크 --%>
<sec:authorize access="isAuthenticated()">
   <sec:authentication property="principal" var="principal" />
   <c:url value="/member/memberget" var="membergetUrl">
      <c:param name="id" value="${principal.username }" />
   </c:url>
</sec:authorize>


<nav class="navbar navbar-light " style="background-color: #e3f2fd;">
  <div class="container-fluid container">
    <a class="navbar-brand" href="${foodBoard }">요리위키</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar" aria-controls="offcanvasNavbar">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
      <div class="offcanvas-header">
        <h5 class="offcanvas-title" id="offcanvasNavbarLabel">요리위키</h5>
        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
      </div>
      <div class="offcanvas-body">
        <ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="${foodBoard }">Home</a>
          </li>
            <sec:authorize access="not isAuthenticated()">
            <li class="nav-item">
               <a href="${loginUrl }" class="nav-link">로그인</a>
            </li>
            </sec:authorize>
            <sec:authorize access="not isAuthenticated()">
            <li class="nav-item">
               <a href="${signupUrl }"
                  class="nav-link
                  ${current == 'signup' ? 'active' : ''}">회원가입</a>
            </li>
            </sec:authorize>
            
            <sec:authorize access="isAuthenticated()">
            <li class="nav-item">
               <a href="${membergetUrl }"
                  class="nav-link ${current == 'memberget' ? 'active' : '' }">회원정보</a>
            </li>
            </sec:authorize>

            <sec:authorize access="hasRole('ADMIN')">
            <li class="nav-item">
               <a href="${memberlistUrl }"
                  class="nav-link
                     ${current == 'memberlist' ? 'active' : ''}">회원목록</a>
            </li>
            </sec:authorize>            
                    
            <sec:authorize access="isAuthenticated()">
            <li class="nav-item">
               <button class="nav-link" type="submit" form="logoutform1">로그아웃</button>
            </li>
            </sec:authorize>
            
            <div class="d-none">
               <form action="${logoutUrl }" id="logoutform1" method="post"></form>
            </div>        
            
            
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="offcanvasNavbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              요리카테고리
            </a>
            <ul class="dropdown-menu" aria-labelledby="offcanvasNavbarDropdown">
              <li><a class="dropdown-item" href="#">나라별</a></li>
              <li><a class="dropdown-item" href="#">재료별</a></li>
              <li>
                <hr class="dropdown-divider">
              </li>
              <li><a class="dropdown-item" href="#">기타등등</a></li>
            </ul>
          </li>
        </ul>
      </div>
    </div>
  </div>
</nav>

<nav class="nav justify-content-end"  >

</nav>