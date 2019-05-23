package com.model2.mvc.service.review;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Review;

public interface ReviewService {

	public void addReview(Review review) throws Exception;

	public Review getReview(int reviewNo) throws Exception;

	public Map<String, Object> getReviewList(Search search, String buyerId, int prodNo) throws Exception;

	public void updateReview(Review review) throws Exception;

	public void deleteReview(int reviewNo) throws Exception;

	public Review pwCheckReview(int reviewNo,String password) throws Exception;
	
}
