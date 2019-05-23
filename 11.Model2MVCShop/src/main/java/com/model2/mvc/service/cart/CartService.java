package com.model2.mvc.service.cart;

import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Cart;
import com.model2.mvc.service.domain.Product;

public interface CartService {

	public void addCart(Cart cart) throws Exception;

	public Cart getCart(int cartNo) throws Exception;

	public Cart getCart2(int prodNo, String buyerId) throws Exception;

	public void updateCart(Cart cart) throws Exception;

	public Map<String, Object> getCartList(Search search, String buyerId) throws Exception;

	public void deleteCart(int cartNo) throws Exception;
}
