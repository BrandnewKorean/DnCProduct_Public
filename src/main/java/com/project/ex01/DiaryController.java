package com.project.ex01;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import service.DiaryService;
import service.DiaryUploadService;
import vo.DiaryUploadVO;
import vo.DiaryVO;

@Controller
public class DiaryController {
	
	@Autowired
	DiaryService service;
	@Autowired
	DiaryUploadService uservice;
	
	@RequestMapping(value = "diaryf")
	public ModelAndView diaryf(ModelAndView mv) {
		mv.setViewName("cat/diary/DiaryForm");
		return mv;
	}
	
	@RequestMapping(value = "diary")
	public ModelAndView diary(HttpServletRequest request, ModelAndView mv, DiaryVO dv) {
		String id = (String)request.getSession().getAttribute("logID");
		DiaryUploadVO duv = new DiaryUploadVO();
		
		List<DiaryUploadVO> uploadlist;
		
		if(id != null) {
			dv.setId(id);
			dv = service.selectOne(dv);
			if(dv != null) {
				duv.setWdate(dv.getWdate());
				duv.setId(id);
				uploadlist = uservice.selectList(duv);
				mv.addObject("uploadlist", uploadlist);
				mv.addObject("code", 0);
			}else {
				mv.addObject("code", 1);
			}
		}else {
			mv.addObject("code", 2);
		}
		
		mv.addObject("dv", dv);
		mv.setViewName("jsonView");
		return mv;
	}
	
	@RequestMapping(value = "iswrited")
	public ModelAndView iswrited2(HttpServletRequest request, ModelAndView mv, DiaryVO dv) {
		String id = (String)request.getSession().getAttribute("logID");
		List<String> writed = new ArrayList<String>();
		
		System.out.println(dv.getStart());
		System.out.println(dv.getEnd());
		List<DiaryVO> list;
		
		if(id != null) {
			dv.setId(id);
			list = service.selectList(dv);
			System.out.println(list);
			for(int i=0;i<list.size();i++) {
				if(list.get(i) != null) {
					writed.add(list.get(i).getWdate());
				}
			}
		}else {
			writed = null;
		}
		mv.addObject("writed", writed);
		mv.setViewName("jsonView");
		return mv;
	}
	
	@RequestMapping(value = "diarywrite", method=RequestMethod.POST)
	public ModelAndView diarywrite(HttpServletRequest request, MultipartFile files, ModelAndView mv, DiaryVO dv) throws IllegalStateException, IOException {
		String id = (String)request.getSession().getAttribute("logID");
		DiaryUploadVO duv = new DiaryUploadVO();
		
		int count;
		if(id != null) {
			dv.setId(id);
			count = service.insert(dv);
			if(count > 0) {
				if(!files.isEmpty()) {
					String filename = dv.getWdate()+"_"+dv.getId()+"_"+files.getOriginalFilename();
					duv.setWdate(dv.getWdate());
					duv.setId(id);
					duv.setFilename(filename);
					String route = "C:/MTest/MyWork/ProjectEx01/src/main/webapp/resources/diaryupload/";
					files.transferTo(new File(route+filename));
					if(uservice.insert(duv) > 0) {
						mv.addObject("code", 0);
					}else {
						mv.addObject("code", 1);
					}
				}
			}else {
				mv.addObject("code", 2);
			}
		}else {
			mv.addObject("code", 3);
		}
		
		mv.setViewName("jsonView");
		return mv;
	}
	
	@RequestMapping(value = "diarydelete")
	public ModelAndView diarydelete(HttpServletRequest request, ModelAndView mv, DiaryVO dv) {
		String id = (String)request.getSession().getAttribute("logID");
		int count;
		
		if(id != null) {
			dv.setId(id);
			count = service.delete(dv);
			if(count > 0) {
				mv.addObject("code", 0);
			}else {
				mv.addObject("code", 1);
			}
		}else {
			mv.addObject("code", 2);
		}
		
		mv.setViewName("jsonView");
		return mv;
	}
	
	@RequestMapping(value = "diaryupdate")
	public ModelAndView diaryupdate(HttpServletRequest request, ModelAndView mv, DiaryVO dv) {
		String id = (String)request.getSession().getAttribute("logID");
		int count;
		
		if(id != null) {
			dv.setId(id);
			count = service.update(dv);
			if(count > 0) {
				mv.addObject("code", 0);
			}else {
				mv.addObject("code", 1);
			}
		}else {
			mv.addObject("code", 2);
		}
		
		mv.setViewName("jsonView");
		return mv;
	}
}