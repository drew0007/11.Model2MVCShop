<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<html>
<head>
<title>구매 목록조회</title>

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
	function fncListPage(currentPage) {
		$("#currentPage").val(currentPage);
		$("form").attr("method","POST").attr("action","/purchase/listPurchase").submit();
	}
	
	$(function(){
		$("td:nth-child(2)").on("click", function(){
			var index = $("td:nth-child(2)").index(this);
			var tranNo = $($("input[name='tranNoList']")[index]).val();
			var tranCode = $($("input[name='tranCodeList']")[index]).val();
			self.location="/purchase/getPurchase?tranNo="+tranNo+"&tranCode="+tranCode;
		});
		
		$("td:nth-child(3)").on("click", function(){
			var index = $("td:nth-child(3)").index(this);
			var prodNo = $($("input[name='prodNoList']")[index]).val();
			var tranCode = $($("input[name='tranCodeList']")[index]).val();
			self.location="/product/getProduct?prodNo="+prodNo+"&menu=search&tranCode="+tranCode;
		});
		
		$("td:nth-child(10)").on("click", function(){
			var index = $("td:nth-child(10)").index(this);
			var prodNo = $($("input[name='prodNoList']")[index]).val();
			var tranNo = $($("input[name='tranNoList']")[index]).val();
			var tranCnt = $($("input[name='tranCntList']")[index]).val();
			var text = $($("td:nth-child(10)")[index]).text().trim();
			if(text == "구매취소요청"){
				self.location="/purchase/updateTranCode?tranNo="+tranNo+"&tranCnt="+tranCnt+"&tranCode=4&prodNo="+prodNo;
			}else if(text == "물건도착"){
				self.location="/purchase/updateTranCode?tranNo="+tranNo+"&tranCnt="+tranCnt+"&tranCode=3&prodNo="+prodNo;
			}else if(text == "상품평 작성"){
				self.location="/purchase/commentPurchase?tranNo="+tranNo+"&prodNo="+prodNo;
			}
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
	       <h3>구매 목록조회</h3>
	    </div>
	    
		<form class="form-inline" name="detailForm">
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
		  <input type="hidden" id="currentPage" name="currentPage" value="0"/>
	    	
		</div>
		<!-- table 위쪽 검색 Start /////////////////////////////////////-->
		<br>
		
		</form>
		
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th class="text-center">No</th>
            <th class="text-center">주문번호</th>
            <th class="text-center">상품명</th>
            <th class="text-center">상품이미지</th>
            <th class="text-center">가격</th>
            <th class="text-center">수량</th>
            <th class="text-center">구매방법</th>
            <th class="text-center">주문일시</th>
            <th class="text-center">상태</th>
            <th class="text-center"></th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="purchase" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">${ i }</td>
			  <td align="center">
				${purchase.tranNo}
				<input type="hidden" name="tranNoList" value="${purchase.tranNo}">
			  </td>
			  <td align="left">
				${purchase.purchaseProd.prodName}
				<input type="hidden" name="prodNoList" value="${purchase.purchaseProd.prodNo}">
			  </td>
			  <td align="center">
				<c:if test="${!empty purchase.purchaseProd.fileNameList[0]}">
					<img src = "/images/uploadFiles/${purchase.purchaseProd.fileNameList[0]}" width="150"/>
				</c:if>
				<c:if test="${empty purchase.purchaseProd.fileNameList[0]}">
					<img src = "/images/uploadFiles/1298310238.png" width="150"/>
				</c:if>
			  </td>
			  <td align="right">${purchase.purchaseProd.price} 원</td>
			  <td align="center">
				${purchase.tranCnt}
				<input type="hidden" name="tranCntList" value="${purchase.tranCnt}">
			  </td>
			  <td align="center">${purchase.paymentOption.equals('1')?"현금구매":"신용구매"}</td>
			  <td align="center">${purchase.orderDate}</td>
			  <td align="center">
				${purchase.tranCode.equals('1')?"구매완료":purchase.tranCode.equals('2')?"배송중":purchase.tranCode.equals('3')?"배송완료":purchase.tranCode.equals('4')?"구매취소요청":purchase.tranCode.equals('5')?"구매취소":"" }
				<input type="hidden" name="tranCodeList" value="${purchase.tranCode}">
			  </td>	
			  <td align="center">
				${purchase.tranCode.equals('1')?"구매취소요청":purchase.tranCode.equals('2')?"물건도착":purchase.tranCode.equals('3')?"상품평 작성":"" }
			  </td>
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
   	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->

</body>
</html>