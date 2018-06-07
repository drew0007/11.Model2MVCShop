<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>상품등록</title>

<!-- 참조 : http://getbootstrap.com/css/   참조 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<!--  ///////////////////////// CSS ////////////////////////// -->
<!-- <style>
   body > div.container{
    	border: 3px solid #D6CDB7;
        margin-top: 10px;
    }
</style> -->


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
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">


<script type="text/javascript" src="../javascript/calendar.js"></script>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	
	function fncAddProduct(){
		//Form 유효성 검증
		var name = $("input[name='prodName']").val();
		var detail = $("input[name='prodDetail']").val();
		var manuDate = $("input[name='manuDate']").val();
		var price = $("input[name='price']").val();
		var cnt = $("input[name='prodCnt']").val();
	
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
		if(cnt == null || cnt.length<1){
			alert("수량은 반드시 입력하셔야 합니다.");
			return;
		}

		$("form").attr("method" , "POST").attr("action" , "/product/addProduct").submit();
	}

	//============= "확인"  Event 연결 =============
	 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-primary:contains('확인')" ).on("click" , function() {
				$("form").attr("method" , "GET").attr("action" , "/product/listProduct?menu=manage").submit();
			});
		});

	//============= "추가등록"  Event 연결 =============
	 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#' ]:contains('추가등록')").on("click" , function() {
				self.location = "/product/addProductView.jsp";
			});
		});
	
	//============= "등록"  Event 연결 =============
	 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-primary:contains('등록')" ).on("click" , function() {
				fncAddProduct();
			});
		});	
	
	//============= "취소"  Event 처리 및  연결 =============
		$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#' ]:contains('취소')").on("click" , function() {
				$("form")[0].reset();
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
	       <h3>${!empty product?'상 품 등 록 완 료':'상 품 등 록'}</h3>
	    </div>
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal" name="detailForm" enctype="multipart/form-data">
		
		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상 품 명</label>
		    <div class="col-sm-4"  ${!empty product?'':'hidden'}>
				<div class="form-control">${product.prodName}</div>
		    </div>
		    <div class="col-sm-4"  ${empty product?'':'hidden'}>
		      	<input type="text" class="form-control" 
		      		id="prodName" name="prodName" placeholder="상품명">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
		    <div class="col-sm-4" ${!empty product?'':'hidden'}>
		      	<div class="form-control">${product.prodDetail}</div>
		    </div>
		    <div class="col-sm-4" ${empty product?'':'hidden'}>
		      	<input type="text" class="form-control" 
		      		id="prodDetail" name="prodDetail" placeholder="상품상세정보">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
		    <div class="col-sm-4" ${!empty product?'':'hidden'}>
		      	<div class="form-control">${product.manuDate}</div>
		    </div>
		    <div class="col-sm-3" ${empty product?'':'hidden'}>
		      	<input type="text" class="form-control" readonly="readonly"
		      		id="manuDate" name="manuDate">
		    </div>
		    <div class="col-sm-3" ${empty product?'':'hidden'}>
		      	<img name="manuDateImg" src="../images/ct_icon_date.gif" width="30" height="30"/>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
		    <div class="col-sm-4" ${!empty product?'':'hidden'}>
		      	<div class="form-control">${product.price}&nbsp;원</div>
		    </div>
		    <div class="col-sm-4" ${empty product?'':'hidden'}>
		      	<input type="text" class="form-control"
		      		id="price" name="price" placeholder="가격">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="prodCnt" class="col-sm-offset-1 col-sm-3 control-label">수량</label>
		    <div class="col-sm-4" ${!empty product?'':'hidden'}>
		      	<div class="form-control">${product.prodCnt}</div>
		    </div>
		    <div class="col-sm-4" ${empty product?'':'hidden'}>
		      	<input type="text" class="form-control"
		      		id="prodCnt" name="prodCnt" placeholder="수량">
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">상품이미지</label>
		    <div class="col-sm-4" ${!empty product?'':'hidden'}>
		      	<c:forEach var="file" items="${product.fileNameList}">
					<c:if test="${!empty file}">
						<img src = "/images/uploadFiles/${file}" width="200"/>
					</c:if>
				</c:forEach>
		    </div>
		    <div class="col-sm-4" ${empty product?'':'hidden'}>
		      	<input type="file" class="form-control" multiple="multiple"
		      		id="file" name="file">
		    </div>
		  </div>
		  
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
		<!-- form Start /////////////////////////////////////-->
		
 	</div>
	<!--  화면구성 div end /////////////////////////////////////-->
	
	
</body>
</html>