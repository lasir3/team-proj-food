package com.team1.food.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class SmallReplyDto {
	private int id;
	private int bigReplyId;
	private String memberId;
	private String board;
	private LocalDateTime inserted;
	
	public String getPrettyInserted() {
		// 24시간 이내면 시간만
		// 이전이면 년-월-일
		LocalDateTime now = LocalDateTime.now();
		if (now.minusHours(24).isBefore(inserted)) {
			return inserted.toLocalTime().toString();
		} else {
			return inserted.toLocalDate().toString();
		}
	}	
}
