package com.team1.food.domain;

import lombok.Data;

@Data
public class FoodCateDto {
	private int cateIndex;
	private String cateName;
	private String memberId;
	private String authRole;
}
