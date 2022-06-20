package com.team1.food.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

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
	
//	int selectNoticeBoardCount();
	
	/* 쉼터 */
	
	List<AdminBoardDto> selectRestAreaBoardAll(
			@Param("startFrom") int startFrom, 
			@Param("rowPerPage") int rowPerPage);
	
	int insertRestAreaBoard(AdminBoardDto dto);

	AdminBoardDto selectRestAreaBoardById(int id);

	int updateRestAreaBoard(AdminBoardDto dto);

	int deleteRestAreaBoardById(int id);
	
	/* 문의 */
	
	List<AdminBoardDto> selectAskBoardAll(
			@Param("startFrom") int startFrom, 
			@Param("rowPerPage") int rowPerPage);
	
	int insertAskBoard(AdminBoardDto dto);

	AdminBoardDto selectAskBoardById(int id);

	int updateAskBoard(AdminBoardDto dto);

	int deleteAskBoardById(int id);
	
	/* 신고 */
	
	List<AdminBoardDto> selectReportBoardAll(
			@Param("startFrom") int startFrom, 
			@Param("rowPerPage") int rowPerPage);
	
	int insertReportBoard(AdminBoardDto dto);

	AdminBoardDto selectReportBoardById(int id);

	int updateReportBoard(AdminBoardDto dto);

	int deleteReportBoardById(int id);
	
	/* 공용 */
	
	int selectBoardCount(
			@Param("tableName")String tableName);

}
