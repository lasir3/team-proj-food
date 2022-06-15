package com.team1.food.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.jsp.tagext.PageData;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team1.food.domain.AdminBoardDto;
import com.team1.food.domain.AdminBoardPageDto;
import com.team1.food.service.AdminBoardService;

@Controller
@RequestMapping("admin")
public class AdminBoardController {
	
	@Autowired
	private AdminBoardService service;
	
	/*** 메인 ***/
	@GetMapping("main")
	public void home(Model model) {
		List<AdminBoardDto> noticeList = service.noticeList(1,7);
		model.addAttribute("noticeBoardList", noticeList);
		
		List<AdminBoardDto> restAreaList = service.restAreaList();
		model.addAttribute("restAreaBoardList", restAreaList);
		
		List<AdminBoardDto> askList = service.askList();
		model.addAttribute("askBoardList", askList);
		
		List<AdminBoardDto> reportList = service.reportList();
		model.addAttribute("reportBoardList", reportList);
		
	}
	
	/*** 공지 ***/
	
	// 공지 글 리스트
	@GetMapping("notice")
	public void notice(@RequestParam(name = "keyword", defaultValue = "") String keyword,
						@RequestParam(name = "type", defaultValue = "") String type,
						@RequestParam(name = "page", defaultValue = "1") int page,
						Model model) {
		
		//한 페이지에 보여질 게시글 개수
		int rowPerPage = 5;
		//DB에 있는 총 레코즈 개수
		int totalRow = service.noticeBoardCount();
		
		AdminBoardPageDto pageDto = new AdminBoardPageDto();
		pageDto.setPage(page);
		pageDto.setTotalRow(totalRow);
		pageDto.setRowPerPage(rowPerPage);
				
		model.addAttribute("pageInfo", pageDto);
		
		List<AdminBoardDto> list = service.noticeList(page, rowPerPage);
		model.addAttribute("boardList", list);
		
	}

	// 공지 글 작성 시작
	@GetMapping("insertNotice")
	public void insertNotice() {
		
	}
	
	// 공지 글 작성 완료
	@PostMapping("insertNotice")
	public String insertNotice(AdminBoardDto dto,
			RedirectAttributes rttr,
			Principal principal) {
		
		dto.setMemberId(principal.getName()); 
		
		boolean success = service.insertNoticeBoard(dto);
		
		if(success) {
			rttr.addFlashAttribute("createMessage", "새 글이 등록되었습니다.");
		}else {
			rttr.addFlashAttribute("createMessage", "글이 등록되지 않았습니다.");
		}
		
		return "redirect:/admin/notice";
	}
	
	// 공지 글 보기
	@GetMapping("getNotice")
	public void getNotice(int id, Model model) {
		AdminBoardDto dto = service.getNoticeBoardById(id);
		
		model.addAttribute("board", dto);
	}
	
	@PostMapping("updateNotice")
	public String updateNotice(AdminBoardDto dto,
			RedirectAttributes rttr) {
		
		boolean success = service.updateNoticeBoard(dto);
		
		if(success) {
			rttr.addFlashAttribute("updateMessage", "글이 수정되었습니다.");
		}else {
			rttr.addFlashAttribute("updateMessage", "글이 수정되지 않았습니다.");
		}
		
		rttr.addAttribute("id", dto.getId());
		return "redirect:/admin/getNotice";
	}
	
	//공지 글 삭제
	
	@PostMapping("deleteNotice")
	public String deleteNotice(AdminBoardDto dto,
			RedirectAttributes rttr) {
		boolean success = service.deleteNoticeBoardById(dto.getId());
		
		if(success) {
			rttr.addFlashAttribute("deleteMessage", "글이 삭제되었습니다.");
		}else {
			rttr.addFlashAttribute("deleteMessage", "글이 삭제되지 않았습니다.");
		}
		
		return "redirect:/admin/notice";
		
	}
	
	/*** 쉼터 ***/
	
	// 쉼터 글 리스트
	
	@GetMapping("restArea")
	public void restArea(@RequestParam(name = "page", defaultValue = "1") int page,
						Model model) {
		
		List<AdminBoardDto> list = service.restAreaList();
		model.addAttribute("boardList", list);
	}
	
	// 쉼터 글 작성 시작
	
	@GetMapping("insertRestArea")
	public void insertRestArea() {
		
	}
	
	// 쉼터 글 작성 완료
	
	@PostMapping("insertRestArea")
	public String insertRestArea(AdminBoardDto dto,
			RedirectAttributes rttr,
			Principal principal) {
		
		dto.setMemberId(principal.getName());
		
		boolean success = service.insertRestAreaBoard(dto);
		
		if(success) {
			rttr.addFlashAttribute("createMessage", "새 글이 등록되었습니다.");
		}else {
			rttr.addFlashAttribute("createMessage", "글이 등록되지 않았습니다.");
		}
		
		return "redirect:/admin/restArea";
	}
	
	// 쉼터 글 보기
	
	@GetMapping("getRestArea")
	public void getRestArea(int id, Model model) {
		AdminBoardDto dto = service.getRestAreaBoardById(id);
		
		model.addAttribute("board", dto);
	}
	
