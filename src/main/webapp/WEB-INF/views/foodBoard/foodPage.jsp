<%@ page import="com.team1.food.domain.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<style>
   .foodname {
       font-size: 48px;
   }
   .catename {
       font-size: 15px;
   }
	.center {
	  justify-content:center;
	  align-items:center;
	}
	.arrow {
		font-size:xx-large;
		text-align: center;
	}
</style>

<script>
	$(document).ready(function() {
		
		const subRecipeList = function() {
			const data = {foodIndex : ${foodDto.foodIndex}};
			$.ajax({
				url : "${appRoot}/foodBoard/subList",
				type : "get",
				data : data,
				success : function(subList) {
					// console.log("댓글 가져 오기 성공");
					console.log('sublist', subList);
					
					const subListElement = $("#subRecipeList1"); 
					// list 표시를 위해 초기화 필요
					subListElement.empty();
					// 하위리스트의 갯수 표시
					$("#numOfRecipe1").text(subList.length);
					
					// subElementArr
					const subElementArr = [];
					for (let i = 0; i < subList.length; i++) {
						var subIndex = subList[i].subRecipeIndex;
						// subRecipeIndex로 추천수 ajax 실행
						const voteData = {subRecipeIndex : subIndex};
						
						// for 문으로 subList List를 가려오고 아래 ajax요청으로 해당 List에 해당하는 subRecipeIndex값을 참조하여 추천수를 카운트하는 service가 작동
						$.ajax({
							url : "${appRoot}/foodBoard/voteSum",
							type : "get",
							data : voteData,
							success : function(voteCount) {
								const subElement = $("<li class='list-group-item' />");
								
								subElement.html(`
									<div id="voteDisplayContainer" class="row">
										<!-- 가져올 subRecipeIndex와 voteCount 정보 -->
										<input type="hidden" name="subIndex1" value="\${subList[i].subRecipeIndex }" /> 
										<input type="hidden" name="voteCountNumber1" value="\${voteCount }" /> 
										<div class="col-1">
											<div class="row">
												<button class="vote-Up-Button1 btn btn-link" type="button"><i class="arrow fa-solid fa-square-caret-up"></i></button>
												<br />
											</div>
											<!-- 추천수 합계 표시 -->
											<div class="row arrow"><h1 class="voteCountHeader">\${voteCount }</h1></div>
											
											<div class="row">
												<button class="vote-Down-Button1 btn btn-link" type="button"><i class="arrow fa-solid fa-square-caret-down"></i></button>
											</div>
										</div>
										<div class="col-11">
											<h1>\${subList[i].subRecipeName }</h1>
											<h3>\${subList[i].content }</h3>
										</div>
									</div>
								`); // end of html
								
								/*
								// 하위 레시피 리스트를 추천수 순으로 정렬
								subElementArr.push(subElement);
								subElementArr.sort(function(a, b) {
									const aVote = Number(a.find(".voteCountHeader").text());
									const bVote = Number(b.find(".voteCountHeader").text());
									return bVote - aVote;
								});
								subListElement.empty();
								subListElement.append(subElementArr); // sublist에 각 항목 추가
								*/
								subListElement.append(subElement); // sublist에 각 항목 추가

								///// 삭제...
								
								//// 삭제...
								// 추천 up 버튼 클릭시 추천수 증가
								subElement.find(".vote-Up-Button1").click((function(subelem) {
									const elem = subelem;
									return function(e) {
										e.preventDefault();
										// div 태그의 Id 검색
										// const divElem = $("#voteDisplayContainer").find("div");
										const voteNumData = {
											subRecipeIndex : elem.find("[name=subIndex1]").val(),
											voteCount : elem.find("[name=voteCountNumber1]").val(),
											// 여기서 
										};
										$.ajax({
											url : "${appRoot }/foodBoard/voteUp",
											type : "put",
											data : JSON.stringify(voteNumData),
											contentType : "application/json",
											success : function(voteNumData) {
												console.log("추천수 증가");
												console.log(voteNumData);
												$("#modalMessage1").modal('show');
												$("#modalBodyMessage1").text(voteNumData);
												subRecipeList();
											},
											error : function() {
												$("#modalMessage1").modal('show')
												$("#modalBodyMessage1").text("추천수가 변경되지 않았습니다. 로그인이 필요합니다.");
												console.log("문제 발생");
											},
											complete : function() {
												console.log("요청 완료");
											}
										});
									}
									
								})(subElement)); // click event handler
								
								subElement.find(".vote-Down-Button1").click((function(subelem) {
									const elem = subelem;
									return function(e) {
										e.preventDefault();
										// div 태그의 Id 검색
										// const divElem = $("#voteDisplayContainer").find("div");
										const voteNumData = {
											subRecipeIndex : elem.find("[name=subIndex1]").val(),
											voteCount : elem.find("[name=voteCountNumber1]").val(),
											// 여기서 
										};
										$.ajax({
											url : "${appRoot }/foodBoard/voteDown",
											type : "put",
											data : JSON.stringify(voteNumData),
											contentType : "application/json",
											success : function(voteNumData) {
												console.log("추천수 감소");
												console.log(voteNumData);
												$("#modalMessage1").modal('show');
												$("#modalBodyMessage1").text(voteNumData);
												subRecipeList();
											},
											error : function() {
												$("#modalMessage1").modal('show')
												$("#modalBodyMessage1").text("추천수가 변경되지 않았습니다. 로그인이 필요합니다.");
												console.log("문제 발생");
											},
											complete : function() {
												console.log("요청 완료");
											}
										});
									}
									
								})(subElement)); // click event handler
							} // end of ajax function
							
						}); // end of ajax
					} // end of for
				} //end of ajax function
			}); //end of ajax
		} // end of subRecipeList
		subRecipeList();
	});
