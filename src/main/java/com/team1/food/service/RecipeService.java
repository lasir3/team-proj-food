package com.team1.food.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team1.food.domain.FoodCateDto;
import com.team1.food.domain.FoodDto;
import com.team1.food.mapper.RecipeMapper;

@Service
public class RecipeService {
	
	@Autowired
	private RecipeMapper mapper;

	public List<FoodCateDto> foodCateList() {
		return mapper.selectCateList();
	}

	public List<FoodDto> foodList(String cateName) {
		return mapper.selectFoodList(cateName);
	}

}