	@PostMapping("updateRestArea")
	public String updateRestArea(AdminBoardDto dto,
			RedirectAttributes rttr) {
		
		boolean success = service.updateRestAreaBoard(dto);
		
		if(success) {
			rttr.addFlashAttribute("updateMessage", "글이 수정되었습니다.");
		}else {
			rttr.addFlashAttribute("updateMessage", "글이 수정되지 않았습니다.");
		}
		
		rttr.addAttribute("id", dto.getId());
		return "redirect:/admin/getRestArea";
	}
	
	// 쉼터 글 삭제
	
	@PostMapping("deleteRestArea")
	public String deleteRestArea(AdminBoardDto dto,
			RedirectAttributes rttr) {
		boolean success = service.deleteRestAreaBoardById(dto.getId());
		
		if(success) {
			rttr.addFlashAttribute("deleteMessage", "글이 삭제되었습니다.");
		}else {
			rttr.addFlashAttribute("deleteMessage", "글이 삭제되지 않았습니다.");
		}
		
		return "redirect:/admin/restArea";
	}
	
	/*** 문의 ***/
	
	// 문의 글 리스트
	
	@GetMapping("ask")
	public void ask(@RequestParam(name = "page", defaultValue = "1") int page,
					Model model) {
		
		List<AdminBoardDto> list = service.askList();
		model.addAttribute("boardList", list);
	}
	
	// 문의 글 작성 시작
	
	@GetMapping("insertAsk")
	public void insertAsk() {
		
	}
	
	// 문의 글 작성 완료
	
	@PostMapping("insertAsk")
	public String insertAsk(AdminBoardDto dto,
			RedirectAttributes rttr,
			Principal principal) {
		
		dto.setMemberId(principal.getName()); 
		
		boolean success = service.insertAskBoard(dto);
		
		if(success) {
			rttr.addFlashAttribute("createMessage", "새 글이 등록되었습니다.");
		}else {
			rttr.addFlashAttribute("createMessage", "글이 등록되지 않았습니다.");
		}
		
		return "redirect:/admin/ask";
	}
	
	// 문의 글 보기
	
	@GetMapping("getAsk")
	public void getAsk(int id, Model model) {
		AdminBoardDto dto = service.getAskBoardById(id);
		
		model.addAttribute("board", dto);
	}
	
	@PostMapping("updateAsk")
	public String updateAsk(AdminBoardDto dto,
			RedirectAttributes rttr) {
		
		boolean success = service.updateAskBoard(dto);
		
		if(success) {
			rttr.addFlashAttribute("updateMessage", "글이 수정되었습니다.");
		}else {
			rttr.addFlashAttribute("updateMessage", "글이 수정되지 않았습니다.");
		}
		
		rttr.addAttribute("id", dto.getId());
		return "redirect:/admin/getAsk";
	}
	
	// 문의 글 삭제
	
	@PostMapping("deleteAsk")
	public String deleteAsk(AdminBoardDto dto,
			RedirectAttributes rttr) {
		boolean success = service.deleteAskBoardById(dto.getId());
		
		if(success) {
			rttr.addFlashAttribute("deleteMessage", "글이 삭제되었습니다.");
		}else {
			rttr.addFlashAttribute("deleteMessage", "글이 삭제되지 않았습니다.");
		}
		
		return "redirect:/admin/ask";
	}
	
	/*** 신고 ***/
	
	
	// 신고 글 리스트
	
	@GetMapping("report")
	public void report(@RequestParam(name = "page", defaultValue = "1") int page,
						Model model) {
		
		List<AdminBoardDto> list = service.reportList();
		model.addAttribute("boardList", list);
	}
	
	// 신고 글 작성 시작
	
	@GetMapping("insertReport")
	public void insertReport() {
		
	}
	
	// 신고 글 작성 완료
	
	@PostMapping("insertReport")
	public String insertReport(AdminBoardDto dto,
			RedirectAttributes rttr,
			Principal principal) {
		
		dto.setMemberId(principal.getName()); 
		
		boolean success = service.insertReportBoard(dto);
		
		if(success) {
			rttr.addFlashAttribute("createMessage", "새 글이 등록되었습니다.");
		}else {
			rttr.addFlashAttribute("createMessage", "글이 등록되지 않았습니다.");
		}
		
		return "redirect:/admin/report";
	}
	
	// 신고 글 보기
	
	@GetMapping("getReport")
	public void getReport(int id, Model model) {
		AdminBoardDto dto = service.getReportBoardById(id);
		
		model.addAttribute("board", dto);
	}
	
	@PostMapping("updateReport")
	public String updateReport(AdminBoardDto dto,
			RedirectAttributes rttr) {
		
		boolean success = service.updateReportBoard(dto);
		
		if(success) {
			rttr.addFlashAttribute("updateMessage", "글이 수정되었습니다.");
		}else {
			rttr.addFlashAttribute("updateMessage", "글이 수정되지 않았습니다.");
		}
		
		rttr.addAttribute("id", dto.getId());
		return "redirect:/admin/getReport";
	}
	
	// 신고 글 삭제
	
	@PostMapping("deleteReport")
	public String deleteReport(AdminBoardDto dto,
			RedirectAttributes rttr) {
		boolean success = service.deleteReportBoardById(dto.getId());
		
		if(success) {
			rttr.addFlashAttribute("deleteMessage", "글이 삭제되었습니다.");
		}else {
			rttr.addFlashAttribute("deleteMessage", "글이 삭제되지 않았습니다.");
		}
		
		return "redirect:/admin/report";
	}
}
