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
   	<!--  ///////////////////////// 우편번호 CDN ////////////////////////// -->	
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
   	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">

	function fncAddPurchase() {
		/* document.addPurchase.submit(); */
		
		var divyDate = $("input[name='divyDate']").val();
		
		if(divyDate==null || divyDate.length <1){
			alert("배송희망날짜는 반드시 입력하여야 합니다.");
			return;
		}
		$("form").attr("method","POST").attr("action","/purchase/addCartPurchase").submit();
	}
	
	$(function(){	
		
	    $("#allCheck").click(function(){
	        //클릭되었으면
	        if($("#allCheck").prop("checked")){
	            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의
	            $("input[name=productCheck]").prop("checked",true);
	            //클릭이 안되있으면
	        }else{
	            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 false로 정의
	            $("input[name=productCheck]").prop("checked",false);
	        }
	    });
	    
	});
	
	$(function() {
		//============= "구매"  Event 처리 및  연결 =============
		$( "button.btn.btn-primary"  ).on("click" , function() {
			fncAddPurchase();
		});
		//============= "취소"  Event 처리 및  연결 =============
		$("button.btn.btn-warning").on("click",function(){
			history.go(-1);
		});
	});
	
	$( function() {
		   
	    $( "#divyDate" ).datepicker( { dateFormat: 'yy-mm-dd' });
	 
	} );
	/* 주소록 */
	 function sample6_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수

	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }

	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    $("input[id='sample6_extraAddress']").val(extraAddr);
	                
	                } else {
	                	 $("input[id='sample6_extraAddress']").val('');
	                }
	               
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                $("input[id='sample6_postcode']").val( data.zonecode);
	                $("input[id='addr']").val(addr);
	                // 커서를 상세주소 필드로 이동한다.		                
	                $("input[id='sample6_detailAddress']").focus();

	            }
	        }).open();
	    }	
	
	</script>
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	 	<form class="form-horizontal">
	<div class="container">
	
		<div class="page-header text-info">
				<h3>상품 구매</h3> 
	    </div>
	      
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >상품명</th>
            <th align="left" >상품이미지</th>
			<th align="left">상품상세정보</th>   	
			<th align="left" >상품 수량</th>   		
            <th align="left">합계</th>
          </tr>
        </thead>
       
 		<tbody>				
		  <c:set var="i" value="0" />
		  <c:forEach var="cart" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			   <input type="hidden" name="cartNo" value="${cart.cartNo}" />	
			<tr>		
			  <td align="center">${ i }</td>
			  <td align="left"  title="Click : 상품정보 확인">${cart.cartProd.prodName}		  
			  </td>
			  <td align="left">
					<c:if test="${ empty cart.cartProd.fileName }">
						 <img src="/images/uploadFiles/no_image.gif" width="100px;" height="100px;"/>						    
					 </c:if>
					<c:if test="${ !(empty cart.cartProd.fileName)}">						    
						      <img src="/images/uploadFiles/${cart.cartProd.fileName}"  width="100px;" height="100px;"/>
					</c:if>			  
			  </td>			  
			  <td align="left">${cart.cartProd. prodDetail}</td>		
			  <td align="left">${cart.cartCount }</td>					 		  
			  <td align="left">${cart.cartProd.price * cart.cartCount } won</td> 
			  
			</tr>
           </c:forEach>       
        </tbody> 
      
      </table>
	  <!--  table End /////////////////////////////////////--> 
 	<hr/>
	  
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
  <div class="form-group">

  <input type="hidden" name="prodNo" value="${prodNo }" />
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">구매자아이디</label>
		    <div class="col-sm-4">
	   		 ${purchase.buyer.userId}
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
		   
		    <div class="col-sm-2">   
			<div class="form-group">	    
			<select class="form-control" name="paymentOption">						
			<option value="1" selected >현금구매</option>
			<option value="2" >신용구매</option>
			</select>
			</div>		
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">구매자이름</label>
		    <div class="col-sm-4">
		     <input type="text" class="form-control" value="${purchase.buyer.userName}" id="receiverName" name="receiverName" placeholder="구매자이름">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">구매자연락처</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control"  value="${purchase.buyer.phone}" id="receiverPhone" name="receiverPhone" placeholder="구매자연락처">
		    </div>
		  </div>
		  
		  <div class="form-group">	
		  <label for="addr" class="col-sm-offset-1 col-sm-3 control-label">주소</label>	
		   <div class="col-sm-2" >  
			<input type="text" class="form-control" id="sample6_postcode" placeholder="우편번호">
			</div>
			<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
			</div>

		  <div class="form-group ">
		   <div class="col-sm-4"  >  
		   </div>		  				
		   <div class="col-sm-4"  >  
			<input type="text" class="form-control " id="addr" name="addr" value="${purchase.buyer.addr }" placeholder="주소"><br>
			</div>
			</div>
			
		  <div class="form-group">		
		  <div class="col-sm-4"  >  
		   </div>						
			<div class="col-sm-2" >  
			<input type="text" class="form-control" id="sample6_detailAddress" placeholder="상세주소">
			</div> <div class="col-sm-2" >  
			<input type="text" class="form-control" id="sample6_extraAddress" placeholder="참고항목">
			</div>
		  </div>
		  
		  <div class="form-group">
		    <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyRequest" name="divyRequest" placeholder="구매요청사항">
		    </div>
		  </div>
		  		  
		  <div class="form-group">
		    <label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyDate" name="divyDate" placeholder="배송희망일자">
		    </div>
		  </div>		  
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
				<button type="button" class="btn btn-primary">구매</button>
	  			<button type="button" class="btn btn-warning">취소</button>
		    </div>
		  </div>
		</form>	
 	<br/><br/>
	
</body>

</html>