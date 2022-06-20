package com.team1.food.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team1.food.domain.FoodCateDto;
import com.team1.food.domain.FoodDto;
import com.team1.food.service.CategoryService;

@Controller
@RequestMapping("foodBoard")
public class CategoryController {

	@Autowired
	private CategoryService cateService;

	@RequestMapping("foodCateList")
	public void cateList(Model model) {
		List<FoodCateDto> list = cateService.foodCateList();
		model.addAttribute("foodCateList", list);
		System.out.println(list.toString());
	}

	@GetMapping("foodList")
	public void getCateFoodList(@RequestParam(name = "cateName", defaultValue = "") String cateName, Model model) {
		List<FoodDto> list = cateService.foodList(cateName);
		model.addAttribute("foodList", list);
		model.addAttribute("categoryName", cateName);
	}

	@PostMapping("addCate")
	public String addCategory(FoodCateDto dto, 
						      @RequestParam(name = "cateName") String cateName, 
							  @RequestParam(name = "addFileList") MultipartFile file, /* Principal principal, */ 
							  RedirectAttributes rttr) {
		
		System.out.println("카테고리명 " + cateName);
		System.out.println("파일명 " + file);
		
		if (cateName != null && !cateName.isEmpty() && file.getSize() > 0) {
			// 카테고리 이미지 파일 추가
			if (file != null) {
				dto.setFileName(file.getOriginalFilename());
			}
			
			// 작성 맴버 추가
			// dto.setMemberId(principal.getName());
			dto.setMemberId("admin");
			
			boolean success = cateService.addCate(dto, file);
			if(success) {
				rttr.addFlashAttribute("cateSuccess", "카테고리 등록 성공했습니다.");
			} else {
				rttr.addFlashAttribute("cateFail", "카테고리 등록 실패했습니다.");
			}
		} else {
			rttr.addFlashAttribute("cateFail", "카테고리명과 이미지를 등록해주세요.");
		}

		return "redirect:/foodBoard/foodCateList";
	}
	
	@PostMapping("modifyCate")
	public String modifyCategory(FoodCateDto dto, 
						      @RequestParam(name = "cateName") String cateName, 
							  @RequestParam(name = "addFileList") MultipartFile file, /* Principal principal, */ 
							  RedirectAttributes rttr) {

		
		return "redirect:foodList?cateName=" + cateName;
	}
}
