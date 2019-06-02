package com.model2.mvc.service.qa;

import java.util.List;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Qa;
import com.model2.mvc.service.domain.Review;

public interface QaDao {

	public void addQa(Qa qa) throws Exception;
	
	public Qa getQa(int qaNo) throws Exception;
	
	public List<Qa> getQaList(Search search, String buyerId, int prodNo) throws Exception;
	
	public void updateQa(Qa qa) throws Exception;
	
	public void deleteQa(int qaNo) throws Exception;
	
	public int getTotalCount( String buyerId, int prodNo) throws Exception;
	
	public Qa pwCheckQa(int qaNo,String password) throws Exception;
	

}
