<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<title>회원정보수정</title>

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

<!-- <link rel="stylesheet" href="/css/admin.css" type="text/css"> -->

<script type="text/javascript" src="../javascript/calendar.js">
</script>

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

//============= "수정"  Event 연결 =============
 $(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$( "button.btn.btn-primary:contains('수정')" ).on("click" , function() {//Form 유효성 검증
			var name = $("input[name='prodName']").val();
			var detail = $("input[name='prodDetail']").val();
			var manuDate = $("input[name='manuDate']").val();
			var price = $("input[name='price']").val();
			var prodCnt = $("input[name='prodCnt']").val();
		
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
			if(prodCnt == null || prodCnt.length<1){
				alert("수량은 반드시 입력하셔야 합니다.");
				return;
			}

			$("form").attr("method" , "POST").attr("action" , "/product/updateProduct?menu=manage").submit();
		});
	});	
	
	$(function(){
		$("img[name='manuDateImg']").on("click", function(){
			show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value);
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
	       <h3>상품수정</h3>
	    </div>
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal" name="detailForm" enctype="multipart/form-data">
		
		<input type="hidden" name="prodNo" value="${param.prodNo}"/>
		
		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상 품 명</label>
		    <div class="col-sm-4">
		      	<input type="text" class="form-control" 
		      		id="prodName" name="prodName" value="${product.prodName}">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
		    <div class="col-sm-4">
		      	<input type="text" class="form-control" 
		      		id="prodDetail" name="prodDetail" value="${product.prodDetail}">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
		    <div class="col-sm-3">
		      	<input type="text" class="form-control" readonly="readonly"
		      		id="manuDate" name="manuDate" value="${product.manuDate}">
		    </div>
		    <div class="col-sm-3">
		      	<img name="manuDateImg" src="../images/ct_icon_date.gif" width="30" height="30"/>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
		    <div class="col-sm-4">
		      	<input type="text" class="form-control"
		      		id="price" name="price" value="${product.price}">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="prodCnt" class="col-sm-offset-1 col-sm-3 control-label">수량</label>
		    <div class="col-sm-4">
		      	<input type="text" class="form-control"
		      		id="prodCnt" name="prodCnt" value="${product.prodCnt}">
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">상품이미지</label>
		    <div class="col-sm-4">
		      	<input type="file" class="form-control" multiple="multiple"
		      		id="file" name="file" value="${product.fileName}">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >수정</button>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
		
 	</div>
	<!--  화면구성 div end /////////////////////////////////////-->
	
</body>
</html>