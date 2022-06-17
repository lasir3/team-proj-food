package com.team1.food.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.team1.food.domain.BigReplyDto;
import com.team1.food.domain.SmallReplyDto;
import com.team1.food.service.BigReplyService;

@Controller
@RequestMapping("reply")
public class BigReplyController {
	
	@Autowired
	private BigReplyService service;
	
	@PostMapping(path = "insert", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> insert(BigReplyDto dto, Principal principal) {
		
		if (principal == null) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
		} else {
			String debateId = principal.getName();
			dto.setDebateId(debateId);
			
			boolean success = service.insertBigReply(dto);
	
			if (success) {
				return ResponseEntity.ok("새 댓글이 등록되었습니다.");
			} else {
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error");
			}
		}

	}
	@PutMapping(path = "modify", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> modify(@RequestBody BigReplyDto dto, Principal principal) {

		if (principal == null) {
			return ResponseEntity.status(401).build();
		} else {
			boolean success = service.updateBigReply(dto, principal);
			
			if (success) {
				return ResponseEntity.ok("댓글이 변경되었습니다.");
			}
			
			return ResponseEntity.status(500).body("");
			
		}
		
	}
	
	@DeleteMapping(path = "delete/{id}", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> delete(@PathVariable("id") int id, Principal principal) {
		
		if (principal == null) {
			return ResponseEntity.status(401).build();
		} else {
			boolean success = service.deleteBigReply(id, principal);
			
			if (success) {
				return ResponseEntity.ok("댓글을 삭제 하였습니다.");
			} else {
				return ResponseEntity.status(500).body("");
			}
			
		}
	}
	
	@GetMapping("list")
	public List<BigReplyDto> list(int debateId, Principal principal) {
		if (principal == null) {
			return service.getBigReplyByDebateId(debateId);
		} else {
			return service.getBigReplyWithOwnByDebateId(debateId, principal.getName());
		}
	}
}
