package com.model2.mvc.web.review;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.review.ReviewService;

@RestController
@RequestMapping("/review/*")
public class ReviewRestController {

	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;

	public ReviewRestController() {
		System.out.println(this.getClass());
	}

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	@RequestMapping(value = "json/getReview/{reviewNo}", method = RequestMethod.GET)
	public Review getReview(@PathVariable int reviewNo) throws Exception {

		System.out.println("/review/json/getReview : GET");

		Review review = reviewService.getReview(reviewNo);
		System.out.println(review + "zzzzzzzzzzzzz");

		return reviewService.getReview(reviewNo);
	}

	@RequestMapping(value="json/PWCheckReview",method=RequestMethod.POST)	
	public boolean PWCheckReview(@RequestBody Review review) throws Exception{

		System.out.println("/review/json/PWCheckReview : GET");
		
		Review review2 = reviewService.pwCheckReview(review.getReviewNo(), review.getPassword());
		
		if(review2 != null) {
			return false;
		}else {
			return true;
		}
	
	}

}
