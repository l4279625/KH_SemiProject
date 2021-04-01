package com.board.biz;

import java.util.List;

import com.board.dto.BoardDto;

public interface BoardBiz {

	public List<BoardDto> accompany_selectList();
	public List<BoardDto> notice_selectList();
	public List<BoardDto> photo_selectList();
	public BoardDto accompany_selectOne(int postId);
	public BoardDto photo_selectOne(int postId);
	public BoardDto notice_selectOne(int postId);
	public int insert(BoardDto dto);
	public int update(BoardDto dto);
	public int delete(int postId);
	public int multiDelete(String[] postIds);
	
}
