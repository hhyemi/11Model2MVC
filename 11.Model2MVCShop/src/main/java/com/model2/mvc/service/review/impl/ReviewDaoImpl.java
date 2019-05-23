package com.model2.mvc.service.review.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.review.ReviewDao;

@Repository("reviewDaoImpl")
public class ReviewDaoImpl implements ReviewDao{
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public ReviewDaoImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public void addReview(Review review) throws Exception {
		sqlSession.insert("ReviewMapper.addReview",review);
	}

	@Override
	public Review getReview(int reviewNo) throws Exception {
		return sqlSession.selectOne("ReviewMapper.getReview",reviewNo);
	}

	@Override
	public List<Review> getReviewList(Search search, String buyerId, int prodNo) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("buyerId",  buyerId );
		map.put("prodNo",  prodNo );
		map.put("endRowNum",  search.getEndRowNum()+"" );
		map.put("startRowNum",  search.getStartRowNum()+"" );
		return sqlSession.selectList("ReviewMapper.getReviewList",map);
	}

	@Override
	public void updateReview(Review review) throws Exception {
		sqlSession.update("ReviewMapper.updateReview",review);	
	}

	@Override
	public void deleteReview(int reviewNo) throws Exception {
		sqlSession.delete("ReviewMapper.deleteReview",reviewNo);
	}

	@Override
	public int getTotalCount( String buyerId, int prodNo) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("buyerId",  buyerId );
		map.put("prodNo",  prodNo );
		return sqlSession.selectOne("ReviewMapper.getTotalCount",map);
	}

	@Override
	public Review pwCheckReview(int reviewNo, String password) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("reviewNo",reviewNo);
		map.put("password", password);
		return sqlSession.selectOne("ReviewMapper.pwCheckReview",map);
	}

}
