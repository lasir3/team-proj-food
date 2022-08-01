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
		
		//Navbar용 cateDto 정보
		List<FoodCateDto> cateNavList = cateService.foodCateList();
		model.addAttribute("foodCateList", cateNavList);
	}
	
	// 검색시 카테고리, 음식, 레시피 리스트 응답 메소드
	@RequestMapping("searchList")
	public void searchList(@RequestParam(name = "keyword", defaultValue = "") String keyword, Model model) {
		List<FoodCateDto> cateList = cateService.getSearchCateList(keyword);
		List<FoodDto> foodList = cateService.getSearchFoodList(keyword);
		List<SubFoodDto> recipeList = cateService.getSearchRecipeList(keyword);
		System.out.println("검색 서비스 작동");
		model.addAttribute("cateList", cateList);
		model.addAttribute("foodList", foodList);
		model.addAttribute("recipeList", recipeList);
		
		//Navbar용 cateDto 정보
		List<FoodCateDto> cateNavList = cateService.foodCateList();
		model.addAttribute("foodCateList", cateNavList);
	}
	
	// 카테고리 수정 페이지 호출
	@RequestMapping("foodEdit")
	public void foodEditPage(@RequestParam(name = "foodIndex", defaultValue = "") int foodIndex, Model model) {
		FoodDto dto = cateService.getPageByIndex(foodIndex);
		// 수정용 파일명 전송
		model.addAttribute("foodDto", dto);
		
		//Navbar용 cateDto 정보
		List<FoodCateDto> cateNavList = cateService.foodCateList();
		model.addAttribute("foodCateList", cateNavList);
	}
	
	// foodPage 수정 메소드
	@PostMapping("modifyFoodPage")
	public String modifyFood(FoodDto dto, RedirectAttributes rttr) {
		int foodIndex = dto.getFoodIndex();
		boolean success = cateService.updateFoodTable(dto);
		if (success) {
			System.out.println("음식 수정 성공");
		} else {
			System.out.println("음식 수정 실패");
		}
		rttr.addAttribute("foodIndex", foodIndex);
		return "redirect:foodPage";
	}

	// 레시피 수정 페이지 호출
	@RequestMapping("recipeEdit")
	public void recipeEditPage(@RequestParam(name = "subRecipeIndex", defaultValue = "") int subRecipeIndex, Model model) {
		SubFoodDto dto = cateService.getRecipeByIndex(subRecipeIndex);
		// 수정용 파일명 전송
		model.addAttribute("recipeDto", dto);
		
		//Navbar용 cateDto 정보
		List<FoodCateDto> cateNavList = cateService.foodCateList();
		model.addAttribute("foodCateList", cateNavList);
	}

	// 레시피 추가 메소드
	@PostMapping("addRecipe")
	public String addRecipe(SubFoodDto dto, @RequestParam(name = "recipeName", defaultValue = "") String subRecipeName, Principal principal, RedirectAttributes rttr) {
		int foodIndex = dto.getFoodIndex();
		if (subRecipeName != null) {
			// 작성 맴버 추가
			dto.setMemberId(principal.getName());
			dto.setSubRecipeName(subRecipeName);
			boolean success = cateService.addRecipe(dto);
			int getSubIndex = cateService.getSubIndex(subRecipeName);
			dto.setSubRecipeIndex(getSubIndex);
			boolean success2 = cateService.addVote(dto);
			if (success && success2) {
				rttr.addFlashAttribute("recipeMessage", "레시피 등록 성공했습니다.");
				System.out.println("추가성공");
			} else {
				rttr.addFlashAttribute("recipeMessage", "레시피 등록 실패했습니다.");
			}
		} else {
			rttr.addFlashAttribute("recipeMessage", "레시피 이름을 입력해주세요.");
		}
		rttr.addAttribute("foodIndex", foodIndex);
		return "redirect:foodPage";
	}

	
	// 레시피 수정 메소드
	@PostMapping("modifyRecipePage")
	public String modifyRecipe(SubFoodDto dto, RedirectAttributes rttr) {
		int foodIndex = dto.getFoodIndex();
		boolean success = cateService.updateRecipeTable(dto);
		if (success) {
			System.out.println("레시피 수정 성공");
		} else {
			System.out.println("레시피 수정 실패");
		}
		rttr.addAttribute("foodIndex", foodIndex);
		return "redirect:foodPage";
	}
	
	// 레시피 삭제 메소드
	@PostMapping("deleteRecipePage")
	public String deleteRecipe(SubFoodDto dto, RedirectAttributes rttr) {
		int foodIndex = dto.getFoodIndex();
		boolean success = cateService.deleteRecipeTable(dto);
		if (success) {
			System.out.println("레시피 수정 성공");
		} else {
			System.out.println("레시피 수정 실패");
		}
		rttr.addAttribute("foodIndex", foodIndex);
		return "redirect:foodPage";
	}

	// 카테고리 추가
	@PostMapping("addCate")
	public String addCategory(FoodCateDto dto, 
						      @RequestParam(name = "cateName") String cateName, 
							  @RequestParam(name = "addFile") MultipartFile file, Principal principal,  
							  RedirectAttributes rttr) {
		if (cateName != null && !cateName.isEmpty() && file.getSize() > 0) {
			
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
		
		//Navbar용 cateDto 정보
		List<FoodCateDto> cateNavList = cateService.foodCateList();
		model.addAttribute("foodCateList", cateNavList);
	}
	
	// subRecipeList ajax 요청
	@GetMapping("subList")
	@ResponseBody
	public List<SubFoodDto> subList(int foodIndex) {
//		System.out.println(cateService.getSubDtoList(foodIndex).toString());
		return cateService.getSubDtoList(foodIndex);
	}

	// 총 추천수 합계
	@GetMapping("voteSum")
	@ResponseBody
	public int voteList(int subRecipeIndex) {
		return cateService.getVoteSum(subRecipeIndex);
	}

	
	
	// 추천 수 증가 클릭
	@PutMapping(path = "voteUp", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public ResponseEntity<String> voteUp(@RequestBody VoteDto dto, Principal principal) {
		// 로그인 검사
		if (principal == null) {
			System.out.println("로그인 필요");
			return ResponseEntity.status(401).build();
		} else {
			boolean success = false;
			dto.setMemberId(principal.getName());
			System.out.println(dto.getSubRecipeIndex());
			// 현재 멤버명과 레시피 인덱스로 튜표테이블 레코드 검색
			String searchMember = cateService.searchMemberIdOnVote(dto);
			System.out.println("테이블멤버:"+searchMember);
			System.out.println("현재맴버:"+dto.getMemberId());
			// 현재 맴버명과 레시피인덱스번호가 존재할 시
			if (searchMember != null) {
				// 추천수 가져오기
				int getVoteNum = cateService.getVoteNum(dto);
				if (getVoteNum == 1) {
					// 추천 취소 (1 -> 0 으로 변경)
					success = cateService.setVoteNum(dto, 0);
				} else {
					// 추천수 증가 (-1, 0 -> 1)
					success = cateService.setVoteNum(dto, 1);
				}

				if (success) {
					System.out.println("투표성공");
					return ResponseEntity.ok("추천수가 변경되었습니다.");
				} else {
					System.out.println("투표실패");
					return ResponseEntity.status(500).body("");
				}
			} else {
				// 처음 추천시 추천테이블에 레코드 생성
				success = cateService.addVoteByMemberId(dto, 1);
				System.out.println("추천레코드 생성");
				return ResponseEntity.ok("추천수가 변경되었습니다.");
			}
		}
	}
	
	// 추천 수 감소 클릭
	@PutMapping(path = "voteDown", produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public ResponseEntity<String> voteDown(@RequestBody VoteDto dto, Principal principal) {
		// 로그인 검사
		if (principal == null) {
			return ResponseEntity.status(401).build();
		} else {
			boolean success = false;
			dto.setMemberId(principal.getName());
			System.out.println(dto.getSubRecipeIndex());
			String searchMember = cateService.searchMemberIdOnVote(dto);
			System.out.println("테이블멤버:"+searchMember);
			System.out.println("현재맴버:"+dto.getMemberId());
			if (searchMember != null) {
				// 추천수 가져오기
				int getVoteNum = cateService.getVoteNum(dto);
				if (getVoteNum == -1) {
					// 추천 취소 (-1 -> 0 으로 변경)
					success = cateService.setVoteNum(dto, 0);
				} else {
					// 추천수 증가 (1, 0 -> -1)
					success = cateService.setVoteNum(dto, -1);
				}

				if (success) {
					System.out.println("투표성공");
					return ResponseEntity.ok("추천수가 변경되었습니다.");
				} else {
					System.out.println("투표실패");
					return ResponseEntity.status(500).body("");
				}
			} else {
				// 처음 추천시 추천테이블에 레코드 생성
				success = cateService.addVoteByMemberId(dto, -1);
				System.out.println("추천레코드 생성");
				return ResponseEntity.ok("추천수가 변경되었습니다.");
			}
		}
	}
	

}
