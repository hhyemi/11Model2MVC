<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

			 
			 $( "button.btn.btn-primary" ).on("click" , function() {
				 
				 var password = $("input[name='password']").val();
				 var reviewNo = $("#reviewNo").text().trim();
				 
				 if(password == null || password.length <1){
						alert("비밀번호는 반드시 입력하셔야 합니다.");
						$("input[name='password']").focus();
						return;
				 }
				 //alert(reviewNo);
				 
				 $.ajax( 
							{
								url : "/review/json/PWCheckReview",
								method : "POST" ,
								dataType : "json" ,
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								},
								data : JSON.stringify({
									reviewNo : reviewNo,
									password : password
								}),
								success : function(JSONData , status) {

									//Debug...
									//alert(status);
									//alert("JSONData : \n"+JSONData);
									//alert( "JSON.stringify(JSONData) : \n"+JSON.stringify(JSONData) );
									//alert( JSONData != null );
									
									if(JSONData){
										alert("비밀번호가 맞지않습니다.");
										//self.location="/review/updateReview?reviewNo=${review.reviewNo}"
									}else{
										self.location="/review/updateReview?reviewNo=${review.reviewNo}"
										//alert("아이디 , 패스워드를 확인하시고 다시 로그인...");
									}
								}
						}); 	
				 
				 
				 
				 
				  // alert("${review.buyer.userId}")
					//self.location="/review/updateReview?reviewNo=${review.reviewNo}"
				});
			
			 
			 $( "btn btn-warning" ).on("click" , function() {
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
	       <h3 class=" text-info">후기상세조회</h3>
	       <h5 class="text-muted">구매하신  <strong class="text-danger">후기상품</strong>상세 조회입니다.</h5>
	    </div>
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>후기번호</strong></div>
			<div class="col-xs-8 col-md-4" id="reviewNo">${review.reviewNo}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>상품번호</strong></div>
			<div class="col-xs-8 col-md-4">${review.reviewProd.prodNo }</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매자아이디</strong></div>
			<div class="col-xs-8 col-md-4">${review.buyer.userId}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>선호도</strong></div>
			<div class="col-xs-8 col-md-4">
			<c:if test="${review.evaluation eq 1 }">
					대만족
			</c:if>
			<c:if test="${review.evaluation eq 2}">
					만족
			</c:if>
			<c:if test="${review.evaluation eq 3 }">
					보통
			</c:if>
			<c:if test="${review.evaluation eq 4}">
					불만족
			</c:if>			
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>후기제목</strong></div>
			<div class="col-xs-8 col-md-4">${review.title}</div>
		</div>		
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>후기내용</strong></div>
			<div class="col-xs-8 col-md-4">${review.reviewText}</div>
		</div>
		
		<hr/>
		
		<c:if test="${review.fileName != null }">
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>후기이미지</strong></div>
			<div class="col-xs-8 col-md-4"><img src="/images/uploadFiles/${review.fileName}" width="400px;" height="400px;" /></div>
		</div>
		<hr/>
		</c:if>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>비밀번호</strong></div>
			<div class="col-xs-8 col-md-4">
			 <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호">
			</div>
		</div>

 		<hr/>
 			
		<div class="row">	
	  		<div class="col-md-10 text-center">
	  		 <h5 class="text-muted">수정하실려면  <strong class="text-danger">비밀번호를</strong>입력해주세요.</h5>
	  			<button type="button" class="btn btn-primary">수정</button>
	  			<button type="button" class="btn btn-warning">이전</button>
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

