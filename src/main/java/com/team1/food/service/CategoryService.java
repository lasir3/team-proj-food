package com.team1.food.service;

import java.io.IOException;
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

	public List<FoodCateDto> foodCateList() {
		return mapper.selectCateList();
	}

	public List<FoodDto> foodList(String cateName) {
		return mapper.selectFoodList(cateName);
	}

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
	private void deleteFromAwsS3(int id, MultipartFile file) {
		String key = "board/" + id + "/" + file;
		
		DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder()
				.bucket(bucketName)
				.key(key)
				.build();
		s3.deleteObject(deleteObjectRequest);
	}
//	// 파일 등록 메소드 추출
//	public void addFiles(int id, MultipartFile files, String tableName) {
//		if (files != null) {
//			for	(MultipartFile file : files) {
//				if (file.getSize() > 0) {
//					mapper.insertFile(id, file.getOriginalFilename(), tableName);
//					saveFileAwsS3(id, file, tableName); // s3에 업로드
//				}
//			}
//		}
//	}

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


}
