package com.team1.food.controller;

import java.beans.Transient;
import java.security.Principal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

import javax.servlet.jsp.tagext.PageData;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team1.food.domain.AdminBoardDto;
import com.team1.food.domain.AdminBoardPageDto;
import com.team1.food.domain.AdminLeaveDto;
import com.team1.food.service.AdminBoardService;
import com.team1.food.service.AdminReplyService;

@Controller
@RequestMapping("admin")
public class AdminBoardController {
	
	@Autowired
	private AdminBoardService service;
	
	@Autowired
	private AdminReplyService replyService;
	
	// 한 화면에 보여줄 게시글 개수
	int rowPerPage = 10;
	
	/*** 메인 ***/
	@GetMapping("main")
	public void home(Model model) {
		// 메인화면에서 각 게시판 별 보여질 글의 개수
		int row = 7;
		
		List<AdminBoardDto> noticeList = service.noticeList("", "", 1, row);
		model.addAttribute("noticeBoardList", noticeList);
		
		List<AdminBoardDto> restAreaList = service.restAreaList("", "", 1, row, 0);
		model.addAttribute("restAreaBoardList", restAreaList);
		
		List<AdminBoardDto> askList = service.askList("", "", 1, row, 0);
		model.addAttribute("askBoardList", askList);
		
		List<AdminBoardDto> reportList = service.reportList("", "", 1, row);
		model.addAttribute("reportBoardList", reportList);
		
	}
	
	/*** 공지 ***/
	
	// 공지 글 리스트
	@GetMapping("notice")
	public void notice(
			@RequestParam(name= "keyword", defaultValue = "") String keyword,
			@RequestParam(name = "type", defaultValue = "") String type,
			@RequestParam(name = "page", defaultValue = "1") int page,
			Model model) {		
		
		// 테이블에 맞는 값이 세팅된 pageDto 가져오기 
		// 파라미터 : (page, DB테이블명)
		AdminBoardPageDto pageDto = getPageDto(type, keyword, page, "Notice");		
		List<AdminBoardDto> list = service.noticeList(
				type, keyword, page, rowPerPage);
		// 고정 공지 글 가져오기
		List<AdminBoardDto> pinnedList = service.pinnedNoticeList();
		
		model.addAttribute("pinnedBoardList", pinnedList);
		model.addAttribute("pageInfo", pageDto);
		model.addAttribute("boardList", list);
		
	}

	// 공지 글 작성 시작
	@GetMapping("insertNotice")
	public void insertNotice() {
		
	}
	
