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
import com.team1.food.domain.CloseDto;
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
			@RequestParam(name = "page", defaultValue = "1") int page) {

		int rowPerPage = 10;

		int totalRecords = service.countDebate();
		int end = (totalRecords - 1) / rowPerPage + 1;

		PageInfoDto pageInfo = new PageInfoDto();
		pageInfo.setCurrent(page);
		pageInfo.setEnd(end);

		List<DebateDto> list = service.listDebatePage(page, rowPerPage);
		//			List<DebateDto> list = service.listDebate();

		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("debateList", list);
	}
	
	/*@RequestMapping("close")
	public void CloseDebate(Model model) {
		List<CloseDto> list = service.CloseDebate();
		
		model.addAttribute("CloseList", list);
	}*/

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
		System.out.println(dto);

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
	
//	@PostMapping("move")
//	public String moveDebate(CloseDto dto, Principal principal, RedirectAttributes rttr) {
//		
//		CloseDto closeDebate = service.getCloseDebateById(dto.getId());
//		
//		
//	}
}