</script>

<style>
.textarea_size {
    resize:none;
    line-height:150%;
    width:100%;
    overflow-y:hidden;
    height:30px;
    border:none;
}
</style>

<script>
	function cmaTextareaSize(obj, bsize) { // 객체명, 기본사이즈
	    var sTextarea = document.getElementById(obj);
	    var csize = (sTextarea.scrollHeight >= bsize) ? sTextarea.scrollHeight+"px" : bsize+"px";
	    sTextarea.style.height = bsize+"px"; 
	    sTextarea.style.height = csize;
	}
	document.getElementById('textarea_size').onmousedown = function(e){
		  e.preventDefault();
	}
</script>
    
<title>Insert title here</title>

</head>
<body>

	<div class="container mt-5">
		<div class="col">
			<div class="row">
				<div class="col-8">
					<div class="foodname">
						${foodDto.foodName}
					</div>
					<div class="catename">
						&nbsp;
						<a href="foodList?cateIndex=${foodDto.cateIndex }">${foodDto.cateName}로 이동</a>
					</div>
				</div>
				<div class="col d-md-flex justify-content-md-end mt-5">
					<sec:authorize access="hasRole('ADMIN')">
						<button type="button" class="btn btn-warning" onclick="location.href='foodEdit?foodIndex=${foodDto.foodIndex }'">카테고리 수정</button>
					</sec:authorize>
				</div>
				<div class="mt-5">
					<!-- 본문 내용 -->
					<textarea name="cma_test1" id="cma_test1" class="textarea_size"
					onchange="cmaTextareaSize('cma_test1', 30);" onkeyup="cmaTextareaSize('cma_test1', 30);">${foodDto.content }</textarea>
					<script>cmaTextareaSize('cma_test1', 30);</script>
				</div>
				<hr />
				<h1 class="mt-5">
					하위 레시피 목록
					<span id="numOfRecipe1"></span>
					개
				</h1>
				<!-- <div class="alert alert-primary" style="display: none;" id="voteMessage1"></div> -->
				<div class="container mt-5">
					<div id="subRecipeList1" class="list-group"></div>
				</div>
			
				<!-- 안내 메시지용 Modal -->
				<div id="modalMessage1" class="modal fade" tabindex="-1">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title">알림</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"	aria-label="Close"></button>
							</div>
							<div class="modal-body input">
								<p id="modalBodyMessage1" class="text"></p>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>