	// 공지 글 작성 완료
	@PostMapping("insertNotice")
	public String insertNotice(
			AdminBoardDto dto,
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
	@Transactional
	@PostMapping("deleteNotice")
	public String deleteNotice(AdminBoardDto dto,
			RedirectAttributes rttr) {
		// 두번째 파라미터는 noticeId, restAreaId, askId, reportId
		replyService.deleteReplyByBoardId(dto.getId(), "noticeId");
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
	public void restArea(
			@RequestParam(name= "keyword", defaultValue = "") String keyword,
			@RequestParam(name = "type", defaultValue = "") String type,
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "state", defaultValue = "0") int state,
						Model model) {
		
		AdminBoardPageDto pageDto = getPageDtoWithState(type, keyword, page, "RestArea", state);
		//state >> 0:전체, 1:휴가, 2:사퇴, 3:신고
		List<AdminBoardDto> list = service.restAreaList(type, keyword, page, rowPerPage, state);
		// 고정 공지 글 가져오기
		List<AdminBoardDto> pinnedList = service.pinnedNoticeList();
		
		model.addAttribute("pinnedBoardList", pinnedList);
		model.addAttribute("pageInfo", pageDto);
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
			Principal principal,
			String datepicker1,
			String datepicker2
			) {
	
		/*** 글 등록 ***/
		
		
		dto.setMemberId(principal.getName());
		
		boolean success = service.insertRestAreaBoard(dto);
		
		if(success) {
			rttr.addFlashAttribute("createMessage", "새 글이 등록되었습니다.");
		}else {
			rttr.addFlashAttribute("createMessage", "글이 등록되지 않았습니다.");
		}
		
		/*** 휴가 기간 값이 있을 때에만 휴가자 테이블에 등록 ***/
		if(datepicker1 != "" && datepicker2 != "") {
			AdminLeaveDto leave = getLeaveDto(principal.getName(), datepicker1, datepicker2);
			AdminBoardDto dto2 = service.selectLastRestArea(principal.getName());
			leave.setBoardId(dto2.getId());
			service.insertLeave(leave);
		}
		
		return "redirect:/admin/restArea";
	}
	
	
	
	// 쉼터 글 보기
	@GetMapping("getRestArea")
	public void getRestArea(int id, Model model) {
		AdminBoardDto dto = service.getRestAreaBoardById(id);
		AdminLeaveDto leaveDto = service.selectLeaveByBoardId(id);
		
		model.addAttribute("board", dto);
		model.addAttribute("leave", leaveDto);
	}
	
	// 쉼터 글 수정
	@PostMapping("updateRestArea")
	public String updateRestArea(AdminBoardDto dto,
			int leaveId,
			RedirectAttributes rttr,
			Principal principal,
			String datepicker1,
			String datepicker2
			) {
		
		// 휴가 기간 값이 있을 경우 휴가자 테이블 정보 수정
		if(dto.getState() == 1 && datepicker1 != "" && datepicker2 != "") {
			AdminLeaveDto leave = getLeaveDto(principal.getName(), datepicker1, datepicker2);
			leave.setId(leaveId);
			service.updateLeave(leave);
		}
		
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
	@Transactional
	@PostMapping("deleteRestArea")
	public String deleteRestArea(AdminBoardDto dto,
			RedirectAttributes rttr) {
		
		replyService.deleteReplyByBoardId(dto.getId(), "restAreaId");
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
	public void ask(
			@RequestParam(name= "keyword", defaultValue = "") String keyword,
			@RequestParam(name = "type", defaultValue = "") String type,
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "state", defaultValue = "0") int state,
					Model model) {
		
		AdminBoardPageDto pageDto = getPageDtoWithState(type, keyword, page, "Ask", state);
		//state >> 0:전체, 1:대기, 2:완료
		List<AdminBoardDto> list = service.askList(type, keyword, page, rowPerPage, state);
		// 고정 공지 글 가져오기
		List<AdminBoardDto> pinnedList = service.pinnedNoticeList();
		
		model.addAttribute("pinnedBoardList", pinnedList);
		model.addAttribute("pageInfo", pageDto);
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
	
	// 문의 글 수정
	
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
	@Transactional
	@PostMapping("deleteAsk")
	public String deleteAsk(AdminBoardDto dto,
			RedirectAttributes rttr) {
		
		replyService.deleteReplyByBoardId(dto.getId(), "askId");
		boolean success = service.deleteAskBoardById(dto.getId());
		
		if(success) {
			rttr.addFlashAttribute("deleteMessage", "글이 삭제되었습니다.");
		}else {
			rttr.addFlashAttribute("deleteMessage", "글이 삭제되지 않았습니다.");
		}
		
		return "redirect:/admin/ask";
	}
	
	// 문의 글 답변 완료
	@PostMapping("updateBoardState")
	public String updateBoardState(int id, int state, RedirectAttributes rttr) {
		// 세번째 파라미터 >> 테이블명
		boolean success = service.updateBoardState(id, state, "Ask");
		if(success) {
			rttr.addFlashAttribute("answerMessage", "답변 완료");
		}else {
			rttr.addFlashAttribute("answerMessage", "실패");
		}
		
		rttr.addAttribute("id", id);
		return "redirect:/admin/getAsk";
	}
	
	/*** 신고 ***/
	
	
	// 신고 글 리스트
	
	@GetMapping("report")
	public void report(
			@RequestParam(name= "keyword", defaultValue = "") String keyword,
			@RequestParam(name = "type", defaultValue = "") String type,
			@RequestParam(name = "page", defaultValue = "1") int page,
						Model model) {
		
		AdminBoardPageDto pageDto = getPageDto(type, keyword, page, "Report");
		List<AdminBoardDto> list = service.reportList(type, keyword, page, rowPerPage);
		// 고정 공지 글 가져오기
		List<AdminBoardDto> pinnedList = service.pinnedNoticeList();
		
		model.addAttribute("pinnedBoardList", pinnedList);
		model.addAttribute("pageInfo", pageDto);
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
	@Transactional
	@PostMapping("deleteReport")
	public String deleteReport(AdminBoardDto dto,
			RedirectAttributes rttr) {
		
		replyService.deleteReplyByBoardId(dto.getId(), "reportId");
		boolean success = service.deleteReportBoardById(dto.getId());
		
		if(success) {
			rttr.addFlashAttribute("deleteMessage", "글이 삭제되었습니다.");
		}else {
			rttr.addFlashAttribute("deleteMessage", "글이 삭제되지 않았습니다.");
		}
		
		return "redirect:/admin/report";
	}
	
	/*** 공용 
	 * @param keyword 
	 * @param type ***/
	
	// 값이 세팅된 pageDto 가져오기
	private AdminBoardPageDto getPageDto(
			String type,
			String keyword, 
			int page, 
			String tableName) {
		AdminBoardPageDto dto = new AdminBoardPageDto();
		dto.setPage(page);
		dto.setRowPerPage(rowPerPage);
		int totalRow = service.boardCount(type, keyword, tableName);
		dto.setTotalRow(totalRow);
		return dto;
	}
	
	// 값이 세팅된 pageDto 가져오기
	private AdminBoardPageDto getPageDtoWithState(
			String type,
			String keyword, 
			int page, 
			String tableName,
			int state) {
		AdminBoardPageDto dto = new AdminBoardPageDto();
		dto.setPage(page);
		dto.setRowPerPage(rowPerPage);
		int totalRow = service.boardCountWithState(type, keyword, tableName, state);
		dto.setTotalRow(totalRow);
		return dto;
	}
	
	// 값 세팅된 leaveDto 가져오기
	public AdminLeaveDto getLeaveDto(String memberId, String dateString1, String dateString2) {
		Date date1 = null;
		Date date2 = null;
		
		try {				
			date1 = new SimpleDateFormat("yyyy-MM-dd").parse(dateString1);
			date2 = new SimpleDateFormat("yyyy-MM-dd").parse(dateString2);
			AdminLeaveDto leave = new AdminLeaveDto();
			leave.setMemberId(memberId);
			leave.setStart(date1);
			leave.setEnd(date2);
			return leave;
		}catch(ParseException e){
			e.printStackTrace();
		}
		return null;
	}
}
