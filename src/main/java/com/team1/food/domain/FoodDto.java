package com.team1.food.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class FoodDto {
	private int foodIndex;
	private String foodName;
	private String memberId;
	private String content;
	private String cateIndex;
	private String cateName;
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
