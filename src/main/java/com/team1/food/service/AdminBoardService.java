package com.team1.food.service;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.team1.food.domain.AdminBoardDto;
import com.team1.food.domain.AdminBoardPageDto;
import com.team1.food.mapper.AdminBoardMapper;

@Service
public class AdminBoardService {
	
	@Autowired
	private AdminBoardMapper mapper;
	
	/*** 공지  ***/
	
	// 공지 글 리스트
	public List<AdminBoardDto> noticeList(int page, int rowPerPage) {
		// 몇번째 레코드부터 가져올 것인지?
		int startFrom = (page - 1) * rowPerPage;
		// 예를 들어 page=1, rowPerPage = 5의 경우. 
		// 0번째부터 5개의 데이터를 가져와야함. (LIMIT 0, 5)
		// >> startFrom = (1 - 1) * 5 = 0
		
		return mapper.selectNoticeBoardAll(startFrom, rowPerPage);
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
		return mapper.deleteNoticeBoardById(id) == 1;
	}
	
	// 공지 레코즈 개수
	public int noticeBoardCount() {
		return mapper.selectNoticeBoardCount();
	}
	
	/*** 쉼터 ***/
	
	// 쉼터 글 리스트
	public List<AdminBoardDto> restAreaList() {
		return mapper.selectRestAreaBoardAll();
	} 
	
	// 쉼터 글 작성
	public boolean insertRestAreaBoard(AdminBoardDto dto) {
		int cnt = mapper.insertRestAreaBoard(dto);
		return cnt == 1;
	}
	
	// 쉼터 글 보기
	public AdminBoardDto getRestAreaBoardById(int id) {
		return mapper.selectRestAreaBoardById(id);
	}
	
	// 쉼터 글 수정
	public boolean updateRestAreaBoard(AdminBoardDto dto) {
		int cnt = mapper.updateRestAreaBoard(dto);
		return cnt == 1;
	}
	
	// 쉼터 글 삭제
	@Transactional
	public boolean deleteRestAreaBoardById(int id) {
		return mapper.deleteRestAreaBoardById(id) == 1;
	}
	
	/*** 문의 ***/
	
	// 문의 글 리스트
	public List<AdminBoardDto> askList() {
		return mapper.selectAskBoardAll();
	} 
	
	// 문의 글 작성
	public boolean insertAskBoard(AdminBoardDto dto) {
		int cnt = mapper.insertAskBoard(dto);
		return cnt == 1;
	}
	
	// 문의 글 보기
	public AdminBoardDto getAskBoardById(int id) {
		return mapper.selectAskBoardById(id);
	}
	
	// 문의 글 수정
	public boolean updateAskBoard(AdminBoardDto dto) {
		int cnt = mapper.updateAskBoard(dto);
		return cnt == 1;
	}
	
	// 문의 글 삭제
	@Transactional
	public boolean deleteAskBoardById(int id) {
		return mapper.deleteAskBoardById(id) == 1;
	}
	
	/*** 신고 ***/
	
	// 신고 글 리스트
	public List<AdminBoardDto> reportList() {
		return mapper.selectReportBoardAll();
	} 
	
	// 신고 글 작성
	public boolean insertReportBoard(AdminBoardDto dto) {
		int cnt = mapper.insertReportBoard(dto);
		return cnt == 1;
	}
	
	// 신고 글 보기
	public AdminBoardDto getReportBoardById(int id) {
		return mapper.selectReportBoardById(id);
	}
	
	// 신고 글 수정
	public boolean updateReportBoard(AdminBoardDto dto) {
		int cnt = mapper.updateReportBoard(dto);
		return cnt == 1;
	}
	
	// 신고 글 삭제
	@Transactional
	public boolean deleteReportBoardById(int id) {
		return mapper.deleteReportBoardById(id) == 1;
	}
		
}
