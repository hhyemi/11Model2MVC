<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<!-- ////////////////////달력 /////////////////////////////-->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
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
	<script type="text/javascript" >

	function fncUpdatePurchase() {

		$("form").attr("method","POST").attr("action","/purchase/updatePurchase?tranNo=${purchase.tranNo }").submit();
	}
	
	 $(function() {

			//============= 수정 Event  처리 =============	
		 $( "button.btn.btn-primary" ).on("click" , function() {
			 fncUpdatePurchase();
			});
			//============= 취소 Event  처리 =============	
		 $( "button.btn.btn-warning" ).on("click" , function() {
				history.go(-1);
			});
	 });
	 
		$( function() {
			   
		      $( "#divyDate" ).datepicker( { dateFormat: 'yy-mm-dd' });
		   
		  } );

		</script>
		
		</head>

		<body>

			<!-- ToolBar Start /////////////////////////////////////-->
			<jsp:include page="/layout/toolbar.jsp" />
		   	<!-- ToolBar End /////////////////////////////////////-->
			
			<!--  화면구성 div Start /////////////////////////////////////-->
			<div class="container">
			
				<div class="page-header text-center">
			       <h3 class=" text-info">구매정보수정</h3>
			       <h5 class="text-muted">상품 구매 정보를 <strong class="text-danger">최신정보로 관리</strong>해 주세요.</h5>
			    </div>
			    
			    <!-- form Start /////////////////////////////////////-->
				<form class="form-horizontal">
				
				  <div class="form-group">
				    <label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">물품번호</label>
				    <div class="col-sm-4">
				      ${purchase.purchaseProd.prodNo}
				    </div>
				  </div>
				
				  <div class="form-group">
				    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">구매자아이디</label>
				    <div class="col-sm-4">
				      ${purchase.buyer.userId }
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
				    <div class="col-sm-4">
					<c:set var="code" value="${fn:substring(purchase.paymentOption,0,1)}"/>
				
					<select class="form-control" name="paymentOption">
									
					<option value="1" ${ ! empty purchase.paymentOption && code==1 ? "selected" : "" }>현금구매</option>
					<option value="2" ${ ! empty purchase.paymentOption && code==2 ? "selected" : "" }>신용구매</option>
		
					</select>				      
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">구매자이름</label>
				    <div class="col-sm-4">
				      <input type="text" class="form-control" id="receiverName" name="receiverName" value="${purchase.receiverName }" placeholder="구매자이름">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">구매자 연락처</label>
				    <div class="col-sm-4">
				      <input type="text" class="form-control" id="receiverPhone" name="receiverPhone"  value="${purchase.receiverPhone }" placeholder="연락처">
				    </div>
				  </div>
				  
				   <div class="form-group">
				    <label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">구매자주소</label>
				    <div class="col-sm-4">
				      <input type="text" class="form-control" id="divyAddr" name="divyAddr"  value="${purchase.divyAddr }" placeholder="구매자주소">
				    </div>
				  </div>
				  
				   <div class="form-group">
				    <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
				    <div class="col-sm-4">
				      <input type="text" class="form-control" id="divyRequest" name="divyRequest"  value="${purchase.divyRequest }" placeholder="구매요청사항">
				    </div>
				  </div>
				  
				   <div class="form-group">
				    <label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
				    <div class="col-sm-4">
				      <input type="text" class="form-control" id="divyDate" name="divyDate"  value="${purchase.divyDate }" placeholder="배송희망일자">
				    </div>
				  </div>
				  				  
				  <div class="form-group">
				    <div class="col-sm-offset-4  col-sm-4 text-center">
			  			<button type="button" class="btn btn-primary">수정</button>
			  			<button type="button" class="btn btn-warning">취소</button>
				    </div>
				  </div>
				  
				<input type="hidden" name="prodNo" value="${product.prodNo}" /> 
				</form>
				<!-- form Start /////////////////////////////////////-->
			    
		 	</div>
			<!--  화면구성 div Start /////////////////////////////////////-->
		 	
		</body>

		</html>