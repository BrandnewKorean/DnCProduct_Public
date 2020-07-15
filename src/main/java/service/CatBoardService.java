package service;

import java.util.List;

import vo.CatBoardVO;

public interface CatBoardService {
	
	List<CatBoardVO> selectList(); // selectList
	
	CatBoardVO selectOne(CatBoardVO bv); // selectOne
	
	int countUp(CatBoardVO bv); // countUp
	
	int insert(CatBoardVO bv); // insert

} // interface