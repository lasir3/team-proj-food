package com.team1.food.mapper;

import java.util.List;

import com.team1.food.domain.AdminBoardDto;

public interface AdminBoardMapper {

	List<AdminBoardDto> selectNoticeBoardAll();

	int insertNoticeBoard(AdminBoardDto dto);

	AdminBoardDto selectNoticeBoardById(int id);

	int updateNoticeBoard(AdminBoardDto dto);

	int deleteNoticeBoardById(int id);
	
}
