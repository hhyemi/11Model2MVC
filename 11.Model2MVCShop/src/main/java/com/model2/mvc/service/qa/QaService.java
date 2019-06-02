package com.model2.mvc.service.qa;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Qa;
import com.model2.mvc.service.domain.Review;

public interface QaService {

	public void addQa(Qa qa) throws Exception;
	
	public Qa getQa(int qaNo) throws Exception;

	public Map<String, Object> getQaList(Search search, String buyerId, int prodNo) throws Exception;

	public void updateQa(Qa qa) throws Exception;
	
	public void deleteQa(int qaNo) throws Exception;

	public Qa pwCheckQa(int qaNo,String password) throws Exception;
	
}
