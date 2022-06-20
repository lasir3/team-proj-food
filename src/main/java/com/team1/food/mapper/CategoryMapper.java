package com.team1.food.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.team1.food.domain.FoodCateDto;
import com.team1.food.domain.FoodDto;

@Mapper
public interface CategoryMapper {

	List<FoodCateDto> selectCateList();

	List<FoodDto> selectFoodList(int cateIndex);

	int insertCate(FoodCateDto dto);

	void insertCateFile(@Param("cateId") int id, @Param("fileName") String filename);

	FoodCateDto selectCateByName(String cateName);

	String selectFileNameByCateName(String cateName);

	int updateCate(FoodCateDto dto);

//	List<String> selectCateNameList(String string);

	void deleteCateFileByCateIndex(@Param("cateId") int cateIndex, @Param("fileName") String deleteFile);

	FoodCateDto selectCateDto(int cateIndex);

	FoodCateDto selectCateByIndex(int i);

	String selectFileNameByCateIndex(int i);

	String selectCateName(String cateName);

	int selectCateIndexFromCateName(String cateName);

}
