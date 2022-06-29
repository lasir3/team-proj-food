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

<script src="${appRoot }/resources/summernote/summernote-lite.js"></script>
<script src="${appRoot }/resources/summernote/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="${appRoot }/resources/summernote/summernote-lite.css">

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
						// 여기서 for 문으로 subList List를 가려오고 아래 ajax요청으로 해당 List에 해당하는 subRecipeIndex값을 참조하여 추천수를 카운트하는 service가 작동합니다
						$.ajax({
							url : "${appRoot}/foodBoard/voteSum",
							type : "get",
							data : voteData,
							success : function(voteCount) {
								const subElement = $("<li class='list-group-item' />");
								console.log(subList[i].subRecipeName);
								console.log(subList[i].content);
								console.log(voteCount);
								// 여기서 voteCount순으로 리스트를 다시 정렬하고 싶습니다
								
								subElement.html(`
										
									<div class="row">
										<div class="col-1">
											<div class="row">
												<i class="arrow fa-solid fa-square-caret-up"></i>
												<br />
											</div>
											<!-- 추천수 합계 표시 -->
											<div class="row arrow"><h1 class="voteCountHeader">\${voteCount }</h1></div>
											
											<div class="row">
												<i class="arrow fa-solid fa-square-caret-down"></i>
											</div>
										</div>
										<div class="col-11">
											<h1>\${subList[i].subRecipeName }</h1>
											
											<h3>\${subList[i].content }</h3>
										</div>
									</div>
								`); // end of html
								subElementArr.push(subElement);
								subElementArr.sort(function(a, b) {
									const aVote = Number(a.find(".voteCountHeader").text());
									const bVote = Number(b.find(".voteCountHeader").text());
									
									return bVote - aVote;
								});
								subListElement.empty();
								subListElement.append(subElementArr); // sublist에 각 항목 추가
							} // end of ajax function
						}); // end of ajax
					} // end of for
					// $("#replyContent" + list[i].id).text(list[i].content); // xml 공격방지
				} //end of ajax function
			}); //end of ajax
		} // end of subRecipeList
		subRecipeList();
	});
</script>


<title>Insert title here</title>
</head>
<body>
	<my:navBar></my:navBar>
	<div class="container mt-5">
		<div class="col">
			<div class="container mt-5">
				<div class="row">
					<div class="col-8">
						<div class="foodname">${foodDto.foodName}</div>
						<div class="catename">
							&nbsp;
							<a href="foodList?cateIndex=${foodDto.cateIndex }">${foodDto.cateName}로 이동</a>
						</div>
					</div>
					<div class="col d-md-flex justify-content-md-end mt-5">
						<button type="button" class="btn btn-warning"
							id="FoodEdit-Button1">내용 수정</button>
					</div>
				</div>
			</div>
			<br />
			<br />
			<div class="container">
				<textarea class="summernote1" name="editordata"></textarea>
			</div>
			<br />
			<script>
				$('.summernote1').summernote({
					height : 450,
					lang : "ko-KR"
				});
			</script>
			<hr />
			<h1>하위 레시피 목록 <span id="numOfRecipe1"></span> 개</h1>
			<div class="container mt-5">
			<div id="subRecipeList1" class="list-group" >
			</div>
			</div>
		</div>
	</div>

</body>
</html>