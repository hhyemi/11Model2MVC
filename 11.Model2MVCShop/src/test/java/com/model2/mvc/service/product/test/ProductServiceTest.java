package com.model2.mvc.service.product.test;

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
import com.model2.mvc.service.product.ProductService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
		"classpath:config/context-aspect.xml",
		"classpath:config/context-mybatis.xml",
		"classpath:config/context-transaction.xml" })
public class ProductServiceTest {

	// ==>@RunWith,@ContextConfiguration 이용 Wiring, Test 할 instance DI
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;

	 //@Test
	public void testAddProduct() throws Exception {

		Product product = new Product();
		product.setProdName("치킨");
		product.setProdDetail("맥주와함께");
		product.setManuDate("1995");
		product.setPrice(1000);
		product.setFileName("11.img");

		productService.addProduct(product);

		// product = productService.getProduct("치킨");

		// ==> console 확인
		 System.out.println(product);

		// ==> API 확인
		Assert.assertEquals("치킨", product.getProdName());
		Assert.assertEquals("맥주와함께", product.getProdDetail());
		Assert.assertEquals("1995", product.getManuDate());
		Assert.assertEquals(1000, product.getPrice());
		Assert.assertEquals("11.img", product.getFileName());

	}

	// @Test
	public void testGetProduct() throws Exception {

		Product product = new Product();

		// 10080 = PROD_NO (PARAMETER값)
		product = productService.getProduct(10080);

		// ==> console 확인
		// System.out.println(product);

		// ==> API 확인
		Assert.assertEquals("치킨", product.getProdName());
		Assert.assertEquals("맥주와함께", product.getProdDetail());
		Assert.assertEquals("1995", product.getManuDate());
		Assert.assertEquals(1000, product.getPrice());
		Assert.assertEquals("11.img", product.getFileName());

		/*
		 * Assert.assertNotNull(userService.getUser("user02"));
		 * Assert.assertNotNull(userService.getUser("user05"));
		 */
	}

	// @Test
	public void testUpdateProduct() throws Exception {

		Product product = productService.getProduct(10080);
		Assert.assertNotNull(product);

		Assert.assertEquals("치킨", product.getProdName());
		Assert.assertEquals("맥주와함께", product.getProdDetail());
		Assert.assertEquals("1995", product.getManuDate());
		Assert.assertEquals(1000, product.getPrice());
		Assert.assertEquals("11.img", product.getFileName());

		product.setProdName("치킨");
		product.setProdDetail("맥주+소주!와함께");
		product.setManuDate("19950801");
		product.setPrice(5000);
		product.setFileName("11.img");

		productService.updateProduct(product);

		product = productService.getProduct(10080);
		Assert.assertNotNull(product);

		// ==> console 확인
		// System.out.println(product);

		// ==> API 확인
		Assert.assertEquals("치킨", product.getProdName());
		Assert.assertEquals("맥주+소주!와함께", product.getProdDetail());
		Assert.assertEquals("19950801", product.getManuDate());
		Assert.assertEquals(5000, product.getPrice());
		Assert.assertEquals("11.img", product.getFileName());
	}

	 @Test
	// 리스트 모두보기
	public void testGetProductListAll() throws Exception {

		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		// 키워드랑 값변경가능
		search.setSearchCondition("");
		search.setSearchKeyword("");
/*		search.setSearchCondition("1");
		search.setSearchKeyword("%1%");*/
		// 재량으로 바꾸기가능
		search.setShippingCondition("");
		search.setPriceSort("");

		Map<String, Object> map = productService.getProductList(search);

		List<Object> list = (List<Object>) map.get("list");
		Assert.assertEquals(3, list.size());

		// ==> console 확인
		System.out.println(list);

		Integer totalCount = (Integer) map.get("totalCount");
		System.out.println(totalCount);
	}

	// @Test
	public void testGetProductListByProdNo() throws Exception {

		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		search.setSearchCondition("0");
		search.setSearchKeyword("10080");
		Map<String, Object> map = productService.getProductList(search);

		List<Object> list = (List<Object>) map.get("list");
		Assert.assertEquals(1, list.size());

		// ==> console 확인
		System.out.println(list);

		Integer totalCount = (Integer) map.get("totalCount");
		System.out.println(totalCount);

		System.out.println("=======================================");

		search.setSearchCondition("0");
		search.setSearchKeyword("" + System.currentTimeMillis());
		map = productService.getProductList(search);

		list = (List<Object>) map.get("list");
		Assert.assertEquals(0, list.size());

		// ==> console 확인
		System.out.println(list);

		totalCount = (Integer) map.get("totalCount");
		System.out.println(totalCount);
	}

	// @Test
	public void testGetProductListByProductName() throws Exception {

		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		search.setSearchCondition("1");
		search.setSearchKeyword("%치킨%");
		Map<String, Object> map = productService.getProductList(search);

		List<Object> list = (List<Object>) map.get("list");
		Assert.assertEquals(2, list.size());

		// ==> console 확인
		System.out.println(list);

		Integer totalCount = (Integer) map.get("totalCount");
		System.out.println(totalCount);

		System.out.println("=======================================");

		search.setSearchCondition("1");
		search.setSearchKeyword("" + System.currentTimeMillis());
		map = productService.getProductList(search);

		list = (List<Object>) map.get("list");
		Assert.assertEquals(0, list.size());

		// ==> console 확인
		System.out.println(list);

		totalCount = (Integer) map.get("totalCount");
		System.out.println(totalCount);
	}

