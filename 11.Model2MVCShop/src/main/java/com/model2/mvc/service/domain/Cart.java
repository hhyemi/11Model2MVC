package com.model2.mvc.service.domain;

public class Cart {

	private int cartNo;
	private User buyer;
	private Product cartProd;
	private int cartCount;

	public Cart() {
	}

	public int getCartNo() {
		return cartNo;
	}

	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}

	public User getBuyer() {
		return buyer;
	}

	public void setBuyer(User buyer) {
		this.buyer = buyer;
	}

	public Product getCartProd() {
		return cartProd;
	}

	public void setCartProd(Product cartProd) {
		this.cartProd = cartProd;
	}

	public int getCartCount() {
		return cartCount;
	}

	public void setCartCount(int cartCount) {
		this.cartCount = cartCount;
	}

	@Override
	public String toString() {
		return "Cart [cartNo=" + cartNo + ", buyer=" + buyer + ", cartProd=" + cartProd + ", cartCount=" + cartCount
				+ "]";
	}

	

}
