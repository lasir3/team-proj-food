package com.team1.food.mapper;

import java.util.List;

import com.team1.food.domain.AdminReplyDto;

public interface AdminReplyMapper {
	
	int insertNoticeReply(AdminReplyDto dto);

	List<AdminReplyDto> getNoticeReplyByBoardId(int boardId);

	void deleteNoticeReplyByBoardId(int boardId);
	

}
