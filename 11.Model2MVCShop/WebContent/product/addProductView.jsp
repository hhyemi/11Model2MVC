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
    
       #start { border:3px solid #0066cc; }

    </style>
    <!--  ///////////////////////// JavaScript ////////////////////////// --> 
<script type="text/javascript" >

function fncAddProduct(){
	//Form 유효성 검증

	var name = $('input[name="prodName"]').val();
	var detail = $('input[name="prodDetail"]').val();
	var manuDate = $('input[name="manuDate"]').val();
	var price = $('input[name="price"]').val();
	var count = $('input[name="quantity"]').val();
	

	if(name == null || name.length<1){
		alert("상품명은 반드시 입력하여야 합니다.");
		return;
	}
	if(detail == null || detail.length<1){
		alert("상품상세정보는 반드시 입력하여야 합니다.");
		return;
	}
	if(manuDate == null || manuDate.length<1){
		alert("제조일자는 반드시 입력하셔야 합니다.");
		return;
	}
	if(price == null || price.length<1){
		alert("가격은 반드시 입력하셔야 합니다.");
		return;
	}
	if(count == "" ) {
		alert("상품수량은 반드시 입력하셔야 합니다.");
		return;
	}

	$('form').attr("method","POST").attr("action","/product/addProduct").attr("enctype","multipart/form-data").submit();

}

		function fnAddFile(fileNameArray) {
		   	$("#multiFile").val(fileNameArray)
		 
		}
		//============= "등록"  Event 연결 =============
			$(function() {
				//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
				$( "button.btn.btn-primary" ).on("click" , function() {
					fncAddProduct();
				});
			});	

		//============= "취소"  Event 처리 및  연결 =============
		$( function(){
			$("a[href='#' ]").on('click', function() {
				$('form')[0].reset();
			});
		
			
		
	});
	
		//============= "달력(제조일자)"  Event 처리 및  연결 =============
		$( function() {
		   
		      $( "#manuDate" ).datepicker( { dateFormat: 'yy-mm-dd' });
		   
		  } );
		
		//============= "다중파일업로드"  Event 처리 및  연결 =============		

		    //임의의 file object영역
	        var files = {};
	        var previewIndex = 0;
	        var fileNameArray = new Array();
	 
	        // image preview 기능 구현
	        // input = file object[]
	        function addPreview(input) {
	            if (input[0].files) {
	                //파일 선택이 여러개였을 시의 대응
	                for (var fileIndex = 0; fileIndex < input[0].files.length; fileIndex++) {
	                    var file = input[0].files[fileIndex];
	 
	                    if (validation(file.name))
	                        continue;

	        	        var fileName = file.name + "";   
	        	        var fileNameExtensionIndex = fileName.lastIndexOf('.') + 1;
	        	        var fileNameExtension = fileName.toLowerCase().substring(fileNameExtensionIndex, fileName.length);       
	        	        
	 					var imgSelectName = "img";
	 
	 					if(fileNameExtension === 'mp4' || fileNameExtension === 'avi'){
	 						imgSelectName = "iframe";
	 					}	                        
	                    
	 
	                    var reader = new FileReader();
	                    reader.onload = function(img) {
	                        //div id="preview" 내에 동적코드추가.
	                        //이 부분을 수정해서 이미지 링크 외 파일명, 사이즈 등의 부가설명을 할 수 있을 것이다.
	                        var imgNum = previewIndex++;
	                        
	                        var previewId = "";
	                       
	                        if(imgNum==0){
	                        	previewId = "start";
	                        }else{
	                        	previewId = "startNo";	
	                        }
                        
	                        $("#preview").append(
	                                        "<div class=\"preview-box\" id="+previewId+"  value=\"" + imgNum +"\"  style='display:inline;float:left;width:208px' >"
	                                                + "<"+imgSelectName+" class=\"thumbnail\" src=\"" + img.target.result + "\"\/ width=\"200px;\" height=\"200px;\"/>"
	                                                + "<a href=\"#\" value=\""
	                                                + imgNum
	                                                + "\" onclick=\"deletePreview(this)\">"
	                                                + "삭제" + "</a>" + "</div>");
	                        files[imgNum] = file;
	                        
	                        fileNameArray[imgNum]=file.name;
	                        fnAddFile(fileNameArray);
	                    };

	                    reader.readAsDataURL(file);
	                }
	            } else
	                alert('invalid file input'); // 첨부클릭 후 취소시의 대응책은 세우지 않았다.
	        }
	 
	        //preview 영역에서 삭제 버튼 클릭시 해당 미리보기이미지 영역 삭제
	        function deletePreview(obj) {
	            var imgNum = obj.attributes['value'].value;
	            delete files[imgNum];
	            $("#preview .preview-box[value=" + imgNum + "]").remove();
	            resizeHeight();
	        }
	 
	        //client-side validation
	        //always server-side validation required
	        function validation(fileName) {
	            fileName = fileName + "";
	            var fileNameExtensionIndex = fileName.lastIndexOf('.') + 1;
	            var fileNameExtension = fileName.toLowerCase().substring(
	                    fileNameExtensionIndex, fileName.length);
	            if (!((fileNameExtension === 'jpg')|| (fileNameExtension === 'gif') || (fileNameExtension === 'png')||(fileNameExtension === 'avi')||(fileNameExtension === 'mp4'))) {
	                alert('jpg, gif, png, avi, mp4 확장자만 업로드 가능합니다.');
	                return true;
	            } else {
	                return false;
	            }
	        }
	 
	   	 		$(document).ready(function() {
	            //submit 등록. 실제로 submit type은 아니다.
	   	 /*
	            $('.submit a').on('click',function() {                        
	                var form = $('#uploadForm')[0];
	                var formData = new FormData(form);
	    
	                for (var index = 0; index < Object.keys(files).length; index++) {
	                    //formData 공간에 files라는 이름으로 파일을 추가한다.
	                    //동일명으로 계속 추가할 수 있다.
	                    formData.append('files',files[index]);
	                }

	                //ajax 통신으로 multipart form을 전송한다.
	                $.ajax({
	                    type : 'POST',
	                    enctype : 'multipart/form-data',
	                    processData : false,
	                    contentType : false,
	                    cache : false,
	                    timeout : 600000,
	                    url : '/imageupload',
	                    dataType : 'JSON',
	                    data : formData,
	                    success : function(result) {
	                        //이 부분을 수정해서 다양한 행동을 할 수 있으며,
	                        //여기서는 데이터를 전송받았다면 순수하게 OK 만을 보내기로 하였다.
	                        //-1 = 잘못된 확장자 업로드, -2 = 용량초과, 그외 = 성공(1)
	                        if (result === -1) {
	                            alert('jpg, gif, png, bmp 확장자만 업로드 가능합니다.');
	                            // 이후 동작 ...
	                        } else if (result === -2) {
	                            alert('파일이 10MB를 초과하였습니다.');
	                            // 이후 동작 ...
	                        } else {
	                            alert('이미지 업로드 성공');
	                            // 이후 동작 ...
	                        }
	                    }
	                    //전송실패에대한 핸들링은 고려하지 않음
	                });
	            });
	            */
	            // <input type=file> 태그 기능 구현
	            $('#attach input[type=file]').change(function() {
	                addPreview($(this)); //preview form 추가하기
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
		<h1 class="bg-primary text-center">상 품 등 록</h1>
	    </div>		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		
		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상 품 명</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodName" name="prodName" placeholder="상 품 명"  >
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodDetail" name="prodDetail" placeholder="상품상세정보">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="manuDate" name="manuDate" placeholder="제조일자">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="price" name="price" placeholder="가격">
		    </div>
		    <strong>원</strong>
		  </div>
		  
		  <div class="form-group">
		    <label for="count" class="col-sm-offset-1 col-sm-3 control-label">상품 수량</label>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="count" name="count" placeholder="상품 수량">
		    </div>
		    <strong>개</strong>
		  </div>
		  
		  
		  
		   <input type="hidden" class="form-control" id="multiFile" name="multiFile" >
		   
		   
		   
		  <div class="form-group">
		    <label for="uploadFile" class="col-sm-offset-1 col-sm-3 control-label">상품이미지</label>
		    <div class="col-sm-4">
		      <input type="file" class="form-control" id="uploadFile" name="uploadFile" >
		    </div>
		  </div>
            <!-- 첨부 버튼 -->
            <div id="attach">
                <label class="waves-effect waves-teal btn-flat" for="uploadInputBox">사진첨부(대표이미지는 파란테두리)</label>
                <input id="uploadInputBox" style="display: none" type="file" name="filedata" multiple />
            </div>
            
            <!-- 미리보기 영역 -->
            <div id="preview" class="content" style='display:inline;min-width:1200px;'></div>
            		  
            
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
