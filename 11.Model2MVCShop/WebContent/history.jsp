<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page contentType="text/html; charset=EUC-KR" %>

<html>
<head>

<title>열어본 상품 보기</title>
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script type="text/javascript">
/* 	
	$(function() {
		
		$("h7").css("color" , "red");
		
		$("h7").on("click" , function(event) {
			$(window.parent.frames["rightFrame"].document.location).attr("href","/purchase//product/getProduct?prodNo="+$(this).children("input").val()+"&menu=search");
			//self.location = "/product/getProduct?prodNo="+$(this).children("input").val()+"&menu=search" 
					
		});
		
	}); */
	</script>
</head>
<body>
	당신이 열어본 상품을 알고 있다
<br>
<br>
<%
	request.setCharacterEncoding("euc-kr");
	response.setCharacterEncoding("euc-kr");
	String history = null;
	Cookie[] cookies = request.getCookies();
	if (cookies!=null && cookies.length > 0) {
		for (int i = 0; i < cookies.length; i++) {
			Cookie cookie = cookies[i];
			if (cookie.getName().equals("history")) {
				history = cookie.getValue();
			}
		}
		if (history != null) {
			String[] h = history.split(",");
			for (int i = 0; i < h.length; i++) {
				if (!h[i].equals("null")) {
%>
 <a href="/product/getProduct?prodNo=<%=h[i]%>&menu=search"
	target="rightFrame"><%=h[i]%></a> 
<br>
<%-- 	<h7>
	
	<input type="hidden" name="prodNo" value="<%=h[i]%>" />
			
		<%=h[i]%>
	</h7> 
<br> --%>
<%
				}
			}
		}
	}
%>

</body>
</html>