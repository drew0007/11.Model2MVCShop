package com.model2.mvc.web.cart;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.service.cart.CartService;
import com.model2.mvc.service.domain.Cart;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;


//==> ȸ������ RestController
@RestController
@RequestMapping("/cart/*")
public class CartRestController {
	
	///Field
	@Autowired
	@Qualifier("cartServiceImpl")
	private CartService cartService;
	//setter Method ���� ����
		
	public CartRestController(){
		System.out.println(this.getClass());
	}
	
	@RequestMapping( value="json/updateCart/{cartNo}/{cartCnt}", method=RequestMethod.GET )
	public Cart updateCart(@PathVariable String cartNo,
								@PathVariable String cartCnt) throws Exception{
		
		Cart cart = new Cart();
		cart.setCartNo(Integer.parseInt(cartNo));
		cart.setCartCnt(Integer.parseInt(cartCnt));
		
		return cart;
	}
	
	@RequestMapping( value = "json/addCart", method=RequestMethod.POST)
	public String addCart(@RequestBody Map<String, Object> map,
						  HttpSession session) throws Exception{

		String prodNo = map.get("prodNo").toString();
		String tranCnt = map.get("tranCnt").toString();
		
		User user = (User)session.getAttribute("user");
		
		Product product = new Product();
		product.setProdNo(Integer.parseInt(prodNo));
		
		Cart cart = cartService.getCart(user.getUserId(), Integer.parseInt(prodNo));

		if(cart == null) {
			cart = new Cart();
			cart.setCartCnt(Integer.parseInt(tranCnt));
			cart.setCartProd(product);
			cart.setCartUser(user);
			
			cartService.addCart(cart);
		}else {
			cart.setCartCnt(Integer.parseInt(tranCnt));
			
			cartService.updateCart(cart);
		}
		
		return "1";
	}
}