package com.team1.food.service;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team1.food.domain.BigReplyDto;
import com.team1.food.mapper.BigReplyMapper;

@Service
public class BigReplyService {

	@Autowired
	private BigReplyMapper mapper;

	public boolean insertBigReply(BigReplyDto dto) {
		
		return mapper.insertBigReply(dto) == 1;
	}

	public List<BigReplyDto> getBigReplyByDebateId(int debateId) {
		
		return mapper.selectAllDebateId(debateId, null);
	}

	public List<BigReplyDto> getBigReplyWithOwnByDebateId(int debateId, String memberId) {
		return mapper.selectAllDebateId(debateId, memberId);
	}

	public boolean deleteBigReply(int id, Principal principal) {
	
		BigReplyDto old = mapper.selectBigReplyById(id);

		if (old.getMemberId().equals(principal.getName())) {
			// 댓글 작성자와 로그인한 유저가 같을 때만 삭제
			return mapper.deleteBigReply(id) == 1;
		} else {
			// 그렇지 않으면 return false;
			return false;
		}
	}

	public boolean updateBigReply(BigReplyDto dto, Principal principal) {
		BigReplyDto old = mapper.selectBigReplyById(dto.getId());

		if (old.getMemberId().equals(principal.getName())) {
			// 댓글 작성자와 로그인한 유저가 같을 때만 수정
			return mapper.updateBigReply(dto) == 1;
		} else {
			// 그렇지 않으면 return false;
			return false;
		}
	}

	public List<BigReplyDto> getBigReplyByCloseId(int debateId) {
		// TODO Auto-generated method stub
		return mapper.selectAllCloseId(debateId, null);
	}
}
