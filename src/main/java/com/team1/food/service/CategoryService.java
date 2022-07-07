package com.team1.food.service;

import java.io.IOException;
import java.security.Principal;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.team1.food.domain.FoodCateDto;
import com.team1.food.domain.FoodDto;
import com.team1.food.domain.SubFoodDto;
import com.team1.food.domain.VoteDto;
import com.team1.food.mapper.CategoryMapper;

import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service
public class CategoryService {

	@Autowired
	private CategoryMapper mapper;

	private S3Client s3;

	@Value("${aws.s3.bucketName}")
	private String bucketName;
	
	@PostConstruct // Service가 실행되자마자 작동하는 어노테이션
	public void init() {
		Region region = Region.AP_NORTHEAST_2;
		this.s3 = S3Client.builder().region(region).build();
	}
	
	@PreDestroy 
	public void destroy() {
		this.s3.close();
	}

	// 카테고리 리스트 메소드
	public List<FoodCateDto> foodCateList() {
		return mapper.selectCateList();
	}

	// 음식 리스트 메소드
	public List<FoodDto> foodList(int cateIndex) {
		return mapper.selectFoodList(cateIndex);
	}

	// 카테고리 등록 메소드
	@Transactional
	public boolean addCate(FoodCateDto dto, MultipartFile file) {
		// 카테고리 등록
		int cnt = mapper.insertCate(dto);
		System.out.println("카테고리등록 성공");

		// 파일 등록
		if (file != null) {
			mapper.insertCateFile(dto.getCateIndex(), file.getOriginalFilename());
			saveFileAwsS3(dto.getCateIndex(), file); // s3에 업로드
			System.out.println("파일등록 성공");
		}
		return cnt == 1;
	}

	// AwsS3 파일 삭제
	private void deleteFromAwsS3(int id, String file) {
		String key = "foodWikiFile/" + "FoodCateTable/" + id + "/" + file;
		
		DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder()
				.bucket(bucketName)
				.key(key)
				.build();
		s3.deleteObject(deleteObjectRequest);
	}

	// 공통 s3 업로드 메소드 작성
	private void saveFileAwsS3(int id, MultipartFile file) {
		String key = "foodWikiFile/" + "FoodCateTable/" + id + "/" + file.getOriginalFilename();

		PutObjectRequest putObjectRequest = PutObjectRequest.builder()
				.acl(ObjectCannedACL.PUBLIC_READ)
				.bucket(bucketName)
				.key(key)
				.build();

		RequestBody requestBody;
		try {
			requestBody = RequestBody.fromInputStream(file.getInputStream(), file.getSize());
			s3.putObject(putObjectRequest, requestBody);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new RuntimeException(e); // Transactional 어노테이션에 대한 exception 설정
		}
	}

	// 미사용 메소드
//	// 카테고리 인덱스번호 호출 메소드
//	public FoodCateDto getCateByIndex(int i) {
//		FoodCateDto dto = mapper.selectCateByIndex(i);
//		String fileName = mapper.selectFileNameByCateIndex(i);
//		dto.setFileName(fileName);
//		return dto;
//	}

	// 카테고리 수정 메소드
	@Transactional
	public boolean updateCate(FoodCateDto dto, String nowFileName, MultipartFile modifyFile) {
		// 파일 수정 메소드
		modifyFile(dto, nowFileName, modifyFile);
		
		// 카테고리명 변경
		int cnt = mapper.updateCate(dto);
		System.out.println("카테고리수정 성공");
		return cnt == 1;
	}
	
	// 카테고리명이 같을때 File 레코드만 수정하는 메소드
	public boolean updateCateFile(FoodCateDto dto, String nowFileName, MultipartFile modifyFile) {
		// 파일 수정 메소드
		modifyFile(dto, nowFileName, modifyFile);
		return true;
	}

	// 공통 파일 수정 메소드 분리
	public void modifyFile(FoodCateDto dto, String nowFileName, MultipartFile modifyFile) {
		// 기존 파일 삭제
		System.out.println("카테고리 인덱스 번호 : " + dto.getCateIndex());
		if (nowFileName != null) {
			deleteFromAwsS3(dto.getCateIndex(), nowFileName);
		}
		// 삭제한 File 테이블 컬럼 추가 및 파일 등록
		if (modifyFile != null) {
			// File 테이블 레코드 삭제
			mapper.deleteCateFileByCateIndex(dto.getCateIndex(), nowFileName);
			// File 테이블 레코드 추가
			mapper.insertCateFile(dto.getCateIndex(), modifyFile.getOriginalFilename());
			saveFileAwsS3(dto.getCateIndex(), modifyFile); // s3에 업로드
			System.out.println("파일수정 성공");
		}
	}
	
