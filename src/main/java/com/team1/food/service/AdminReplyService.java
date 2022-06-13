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
	
	// 공지 댓글 작성
	public boolean insertNoticeReply(AdminReplyDto dto) {
		int cnt = mapper.insertNoticeReply(dto);
		return cnt == 1;
	}
	
	// 공지 댓글 불러오기
	public List<AdminReplyDto> getNoticeReplyByBoardId(int boardId) {
		return mapper.getNoticeReplyByBoardId(boardId);
	}
	
	
}
