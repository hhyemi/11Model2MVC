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
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
     </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	 $(function() {

			//============= "수정"  Event 처리 및  연결 =============			 
			 $( "button.btn.btn-primary" ).on("click" , function() {
				 
				var tranCode = ${purchase.tranCode};
				if(tranCode ==1){
					self.location="/purchase/updatePurchase?tranNo=${purchase.tranNo}";
				}else if(tranCode ==2){
					alert("이미 배송중이라 수정이 불가합니다. \n 010-8410-0099로 문의 바랍니다.")
				}else {
					alert("이미 배송완료된 상품이라 수정이 불가합니다.")
				}
				});
			
			//============= "확인"  Event 처리 및  연결 =============			 
			 $("button.btn.btn-warning"  ).on("click" , function() {
				 history.go(-1);
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
	
		<div class="page-header">
	       <h3 class=" text-info">구매상세조회</h3>
	       <h5 class="text-muted">구매하신  <strong class="text-danger">상품</strong>상세 조회입니다.</h5>
	    </div>
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>물품명</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.purchaseProd.prodName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>물품이미지</strong></div>
			<div class="col-xs-8 col-md-4"> <img src="/images/uploadFiles/${purchase.purchaseProd.fileName}" width="130px;" height="130px;"/></div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>구매수량</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.count}개</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>구매합계</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.purchaseProd.price * purchase.count}원</div>
		</div>
		
		<hr/>		

		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매자아이디</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.buyer.userId}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매방법</strong></div>
			<div class="col-xs-8 col-md-4">
			<c:set var="code" value="${fn:substring(purchase.paymentOption,0,1)}"/>
			
			<c:if test="${code eq 1 }">
				현금구매
			</c:if>
			<c:if test="${code eq 2 }">
				신용구매
			</c:if>			
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매자이름</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.receiverName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>구매자연락처</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.receiverPhone}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매자주소</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.divyAddr}</div>
		</div>
		
		<hr/>

		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매요청사항</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.divyRequest}</div>
		</div>

		<hr/>
			
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>배송희망일</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.divyDate}</div>
		</div>	
			
		<hr/>

		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>주문일</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.orderDate}</div>
		</div>	
		
		
	 	
		<div class="row">	
	  		<div class="col-md-10 text-center">
	  			<button type="button" class="btn btn-primary">수정</button>
	  			<button type="button" class="btn btn-warning">확인</button>
	  		</div> 		
	 	</div>
	 	
	 	<br/><br/>			
		<br/>
		
 	</div>
 	
 	<!--  화면구성 div Start /////////////////////////////////////-->
 	
 	<div>
    <jsp:include page="/review/listReview?prod_no=${product.prodNo}" />
	</div>

</body>

</html>

