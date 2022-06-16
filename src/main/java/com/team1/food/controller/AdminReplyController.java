package com.team1.food.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.team1.food.domain.AdminReplyDto;
import com.team1.food.service.AdminReplyService;

@RestController
@RequestMapping("adminReply")
public class AdminReplyController {
	
	@Autowired
	private AdminReplyService service;
	
	@PostMapping(path = "insertNoticeReply", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> insertNoticeReply(AdminReplyDto dto, Principal principal){
		if(principal == null) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
		}else {
			dto.setMemberId(principal.getName());
			
			boolean success = service.insertNoticeReply(dto);
			
			if (success) {
				return ResponseEntity.ok("새 댓글이 등록되었습니다.");
			} else {
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error");
			}
		}
	}

	
}
