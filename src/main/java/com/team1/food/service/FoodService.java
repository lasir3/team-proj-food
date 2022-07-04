package com.team1.food.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team1.food.domain.FoodDto;
import com.team1.food.mapper.FoodMapper;

@Service
public class FoodService {

	@Autowired
	private FoodMapper mapper;
	

}
