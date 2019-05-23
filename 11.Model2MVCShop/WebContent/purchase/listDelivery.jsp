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
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	function fncGetList(currentPage) {
	 	$("#currentPage").val(currentPage)
	 	$("form").attr("method" , "POST").attr("action" , "/purchase/listDelivery").submit();		 
	}
	
	
	$(function(){
		
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		
		
		//============= userId 에 회원정보보기  Event  처리(Click) =============
		$( "td:nth-child(2)" ).on("click" , function() {
			 self.location ="/user/getUser?userId="+$(this).text().trim();			
		}); 
		$( "td:nth-child(2)" ).css("color" , "blue");
		
		//============= 배송정보보기  Event  처리(Click) =============		
		$( "td:nth-child(5)" ).on("click" , function() {
			 self.location ="/purchase/getPurchase?tranNo="+$(this).children("input").val()	
		}); 
		$( "td:nth-child(5)" ).css("color" , "green");	
		
		//============= 배송하기  Event  처리(Click) =============		
		$( "td:nth-child(6)" ).on("click" , function() {
			if($($(this).children("input")[3]).val()==1){
			 self.location ="/purchase/updateTranCodeByProd?tranNo="
				 +$($(this).children("input")[0]).val()+"&tranCode="+$($(this).children("input")[1]).val()+"&currentPage="+$($(this).children("input")[2]).val()
			}
		}); 
		$( "td:nth-child(6):contains('배송하기')" ).css("color" , "red");	
		
		//============= "골라보기"  Event   처리 =============
		$( "#shippingCondition" ).change(function(){
			fncGetList('1');
		});
		
		
		//============= 간략히보기  Event  처리(Click) =============	
		 $( "td:nth-child(7)" ).on("click" , function() {
					 var tranNo = $(this).children("input").val();
						$.ajax( 
								{
									url : "/purchase/json/getPurchase/"+tranNo ,
									method : "GET" ,
									dataType : "json" ,
									headers : {
										"Accept" : "application/json",
										"Content-Type" : "application/json"
									},
									success : function(JSONData , status) {

										//Debug...
										//alert(status);
										//Debug...
										//alert("JSONData : \n"+JSONData);
										var payOpt=null;
										if(JSONData.paymentOption==1){
											payOpt="현금구매";
										}else{
											payOpt="신용구매";
										}
										
										var displayValue = "<h6>"
																	+"물품번호 : "+JSONData.purchaseProd.prodNo+"<br/>"
		 															+"구매자아이디 : "+JSONData.buyer.userId+"<br/>"
		 															+"구매방법 : "+payOpt+"<br/>"
																	+"구매자이름 : "+JSONData.receiverName+"<br/>"
																	+"구매자연락처 : "+JSONData.receiverPhone+"<br/>" 
																	+"구매자주소 : "+JSONData.divyAddr+"<br/>" 
																	+"구매요청사항 : "+JSONData.divyRequest+"<br/>" 
																	+"배송희망일 : "+JSONData.divyDate+"<br/>" 
																	+"주문일 : "+JSONData.orderDate+"<br/>" 
																	+"</h6>";
										//Debug...									
										//alert(displayValue);
										$("h6").remove();
										$( "#"+tranNo+"" ).html(displayValue);
									}
							});
				
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
				<h3>배송 상품 관리</h3>
	    </div>
	      
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	      
	    <div class="row">
	    
		    <div class="col-md-10 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		     <form class="form-inline" name="detailForm">
			 <input type="hidden" id="currentPage" name="currentPage" value=""/>

	    	<div class="col-md-2 text-right">
 				  <div class="form-group">
				    <select class="form-control" id="shippingCondition" name="shippingCondition" >
					<option value="9"  ${ ! empty search.shippingCondition && search.shippingCondition==9 ? "selected" : "" }>모두보기</option>
					<option value="1"  ${ ! empty search.shippingCondition && search.shippingCondition==1 ? "selected" : "" }>구매완료</option>
					<option value="2"  ${ ! empty search.shippingCondition && search.shippingCondition==2 ? "selected" : "" }>배송중</option>
					<option value="3"  ${ ! empty search.shippingCondition && search.shippingCondition==3 ? "selected" : "" }>배송완료</option>
					</select>   
				  </div>
			</div>	 
			</form> 
		</div>  	
	    
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >회원ID</th>
            <th align="left">구매자이름</th>
            <th align="left">구매자번호</th>
			<th align="left">배송현황</th>
            <th align="left">현재상태
			</th> 
			<th align="left">간략정보</th>         			
          </tr>
        </thead>
       
 		<tbody>				
		  <c:set var="i" value="0" />
		  <c:forEach var="purchase" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			
			  <td align="center">${ i }</td>
			  <td align="left"  title="Click : 회원정보 확인">${purchase.buyer.userId} 		  
			  <td align="left">${purchase.receiverName}</td>
			  <td align="left">${purchase.receiverPhone}</td>	
			  <td align="left">
			  	<input type="hidden" name="tranNo" value="${purchase.tranNo}" />
				<c:set var="code" value="${fn:substring(purchase.tranCode,0,1)}"/>
				
				<c:if test="${code eq '1' }">
					현재 구매완료 상태입니다.
				</c:if>
				<c:if test="${code eq '2' }">
					현재 배송중 상태입니다.
				</c:if>
				<c:if test="${code eq '3' }">
					현재 배송완료 상태입니다.
				</c:if>			  		  
			  </td>		
			  <td align="left">
		
				<input type="hidden" name="tranNo"  value="${purchase.tranNo}" />
				<input type="hidden" name="tranCode" value="${code+1}" />
				<input type="hidden" name="currentPage" value="${resultPage.currentPage}" />
				<input type="hidden" name="code" value="${code}" />
			
				<c:if test="${code eq '1' }">
					배송하기
				</c:if>	
				<c:if test="${code eq '2' }">
					배송중
				</c:if>
				<c:if test="${code eq '3' }">
					배송완료
				</c:if>	
						
			</td>				  
			  
			  <td align="left">			  
				<input type="hidden" value="${purchase.tranNo }" />
			  	<i class="glyphicon glyphicon-ok" id= "${purchase.tranNo }"></i>
			  </td>
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