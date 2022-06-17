package com.team1.food.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.team1.food.domain.DebateDto;

public interface DebateMapper {


	int writeDebate(DebateDto debate);

	DebateDto selectDebateById(int id);

	void getDebate(int id);

	int deleteDebate(int id);

	int updateDebate(DebateDto dto);

	int countDebate();

	List<DebateDto> listDebatePage(@Param("from")int from, @Param("row")int rowPerPage);
	
	List<DebateDto> selectDebateBoard();



}
