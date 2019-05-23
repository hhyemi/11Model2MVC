package com.model2.mvc.web.review;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.review.ReviewService;

//==> 회원관리 Controller
@Controller
@RequestMapping("/review/*")
public class ReviewController {

	/// Field
	@Autowired
	@Qualifier("reviewServiceImpl")
	private  ReviewService reviewService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;

	// setter Method 구현 않음

	public ReviewController() {
		System.out.println(this.getClass());
	}

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	@Value("#{commonProperties['fileroot']}")

	String fileroot;

	@RequestMapping(value = "addReview", method = RequestMethod.GET)
	public ModelAndView addReview(@RequestParam("prodNo") int prodNo,HttpSession session) throws Exception {

		System.out.println("/review/addReview : GET");
		
		User buyer=(User)session.getAttribute("user");
		Product reviewProd = productService.getProduct(prodNo);

		ModelAndView modelAndView = new ModelAndView();
		
		Review review = new Review();
		review.setBuyer(buyer);
		review.setReviewProd(reviewProd);
		
		modelAndView.addObject("review", review);

		modelAndView.setViewName("forward:/review/addReviewView.jsp");
		
		return modelAndView;
	
	}

	@RequestMapping(value = "addReview", method = RequestMethod.POST)
	public String addReview(@ModelAttribute("review") Review review,
			@RequestParam("prodNo") int prodNo,HttpSession session,@RequestParam("uploadFile") MultipartFile uploadFile) throws Exception {

		System.out.println("/review/addReview : POST");

		String fileName = uploadFile.getOriginalFilename();

		File f = new File(fileroot, fileName);
		
		if (f.exists()) {
			f = new File(fileroot, fileName + "(1)");
		}

		try {
			uploadFile.transferTo(f);
		} catch (IOException e) {
			e.printStackTrace();
		}
		review.setFileName(fileName);
		
		User buyer=(User)session.getAttribute("user");
		Product reviewProd = productService.getProduct(prodNo);

		review.setBuyer(buyer);
		review.setReviewProd(reviewProd);
		
		
		reviewService.addReview(review);
		
		return "forward:/review/addReview.jsp";
		


	}
	
	@RequestMapping(value = "listReview")
	public ModelAndView listReview(@ModelAttribute("search") Search search, @RequestParam("prod_no") int prodNo,
			HttpSession session,HttpServletRequest request)
			throws Exception {

		System.out.println("/review/listReview : GET / POST");

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		User buyer=(User)session.getAttribute("user");

		// Business logic 수행
		Map<String, Object> map = reviewService.getReviewList(search, buyer.getUserId(), prodNo);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);
		System.out.println(resultPage);

		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.setViewName("forward:/review/listReview.jsp");

		return modelAndView;
	}
	
	@RequestMapping(value = "getReview")
	public ModelAndView getReview(HttpServletRequest request, HttpServletResponse response,
			@RequestParam("reviewNo") int reviewNo) throws Exception {

		System.out.println("/review/getReview ");
		Review review = reviewService.getReview(reviewNo);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("review", review);

		modelAndView.setViewName("forward:/review/getReview.jsp");
		return modelAndView;
	}


	@RequestMapping(value = "updateReview", method = RequestMethod.GET)
	public String updateReview(@RequestParam("reviewNo") int reviewNo, Model model) throws Exception {

		System.out.println("/review/updateReview : GET");
		// Business Logic
		Review review = reviewService.getReview(reviewNo);

		// Model 과 View 연결
		model.addAttribute("review", review);

		return "forward:/review/updateReviewView.jsp";
	}

	@RequestMapping(value = "updateReview", method = RequestMethod.POST)
	public ModelAndView updateReview(@ModelAttribute("review") Review review,@RequestParam("reviewNo") int reviewNo,
			@RequestParam("uploadFile") MultipartFile uploadFile)
			throws Exception {

		System.out.println("/review/updateReview : POST");

		String fileName = uploadFile.getOriginalFilename();

		File f = new File(fileroot, fileName);
		// 한번에 한해서 동일한 파일이 존재하면 이름에 (1) ,
		// (나중에)2번째에도 검사해서 이름을 편해보고, 확장자 앞에 다른 이름을 추가하도록 해보자
		if (f.exists()) {
			f = new File(fileroot, fileName + "(1)");
		}

		try {
			uploadFile.transferTo(f);
		} catch (IOException e) {
			e.printStackTrace();
		}

		review.setFileName(fileName);

		reviewService.updateReview(review);
		

		return new ModelAndView("redirect:/review/getReview?reviewNo=" + reviewNo);
	}


}
