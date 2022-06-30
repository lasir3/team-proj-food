package com.team1.food.service;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.team1.food.domain.AdminBoardDto;
import com.team1.food.domain.AdminBoardPageDto;
import com.team1.food.domain.AdminLeaveDto;
import com.team1.food.domain.AdminWarningDto;
import com.team1.food.domain.MemberDto;
import com.team1.food.mapper.AdminBoardMapper;

@Service
public class AdminBoardService {
	
	@Autowired
	private AdminBoardMapper mapper;
	
	/*** 공지  
	 * @param keyword 
	 * @param type 
	 * @param keyword 
	 * @param type ***/
	
	// 공지 글 리스트
	public List<AdminBoardDto> noticeList(String type, String keyword, int page, int rowPerPage) {
		// 몇번째 레코드부터 가져올 것인지?
		int startFrom = (page - 1) * rowPerPage;
		// 예를 들어 page=1, rowPerPage = 5의 경우. 
		// 0번째부터 5개의 데이터를 가져와야함. (LIMIT 0, 5)
		// >> startFrom = (1 - 1) * 5 = 0
		
		return mapper.selectNoticeBoardAll(type, "%" + keyword + "%", startFrom, rowPerPage);
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
	
	// 공지 고정글 리스트
	public List<AdminBoardDto> pinnedNoticeList() {
		return mapper.selectPinnedNoticeList();
	}
	
	/*** 쉼터 
	 * @param rowPerPage 
	 * @param page 
	 * @param state ***/
	
	// 쉼터 글 리스트
	public List<AdminBoardDto> restAreaList(
			String type, 
			String keyword, 
			int page, 
			int rowPerPage, 
			int state) {
		
		int startFrom = (page - 1) * rowPerPage;
		
		return mapper.selectRestAreaBoardAll(type, "%" + keyword + "%", startFrom, rowPerPage, state);
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
	
	/*** 문의 
	 * @param rowPerPage 
	 * @param page 
	 * @param state ***/
	
	// 문의 글 리스트
	public List<AdminBoardDto> askList(String type, String keyword, int page, int rowPerPage, int state) {
		int startFrom = (page - 1) * rowPerPage;
		return mapper.selectAskBoardAll(type, "%" + keyword + "%", startFrom, rowPerPage, state);
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
	
	/*** 신고 
	 * @param rowPerPage 
	 * @param page ***/
	
	// 신고 글 리스트
	public List<AdminBoardDto> reportList(String type, String keyword, int page, int rowPerPage) {
		int startFrom = (page - 1) * rowPerPage;
		return mapper.selectReportBoardAll(type, "%" + keyword + "%", startFrom, rowPerPage);
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

	
	// 공용
	public int boardCount(
			String type, 
			String keyword, 
			String tableName) {
		return mapper.selectBoardCount(type,"%" + keyword + "%",tableName);
	}

	public int boardCountWithState(
			String type, 
			String keyword, 
			String tableName, 
			int state) {
		return mapper.selectBoardCountWithState(type, "%" + keyword + "%", tableName, state);
	}

	public boolean updateBoardState(int id, int state, String tableName) {
		int cnt = mapper.updateBoardState(id, state, tableName);
		return cnt == 1;
		
	}

	public void insertLeave(AdminLeaveDto leave) {
		mapper.insertLeave(leave);
	}

	public void updateLeave(AdminLeaveDto leave) {
		mapper.updateLeave(leave);
	}

	public AdminBoardDto selectLastRestArea(String memberId) {
		return mapper.selectLastRestArea(memberId);
	}


	public AdminLeaveDto selectLeaveByBoardId(int boardId) {
		return mapper.selectLeaveByBoardId(boardId);
	}

	public void deleteLeave(int id) {
		mapper.deleteLeave(id);
	}

	public List<AdminLeaveDto> LeaveList() {
		return mapper.selectLeaveAll();
	}

	public List<MemberDto> selectMemberById(String userId) {
		return mapper.selectMemberById("%" + userId + "%");
	}

	public void insertWarning(AdminWarningDto warning) {
		mapper.insertWarning(warning);
	}

	public AdminWarningDto selectWarningByBoardId(int boardId) {
		return mapper.selectWarningByBoardId(boardId);
	}

	public void updateWarning(AdminWarningDto warning) {
		return mapper.updateWarning(warning);
	}



	
		
}
