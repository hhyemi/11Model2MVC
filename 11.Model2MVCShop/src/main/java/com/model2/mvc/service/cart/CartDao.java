package com.model2.mvc.service.cart;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Cart;
import com.model2.mvc.service.domain.Product;

public interface CartDao {

	public List<Cart> getCart(String cartNo) throws Exception;

	public Cart getCart2(int prodNo, String buyerId) throws Exception;

	public void updateCart(Cart cart) throws Exception;

	public void addCart(Cart cart) throws Exception;

	public List<Cart> getCartList(Search search, String buyerId) throws Exception;

	public int getTotalCount(String buyerId) throws Exception;

	public void deleteCart(String cartNo) throws Exception;
}
