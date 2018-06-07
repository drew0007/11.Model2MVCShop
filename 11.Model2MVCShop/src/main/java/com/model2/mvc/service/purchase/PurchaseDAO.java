package com.model2.mvc.service.purchase;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;


public interface PurchaseDAO {

	//���� ��û	
	public int addPurchase(List<Purchase> list) throws Exception;

	//���� �� ��ȸ
	public Map<String,Object> getPurchase(int tranNo) throws Exception;

	//���� ����Ʈ ��ȸ
	public Map<String,Object> getPurchaseList(Search search,String buyerId) throws Exception;

	//�Ǹ� ����Ʈ ��ȸ
	public Map<String,Object> getSaleList(Search search,int prodNo) throws Exception;

	//���� ���� ����
	public void updatePurchase(Purchase purchase) throws Exception;
	
	//�����ı�
	public void updatePurchaseComment(Purchase purchase) throws Exception;

	//��� ���� ����
	public void updateTranCode(Purchase purchase) throws Exception;
	
	//list count
	public int getTotalCount(Search search) throws Exception ;
	
	//���� �ı�
	public Purchase getCommentPurchase(int tranNo, int prodNo) throws Exception;
	
}