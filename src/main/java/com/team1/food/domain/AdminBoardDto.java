package com.team1.food.domain;



import java.time.LocalDateTime;

import lombok.Data;

@Data
public class AdminBoardDto {
	
	private int id;
	private String title;
	private String content;
	private String memberId;
	private LocalDateTime inserted;
	private String writerNickName;
	private int numOfReply;
	// 상단 고정 여부
	private boolean pinned;
	// 쉼터 글 분류 번호
	private int state;
	
	public String getPrettyInserted() {
		// 24시간 이내면 "시간:분:초"
		// 이전이면 "년-월-일"
		LocalDateTime now = LocalDateTime.now();
		if (now.minusHours(24).isBefore(inserted)) {
			return inserted.toLocalTime().toString();
		} else {
			return inserted.toLocalDate().toString();
		}
	}
	
	public String getShortInserted() {
		// "월-일"만 표시
		int month = inserted.getMonthValue();
		int day = inserted.getDayOfMonth();
		return month + "-" + day;
	}
	
}
