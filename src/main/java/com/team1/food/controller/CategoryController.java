package com.team1.food.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team1.food.domain.FoodCateDto;
import com.team1.food.domain.FoodDto;
import com.team1.food.domain.SubFoodDto;
import com.team1.food.domain.VoteDto;
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
		model.addAttribute("foodListPage", list);
		model.addAttribute("cateDto", dto);
	}
	
	// 카테고리 수정 페이지
	@GetMapping("foodEdit")
	public void foodEditPage(@RequestParam(name = "foodIndex", defaultValue = "") int foodIndex, Model model) {
		FoodDto dto = cateService.getPageByIndex(foodIndex);
		// 수정용 파일명 전송
		model.addAttribute("foodDto", dto);
	}

	// 카테고리 추가
	@PostMapping("addCate")
	public String addCategory(FoodCateDto dto, 
							  @RequestParam(name = "addFile") MultipartFile file, Principal principal,  
							  RedirectAttributes rttr) {
		// 카테고리명이 비어있지 않고 파일사이즈가 0보다 클경우 진행
		if (!dto.getCateName().isEmpty() && file.getSize() > 0) {
			// 카테고리명 중복 체크
			String excistFoodName = cateService.selectCateName(dto.getCateName());
			if (excistFoodName != null) {
				rttr.addFlashAttribute("cateFail", "중복된 카테고리명이 존재합니다.");
			} else {
				System.out.println("카테고리 추가기능 진행");
				// 카테고리 이미지 파일 추가
				if (file != null) {
					dto.setFileName(file.getOriginalFilename());
				}

				// 작성 맴버 추가
				dto.setMemberId(principal.getName());
				
				boolean success = cateService.addCate(dto, file);
				if (success) {
					rttr.addFlashAttribute("cateMessage", "카테고리 등록 성공했습니다.");
					System.out.println("추가성공");
				} else {
					rttr.addFlashAttribute("cateMessage", "카테고리 등록 실패했습니다.");
				}
			}
		} else {
			rttr.addFlashAttribute("cateMessage", "카테고리 이름과 이미지를 입력해주세요.");
		}

		return "redirect:foodCateList";
	}
	
	// 카테고리 수정
	@PostMapping("modifyCate")
	public String modifyCategory(FoodCateDto dto, 
			@RequestParam(name = "modifyFile") MultipartFile modifyFile, /* Principal principal, */
			RedirectAttributes rttr) {
		boolean success = true;
		// FoodCateDto oldCateByMember = cateService.getCateIndexByMember(dto.getCateIndex());
		
		// 카테고리명이 비어있지 않고 파일사이즈가 0보다 클경우 진행
		if (!dto.getCateName().isEmpty() && modifyFile.getSize() > 0) {
			
			// 입력한 카테고리명으로 테이블 카테고리명 검색
			String excistCateName = cateService.selectCateName(dto.getCateName());
			
			// 현재 인덱스 번호에 해당하는 카테고리 이름 호출
			String originalFoodName = cateService.selectCateNameByIndex(dto.getCateIndex());
			
			// 같은 카테고리 이름일경우 파일만 교체
			if (originalFoodName.equals(dto.getCateName())) {
				success = cateService.updateCateFile(dto, dto.getFileName(), modifyFile);
			// 카테고리명 중복 체크
			} else if (excistCateName != null) {
				rttr.addFlashAttribute("cateFail", "중복된 카테고리명이 존재합니다.");
			} else {
				success = cateService.updateCate(dto, dto.getFileName(), modifyFile);
			}
			if (success) {
				rttr.addFlashAttribute("cateMessage", "카테고리 수정에 성공하였습니다.");
			} else {
				rttr.addFlashAttribute("cateMessage", "카테고리 수정에 실패하였습니다.");
			}
		} else {
			rttr.addFlashAttribute("cateMessage", "카테고리 이름과 이미지를 입력해주세요.");
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
			rttr.addFlashAttribute("cateMessage", "카테고리가 삭제 되었습니다.");
			System.out.println("삭제성공");
			return "redirect:foodCateList";
		} else {
			rttr.addFlashAttribute("cateMessage", "카테고리가 삭제되지 않았습니다.");
			System.out.println("삭제실패");
			return "redirect:foodCateList";
		}

//		} else { 
//			rttr.addFlashAttribute("message", "권한이 없습니다.");
//		}
//		// 아니면 리턴.
//		return "redirect:foodList";
	}
	
	
	// 음식테이블 추가 메소드
	@PostMapping("addFood")
	public String addFood(FoodDto dto, Principal principal, RedirectAttributes rttr) {
		// 작성 맴버 추가
		dto.setMemberId(principal.getName());
		
		String excistFoodName = cateService.selectFoodName(dto.getFoodName());
		if (excistFoodName == null) {
			System.out.println("음식레코드 추가 가능");
			boolean success = cateService.addFoodTable(dto);
			if(success) {
				rttr.addFlashAttribute("message", "음식레코드를 추가하였습니다.");
			} else {
				rttr.addFlashAttribute("message", "음식레코드 추가를 실패하였습니다.");
			}
		} else {
			rttr.addFlashAttribute("message", "동일한 음식명이 존재합니다.");
		}
		
		rttr.addAttribute("cateIndex", dto.getCateIndex());
		return "redirect:foodList";
	}
	
	// 음식 페이지 메소드
	@GetMapping("foodPage")
	public void getFoodPage(@RequestParam(name = "foodIndex", defaultValue = "") int foodIndex, Model model) {
		FoodDto dto = cateService.getPageByIndex(foodIndex);
		model.addAttribute("foodDto", dto);
	}
	
	// subRecipeList ajax 요청
	@GetMapping("subList")
	@ResponseBody
	public List<SubFoodDto> subList(int foodIndex) {
		return cateService.getSubDtoList(foodIndex);
	}

	 @GetMapping("voteSum")
	 @ResponseBody
	 public int voteList(int subRecipeIndex) {
	 	return cateService.getVoteSum(subRecipeIndex);
	 }
	 
	 @PutMapping(path = "voteUp", produces = "text/plain;charset=UTF-8")
	 @ResponseBody
	 public ResponseEntity<String> voteUp(@RequestBody VoteDto dto, Principal principal) {
		 if (principal == null) {
			return ResponseEntity.status(401).build();
		 } else {
			 int getVoteNum = cateService.getVoteNum(dto, principal);
			 boolean success = false;
			 if	(getVoteNum == 1) {
				 // 투표 취소 (1 -> 0 으로 변경)
				 success = cateService.setVoteUp(dto, 0, principal);
			 } else {
				 // 투표수 증가 (0 -> 1)
				 success = cateService.setVoteUp(dto, 1, principal);
			 }
			 
			 if (success) {
				 System.out.println("투표성공");
				 return ResponseEntity.ok("추천수가 변경되었습니다.");
			 } else {
				 System.out.println("투표실패");
				 return ResponseEntity.status(500).body("");
			 }
		 }
	 }
	
}
