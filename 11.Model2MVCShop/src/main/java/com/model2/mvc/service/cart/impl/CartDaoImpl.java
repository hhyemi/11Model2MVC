package com.model2.mvc.service.cart.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.cart.CartDao;
import com.model2.mvc.service.domain.Cart;
import com.model2.mvc.service.domain.Product;

@Repository("cartDaoImpl")
public class CartDaoImpl implements CartDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public CartDaoImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public Cart getCart(int cartNo) throws Exception {
		return sqlSession.selectOne("CartMapper.getCart", cartNo);
	}
	
	@Override
	public Cart getCart2(int prodNo, String buyerId) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("prodNo",  prodNo );
		map.put("buyerId",  buyerId );
		//System.out.println("Dddddddddddddddddddd"+(sqlSession.selectOne("CartMapper.getCart2",map).toString()));
		return sqlSession.selectOne("CartMapper.getCart2",map);
	}

	@Override
	public void addCart(Cart cart) throws Exception {
		sqlSession.insert("CartMapper.addCart", cart);
	}
	
	@Override
	public int getTotalCount(String buyerId) throws Exception {
		return sqlSession.selectOne("CartMapper.getTotalCount", buyerId);
	
	}

	@Override
	public void deleteCart(int cartNo) throws Exception {
		sqlSession.delete("CartMapper.deleteCart", cartNo);
	}

	@Override
	public List<Cart> getCartList(Search search, String buyerId) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("buyerId",  buyerId );
		map.put("endRowNum",  search.getEndRowNum()+"" );
		map.put("startRowNum",  search.getStartRowNum()+"" );
		return sqlSession.selectList("CartMapper.getCartList", map);
		
	}

	@Override
	public void updateCart(Cart cart) throws Exception {
		sqlSession.update("CartMapper.updateCart", cart);
	}




}
