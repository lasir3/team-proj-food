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

	// 카테고리 리스트
	@RequestMapping("foodCateList")
	public void cateList(Model model) {
		List<FoodCateDto> list = cateService.foodCateList();
		model.addAttribute("foodCateList", list);
	}

	// 카테고리 음식 리스트
	@GetMapping("foodList")
	public void getCateFoodList(@RequestParam(name = "cateIndex", defaultValue = "") int cateIndex, Model model) {
		List<FoodDto> list = cateService.foodList(cateIndex);
		FoodCateDto dto = cateService.selectCateDto(cateIndex);
		// 수정용 파일명 전송
		model.addAttribute("foodList", list);
		model.addAttribute("cateDto", dto);
	}

	// 카테고리 추가
	@PostMapping("addCate")
	public String addCategory(FoodCateDto dto, 
						      @RequestParam(name = "cateName") String cateName, 
							  @RequestParam(name = "addFile") MultipartFile file, /* Principal principal, */ 
							  RedirectAttributes rttr) {
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

		return "redirect:foodCateList";
	}
	
	// 카테고리 수정
	@PostMapping("modifyCate")
	public String modifyCategory(FoodCateDto dto, 
			@RequestParam(name = "modifyFile") MultipartFile modifyFile, /* Principal principal, */
			RedirectAttributes rttr) {
		System.out.println("수정시작");

		// FoodCateDto oldCateByMember = cateService.getCateIndexByMember(dto.getCateIndex());
		boolean success = cateService.updateCate(dto, dto.getFileName(), modifyFile);

		if (success) {
			rttr.addFlashAttribute("cateSuccess", "카테고리 수정에 성공하였습니다.");
		} else {
			rttr.addFlashAttribute("cateFail", "카테고리 수정에 실패하였습니다.");
		}
		rttr.addAttribute("cateIndex", dto.getCateIndex());
		return "redirect:foodList";
	}
	
	// 카테고리 삭제
	@PostMapping("deleteCate")
	public String deleteCategory(FoodCateDto dto,  /* Principal principal, */ RedirectAttributes rttr) {
		
		// 게시물 정보 얻고
//		FoodCateDto oldCateByMember = cateService.getCateIndexByMember(dto.getCateIndex());
		// 게시물 작성자(memberId)와 principal의 name과 비교해서 같을 때만 진행.
//		if (oldBoard.getMemberId().equals(principal.getName())) {
		boolean success = cateService.deleteCate(dto.getCateIndex());

		if (success) {
			rttr.addFlashAttribute("message", "카테고리가 삭제 되었습니다.");
			System.out.println("삭제성공");
			return "redirect:foodCateList";
		} else {
			rttr.addFlashAttribute("message", "카테고리가 삭제되지 않았습니다.");
			System.out.println("삭제실패");
			return "redirect:foodCateList";
		}

//		} else { 
//			rttr.addFlashAttribute("message", "권한이 없습니다.");
//		}
		// 아니면 리턴.
//		return "redirect:foodList";
	}
}
