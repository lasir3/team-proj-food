package com.team1.food.mapper;

import java.util.List;

import com.team1.food.domain.MemberDto;

public interface MemberMapper {

	int insertMember(MemberDto member);

	int countMemberId(String id);

	int countMemberEmail(String email);

	int countMemberNickName(String nickName);

	List<MemberDto> selectAllMember();

	MemberDto selectMemberById(String id);
	
}


