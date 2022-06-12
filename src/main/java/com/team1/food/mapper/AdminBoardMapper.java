package com.team1.food.mapper;

import java.util.List;

import com.team1.food.domain.AdminNoticeBoardDto;

public interface AdminBoardMapper {

	List<AdminNoticeBoardDto> selectNoticeBoardAll();

	int insertNoticeBoard(AdminNoticeBoardDto dto);

	AdminNoticeBoardDto selectNoticeBoardById(int id);
	
}
