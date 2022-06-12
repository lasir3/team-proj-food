package com.team1.food.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team1.food.domain.AdminNoticeBoardDto;
import com.team1.food.mapper.AdminBoardMapper;

@Service
public class AdminBoardService {
	
	@Autowired
	private AdminBoardMapper mapper;
	
	// 공지 리스트
	public List<AdminNoticeBoardDto> noticeList() {
		return mapper.selectNoticeBoardAll();
	}

	// 공지 작성
	public boolean insertNoticeBoard(AdminNoticeBoardDto dto) {
		int cnt = mapper.insertNoticeBoard(dto);
		return cnt == 1;
	}

	public AdminNoticeBoardDto getNoticeBoardById(int id) {
		return mapper.selectNoticeBoardById(id);
	} 
}
