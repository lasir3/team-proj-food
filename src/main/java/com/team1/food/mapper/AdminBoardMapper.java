package com.team1.food.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.team1.food.domain.AdminBoardDto;

public interface AdminBoardMapper {

	/* 공지 */
	
	List<AdminBoardDto> selectNoticeBoardAll(
			@Param("startFrom") int startFrom, 
			@Param("rowPerPage") int rowPerPage);

	int insertNoticeBoard(AdminBoardDto dto);

	AdminBoardDto selectNoticeBoardById(int id);

	int updateNoticeBoard(AdminBoardDto dto);

	int deleteNoticeBoardById(int id);
	
	int selectNoticeBoardCount();
	
	/* 쉼터 */
	
	List<AdminBoardDto> selectRestAreaBoardAll();
	
	int insertRestAreaBoard(AdminBoardDto dto);

	AdminBoardDto selectRestAreaBoardById(int id);

	int updateRestAreaBoard(AdminBoardDto dto);

	int deleteRestAreaBoardById(int id);
	
	/* 문의 */
	
	List<AdminBoardDto> selectAskBoardAll();
	
	int insertAskBoard(AdminBoardDto dto);

	AdminBoardDto selectAskBoardById(int id);

	int updateAskBoard(AdminBoardDto dto);

	int deleteAskBoardById(int id);
	
	/* 신고 */
	
	List<AdminBoardDto> selectReportBoardAll();
	
	int insertReportBoard(AdminBoardDto dto);

	AdminBoardDto selectReportBoardById(int id);

	int updateReportBoard(AdminBoardDto dto);

	int deleteReportBoardById(int id);
	
}
