package com.model2.mvc.service.purchase.test;

import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.purchase.PurchaseService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
		"classpath:config/context-aspect.xml",
		"classpath:config/context-mybatis.xml",
		"classpath:config/context-transaction.xml" })
public class PurchaseServiceTest {

	// ==>@RunWith,@ContextConfiguration 이용 Wiring, Test 할 instance DI
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;

	 //@Test
	public void testAddPurchase() throws Exception {

		Purchase purchase = new Purchase();

		Product product = new Product();
		product.setProdNo(10006);

		User user = new User();
		user.setUserId("user01");

		purchase.setPurchaseProd(product);
		purchase.setBuyer(user);
		purchase.setPaymentOption("2");
		purchase.setReceiverName("혜미");
		purchase.setReceiverPhone("18");
		purchase.setDivyAddr("성남");
		purchase.setDivyRequest("조심히배달점요");
		purchase.setTranCode("1");
		//purchase.setDivyDate("19950801");

		//purchaseService.addPurchase(purchase);

		// ==> console 확인
		System.out.println(purchase);

		// ==> API 확인
		Assert.assertEquals(10006, purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("user01", purchase.getBuyer().getUserId());
		Assert.assertEquals("2", purchase.getPaymentOption());
		Assert.assertEquals("혜미", purchase.getReceiverName());
		Assert.assertEquals("18", purchase.getReceiverPhone());
		Assert.assertEquals("성남", purchase.getDivyAddr());
		Assert.assertEquals("조심히배달점요", purchase.getDivyRequest());
		Assert.assertEquals("1", purchase.getTranCode());
		//Assert.assertEquals("19950801", purchase.getDivyDate());

	}

	// @Test
	// tranNo으로검색
	public void testGetPurchase() throws Exception {

		Purchase purchase = new Purchase();

		purchase = purchaseService.getPurchase(10051);

		// ==> console 확인
		System.out.println(purchase);

		// ==> API 확인
		Assert.assertEquals(10051, purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("user04", purchase.getBuyer().getUserId());

		String paymentcode = purchase.getPaymentOption().substring(0, 1);
		Assert.assertEquals("2", paymentcode);

		Assert.assertEquals("혜미", purchase.getReceiverName());
		Assert.assertEquals("18", purchase.getReceiverPhone());
		Assert.assertEquals("강남", purchase.getDivyAddr());
		Assert.assertEquals("수정", purchase.getDivyRequest());

		String trancode = purchase.getTranCode().substring(0, 1);
		Assert.assertEquals("1", trancode);

		Assert.assertEquals("1995-08-01 00:00:00.0", purchase.getDivyDate());

	}

	// @Test
	// proNo으로검색
	public void testGetPurchase2() throws Exception {

		Purchase purchase = new Purchase();

		purchase = purchaseService.getPurchase2(10040);

		// ==> console 확인
		System.out.println(purchase);

		// ==> API 확인
		Assert.assertEquals(10040, purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("user05", purchase.getBuyer().getUserId());

		String paymentcode = purchase.getPaymentOption().substring(0, 1);
		Assert.assertEquals("1", paymentcode);

		Assert.assertEquals("SCOTT", purchase.getReceiverName());
		Assert.assertEquals("123", purchase.getReceiverPhone());

		String trancode = purchase.getTranCode().substring(0, 1);
		Assert.assertEquals("3", trancode);

	}

//	/ @Test
	// 구매 업데이트
	public void testUpdatePurchase() throws Exception {

		Purchase purchase = purchaseService.getPurchase(10078);
		Assert.assertNotNull(purchase);

		Assert.assertEquals(10025, purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("user01", purchase.getBuyer().getUserId());

		String paymentcode = purchase.getPaymentOption().substring(0, 1);
		Assert.assertEquals("2", paymentcode);

		Assert.assertEquals("혜미", purchase.getReceiverName());
		Assert.assertEquals("18", purchase.getReceiverPhone());
		Assert.assertEquals("성남", purchase.getDivyAddr());
		Assert.assertEquals("조심히배달점요", purchase.getDivyRequest());

		String trancode = purchase.getTranCode().substring(0, 1);
		Assert.assertEquals("1", trancode);

		Assert.assertEquals("1995-08-01 00:00:00.0", purchase.getDivyDate());

		Product product = new Product();
		product.setProdNo(10025);

		User user = new User();
		user.setUserId("user01");

		purchase.setPurchaseProd(product);
		purchase.setBuyer(user);
		purchase.setPaymentOption("2");
		purchase.setReceiverName("혜미");
		purchase.setReceiverPhone("18");
		purchase.setDivyAddr("강남");
		purchase.setDivyRequest("수정");
		purchase.setTranCode("1");
		purchase.setDivyDate("19950801");

		purchaseService.updatePurchase(purchase);

		purchase = purchaseService.getPurchase(10078);
		Assert.assertNotNull(purchase);

		// ==> console 확인 // System.out.println(product);

		// ==> API 확인
		Assert.assertEquals("혜미", purchase.getReceiverName());
		Assert.assertEquals("18", purchase.getReceiverPhone());
		Assert.assertEquals("강남", purchase.getDivyAddr());
		Assert.assertEquals("수정", purchase.getDivyRequest());
	}

	//@Test
	// 구매 tranCode변경
	public void testUpdateTranCode() throws Exception {

		Purchase purchase = purchaseService.getPurchase(10078);
		Assert.assertNotNull(purchase);

		Product product = new Product();
		product.setProdNo(10025);

		User user = new User();
		user.setUserId("user01");

		purchase.setPurchaseProd(product);
		purchase.setBuyer(user);
		purchase.setPaymentOption("2");
		purchase.setReceiverName("혜미");
		purchase.setReceiverPhone("18");
		purchase.setDivyAddr("강남");
		purchase.setDivyRequest("수정");
		purchase.setTranCode("2");
		purchase.setDivyDate("19950801");

		purchaseService.updateTranCode(purchase);

		purchase = purchaseService.getPurchase(10078);
		Assert.assertNotNull(purchase);

		// ==> console 확인 // System.out.println(product);

		// ==> API 확인
		Assert.assertEquals("혜미", purchase.getReceiverName());
		Assert.assertEquals("18", purchase.getReceiverPhone());
		Assert.assertEquals("강남", purchase.getDivyAddr());
		Assert.assertEquals("수정", purchase.getDivyRequest());
	}

	 //@Test // 리스트 모두보기
	public void testGetPurchaseListAll() throws Exception {

		Search search = new Search();
		search.setCurrentPage(2);
		search.setPageSize(3); // 키워드랑 값변경가능 search.setSearchCondition("1");

		Map<String, Object> map = purchaseService.getPurchaseList(search, "user04");
		System.out.println("USER11111" + map);

		List<Object> list = (List<Object>) map.get("list");
		Assert.assertEquals(3, list.size());

		// ==> console 확인
		System.out.println(list);

		Integer totalCount = (Integer) map.get("totalCount");
		System.out.println(totalCount);
	}

}