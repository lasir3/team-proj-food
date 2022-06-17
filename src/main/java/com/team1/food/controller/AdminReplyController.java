package com.team1.food.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.team1.food.domain.AdminReplyDto;
import com.team1.food.service.AdminReplyService;

@RestController
@RequestMapping("adminReply")
public class AdminReplyController {
	
	@Autowired
	private AdminReplyService service;
	
	/*** 공지 ***/
	
	// 공지 댓글 입력
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
	
	// 공지 댓글 리스트
	@GetMapping("noticeReplyList")
	public List<AdminReplyDto> replyList(
			int boardId,
			Principal principal){
		
		if(principal == null) {			
			// 두번째 파라미터 : noticeId, restAreaId, askId, reportId
			return service.replyList(boardId, "noticeId");
		} else {
			return service.replyListWithOwn(boardId, "noticeId", principal.getName());
		}
	}
	
	/*** 공용 ***/
	
	// 댓글 수정
	@PutMapping("updateReply")
	public ResponseEntity<String> modifyReply(
			@RequestBody AdminReplyDto dto,
			Principal principal
			){
		
		if(principal == null) {
			// 로그인 상태가 아닐 때
			return ResponseEntity.status(401).build();
		}else {			
			// 로그인 상태일 때
			boolean success = service.updateReply(dto);
			
			if (success) {
				return ResponseEntity.ok("댓글이 변경되었습니다.");
			}
			
			return ResponseEntity.status(500).body("");
		}
	}
	
	// 댓글 삭제
	//{id}의 값이 delete()의 파라미터로 들어옴
	@DeleteMapping(path = "deleteReply/{id}", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> deleteReply(
			@PathVariable("id")int id,
			Principal principal){
		
		if(principal == null) {
			// 로그인 상태가 아닐 때
			return ResponseEntity.status(401).build();
		}else {			
			// 로그인 상태일 때
			boolean success = service.deleteReplyById(id);
			
			if (success) {
				return ResponseEntity.ok("댓글이 삭제되었습니다.");
			}
			
			return ResponseEntity.status(500).body("");
		}
	}
	
}
