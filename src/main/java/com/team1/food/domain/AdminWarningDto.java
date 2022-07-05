package com.team1.food.domain;

import lombok.Data;

//com.team1.food.domain.AdminWarningDto 

@Data
public class AdminWarningDto {
	private int id;
	private String userId;
	private String reason;
	private int boardId;
}
