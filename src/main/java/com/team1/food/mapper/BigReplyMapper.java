package com.team1.food.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.team1.food.domain.BigReplyDto;

public interface BigReplyMapper {

	int insertBigReply(BigReplyDto dto);

	List<BigReplyDto> selectAllDebateId(@Param("debateId")int debateId, @Param("memberId") String memberId);

	BigReplyDto selectBigReplyById(int id);

	int deleteBigReply(int id);

	void deleteByDebateId(int id);

	int updateBigReply(BigReplyDto dto);

	List<BigReplyDto> selectAllCloseId(@Param("debateId")int debateId, @Param("memberId")String memberId);

	void deleteByCloseId(int id);

}
