<%@ page contentType="text/html; charset=EUC-KR"%>

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
       body > div.container{
/* 	일촌 후손만  */
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
    </style>
    <!--  ///////////////////////// JavaScript ////////////////////////// --> 
<script type="text/javascript" >

function fncAddReview(){
	//Form 유효성 검증

	var reviewText = $("textarea[name='reviewText']").val();
	var password = $("input[name='password']").val();
	
	if(reviewText == null || reviewText.length<1){
		alert("후기내용은 반드시 입력하여야 합니다.");
		return;
	}
	
	if(password == null || password.length<1){
		alert("비밀번호는 반드시 입력하여야 합니다.");
		return;
	}


	$('form').attr("method","POST").attr("action","/review/addReview").attr("enctype","multipart/form-data").submit();

}

	$( function(){
		//============= "취소"  Event 처리 및  연결 =============
		$("a[href='#' ]").on('click', function() {
			$('form')[0].reset();
		});
		
		//============= "등록"  Event 연결 =============
		$('button.btn.btn-primary').on('click', function(){
			fncAddReview();
		});
			
		
	});
	
	</script>
	</head>

	<body>

		<!-- ToolBar Start /////////////////////////////////////-->
		<div class="navbar  navbar-default">
		<jsp:include page="/layout/toolbar.jsp" />
		</div>
	   	<!-- ToolBar End /////////////////////////////////////-->

		<!--  화면구성 div Start /////////////////////////////////////-->
		<div class="container">
		
			<div class="page-header">	
			<h1 class="bg-primary text-center">상 품 후 기 등 록</h1>
		    </div>		
			<!-- form Start /////////////////////////////////////-->
			<form class="form-horizontal">
			
			  <div class="form-group">
			    <label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">상 품 번 호</label>
			    <div class="col-sm-4">
			    <input type="hidden" name="prodNo" value="${review.reviewProd.prodNo }" />
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
			    <label for="evaluation" class="col-sm-offset-1 col-sm-3 control-label">선호도</label>
			    <div class="col-sm-4">
					<select name="evaluation" >
					<option value="1" selected >대만족</option>
					<option value="2" >만족</option>
					<option value="3" >보통</option>
					<option value="4" >불만족</option>
					</select>
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="title" class="col-sm-offset-1 col-sm-3 control-label">제목</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="title" name="title" placeholder="제목">
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="reviewText" class="col-sm-offset-1 col-sm-3 control-label">후기내용</label>
			    <div class="col-sm-6">
			      <textarea name="reviewText" class="form-control" rows="5" ></textarea>
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="uploadFile" class="col-sm-offset-1 col-sm-3 control-label">후기이미지</label>
			    <div class="col-sm-4">
			      <input type="file" class="form-control" id="uploadFile" name="uploadFile" >
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="password" class="col-sm-offset-1 col-sm-3 control-label">비밀번호</label>
			    <div class="col-sm-2">
			      <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호">
			    </div>
			  </div>
			  		  
			  <div class="form-group">
			    <div class="col-sm-offset-4  col-sm-4 text-center">
			      <button type="button" class="btn btn-primary"  >등&nbsp;록</button>
				  <a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>
			    </div>
			  </div>
			</form>
			<!-- form Start /////////////////////////////////////-->
			
	 	</div>
		<!--  화면구성 div end /////////////////////////////////////-->
			
	</body>

	</html>
