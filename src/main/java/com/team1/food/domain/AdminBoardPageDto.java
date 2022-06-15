package com.team1.food.domain;

import lombok.Data;

@Data
public class AdminBoardPageDto {
	//현재 페이지 파라미터 저장(controller의 page파라미터 값으로 세팅)
	private int page;
	//보드 테이블의 총 레코즈 개수 저장
	private int totalRow; 
	//한 페이지 당 출력할 게시글 개수 저장
	private int rowPerPage;
	
	// 페이지 번호(왼쪽)
	public int getLeft() {
		
		//화면에 보여질 페이지 번호 묶음(1~5 또는 6~10)들의 몇번째 집합인지?
		// 예를 들어 1~5 이면 1번째, 6~10 이면 2번째.
		int currentPageSet = (page - 1) / rowPerPage + 1;
		currentPageSet = Math.max(currentPageSet, 1);
		int left = (currentPageSet - 1) * rowPerPage + 1;

		return left;
	}
	
	
	// 페이지 번호(오른쪽)
	public int getRight() {
		// 페이지 번호(왼쪽)을 기준으로 페이지 번호(오른쪽)을 구함
		int right = getLeft() + rowPerPage - 1;
		// 마지막 페이지를 넘어가지 않도록 함
		right = Math.min(right, getLast());
		return right;
	}
	
	// 가장 마지막 페이지 번호
	public int getLast() {
		return (totalRow - 1) / rowPerPage + 1;
	}

}
