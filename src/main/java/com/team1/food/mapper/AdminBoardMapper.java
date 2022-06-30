package com.team1.food.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.team1.food.domain.AdminBoardDto;
import com.team1.food.domain.AdminLeaveDto;
import com.team1.food.domain.AdminWarningDto;
import com.team1.food.domain.MemberDto;

public interface AdminBoardMapper {

	/* 공지 */
	
	List<AdminBoardDto> selectNoticeBoardAll(
			@Param("type") String type, 
			@Param("keyword") String keyword,
			@Param("startFrom") int startFrom, 
			@Param("rowPerPage") int rowPerPage);

	int insertNoticeBoard(AdminBoardDto dto);

	AdminBoardDto selectNoticeBoardById(int id);

	int updateNoticeBoard(AdminBoardDto dto);

	int deleteNoticeBoardById(int id);
	
//	int selectNoticeBoardCount();
	
	/* 쉼터 */
	
	List<AdminBoardDto> selectRestAreaBoardAll(
			@Param("type") String type, 
			@Param("keyword") String keyword,
			@Param("startFrom") int startFrom, 
			@Param("rowPerPage") int rowPerPage,
			@Param("state") int state);
	
	int insertRestAreaBoard(AdminBoardDto dto);

	AdminBoardDto selectRestAreaBoardById(int id);

	int updateRestAreaBoard(AdminBoardDto dto);

	int deleteRestAreaBoardById(int id);
	
	AdminBoardDto selectLastRestArea(String memberId);
	
	/* 문의 */
	
	List<AdminBoardDto> selectAskBoardAll(
			@Param("type") String type, 
			@Param("keyword") String keyword,
			@Param("startFrom") int startFrom, 
			@Param("rowPerPage") int rowPerPage, 
			@Param("state") int state);
	
	int insertAskBoard(AdminBoardDto dto);

	AdminBoardDto selectAskBoardById(int id);

	int updateAskBoard(AdminBoardDto dto);

	int deleteAskBoardById(int id);
	
	/* 신고 */
	
	List<AdminBoardDto> selectReportBoardAll(
			@Param("type") String type, 
			@Param("keyword") String keyword,
			@Param("startFrom") int startFrom, 
			@Param("rowPerPage") int rowPerPage);
	
	int insertReportBoard(AdminBoardDto dto);

	AdminBoardDto selectReportBoardById(int id);

	int updateReportBoard(AdminBoardDto dto);

	int deleteReportBoardById(int id);
	
	/* 공용 */
	
	int selectBoardCount(
			@Param("type") String type, 
			@Param("keyword") String keyword,
			@Param("tableName")String tableName);

	int selectBoardCountWithState(
			@Param("type") String type, 
			@Param("keyword") String keyword,
			@Param("tableName") String tableName, 
			@Param("state") int state);

	List<AdminBoardDto> selectPinnedNoticeList();

	int updateBoardState(
			@Param("id")int id, 
			@Param("state")int state, 
			@Param("tableName")String tableName);

	void insertLeave(AdminLeaveDto leave);

	void updateLeave(AdminLeaveDto leave);

	AdminLeaveDto selectLeaveByBoardId(int boardId);

	void deleteLeave(int id);

	List<AdminLeaveDto> selectLeaveAll();

	List<MemberDto> selectMemberById(String userId);

	void insertWarning(AdminWarningDto warning);

	AdminWarningDto selectWarningByBoardId(int boardId);

	void updateWarning(AdminWarningDto warning);

	


}
