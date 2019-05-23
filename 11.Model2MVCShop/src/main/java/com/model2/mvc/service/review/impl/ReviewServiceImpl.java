package com.model2.mvc.service.review.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Cart;
import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.review.ReviewDao;
import com.model2.mvc.service.review.ReviewService;

@Service("reviewServiceImpl")
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	@Qualifier("reviewDaoImpl")
	private ReviewDao reviewDao;

	public void setReviewDao(ReviewDao reviewDao) {
		this.reviewDao = reviewDao;
	}

	public ReviewServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public void addReview(Review review) throws Exception {
		reviewDao.addReview(review);

	}

	@Override
	public Review getReview(int reviewNo) throws Exception {
		return reviewDao.getReview(reviewNo);
	}

	@Override
	public Map<String, Object> getReviewList(Search search, String buyerId, int prodNo) throws Exception {
		List<Review> list = reviewDao.getReviewList(search, buyerId, prodNo);
		int totalCount = reviewDao.getTotalCount(buyerId, prodNo);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));

		return map;
	}

	@Override
	public void updateReview(Review review) throws Exception {
		reviewDao.updateReview(review);
	}

	@Override
	public void deleteReview(int reviewNo) throws Exception {
		reviewDao.deleteReview(reviewNo);
	}

	@Override
	public Review pwCheckReview(int reviewNo, String password) throws Exception {
		return reviewDao.pwCheckReview(reviewNo, password);
	}

}
