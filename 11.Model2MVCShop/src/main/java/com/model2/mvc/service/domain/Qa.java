package com.model2.mvc.service.domain;

import java.sql.Date;

public class Qa {

	private int qaNo;
	private User buyer;
	private Product qaProd;
	private String fileName;
	private String title;
	private String qaText;
	private int pwCheck;
	private String password;
	private Date regDate;

	public Qa() {

	}

	public int getQaNo() {
		return qaNo;
	}

	public void setQaNo(int qaNo) {
		this.qaNo = qaNo;
	}

	public User getBuyer() {
		return buyer;
	}

	public void setBuyer(User buyer) {
		this.buyer = buyer;
	}

	public Product getQaProd() {
		return qaProd;
	}

	public void setQaProd(Product qaProd) {
		this.qaProd = qaProd;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getQaText() {
		return qaText;
	}

	public void setQaText(String qaText) {
		this.qaText = qaText;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public int getPwCheck() {
		return pwCheck;
	}

	public void setPwCheck(int pwCheck) {
		this.pwCheck = pwCheck;
	}

	@Override
	public String toString() {
		return "Qa [qaNo=" + qaNo + ", buyer=" + buyer + ", qaProd=" + qaProd + ", fileName=" + fileName + ", title="
				+ title + ", qaText=" + qaText + ", pwCheck=" + pwCheck + ", password=" + password + ", regDate="
				+ regDate + "]";
	}

}
