package com.team1.food.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class DebateDto {
	private boolean close;
	private String memberId;
	private int id;
	private String title;
	private String body;
	private LocalDateTime inserted;
	private String writerNickName;
	private int numOfReply;
	private int hit;
	private int cateIndex;
	private String cateName;
	private int foodIndex;
	
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
