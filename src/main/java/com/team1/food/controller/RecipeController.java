package com.team1.food.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.team1.food.domain.FoodCateDto;
import com.team1.food.domain.FoodDto;
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
	
	@GetMapping("foodList")
	public void getCateFoodList(@RequestParam (name = "cateName", defaultValue = "") String cateName, Model model) {
		List<FoodDto> list = foodService.foodList(cateName);
		model.addAttribute("foodList", list);
	}
}
