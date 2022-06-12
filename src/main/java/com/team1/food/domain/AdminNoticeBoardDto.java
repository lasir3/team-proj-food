package com.team1.food.domain;



import java.time.LocalDateTime;

import lombok.Data;

@Data
public class AdminNoticeBoardDto {
	
	private int id;
	private String title;
	private String content;
	private String memberId;
	private LocalDateTime inserted;
}
