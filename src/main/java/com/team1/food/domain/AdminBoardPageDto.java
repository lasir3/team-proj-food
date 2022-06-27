package com.team1.food.domain;

import lombok.Data;

@Data
public class AdminBoardPageDto {
	
	//한 화면에 보여줄 버튼 개수
	private int numOfButton = 5;
	
	//현재 페이지 파라미터 저장(controller의 page파라미터 값으로 세팅)
	private int page;
	//보드 테이블의 총 레코즈 개수 저장
	private int totalRow; 
	//한 페이지 당 출력할 게시글 개수 저장
	private int rowPerPage;
	
	
	// 가장 마지막 페이지 번호(DB의 레코즈 수를 기준으로 정해진다)
	public int getLast() {
		return (totalRow - 1) / rowPerPage + 1;
	}
	
	// 페이지 번호(왼쪽)
	public int getLeft() {
		return (getCurrentPageBundle() - 1) * numOfButton + 1;
	}
	
	// 페이지 번호(오른쪽)
	public int getRight() {
		// 페이지 번호(왼쪽)을 기준으로 페이지 번호(오른쪽)을 구함
		int right = getLeft() + numOfButton - 1;
		// 끝 페이지 번호를 넘기지 않도록 함
		return Math.min(right, getLast()); 
	}
	
	// 내가 몇번째 페이지 번호 묶음에 있는지
	// >> 화면에 1~5를 보고있다면 1번째
	// >> 화면에 6~10를 보고있다면 2번째
	public int getCurrentPageBundle() {
		int currentPageBundle = (page - 1) / numOfButton + 1;
		return currentPageBundle = Math.max(currentPageBundle, 1);
	}
	
	// 이전 페이지 번호 묶음의 '마지막 번호'로 돌아갈때 사용할 프로퍼티
	// >> page=1~5 묶음을 보고 있을 때 1을 리턴
	// >> page=6~10 묶음을 보고 있을 때 5를 리턴
	// >> page=11~15 묶음을 보고 있을 때 10을 리턴
	public int getLastNumOfPrevPageBundle() {
		return (page - 1) / numOfButton * numOfButton;
	}
	
	// 다음 페이지 번호 묶음의 첫번째 번호로 갈 때에 사용할 프로퍼티
	// >> page=1~5 묶음을 보고 있을 때 6을 리턴
	// >> page=6~10 묶음을 보고 있을 때 11을 리턴
	public int getFirstNumOfNextPageBundle() {
		return getCurrentPageBundle() * numOfButton + 1;
	}
	
}
