package com.model2.mvc.web.cart;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.cart.CartService;
import com.model2.mvc.service.domain.Cart;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;

//==> 회원관리 Controller
@Controller
@RequestMapping("/cart/*")
public class CartController {

	/// Field
	@Autowired
	@Qualifier("cartServiceImpl")
	private CartService cartService;

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	// setter Method 구현 않음

	public CartController() {
		System.out.println(this.getClass());
	}

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	@Value("#{commonProperties['fileroot']}")
	String fileroot;

	@RequestMapping(value = "addCart", method = RequestMethod.GET)
	public ModelAndView addCart(@RequestParam("prod_no") int prodNo, HttpSession session) throws Exception {

		System.out.println("/cart/addCart : GET");

		User user = (User) session.getAttribute("user");

		Product product = productService.getProduct(prodNo);

		Cart cart = new Cart();
		cart.setBuyer(user);
		cart.setCartProd(product);

		Cart cart2 = cartService.getCart2(prodNo, user.getUserId());

		if (cart2 == null) {
			cart.setCartCount(1);
			cartService.addCart(cart);
		} else {
			cartService.updateCart(cart2);
		}


		return new ModelAndView("forward:/product/getProduct?menu=search&prodNo=" + prodNo);
	}

/*	@RequestMapping(value = "getCart")
	public ModelAndView getCart(HttpServletRequest request, HttpServletResponse response,
			@RequestParam("cartNo") int cartNo) throws Exception {

		System.out.println("/cart/getCart ");
		Cart cart = cartService.getCart(cartNo);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("cart", cart);

		modelAndView.setViewName("forward:/product/getCart.jsp");
		return modelAndView;

	}
*/
	@RequestMapping(value = "listCart")
	public ModelAndView listCart(@ModelAttribute("search") Search search, HttpServletRequest request,
			HttpSession session) throws Exception {

		System.out.println("/cart/listCart : GET / POST");

		String originSearch = null;

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		User user = (User) session.getAttribute("user");

		Map<String, Object> map = cartService.getCartList(search, user.getUserId());

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);
		System.out.println(resultPage);

		search.setSearchKeyword(originSearch);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.setViewName("forward:/product/listCart.jsp");

		return modelAndView;
	}

	@RequestMapping(value = "deleteCart")
	public ModelAndView deleteCart(@ModelAttribute("search") Search search,
			@RequestParam("cartNo") String cartNo, HttpSession session) throws Exception {

		System.out.println("/cart/deleteCart");

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);


		cartService.deleteCart(cartNo);

		User user = (User) session.getAttribute("user");

		Map<String, Object> map = cartService.getCartList(search, user.getUserId());

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);
		System.out.println(resultPage);

		ModelAndView modelAndView = new ModelAndView();

		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.setViewName("forward:/product/listCart.jsp");

		return modelAndView;
	}

}
