package com.model2.mvc.service.product;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;

public interface ProductDAO {

	//��ǰ ���
	public void addProduct(Product product) throws Exception;
	
	//��ǰ ��ȸ
	public Product getProduct(int prodNo) throws Exception;
	
	//��ǰ ����Ʈ ��ȸ
	public Map<String,Object> getProductList(Search search) throws Exception;

	//��ǰ ���� ����
	public void updateProduct(Product product) throws Exception;
	
	//list count
	public int getTotalCount(Search search) throws Exception ;
	
	//��ǰ comment ��ȸ
	public Map<String, Object> getProductComment(int prodNo) throws Exception;
}
