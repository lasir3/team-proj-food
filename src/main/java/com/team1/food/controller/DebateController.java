package com.team1.food.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team1.food.domain.BigReplyDto;
import com.team1.food.domain.DebateDto;
import com.team1.food.domain.PageInfoDto;
import com.team1.food.service.BigReplyService;
import com.team1.food.service.DebateService;

@Controller
@RequestMapping("debate")
public class DebateController {

	@Autowired
	private DebateService service;

	@Autowired
	private BigReplyService replyService;

	@RequestMapping("list")
	public void listDebate(Model model,
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "type", defaultValue = "")String type,
			@RequestParam(name = "keyword", defaultValue = "") String keyword) {

		int rowPerPage = 10;

		int totalRecords = service.countDebate(type, keyword);
		int end = (totalRecords - 1) / rowPerPage + 1;

		PageInfoDto pageInfo = new PageInfoDto();
		pageInfo.setCurrent(page);
		pageInfo.setEnd(end);
		
		List<DebateDto> list = service.listDebatePage(page, rowPerPage, type, keyword);
		/*List<DebateDto> search = service.searchDebate(type, keyword);*/
		//			List<DebateDto> list = service.listDebate();
		
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("debateList", list);
	}
	
	@RequestMapping("all")
	public void allDebate(Model model,
			@RequestParam(name = "page", defaultValue="1")int page,
			@RequestParam(name = "type", defaultValue="")String type,
			@RequestParam(name = "keyword", defaultValue="")String keyword){
		
		int rowPerPage = 10;
		
		int totalRecords = service.countAllDebate(type, keyword);
		int end = (totalRecords - 1) / rowPerPage + 1;
		
		PageInfoDto pageInfo = new PageInfoDto();
		pageInfo.setCurrent(page);
		pageInfo.setEnd(end);
		
		List<DebateDto> allDebate = service.AllDebate(page, rowPerPage, type, keyword);
		
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("allDebate", allDebate);
	}
	 
	
	
	@RequestMapping("close")
	public void closeDebate(Model model,
			@RequestParam(name = "page", defaultValue = "1")int page,
			@RequestParam(name = "type", defaultValue = "") String type,
			@RequestParam(name = "keyword", defaultValue = "") String keyword) {
		
		int rowPerPage = 10;
		
		int totalRecords = service.countClose(type, keyword);
		int end = (totalRecords -1) / rowPerPage + 1;
		
		PageInfoDto pageInfo = new PageInfoDto();
		pageInfo.setCurrent(page);
		pageInfo.setEnd(end);
				
		List<DebateDto> close = service.closeDebate(type, page, keyword, rowPerPage);
	 
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("closeDebate", close);

	}
	
	@GetMapping("closeget")
	public void getClose(int id, Model model) {
		DebateDto dto = service.getCloseById(id);
		List<BigReplyDto> replyList = replyService.getBigReplyByCloseId(id);
		model.addAttribute("debate", dto);
		

		/* ajax로 처리하기 위해 삭제 */
		// model.addAttribute("replyList", replyList);

	}
	
	@PostMapping("updateclose")
	public String updateclose(int id, RedirectAttributes rttr) {
		
		boolean success = service.updateClose(id);
		
		if(success) {
			rttr.addFlashAttribute("message", "토론이 종료되었습니다.");
	} else {
		rttr.addFlashAttribute("message", "토론닫기 실패했습니다.");
	}
		 return "redirect:/debate/close";
	}
	
	@GetMapping("write")
	public void insert() {
		
	}
	
	@PostMapping("write")
	public String writeBoardProcess(DebateDto debate,
			Principal principal,
			RedirectAttributes rttr
			) {
		
		debate.setMemberId(principal.getName());
		boolean success = service.addDebate(debate);
		
			if(success) {
				rttr.addFlashAttribute("message", "새 글이 등록되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "새 글이 등록 실패했습니다.");
		}

		return "redirect:/debate/list";
	}

	@GetMapping("get")
	public void get(int id, Model model) {
		DebateDto dto = service.getDebateById(id);
		List<BigReplyDto> replyList = replyService.getBigReplyByDebateId(id);
		model.addAttribute("debate", dto);
		

		/* ajax로 처리하기 위해 삭제 */
		// model.addAttribute("replyList", replyList);

	}

	@PostMapping("modify")
	public String modify(DebateDto dto,
			Principal principal,
			RedirectAttributes rttr) {
		DebateDto oldBoard = service.getDebateById(dto.getId());
	
		if (oldBoard.getMemberId().equals(principal.getName())) {
			boolean success = service.updateDebate(dto);

			if (success) {
				rttr.addFlashAttribute("message", "글이 수정되었습니다.");
			} else {
				rttr.addFlashAttribute("message", "글이 수정되지 않았습니다.");
			}

		} else {
			rttr.addFlashAttribute("message", "권한이 없습니다.");
		}

		rttr.addAttribute("id", dto.getId());
		return "redirect:/debate/get";

	}

	@PostMapping("remove")
	public String removeDebate(DebateDto dto, Principal principal, RedirectAttributes rttr) {

		// 게시물 정보 얻고
		DebateDto oldBoard = service.getDebateById(dto.getId());
		// 게시물 작성자(memberId)와 principal의 name과 비교해서 같을 때만 진행.
		if (oldBoard.getMemberId().equals(principal.getName())) {
			boolean success = service.deleteDebate(dto.getId());

			if (success) {
				rttr.addFlashAttribute("message", "글이 삭제 되었습니다.");

			} else {
				rttr.addFlashAttribute("message", "글이 삭제 되지않았습니다.");
			}

		} else {
			rttr.addFlashAttribute("message", "권한이 없습니다.");
			rttr.addAttribute("id", dto.getId());
			return "redirect:/debate/get";
		}

		return "redirect:/debate/list";
	}
	
	@PostMapping("removeclose")
		public String removeClose(DebateDto dto, Principal principal, RedirectAttributes rttr) {
	
			// 게시물 정보 얻고
			DebateDto oldBoard = service.getRemoveById(dto.getId());
			// 게시물 작성자(memberId)와 principal의 name과 비교해서 같을 때만 진행.
			if (oldBoard.getMemberId().equals(principal.getName())) {
				boolean success = service.deleteClose(dto.getId());
	
				if (success) {
					rttr.addFlashAttribute("message", "글이 삭제 되었습니다.");
	
				} else {
					rttr.addFlashAttribute("message", "글이 삭제 되지않았습니다.");
				}
	 
			} else {
				rttr.addFlashAttribute("message", "권한이 없습니다.");
				rttr.addAttribute("id", dto.getId());
				return "redirect:/debate/closeget";
			}
	
			return "redirect:/debate/close";
		}
}
