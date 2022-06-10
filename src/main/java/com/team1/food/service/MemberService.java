package com.team1.food.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team1.food.domain.MemberDto;
import com.team1.food.mapper.MemberMapper;

@Service
public class MemberService {
    @Autowired

    private MemberMapper mapper;

    public boolean addMember(MemberDto member) {

        return mapper.insertMember(member) == 1;

    }

	public boolean hasMemberId(String id) {
		return mapper.countMemberId(id) > 0;
	}

	public boolean hasMemberEmail(String email) {
		
		 return mapper.countMemberEmail(email) > 0;
	}

	public boolean hasMemberNickName(String nickName) {
		
		return mapper.countMemberNickName(nickName) > 0;
	}


}
