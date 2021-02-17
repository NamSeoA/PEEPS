package com.gnjk.post.mypost.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.gnjk.post.mypost.dao.FileDao;
import com.gnjk.post.mypost.dao.PostDao;
import com.gnjk.post.mypost.domain.Post;
import com.gnjk.post.mypost.domain.PostFile;
import com.gnjk.post.mypost.domain.PostWriteRequest;

import net.coobird.thumbnailator.Thumbnailator;

@Service
public class PostUploadService {

	private PostDao dao;
	private FileDao fDao;

	@Autowired
	private SqlSessionTemplate template;

	// 게시글 저장
	public int upload(PostWriteRequest writeRequest, HttpServletRequest request, Model model) {
		int postResult = 0;

		MultipartFile[] files = writeRequest.getPostformfile();

		for (int i = 0; i < files.length; i++) {
			System.out.println(files[i]);
		}
		System.out.println("첫번째 파일 크기 : " + files[0].getSize());
		
		// 웹 경로
		String uploadPath = "/resources/fileupload/postfile";
		// 실제 경로
		String saveDirPath = request.getSession().getServletContext().getRealPath(uploadPath);
		String fileName = "";
		String newFileName = "";
		File newFile = null;

		// 게시글 데이터 바인딩
		Post post = writeRequest.toPost();
		System.out.println("게시글 제목 :" + post.getP_title());
		System.out.println("위치 주소 : " + post.getP_loc());

		try {
			// 데이터베이스 입력
			dao = template.getMapper(PostDao.class);

			// 게시글 DB insert
			postResult = dao.insertPost(post);

			// 속성에 저장 -> 나중에 확인해서 출력
			model.addAttribute("result", postResult);

		} catch (Exception e) {
			System.out.println("게시글 저장 실패");
			e.printStackTrace();
		}

		// test 게시글 idx 확인
		int postidx = post.getP_idx();
		System.out.println("방금 저장된 게시글의 idx : " + postidx);

		// 이미지 파일 저장 시작
		if (postResult > 0 && files[0].getSize() > 0) {
			System.out.println("파일 if구문 진입");

			String thumbnailFname = files[0].getOriginalFilename();

			for (MultipartFile mf : files) {

				fileName = mf.getOriginalFilename(); // 파일 이름
				// System.out.println("fileName : " + fileName);
				newFileName = System.currentTimeMillis() + fileName;

				// 첫번째 파일 이름을 게시글 썸네일 이름으로 설정
				if (mf.getOriginalFilename() == thumbnailFname) {
					post.setP_thumbnail(newFileName);
				}

				try {
					// 디렉토리에 저장
					mf.transferTo(newFile = new File(saveDirPath, newFileName));

					PostFile postFile = new PostFile();
					postFile.setF_name(newFileName);
					postFile.setPost_idx(post.getP_idx());

					System.out.println("!!!postFile : " + postFile);

					// 파일 DB insert
					fDao = template.getMapper(FileDao.class);
					int postFileResult = fDao.insertFiles(postFile);
					System.out.println("!!postFileResult : " + postFileResult);
					
					
				} catch (Exception e) {
					e.printStackTrace();
					// 현재 저장된 파일 있을 경우 삭제
					if (newFile != null && newFile.exists()) {
						newFile.delete();
					}
				}
			} // foreach end
			
			// 게시글 썸네일 db update
			dao.updatePostThumbnail(post.getP_idx(), post.getP_thumbnail());
		} // 파일 저장 시작 if end

		

		return postResult;
	}

}