package com.team1.food.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.team1.food.domain.FoodCateDto;
import com.team1.food.domain.FoodDto;

@Mapper
public interface CategoryMapper {

	List<FoodCateDto> selectCateList();

	List<FoodDto> selectFoodList(String foodName);

	int insertCate(FoodCateDto dto);

	void insertCateFile(@Param("cateId") int id, @Param("fileName") String filename);

}