	// @Test
	public void testGetProductListByPrice() throws Exception {

		Search search = new Search();
		search.setCurrentPage(2);
		search.setPageSize(3);
		search.setSearchCondition("2");
		search.setSearchKeyword("22");
		Map<String, Object> map = productService.getProductList(search);

		List<Object> list = (List<Object>) map.get("list");
		Assert.assertEquals(2, list.size());

		// ==> console 확인
		System.out.println(list);

		Integer totalCount = (Integer) map.get("totalCount");
		System.out.println(totalCount);

		System.out.println("=======================================");

		search.setSearchCondition("2");
		search.setSearchKeyword("" + System.currentTimeMillis());
		map = productService.getProductList(search);

		list = (List<Object>) map.get("list");
		Assert.assertEquals(0, list.size());

		// ==> console 확인
		System.out.println(list);

		totalCount = (Integer) map.get("totalCount");
		System.out.println(totalCount);
	}
	// @Test
	// 판매중만 보기
	public void testGetProductShippingListBySale() throws Exception {

		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		// 키워드랑 값변경가능
		search.setSearchCondition("1");
		search.setSearchKeyword("%1%");
		// 재량으로 바꾸기가능
		search.setShippingCondition("0");
		Map<String, Object> map = productService.getProductList(search);

		List<Object> list = (List<Object>) map.get("list");
		Assert.assertEquals(3, list.size());

		// ==> console 확인
		System.out.println(list);

		Integer totalCount = (Integer) map.get("totalCount");
		System.out.println(totalCount);

	}

	// @Test
	// 구매완료만 보기
	public void testGetProductShippingListByBuy() throws Exception {

		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		// 키워드랑 값변경가능
		search.setSearchCondition("1");
		search.setSearchKeyword("%1%");
		// 재량으로 바꾸기가능
		search.setShippingCondition("1");
		Map<String, Object> map = productService.getProductList(search);

		List<Object> list = (List<Object>) map.get("list");
		Assert.assertEquals(1, list.size());

		// ==> console 확인
		System.out.println(list);

		Integer totalCount = (Integer) map.get("totalCount");
		System.out.println(totalCount);

	}

	// @Test
	// 배송중만 보기
	public void testGetProductShippingListByDelivery() throws Exception {

		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		// 키워드랑 값변경가능
		search.setSearchCondition("1");
		search.setSearchKeyword("%1%");
		// 재량으로 바꾸기가능
		search.setShippingCondition("2");
		Map<String, Object> map = productService.getProductList(search);

		List<Object> list = (List<Object>) map.get("list");
		Assert.assertEquals(1, list.size());

		// ==> console 확인
		System.out.println(list);

		Integer totalCount = (Integer) map.get("totalCount");
		System.out.println(totalCount);

	}

	//@Test
	// 배송완료만 보기
	public void testGetProductShippingListByDeliveryCompleted() throws Exception {

		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		// 키워드랑 값변경가능
		search.setSearchCondition("1");
		search.setSearchKeyword("%1%");
		// 재량으로 바꾸기가능
		search.setShippingCondition("3");
		Map<String, Object> map = productService.getProductList(search);

		List<Object> list = (List<Object>) map.get("list");
		Assert.assertEquals(0, list.size());

		// ==> console 확인
		System.out.println(list);

		Integer totalCount = (Integer) map.get("totalCount");
		System.out.println(totalCount);

	}
	
	//@Test
	// 가격높은순
	public void testGetProductPriceSortListHigh() throws Exception {

		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		// 키워드랑 값변경가능
		search.setSearchCondition("1");
		search.setSearchKeyword("%1%");
		search.setShippingCondition("0");
		// 재량으로 바꾸기가능
		search.setPriceSort("high");
		Map<String, Object> map = productService.getProductList(search);

		List<Object> list = (List<Object>) map.get("list");
		Assert.assertEquals(3, list.size());

		// ==> console 확인
		System.out.println(list);

		Integer totalCount = (Integer) map.get("totalCount");
		System.out.println(totalCount);

	}
	
	//@Test
	// 가격낮은순
	public void testGetProductPriceSortListLow() throws Exception {

		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		// 키워드랑 값변경가능
		search.setSearchCondition("1");
		search.setSearchKeyword("%1%");
		search.setShippingCondition("0");
		// 재량으로 바꾸기가능
		search.setPriceSort("low");
		Map<String, Object> map = productService.getProductList(search);

		List<Object> list = (List<Object>) map.get("list");
		Assert.assertEquals(3, list.size());

		// ==> console 확인
		System.out.println(list);

		Integer totalCount = (Integer) map.get("totalCount");
		System.out.println(totalCount);

	}
}