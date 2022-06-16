package com.team1.food.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team1.food.domain.AdminReplyDto;
import com.team1.food.mapper.AdminReplyMapper;

@Service
public class AdminReplyService {
	
	@Autowired
	private AdminReplyMapper mapper;

	public boolean insertNoticeReply(AdminReplyDto dto) {
		return mapper.insertNoticeReply(dto) == 1;
	}
}
