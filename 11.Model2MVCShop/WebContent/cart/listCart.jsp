<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%@ page import="java.net.URLEncoder"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<html>
<head>
<title>장바구니 조회</title>

<!-- 참조 : http://getbootstrap.com/css/   참조 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!-- autocomple -->
<!-- <link rel="stylesheet" href="/css/admin.css" type="text/css"> -->
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
 	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<style>
	.ui-autocomplete {
		max-height: 100px;
		overflow-y: auto;
		/* prevent horizontal scrollbar */
		overflow-x: hidden;
	}
	
	/* IE 6 doesn't support max-height
	 * we use height instead, but this forces the menu to always be this tall
	 */
	
	* html .ui-autocomplete {
		height: 100px;
	}
</style>

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
       
  .table.table-hover.table-striped td {vertical-align: middle}
</style>
<script type="text/javascript">
function fncSumPrice(){
	var listSize = ${list.size()};
	var sumPrice = 0;

	for(i=0; i<listSize; i++){
		if($($("input[name='cartChk']")[i]).prop("checked")){
			sumPrice += parseInt($($("input[name='price']")[i]).val());
		}
	}
	
	$("#sumPrice").val(sumPrice);
}

$(function(){
	$("#cartChkAll").on("click",function(){
		if($("#cartChkAll").prop("checked")){
			$("input[name='cartChk']:checkbox").each(function(){
				$(this).prop('checked', true);
			});
		}else{
			$("input[name='cartChk']:checkbox").each(function(){
				$(this).prop('checked', false);
			});
		}
		fncSumPrice();
	});
	
	$("input[name='cartChk']").on("click", function(){
		fncSumPrice();
	});
});

$(function(){
	$("td:nth-child(2)").on("click", function(){
		var index = $("td:nth-child(2)").index(this);
		var prodNo = $($("input[name='prodNo']")[index]).val();
		location.href="/product/getProduct?prodNo="+prodNo+"&menu=search";
	});
	
	$("input[name='cartCnt']").on("change", function(){
		var index = $("input[name='cartCnt']").index(this);
		$($("input[name='cntChange']")[index]).attr("type", "button");
	});
	
	$("input[name='cntChange']").on("click", function(){
		var index = $("input[name='cntChange']").index(this);
		var cartNo = $($("input[name='cartNo']")[index]).val();
		var cartCnt = $($("input[name='cartCnt']")[index]).val();
		var prodCnt = $($("input[name='prodCnt']")[index]).val();

		if(cartCnt == null || cartCnt.length<1){
			alert("수량은 반드시 입력하셔야 합니다.");
			return;
		}
		if(parseInt(cartCnt) > parseInt(prodCnt)){
			alert("재고 수량을 초과할 수 없습니다.");
			return;
		}

		location.href="/cart/updateCart?cartNo="+cartNo+"&cartCnt="+cartCnt;
		/* 
		$.ajax(
				{
					url : "/cart/json/updateCart/"+cartNo+"/"+cartCnt,
					method : "GET",
					dataType : "json",
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
				success : function(JSONData , status){
					//alert(index);
					$($("input[name='cntChange']")[index]).attr("type", "hidden");
					alert("확인");
				}
			}); */
	});
});

$(function(){
	$("p.state1").on("click",function(){
		if($(this).text().trim() == '재고없음'){
			return;
		}
		var index = $("p.state1").index(this);
		var prodNo = $($("input[name='prodNo']")[index]).val();
		var cartCnt = $($("input[name='cartCnt']")[index]).val();
		var cartNo = $($("input[name='cartNo']")[index]).val();
		location.href="/purchase/addPurchaseView?cartList=" + cartNo;
	});
	
	$("p.state2").on("click",function(){
		var index = $("p.state2").index(this);
		var cartNo = $($("input[name='cartNo']")[index]).val();
		location.href="/cart/deleteCart?cartNo="+cartNo;
	});
	
	$("button:contains('구매하기')").on("click", function(){
		var cartList = "";
		var listSize = ${list.size()};
		
		for(i=0; i<listSize; i++){
			if($($("input[name='cartChk']")[i]).prop("checked")){
				cartList += ($($("input[name='cartNo']")[i]).val()) + ",";
			}
		}

		if(cartList == ""){
			alert("1개 이상의 상품을 선택해주세요.");
			return;
		}
		
		location.href="/purchase/addPurchaseView?cartList=" + cartList;
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
	       <h3>장바구니</h3>
	    </div>
	    
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수
		    	</p>
		    </div>
		    	    	
		</div>
		<!-- table 위쪽 검색 Start /////////////////////////////////////-->
		<br>
				
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th class="text-center">
				<input type="checkbox" id="cartChkAll" name="cartChkAll">
			</th>
            <th class="text-center">상품명</th>
            <th class="text-center">상품이미지</th>
            <th class="text-center">재고수량</th>
            <th class="text-center">가격</th>
            <th class="text-center">구매수량</th>
            <th class="text-center">구매금액</th>
            <th class="text-center"></th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="cart" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">
				<input type=${cart.cartCnt <= cart.cartProd.prodCnt ? "checkbox" : "hidden"} id="cartChk" name="cartChk">
				<input type="hidden" id="cartNo" name="cartNo" value="${cart.cartNo}">
			  </td>
			  <td align="left">
				${cart.cartProd.prodName}
				<input type="hidden" id="prodNo" name="prodNo" value="${cart.cartProd.prodNo}">
			  </td>
			  <td align="center">
				<c:if test="${!empty cart.cartProd.fileNameList[0]}">
					<img src = "/images/uploadFiles/${cart.cartProd.fileNameList[0]}" width="150"/>
				</c:if>
				<c:if test="${empty cart.cartProd.fileNameList[0]}">
					<img src = "/images/uploadFiles/1298310238.png" width="150"/>
				</c:if>
			  </td>
			  <td align="center">
				${cart.cartProd.prodCnt}
				<input type="hidden" name="prodCnt" id="prodCnt" value="${cart.cartProd.prodCnt }"/>
			  </td>
			  <td align="right">${cart.cartProd.price} 원</td>
			  <td align="center">
				<input type="text" name="cartCnt" id="cartCnt" 	class="form-control"
							style="width: 80px; height: 25px" maxLength="5" value="${cart.cartCnt}" /><br/>
				<input type="hidden" name="cntChange" id="cntChange" value="수량변경"
							class="btn btn-primary" style="width: 80px; height: 30px"/>
			  </td>
			  <td align="right">
				${cart.cartProd.price * cart.cartCnt} 원
				<input type="hidden" id="price" name="price" value="${cart.cartProd.price * cart.cartCnt}"/>
			  </td>	
			  <td align="center">
				<p class="state1">${cart.cartCnt <= cart.cartProd.prodCnt?"구매":"재고없음"}</p>
				<p class="state2">삭제</p>
			  </td>
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
	  <div class="row">
	  		<div class="col-md-12 text-right ">
	  			총 구매금액 : 
				<input style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px; text-align:right" 
						type="text" id="sumPrice" size="10" value="0" readonly="readonly">
				 원 &nbsp;&nbsp;
	  			<button type="button" class="btn btn-primary">구매하기</button>
	  		</div>
		</div>
 	</div>
 	<br>
   	
</body>
</html>
