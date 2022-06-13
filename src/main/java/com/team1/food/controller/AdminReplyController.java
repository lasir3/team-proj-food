package com.team1.food.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team1.food.domain.AdminReplyDto;
import com.team1.food.service.AdminReplyService;


@Controller
@RequestMapping("adminReply")
public class AdminReplyController {
	
	@Autowired
	AdminReplyService service;
	
	// 공지 댓글 등록
	@PostMapping(path = "insertNoticeReply", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> insertNoticeReply(AdminReplyDto dto){
		
		dto.setMemberId("1"); // 오류방지를 위해 임시로 넣어줌(not null)
		boolean success = service.insertNoticeReply(dto);
		if(success) {
			return ResponseEntity.ok("새 댓글이 등록되었습니다.");
		}else {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error");
		}
	}
	
	@GetMapping("noticeReplyList")
	@ResponseBody
	public List<AdminReplyDto> list(int boardId){
		
		return service.getNoticeReplyByBoardId(boardId);
	}
	
}
