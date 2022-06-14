package com.team1.food.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.team1.food.domain.FoodDto;
import com.team1.food.domain.FoodCateDto;
import com.team1.food.service.RecipeService;

@Controller
@RequestMapping("foodBoard")
public class RecipeController {
	
	@Autowired
	private RecipeService foodService;
	
	@RequestMapping("foodCateList")
	public void cateList(Model model) {
		List<FoodCateDto> list = foodService.foodCateList();
		model.addAttribute("foodCateList", list);
	}
	
//	@RequestMapping("foodList")
//	public void list(Model model) {
//		List<FoodBoardDto> list = foodService.foodBoard();
//		
//		model.addAttribute("foodList", list);
//	}
}
