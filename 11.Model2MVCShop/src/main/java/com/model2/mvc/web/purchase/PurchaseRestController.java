package com.model2.mvc.web.purchase;


import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchase.PurchaseService;


//==> 회원관리 RestController
@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	//setter Method 구현 않음
		
	public PurchaseRestController(){
		System.out.println(this.getClass());
	}
	
	@RequestMapping( value="json/updateTranCode", method=RequestMethod.POST)
	public String updateTranCode(@RequestBody Map<String, Object> map) throws Exception{
		
		System.out.println("json/updateTranCode ::: START");
		String prodNo = map.get("prodNo").toString();
		String tranNo = map.get("tranNo").toString();
		String tranCnt = map.get("tranCnt").toString();
		String tranCode = map.get("tranCode").toString();
		
		Product product = new Product();
		product.setProdNo(Integer.parseInt(prodNo));
		
		Purchase purchase = new Purchase();
		purchase.setTranNo(Integer.parseInt(tranNo));
		purchase.setTranCnt(Integer.parseInt(tranCnt));
		purchase.setTranCode(tranCode);
		purchase.setPurchaseProd(product);
		
		purchaseService.updateTranCode(purchase);
		
		return "1";
	}
}