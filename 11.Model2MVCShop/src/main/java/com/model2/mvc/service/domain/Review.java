package com.model2.mvc.service.domain;

public class Review {

	private int reviewNo;
	private User buyer;
	private Product reviewProd;
	private String fileName;
	private String reviewText;
	private String evaluation;
	private String password;
	private String title;

	public Review() {
	}

	public int getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}

	public User getBuyer() {
		return buyer;
	}

	public void setBuyer(User buyer) {
		this.buyer = buyer;
	}

	public Product getReviewProd() {
		return reviewProd;
	}

	public void setReviewProd(Product reviewProd) {
		this.reviewProd = reviewProd;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getReviewText() {
		return reviewText;
	}

	public void setReviewText(String reviewText) {
		this.reviewText = reviewText;
	}

	public String getEvaluation() {
		return evaluation;
	}

	public void setEvaluation(String evaluation) {
		this.evaluation = evaluation;
	}

	
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Override
	public String toString() {
		return "Review [reviewNo=" + reviewNo + ", buyer=" + buyer + ", reviewProd=" + reviewProd + ", fileName="
				+ fileName + ", reviewText=" + reviewText + ", evaluation=" + evaluation + ", password=" + password
				+ ", title=" + title + "]";
	}

	

	

}
