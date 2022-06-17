<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ attribute name="current"%>

<c:url value="/debate/list" var="listUrl"></c:url>
<c:url value="/debate/write" var="writeUrl"></c:url>

<nav class="navbar navbar-expand-lg navbar-light bg-light mb-3">
		<div class="container">
		<%-- <a class="navbar-brand" href="${listUrl }">
			<i class="fa-solid fa-house"></i>
		</a> --%>

		<!-- button.navbar-toggler>span.navbar-toggler-icon -->
		<button class="navbar-toggler" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item">
					<a class="nav-link ${current == 'list' ? 'active' : '' }"
						href="${listUrl }">목록보기</a>
				</li>

				<sec:authorize access="isAuthenticated()">
					<li class="nav-item">
						<a class="nav-link ${current == 'write' ? 'active' : '' }"
							href="${writeUrl }">글쓰기</a>
					</li>
				</sec:authorize>
			</ul>
		</div>
	</div>
</nav>