<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%@ page import="java.net.URLEncoder"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>상품 목록조회</title>

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
 
	function fncGetProductList(currentPage){
		$("#currentPage").val(currentPage);
		$("form").attr("method", "POST").attr("action", "/product/listProduct?menu=${param.menu}").submit();
	}
	function fncListPage(currentPage){
		$("#searchCondition").val("${search.searchCondition}");
		$("#searchKeyword").val("${search.searchKeyword}");
		fncGetProductList(currentPage);
	}
	  
	$(function(){
		$(".sort1").on("click", function(){
			var sort = $("#sort").val();
			if(sort == "asc"){
				$("#sort").val("default");
			}else{
				$("#sort").val("asc");
			}
			fncListPage(1);
		});

		$(".sort2").on("click", function(){
			var sort = $("#sort").val();
			if(sort == "dsc"){
				$("#sort").val("default");
			}else{
				$("#sort").val("dsc");
			}
			fncListPage(1);
		});
	});
	
	$(function(){
		$( ".btn-default" ).on("click" , function() {
			fncGetProductList(1);
		});
		
		$("td:nth-child(2)").on("click", function(){
			var menu = "${param.menu}";
			var index = $("td:nth-child(2)").index(this);
			var val = $($("input[name='prodNo']")[index]).val();
			
			if(menu == 'manage'){
				self.location = "/product/updateProductView?prodNo="+val+"&menu="+menu;
			}else{
				self.location = "/product/getProduct?prodNo="+val+"&menu="+menu;
			}
		});
		
		$("td:contains('확인')").on("click", function(){
			var index = $("td:contains('확인')").index(this);
			var val = $($("input[name='prodNo']")[index]).val();
			
			self.location ="/purchase/historyPurchase?prodNo="+val;
		});
	});
	$( function() {
	    var autocompleNo = [];
	    var autocompleName = [];
	    var autocomplePrice = [];
	    
	    $.ajax( 
				{
					url : "/product/json/autocompleteProduct" ,
					method : "GET" ,
					dataType : "json" ,
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					success : function(JSONData , status) {
						for(i=0; i<JSONData.length; i++){
							autocompleNo.push(JSON.stringify(JSONData[i].prodNo));
							autocompleName.push(JSONData[i].prodName);
							autocomplePrice.push(JSON.stringify(JSONData[i].price));
						}
					}
			});

	    $( "input[name=searchKeyword]" ).autocomplete({
	      source: autocompleNo
	    });
	    
	    $("select[name=searchCondition]").on("change", function(){
	    	var value = $(this).val();
	    	if(value == "0"){
	    		$( "input[name=searchKeyword]" ).autocomplete({
	  		      source: autocompleNo
	  		    });	    		
	    	} else if(value == "1"){
	    		$( "input[name=searchKeyword]" ).autocomplete({
	  		      source: autocompleName
	  		    });
	    	} else{
	    		$( "input[name=searchKeyword]" ).autocomplete({
		  		      source: autocomplePrice
		  		    });
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
	       <h3>${param.menu.equals('manage')?"판매 상품관리":"상품 목록조회"}</h3>
	    </div>
	    
		<form class="form-inline" name="detailForm">
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0"  ${ ! empty search.searchCondition && search.searchCondition.equals("0") ? "selected" : "" }>상품번호</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition.equals("1") ? "selected" : "" }>상품명</option>
						<option value="2"  ${ ! empty search.searchCondition && search.searchCondition.equals("2") ? "selected" : "" }>상품가격</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">검색</button>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value="0"/>
				  
	    	</div>
	    	
		</div>
		<!-- table 위쪽 검색 Start /////////////////////////////////////-->
		<br>
		
		<div class="row">
		    <div class="col-md-6 text-left">
		    </div>
		    <div class="col-md-6 text-right">
				<div class="form-group">
					<c:if test="${search.sort.equals('asc')}">
						<img src="/images/ct_icon_red.gif" width="5" height="5" align="middle"/> 
						<span class="sort1"><b>낮은 가격 순</b></span>
					</c:if>
					<c:if test="${!search.sort.equals('asc')}">
						<img src="/images/empty.gif" width="5" height="5" align="middle"/> 
						<span class="sort1">낮은 가격 순</span>
					</c:if>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<c:if test="${search.sort.equals('dsc')}">
						<img src="/images/ct_icon_red.gif" width="5" height="5" align="middle"/> 
						<span class="sort2"><b>높은 가격 순</b></span>
					</c:if>
					<c:if test="${!search.sort.equals('dsc')}">
						<img src="/images/empty.gif" width="5" height="5" align="middle"/> 
						<span class="sort2">높은 가격 순</span>
					</c:if>
					<input type="hidden" id="sort" name="sort" value="${empty search.sort?'default':search.sort }"/>
				</div>
			</div>
		</div>
		</form>
		
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th class="text-center">No</th>
            <th class="text-center">상품명</th>
            <th class="text-center">상품이미지</th>
            <th class="text-center">가격</th>
            <th class="text-center">재고수량</th>
            <th class="text-center">등록일</th>
            <th class="text-center">평점</th>
            <th class="text-center">현재상태</th>
            <th class="text-center">${param.menu.equals('manage')?'판매내역':''}</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="product" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">${ i }</td>
			  <td align="left">
			  	<input type="hidden" name="prodNo" value="${product.prodNo }">
			  	${product.prodName}
			  </td>
			  <td align="center">
				<c:if test="${!empty product.fileNameList[0]}">
					<img src = "/images/uploadFiles/${product.fileNameList[0]}" width="150"/>
				</c:if>
				<c:if test="${empty product.fileNameList[0]}">
					<img src = "/images/uploadFiles/1298310238.png" width="150"/>
				</c:if>
			  </td>
			  <td align="right">${product.price} 원</td>
			  <td align="center">${product.prodCnt}</td>
			  <td align="center">${product.regDate}</td>
			  <td align="center">${product.scoreAvg}</td>
			  <td align="center">
					${product.prodCnt != 0?"판매중":"재고없음" }
			  </td>	
			  <td align="center">${param.menu.equals('manage')?'확인':'' }</td>
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
