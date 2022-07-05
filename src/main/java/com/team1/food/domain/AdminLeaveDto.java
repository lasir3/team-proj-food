package com.team1.food.domain;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Data;

//com.team1.food.domain.AdminLeaveDto

@Data
public class AdminLeaveDto {
	private int id;
	private String memberId;
	private Date start;
	private Date end;
	private int boardId;
	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	
	public String getStartDate() {
		return dateFormat.format(start);		
	}
	
	public String getEndDate() {
		return dateFormat.format(end);
	}
}
