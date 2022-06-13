package com.team1.food.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.team1.food.domain.AdminBoardDto;
import com.team1.food.mapper.AdminBoardMapper;
import com.team1.food.mapper.AdminReplyMapper;

@Service
public class AdminBoardService {
	
	@Autowired
	private AdminBoardMapper mapper;
	@Autowired
	private AdminReplyMapper replyMapper;
	
	// 공지 글 리스트
	public List<AdminBoardDto> noticeList() {
		return mapper.selectNoticeBoardAll();
	}

	// 공지 글 작성
	public boolean insertNoticeBoard(AdminBoardDto dto) {
		int cnt = mapper.insertNoticeBoard(dto);
		return cnt == 1;
	}
	
	// 공지 글 보기
	public AdminBoardDto getNoticeBoardById(int id) {
		return mapper.selectNoticeBoardById(id);
	}
	
	// 공지 글 수정
	public boolean updateNoticeBoard(AdminBoardDto dto) {
		int cnt = mapper.updateNoticeBoard(dto);
		return cnt == 1;
	}
	
	// 공지 글 삭제
	@Transactional
	public boolean deleteNoticeBoardById(int id) {
		
		replyMapper.deleteNoticeReplyByBoardId(id);
		
		return mapper.deleteNoticeBoardById(id) == 1;
		
	} 
}
