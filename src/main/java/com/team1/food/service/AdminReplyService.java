package com.team1.food.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team1.food.domain.AdminReplyDto;
import com.team1.food.mapper.AdminReplyMapper;

@Service
public class AdminReplyService {
	
	@Autowired
	private AdminReplyMapper mapper;
	
	/*** 공지 ***/
	public boolean insertNoticeReply(AdminReplyDto dto) {
		return mapper.insertNoticeReply(dto) == 1;
	}
	
	
	/*** 공용 ***/

	public List<AdminReplyDto> replyList(int boardId, String columnName) {
		return mapper.selectAllReplyByBoardId(boardId, columnName);
	}

	public List<AdminReplyDto> replyListWithOwn(int boardId, String columnName, String memberId) {
		return mapper.selectAllReplyWithOwnByBoardId(boardId, columnName, memberId);
	}

	public boolean updateReply(AdminReplyDto dto) {
		return mapper.updateReply(dto);
	}

	public boolean deleteReplyById(int id) {
		return mapper.deleteReplyById(id);
	}

	public boolean deleteReplyByBoardId(int boardId, String columnName) {
		return mapper.deleteReplyByBoardId(boardId, columnName);
	}
}
