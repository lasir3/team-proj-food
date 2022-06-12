package com.team1.food.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team1.food.domain.AdminNoticeBoardDto;
import com.team1.food.service.AdminBoardService;

@Controller
@RequestMapping("admin")
public class AdminBoardController {
	
	@Autowired
	private AdminBoardService service;
	
	// 공지 리스트
	@GetMapping("notice")
	public void notice(Model model) {
		List<AdminNoticeBoardDto> list = service.noticeList();
		model.addAttribute("noticeList", list);
	}
	
	// 공지 작성 시작
	@GetMapping("insertNotice")
	public void insertNotice() {
		
	}
	
	// 공지 작성 완료
	@PostMapping("insertNotice")
	public String insertNotice(AdminNoticeBoardDto dto,
			RedirectAttributes rttr) {
		
		dto.setMemberId("1"); // null이면 오류가 발생하기 때문에 임시로 넣어줌
		
		boolean success = service.insertNoticeBoard(dto);
		
		if(success) {
			rttr.addFlashAttribute("message", "새 글이 등록되었습니다.");
		}else {
			rttr.addFlashAttribute("message", "글이 등록되지 않았습니다.");
		}
		
		return "redirect:/admin/notice";
	}
	
	// 공지 글 보기
	@GetMapping("getNotice")
	public void getNotice(int id, Model model) {
		AdminNoticeBoardDto dto = service.getNoticeBoardById(id);
		
		model.addAttribute("notice", dto);
	}
}
