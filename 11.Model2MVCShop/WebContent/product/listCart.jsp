<%@ page contentType="text/html; charset=EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   
   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip 사용 JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
        .thumbnail{
        	width : 350px;
        	height : 550px;
        }

    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">

	// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  

function fncGetList(currentPage) {

   	$("#currentPage").val(currentPage)
   	$("form").attr("method" , "POST").attr("action" , "/cart/listCart";).submit();
 
}
	

$(function(){

		$( " td:nth-child(7):contains('품절')" ).css("color" , "red");

		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		
		//============= "getProduct"  Event   처리 =============
		$( "td:nth-child(3)" ).on("click",function(){
			self.location ="/product/getProduct?prodNo="+$(this).children("input").val()+"&menu=${param.menu}";
		});
	
		//============= "품절제외"  Event   처리 =============
		$( "#shippingCondition" ).change(function(){
			fncGetList('1');
		});
});

</script>
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
				<h3>장바구니 목록조회</h3>
	    </div>
	      
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	      
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <div class="col-md-5 text-right">
			    <form class="form-inline" name="detailForm">
				  <div class="form-group">
				    <select class="form-control" id="shippingCondition" name="shippingCondition" >
							<option value="9"  ${ ! empty search.shippingCondition && search.shippingCondition==9 ? "selected" : "" }>모두보기</option>
							<option value="0"  ${ ! empty search.shippingCondition && search.shippingCondition==0 ? "selected" : "" }>판매중</option>
							<option value="8"  ${ ! empty search.shippingCondition && search.shippingCondition==8 ? "selected" : "" }>품절</option>
					</select>   
				  </div>
			 <input type="hidden" id="currentPage" name="currentPage" value=""/>	 
				</form>
	    	</div>

		</div>  	
	    
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >상품명</th>
            <th align="left" >상품이미지</th>
            <th align="left">가격</th>
            <th align="left">재고현황</th>
			<th align="left">상품상세정보</th>
            <th align="left">현재상태</th> 
			<th align="left">담은 개수</th>         			
          </tr>
        </thead>
       
 		<tbody>				
		  <c:set var="i" value="0" />
		  <c:forEach var="cart" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			
			  <td align="center">${ i }</td>
			  <td align="left"  title="Click : 상품정보 확인"><strong class="text-secondary">${cart.cartProd.prodName}</strong></td>	
			  <td align="left" >
			  <input type="hidden" name="prodNo" value="${cart.cartProd.prodNo}" />
			  <img src="/images/uploadFiles/${cart.cartProd.fileName}"  width="200px;" height="200px;"/></td>			  	  
			  <td align="left">${cart.cartProd.price}</td>
			  <td align="left">${cart.cartProd.count}</td>	
			  <td align="left">${cart.cartProd.prodDetail}</td>		
			  <td align="left">
				<c:if test="${cart.cartProd.count eq 0 }">
						품절 
				</c:if>			
				<c:if test="${!(cart.cartProd.count eq 0) }">
						재고있음 
				</c:if>					
			</td>				  
			  
			  <td align="left"> ${cart.cartCount} </td>
			</tr>
          </c:forEach>
        
        </tbody> 
      
      </table>
	  <!--  table End /////////////////////////////////////--> 
	  
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>

</html>