package com.team1.food.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.team1.food.domain.FoodCateDto;
import com.team1.food.domain.FoodDto;

@Mapper
public interface RecipeMapper {

	List<FoodCateDto> selectCateList();

	List<FoodDto> selectFoodList(String foodName);

}
