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

<nav class="navbar navbar-expand-md navbar-light bg-light mb-3"  >
	<div class="container">
		<a class="navbar-brand" href="${foodBoard }">
			<i class="fa-solid fa-house"></i>
		</a>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">

				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#"
						id="navbarDropdownMenuLink" role="button"
						data-bs-toggle="dropdown" aria-expanded="false"> 카테고리 </a>
					<ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
						<li>
							<a class="dropdown-item" href="#">나라별</a>
						</li>
						<li>
							<a class="dropdown-item" href="#">재료별</a>
						</li>
						<li>
							<a class="dropdown-item" href="#">기타 등등</a>
						</li>
					</ul>
				</li>


				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#"
						id="navbarDropdownMenuLink" role="button"
						data-bs-toggle="dropdown" aria-expanded="false"> 커뮤니티 </a>
					<ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
						<li>
							<a class="dropdown-item" href="#">공지사항</a>
						</li>
						<li>
							<a class="dropdown-item" href="#">문의</a>
						</li>
						<li>
							<a class="dropdown-item" href="#">쉼터</a>
						</li>
						<li>
							<a class="dropdown-item" href="#">신고</a>
						</li>
					</ul>
				</li>

				<li class="nav-item">
					<a href="${debateUrl }"
						class="nav-link
						${current == 'debate' ? 'active' : ''}">토론게시판</a>
				</li>


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

				<sec:authorize access="not isAuthenticated()">
				<li class="nav-item">
					<a href="${loginUrl }" class="nav-link">로그인</a>
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


			</ul>
		</div>
	</div>
</nav>
