package com.team1.food.domain;

public class PageInfoDto {
	private int current;
	private int end;

	public void setCurrent(int current) {
		this.current = current;
	}

	public int getCurrent() {
		return current;
	}

	public int getLeft() {
		return Math.max(current - 4, 1);
		
	}

	public int getRight() {
		return Math.min(current + 4, end);
		
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public int getEnd() {
		return end;
	}
}
