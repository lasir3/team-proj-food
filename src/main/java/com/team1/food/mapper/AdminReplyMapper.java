package com.team1.food.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.team1.food.domain.AdminReplyDto;

public interface AdminReplyMapper {

	int insertNoticeReply(AdminReplyDto dto);
	
	List<AdminReplyDto> selectAllReplyByBoardId(
			@Param("boardId")int boardId,
			@Param("columnName")String columnName);

	List<AdminReplyDto> selectAllReplyWithOwnByBoardId(
			@Param("boardId")int boardId, 
			@Param("columnName")String columnName, 
			@Param("memberId")String memberId);

	boolean updateReply(AdminReplyDto dto);

	boolean deleteReplyById(int id);

	boolean deleteReplyByBoardId(
			@Param("boardId")int boardId, 
			@Param("columnName")String columnName);

	

}
