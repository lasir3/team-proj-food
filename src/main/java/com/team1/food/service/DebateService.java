package com.team1.food.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.team1.food.domain.DebateDto;
import com.team1.food.domain.FoodCateDto;
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
		mapper.viewCount(id);
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

	public int countDebate(String type, String keyword) {
		// TODO Auto-generated method stub
		return mapper.countDebate(type, keyword);
	}

	public List<DebateDto> listDebatePage(int page, int rowPerPage, String type, String keyword) {
		int from = (page - 1) * rowPerPage;
		
		return mapper.listDebatePage(from, rowPerPage, type, "%" + keyword + "%");
	}

	public List<DebateDto> closeDebate(String type, int page, String keyword, int rowPerPage) {
		int from = (page - 1) * rowPerPage;
		
		
		return mapper.selectCloseDebate(from, rowPerPage, type, "%" + keyword + "%");
	}

	public int countClose(String type, String keyword) {
		// TODO Auto-generated method stub
		return mapper.countClose(type, keyword);
	}

	public DebateDto getCloseById(int id) {
		
		DebateDto close = mapper.selectCloseById(id);
						  mapper.closeViewCount(id);
		return close;
	}
	
	@Transactional
	public boolean updateClose(int id) {
		int cnt = mapper.updateClose(id);
		
		return cnt == 1;
	}

	public DebateDto getRemoveById(int id) {
		DebateDto debate = mapper.removeClose(id);
		return debate;
	}
	
	public boolean deleteClose(int id) {
		replyMapper.deleteByCloseId(id);
		
		return mapper.deleteClose(id) == 1;
	}

	public List<FoodCateDto> selectCateNameList() {
		return mapper.selectCateName();
	}

	/*public int viewCount(int hit) {
		// TODO Auto-generated method stub
		return mapper.viewCount(hit);
	}	*/
}
