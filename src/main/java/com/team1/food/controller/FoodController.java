package com.team1.food.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.team1.food.domain.FoodDto;
import com.team1.food.service.CategoryService;

@Controller
public class FoodController {
	
	@Autowired
	private CategoryService foodService;
	

}
