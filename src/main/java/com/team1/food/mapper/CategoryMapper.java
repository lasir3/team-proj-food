package com.team1.food.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.team1.food.domain.FoodCateDto;
import com.team1.food.domain.FoodDto;
import com.team1.food.domain.SubFoodDto;
import com.team1.food.domain.VoteDto;

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

	void deleteFileByCateIndex(int cateIndex);

	int deleteCate(int cateIndex);

	void deleteFilelistByCateIndex(int cateIndex);

//	int selectCateIndexFromCateName(String cateName);
	
	FoodDto selectFoodDto(int foodIndex);

	int insertFood(FoodDto dto);

	String selectCateNameByIndex(int cateIndex);

	String selectFoodName(String foodName);

	List<SubFoodDto> selectSubFoodList(int foodIndex);

	int selectVoteSum(int subRecipeIndex);

	int selectVoteNum(VoteDto dto);

	int updateVoteNum(@Param("subRecipeIndex") int subRecipeIndex, @Param("voteCount") int voteNum, @Param("memberId") String memberId);

	int updateFood(FoodDto dto);

	List<FoodCateDto> selectSearchCateList(String keyword);

	List<FoodDto> selectSearchFoodList(String keyword);

	List<SubFoodDto> selectSearchRecipeList(String keyword);

    SubFoodDto selectSubFoodDto(int subRecipeIndex);

	int updateRecipe(SubFoodDto dto);

	int deleteRecipe(SubFoodDto dto);

	void deleteVote(SubFoodDto dto);

	int insertRecipe(SubFoodDto dto);

	int selectSubIndexBySubName(String subRecipeName);

	int insertVote(SubFoodDto dto);

	String selectMemberIdOnVote(VoteDto dto);

	void insertVoteByMemberId(VoteDto dto);

	int insertVoteByMemberId(@Param("subRecipeIndex") int subRecipeIndex, @Param("voteCount") int voteNum, @Param("memberId") String memberId);

}
