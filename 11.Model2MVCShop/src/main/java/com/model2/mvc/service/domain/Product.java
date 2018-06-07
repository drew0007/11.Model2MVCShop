package com.model2.mvc.service.domain;

import java.sql.Date;


public class Product {
	
	private String fileName;		//	������ϸ�
	private String[] fileNameList;
	private String manuDate;		//	������
	private int price;				//	����
	private String prodDetail;		//	��ǰ������
	private String prodName;		//	��ǰ��
	private int prodNo;				//	��ǰ��ȣ
	private Date regDate;			//	�����
	private String prodTranCode;	//	��ǰ����
	private int prodCnt;			//	������
	private double scoreAvg;			//	����
	
	public Product(){
	}
	
	public String getProdTranCode() {
		return prodTranCode;
	}
	public void setProdTranCode(String prodTranCode) {
		this.prodTranCode = prodTranCode;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
		if(fileName != null && fileName.length() !=0 ){
			this.fileNameList = fileName.split("/");
		}
	}
	public String[] getFileNameList() {
		return fileNameList;
	}

	public void setFileNameList(String[] fileNameList) {
		this.fileNameList = fileNameList;
	}

	public String getManuDate() {
		return manuDate;
	}
	public void setManuDate(String manuDate) {
		this.manuDate = manuDate;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getProdDetail() {
		return prodDetail;
	}
	public void setProdDetail(String prodDetail) {
		this.prodDetail = prodDetail;
	}
	public String getProdName() {
		return prodName;
	}
	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	public int getProdNo() {
		return prodNo;
	}
	public void setProdNo(int prodNo) {
		this.prodNo = prodNo;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public int getProdCnt() {
		return prodCnt;
	}

	public void setProdCnt(int prodCnt) {
		this.prodCnt = prodCnt;
	}

	public double getScoreAvg() {
		return scoreAvg;
	}

	public void setScoreAvg(double scoreAvg) {
		this.scoreAvg = scoreAvg;
	}

	// Override
	public String toString() {
		return "Product : [fileName]" + fileName
				+ "[manuDate]" + manuDate+ "[price]" + price + "[prodDetail]" + prodDetail
				+ "[prodName]" + prodName + "[prodNo]" + prodNo + "[prodTranCode]" + prodTranCode
				+ "[prodCnt]" + prodCnt + "[regDate]" + regDate + "[scoreAvg]" + scoreAvg;
	}
}