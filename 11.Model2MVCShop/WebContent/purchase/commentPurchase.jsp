<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<!-- <link rel="stylesheet" href="/css/admin.css" type="text/css"> -->
<!-- 참조 : http://getbootstrap.com/css/   참조 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

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

<script type="text/javascript" src="../javascript/calendar.js">
</script>

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">	
	$(function(){
		$("img[name='star']").on("click", function(){
			var index = $("img[name='star']").index(this);
			
			for(i=0; i<5; i++){
				if(i<=index){
					$($("img[name='star']")[i]).attr('src','/images/uploadFiles/roundstar_01.png');
				}else{
					$($("img[name='star']")[i]).attr('src','/images/uploadFiles/roundstar_02.png');
				}
			}
			
			$("#score").val(index+1);
		});
	});
	
	$(function(){
		$("button:contains('등록')").on("click", function(){
			$("form").attr("method", "POST").attr("action", "/purchase/commentPurchase").submit();
		});
		
		$("button:contains('취소')").on("click", function(){
			history.go(-1)
		});
	});
</script>

<title>Insert title here</title>
</head>
<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<!--  화면구성 div Start /////////////////////////////////////-->
	
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">상품평쓰기</h3>
	    </div>
	    
	    <form class="form-horizontal" name="detailForm" enctype="multipart/form-data">
	    
		<table  border="0" cellspacing="0" cellpadding="0"	style="margin:0px auto" align="center">
			<tr>
				<td rowspan="2">
					<c:if test="${!empty purchase.purchaseProd.fileNameList[0]}">
						<img src = "/images/uploadFiles/${purchase.purchaseProd.fileNameList[0]}" width="150"/>
					</c:if>
					<c:if test="${empty purchase.purchaseProd.fileNameList[0]}">
						<img src = "/images/uploadFiles/1298310238.png" width="150"/>
					</c:if>
				</td>
				<td rowspan="2" width="15"></td>
				<td colspan="10"><b><font size="5">${purchase.purchaseProd.prodName}</font></b></td>
			</tr>
			<tr>
				<td colspan="10">주문일시 : ${purchase.orderDate}</td>
			</tr>
			<tr>
				<td height="1" colspan="10" bgcolor="D6D6D6"></td>
			</tr>
			<tr height="50">
				<td><b><font size="5">별점</font></b></td>
				<td rowspan="2" width="15"></td>
				<td><img name="star" src="/images/uploadFiles/roundstar_01.png" width="30" />
				<img name="star" src="/images/uploadFiles/roundstar_02.png" width="30" />
				<img name="star" src="/images/uploadFiles/roundstar_02.png" width="30" />
				<img name="star" src="/images/uploadFiles/roundstar_02.png" width="30" />
				<img name="star" src="/images/uploadFiles/roundstar_02.png" width="30" /></td>
		
				<td><input type="hidden" id="score" name="score" value="1"></td>
			</tr>
			<tr>
				<td height="1" colspan="10" bgcolor="D6D6D6"></td>
			</tr>
			<tr height="50">
				<td><b><font size="5">상품평</font></b></td>
				<td rowspan="2" width="15"></td>
				<td colspan="10">
					<input type="text" name="commentText" class="form-control">
				</td>
			</tr>
			<tr>
				<td height="1" colspan="10" bgcolor="D6D6D6"></td>
			</tr>
			<tr height="50">
				<td><b><font size="5">파일첨부</font></b></td>
				<td rowspan="2" width="15"></td>
				<td colspan="10"><input	type="file" name="file" class="form-control" multiple="multiple"></td>
			</tr>
		</table>
		
		<br>
		
		<input type="hidden" name="tranNo" value="${purchase.tranNo }">
		<input type="hidden" name="prodNo" value="${purchase.purchaseProd.prodNo }">
		
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
			<c:if test="${!empty product}">
		      <button type="button" class="btn btn-primary"  >확인</button>
			  <a class="btn btn-primary btn" href="#" role="button">추가등록</a>
			</c:if>
			<c:if test="${empty product}">
		      <button type="button" class="btn btn-primary"  >등록</button>
			  <a class="btn btn-primary btn" href="#" role="button">취소</a>
			</c:if>
		    </div>
		  </div>
	    
	    </form>
	    
	</div>
</body>
</html>