	// 카테고리 삭제 메소드
	@Transactional
	public boolean deleteCate(int cateIndex) {
		// 파일 목록 읽기
		String fileName = mapper.selectFileNameByCateIndex(cateIndex);
		System.out.println("카테고리 삭제 파일명 : " + fileName);
		System.out.println("카테고리 인덱스명 : " + cateIndex);
		
		// s3에서 지우기
		deleteFromAwsS3(cateIndex, fileName);
		
		// 파일 테이블 삭제
		mapper.deleteFileByCateIndex(cateIndex);
		
		// 카테고리 음식 리스트 삭제
		mapper.deleteFilelistByCateIndex(cateIndex);
		
		// 카테고리 테이블 삭제
		return mapper.deleteCate(cateIndex) == 1;
	}

	// 카테고리 페이지의 인덱스 번호를 이용해 DTO 입력 메소드
	public FoodCateDto selectCateDto(int cateIndex) {
		return mapper.selectCateDto(cateIndex);
	}
	
	// 인덱스 번호로 음식 페이지 가져오는 메소드
	public FoodDto getPageByIndex(int foodIndex) {
		return mapper.selectFoodDto(foodIndex);
	}

	// 음식 테이블 추가 메소드
	public boolean addFoodTable(FoodDto dto) {
		return mapper.insertFood(dto) == 1;
	}

	// 카테고리명 중복검사 메소드
	public String selectCateName(String cateName) {
		return mapper.selectCateName(cateName);
	}
	
	// 인덱스 번호로 이름을 가져와 수정할 카테고리명과 비교하기위한 메소드
	public String selectCateNameByIndex(int cateIndex) {
		return mapper.selectCateNameByIndex(cateIndex);
	}

	// 음식명 중복 검사 메소드
	public String selectFoodName(String foodName) {
		return mapper.selectFoodName(foodName);
	}

	// foodIndex 번호로 하위 레시피 리스트 호출
	public List<SubFoodDto> getSubDtoList(int foodIndex) {
		return mapper.selectSubFoodList(foodIndex);
	}

	// subRecipeIndex 번호로 추천수 합계 계산
	public int getVoteSum(int subRecipeIndex) {
		return mapper.selectVoteSum(subRecipeIndex);
	}
	
	// subRecipeIndex에 해당하는 memberId의 추천수 가져오기 
	public int getVoteNum(VoteDto dto, Principal principal) {
		return mapper.selectVoteNum(dto.getSubRecipeIndex(), principal.getName());
	}

	// 추천 버튼 누를때 서비스
	public boolean setVoteNum(VoteDto dto, int voteNum, Principal principal) {
		return mapper.updateVoteNum(dto.getSubRecipeIndex(), voteNum, principal.getName()) == 1;
	}

	// 음식 테이블 수정 서비스
	public boolean updateFoodTable(FoodDto dto) {
		int cnt = mapper.updateFood(dto);
		return cnt == 1;
	}

	// 레시피 DTO 요청 서비스
	public SubFoodDto getRecipeByIndex(int subRecipeIndex) {
		return mapper.selectSubFoodDto(subRecipeIndex);
	}

	// 레시피 테이블 수정 서비스
	public boolean updateRecipeTable(SubFoodDto dto) {
		int cnt = mapper.updateRecipe(dto);
		return cnt == 1;
	}

	// 카테고리 이름 검색 서비스
	public List<FoodCateDto> getSearchCateList(String keyword) {
		return mapper.selectSearchCateList("%"+keyword+"%");
	}
	
	// 음식 이름 검색 서비스
	public List<FoodDto> getSearchFoodList(String keyword) {
		return mapper.selectSearchFoodList("%"+keyword+"%");
	}
	
	// 레시피 검색 서비스
	public List<SubFoodDto> getSearchRecipeList(String keyword) {
		return mapper.selectSearchRecipeList("%"+keyword+"%");
	}

	// 레시피 삭제 서비스
	@Transactional
	public boolean deleteRecipeTable(SubFoodDto dto) {
		mapper.deleteVote(dto);
		int cnt = mapper.deleteRecipe(dto);
		return cnt == 1;
	}

	public boolean addRecipe(SubFoodDto dto) {
		int cnt = mapper.insertRecipe(dto);
		return cnt == 1;
	}

}