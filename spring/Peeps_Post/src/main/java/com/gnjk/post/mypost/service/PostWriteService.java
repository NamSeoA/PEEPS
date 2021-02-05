package com.gnjk.post.mypost.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gnjk.post.mypost.dao.PostDao;
import com.gnjk.post.mypost.domain.Post;
import com.gnjk.post.mypost.domain.PostFile;
import com.gnjk.post.mypost.domain.PostWriteRequest;

@Service
public class PostWriteService {

	private PostDao dao;
	
	@Autowired
	private SqlSessionTemplate template;
	
	// 데이터베이스 저장
	public int postWrite(
			PostWriteRequest writeRequest, 
			MultipartHttpServletRequest request
			) {	
		int postResult = 0;
		
		Post post = writeRequest.toPost();
		
		try {
		// 데이터베이스 입력
		dao = template.getMapper(PostDao.class);
		
		// 게시글 DB insert
		postResult = dao.insertPost(post);
		} catch (Exception e) {
			System.out.println("게시글 저장 실패");
			e.printStackTrace();
		}
		
		// 파일 업로드 처리 시작
		int postFileResult = 0;
		String newFileName = null;
		File newFile = null;
		
//		System.out.println("!!!!!request.getFiles(postfile): " + request.getFiles("postfile"));
		if(
				request.getFiles("postfile") !=null 
				&& !request.getFiles("postfile").isEmpty()
				&& postResult > 0
				) {
			System.out.println("!!!파일 업로드 if구문 진입");
			List<MultipartFile> postfileList = request.getFiles("postfile");
			// 웹 경로
			String uploadPath = "/resources/fileupload/postfile";
			// 실제 경로
			String saveDirPath = request.getSession().getServletContext().getRealPath(uploadPath);
			
			for (MultipartFile mf : postfileList) {
				newFileName = writeRequest.getUserIdx() 
						+ post.getP_idx()	// 방금 insert된 게시글 idx
						+ mf.getOriginalFilename()
						+ System.currentTimeMillis();
				System.out.println("newFileName : "+newFileName);
				
				try {
					// 실제 경로에 저장
					mf.transferTo(newFile = new File(saveDirPath, newFileName));
					
					PostFile postFile = new PostFile();
					postFile.setF_name(newFileName);
					postFile.setPost_idx(post.getP_idx());

					System.out.println("!!!postFile : "+postFile);
					postFileResult = dao.insertFiles(postFile);
					System.out.println("!!!!postFileResult : "+postFileResult);
					
				} catch (Exception e) {
					e.printStackTrace();
					// 현재 저장된 파일 있을 경우 삭제
					if(newFile != null && newFile.exists()) {
						newFile.delete();
					}
				}
			} // foreach end
			
		} 
		
		return postResult;
	}
	
}