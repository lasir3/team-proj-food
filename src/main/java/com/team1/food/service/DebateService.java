package com.team1.food.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.team1.food.domain.CloseDto;
import com.team1.food.domain.DebateDto;
import com.team1.food.mapper.BigReplyMapper;
import com.team1.food.mapper.DebateMapper;

@Service
public class DebateService {

	@Autowired
	private DebateMapper mapper;
	
	@Autowired
	private BigReplyMapper replyMapper;

	public List<DebateDto> listDebate() {
		// TODO Auto-generated method stub
		return mapper.selectDebateBoard();
	}

	public DebateDto getDebateById(int id) {
		DebateDto debate = mapper.selectDebateById(id);
		return debate;
	}

	@Transactional
	public boolean addDebate(DebateDto debate) {
//		board.setInserted(LocalDateTime.now());
		
		// 게시글 등록
		int cnt = mapper.writeDebate(debate);
		
		return cnt == 1; 
	}
	
	@Transactional
	public boolean deleteDebate(int id) {
		
		replyMapper.deleteByDebateId(id);
		
		return mapper.deleteDebate(id) == 1;
	}
	
	@Transactional
	public boolean updateDebate(DebateDto dto) {
		int cnt = mapper.updateDebate(dto);
		
		return cnt == 1;
	}

	public int countDebate() {
		// TODO Auto-generated method stub
		return mapper.countDebate();
	}

	public List<DebateDto> listDebatePage(int page, int rowPerPage) {
		int from = (page - 1) * rowPerPage;
		
		return mapper.listDebatePage(from, rowPerPage);
	}
}
