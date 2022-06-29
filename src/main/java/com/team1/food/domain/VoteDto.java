package com.team1.food.domain;

import lombok.Data;

@Data
public class VoteDto {
	private int voteRecipeIndex;
	private int subRecipeIndex;
	private String memberId;
	private int voteSum;
}
