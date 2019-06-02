package com.model2.mvc.service.qa.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Qa;
import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.qa.QaDao;
import com.model2.mvc.service.review.ReviewDao;

@Repository("qaDaoImpl")
public class QaDaoImpl implements QaDao{
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public QaDaoImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public void addQa(Qa qa) throws Exception {
		sqlSession.insert("QaMapper.addQa",qa);
	}

	@Override
	public Qa getQa(int qaNo) throws Exception {
		return sqlSession.selectOne("QaMapper.getQa",qaNo);
	}

	@Override
	public List<Qa> getQaList(Search search, String buyerId, int prodNo) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("buyerId",  buyerId );
		map.put("prodNo",  prodNo );
		map.put("endRowNum",  search.getEndRowNum()+"" );
		map.put("startRowNum",  search.getStartRowNum()+"" );
		return sqlSession.selectList("QaMapper.getQaList",map);
	}

	@Override
	public void updateQa(Qa qa) throws Exception {
		sqlSession.update("QaMapper.updateQa",qa);	
	}

	@Override
	public void deleteQa(int qaNo) throws Exception {
		sqlSession.delete("QaMapper.deleteQa",qaNo);
	}

	@Override
	public int getTotalCount( String buyerId, int prodNo) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("buyerId",  buyerId );
		map.put("prodNo",  prodNo );
		return sqlSession.selectOne("QaMapper.getTotalCount",map);
	}

	@Override
	public Qa pwCheckQa(int qaNo, String password) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("qaNo",qaNo);
		map.put("password", password);
		return sqlSession.selectOne("ReviewMapper.pwCheckReview",map);
	}

}
