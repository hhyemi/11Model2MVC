package com.model2.mvc.service.qa.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Cart;
import com.model2.mvc.service.domain.Qa;
import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.qa.QaDao;
import com.model2.mvc.service.qa.QaService;
import com.model2.mvc.service.review.ReviewDao;
import com.model2.mvc.service.review.ReviewService;

@Service("qaServiceImpl")
public class QaServiceImpl implements QaService{

	@Autowired
	@Qualifier("qaDaoImpl")
	private QaDao qaDao;

	public void setQaDao(QaDao qaDao) {
		this.qaDao = qaDao;
	}

	public QaServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public void addQa(Qa qa) throws Exception {
		qaDao.addQa(qa);

	}

	@Override
	public Qa getQa(int qaNo) throws Exception {
		return qaDao.getQa(qaNo);
	}

	@Override
	public Map<String, Object> getQaList(Search search, String buyerId, int prodNo) throws Exception {
		List<Qa> list = qaDao.getQaList(search, buyerId, prodNo);
		int totalCount = qaDao.getTotalCount(buyerId, prodNo);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));

		return map;
	}

	@Override
	public void updateQa(Qa qa) throws Exception {
		qaDao.updateQa(qa);
	}

	@Override
	public void deleteQa(int qaNo) throws Exception {
		qaDao.deleteQa(qaNo);
	}

	@Override
	public Qa pwCheckQa(int qaNo, String password) throws Exception {
		return qaDao.pwCheckQa(qaNo, password);
	}

}
