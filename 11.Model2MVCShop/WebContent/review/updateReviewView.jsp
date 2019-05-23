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

		$("form").attr("method","POST").attr("action","/review/updateReview?reviewNo=${review.reviewNo}").attr("enctype","multipart/form-data").submit();
	}
	
	 $(function() {
			//============= 수정 Event  처리 =============	
		 $( "button.btn.btn-primary"  ).on("click" , function() {
			 fncUpdatePurchase();
			});
			//============= 취소 Event  처리 =============		 
		 $( "button.btn.btn-warning" ).on("click" , function() {
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
			
				<div class="page-header text-center">
			       <h3 class=" text-info">후기정보수정</h3>
			       <h5 class="text-muted">상품 후기 정보를 <strong class="text-danger"> 수정</strong>해 주세요.</h5>
			    </div>
			    
			    <!-- form Start /////////////////////////////////////-->
				<form class="form-horizontal">
				
				  <div class="form-group">
				    <label for="reviewNo" class="col-sm-offset-1 col-sm-3 control-label">구매번호</label>
				    <div class="col-sm-4">
				     ${review.reviewNo}
				    </div>
				  </div>
				
				  <div class="form-group">
				    <label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
				    <div class="col-sm-4">
				     ${review.reviewProd.prodNo }
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">구매자아이디</label>
				    <div class="col-sm-4">
					${review.buyer.userId }				      
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <label for="title" class="col-sm-offset-1 col-sm-3 control-label">제목</label>
				    <div class="col-sm-4">
				      <input type="text" class="form-control" id="title" name="title" value="${review.title }" placeholder="제목">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <label for="evaluation" class="col-sm-offset-1 col-sm-3 control-label">선호도</label>
				    <div class="col-sm-4">
					 <select name="evaluation"  class="form-control">
					<option value="1" ${ review.evaluation eq 1 ? "selected" : "" } >대만족</option>
					<option value="2" ${ review.evaluation eq 2 ? "selected" : "" }>만족</option>
					<option value="3" ${ review.evaluation eq 3 ? "selected" : "" }>보통</option>
					<option value="4" ${ review.evaluation eq 4 ? "selected" : "" }>불만족</option>
					</select>
				    </div>
				  </div>
				  
				   <div class="form-group">
				    <label for="reviewText" class="col-sm-offset-1 col-sm-3 control-label">후기내용</label>
				    <div class="col-sm-4">
				      <input type="text" class="form-control" id="reviewText" name="reviewText"  value="${review.reviewText }" placeholder="후기내용">
				    </div>
				  </div>
				  
				   <div class="form-group">
				    <label for="uploadFile" class="col-sm-offset-1 col-sm-3 control-label">후기이미지</label>
				    <div class="col-sm-4">
				     <input type="file" class="form-control" id="uploadFile" name="uploadFile" >
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="col-sm-offset-4  col-sm-4 text-center">
			  			<button type="button" class="btn btn-primary">수정</button>
			  			<button type="button" class="btn btn-warning">취소</button>
				    </div>
				  </div>

				</form>
				<!-- form Start /////////////////////////////////////-->
			    
		 	</div>
			<!--  화면구성 div Start /////////////////////////////////////-->
		 	
		</body>

		</html>