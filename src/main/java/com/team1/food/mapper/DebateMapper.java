package com.team1.food.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.team1.food.domain.DebateDto;
import com.team1.food.domain.FoodCateDto;

public interface DebateMapper {


	int writeDebate(DebateDto debate);

	DebateDto selectDebateById(int id);

	void getDebate(int id);

	int deleteDebate(int id);


	int countDebate(@Param("type")String type, @Param("keyword")String keyword);

	List<DebateDto> listDebatePage(@Param("from")int from,
			@Param("row")int rowPerPage, 
			@Param("type")String type, 
			@Param("keyword")String keyword);
	
	List<DebateDto> selectDebateBoard();

	int updateDebate(DebateDto dto);


	List<DebateDto> selectCloseDebate(@Param("from")int from,
			@Param("row")int rowPerPage, 
			@Param("type")String type, 
			@Param("keyword")String keyword);

	int countClose(@Param("type")String type, @Param("keyword")String keyword);

	DebateDto selectCloseById(int id);

	int updateClose(int id);

	DebateDto removeClose(int id);
	
		int deleteClose(int id);
			
		List<DebateDto> searchDebate(@Param("type")String type, @Param("keyword")String keyword);

		void viewCount(int id);

		void closeViewCount(int id);

		List<FoodCateDto> selectCateName();

}
