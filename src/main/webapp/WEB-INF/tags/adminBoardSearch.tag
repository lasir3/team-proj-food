<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="path" %>

<form action="${appRoot }${path }" class="d-flex">
	<div class="input-group">    
    	<select name="type" id="" class="form-select">
    		<option value="all" ${param.type != 'title' && param.type != 'content' ? 'selected' : '' }>전체</option>
    		<option value="title" ${param.type == 'title' ? 'selected' : '' }>제목</option>
    		<option value="content" ${param.type == 'content' ? 'selected' : '' }>본문</option>
    	</select>
    	<input type="search" class="form-control me-2" name="keyword"/>
    	<input type="hidden" name="page" value="1" />
    	<button class="btn btn-outline-success" ><i class="fa-solid fa-magnifying-glass"></i></button>
   	</div>
</form>