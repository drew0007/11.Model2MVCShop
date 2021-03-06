<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>
<head>

<!-- <link rel="stylesheet" href="/css/admin.css" type="text/css"> -->

<title>Insert title here</title>

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
       
  .table.table-hover.table-striped td {vertical-align: middle}
</style>

<script type="text/javascript" src="../javascript/calendar.js">
</script>

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	function execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var fullAddr = ''; // 최종 주소 변수
	            var extraAddr = ''; // 조합형 주소 변수
	
	            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                fullAddr = data.roadAddress;
	
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                fullAddr = data.jibunAddress;
	            }
	
	            // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
	            if(data.userSelectedType === 'R'){
	                //법정동명이 있을 경우 추가한다.
	                if(data.bname !== ''){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있을 경우 추가한다.
	                if(data.buildingName !== ''){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	            }
	
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('postcode').value = data.zonecode; //5자리 새우편번호 사용
	            document.getElementById('address').value = fullAddr;
	
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById('address2').focus();
	        }
	    }).open();
	}
	
	function fncAddPurchase() {
		var listSize = ${list.size()};
		var prodNoList = "";
		var tranCntList = "";	
		
		for(i=0; i<listSize; i++){
			prodNoList += $($("input[name=prodNo]")[i]).val() + ",";
			tranCntList += $($("input[name=tranCnt]")[i]).val() + ",";
		}
		
		$("#prodNoList").val(prodNoList);
		$("#tranCntList").val(tranCntList);
		
		$("form").attr("method" , "POST").attr("action" , "/purchase/addPurchase").submit();
	}
	
	$(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
		$("button.btn.btn-primary:contains('구매')").on("click", function(){
			fncAddPurchase();
		});
		
		$( "button.btn.btn-primary:contains('취소')" ).on("click" , function() {
			history.go(-1);
		});
	});
	
	$(function(){
		$("td:nth-child(2)").on("click", function(){
			var index = $("td:nth-child(2)").index(this);
			var val = $($("input[name='prodNo']")[index]).val();
			self.location = "/product/getProduct?prodNo="+val+"&menu=search";
		});
	});
	
	$(function(){
		$("img[name='divyDateImg']").on("click", function(){
			show_calendar('document.detailForm.divyDate', document.detailForm.divyDate.value);
		});
	});
	
	$(function(){
		$("button[id='execPostcode']").on("click", function(){
			execDaumPostcode();
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
	
		<div class="page-header">
	       <h3 class=" text-info">상품구매</h3>
	    </div>
	    
	    <form class="form-horizontal" name="detailForm">
	    
		<input type="hidden" name="prodNoList" id="prodNoList" value="" />
		<input type="hidden" name="tranCntList" id="tranCntList" value="" />
			    
	    <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th class="text-center">No</th>
            <th class="text-center">상품명</th>
            <th class="text-center">상품이미지</th>
            <th class="text-center">구매수량</th>
            <th class="text-center">구매금액</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="sum" value="0"/>
		  <c:set var="i" value="0"/>
		  <c:forEach var="cart" items="${list }">
		  <c:set var="i" value="${i+1 }"/>
		  <c:set var="sum" value="${sum + cart.cartProd.price * cart.cartCnt}"/>
			<tr>
			  <td align="center">
			  	${ i }
			  	<input type="hidden" name="prodNo" id="prodNo" value="${cart.cartProd.prodNo}" />
			  </td>
			  <td align="left">
			  	${cart.cartProd.prodName}
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
			  	${cart.cartCnt}
				<input type="hidden" name="tranCnt" id="tranCnt" value="${cart.cartCnt}"/>
			  </td>
			  <td align="right">${cart.cartProd.price * cart.cartCnt} 원</td>
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
      
      
      
      
	  <div class="form-group">
	    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">구매자아이디</label>
	    <div class="col-sm-4">
	      	<input type="text" class="form-control" readonly="readonly"
	      		id="userId" name="userId" value="${user.userId}">
	    </div>
	  </div>
	  
	  <div class="form-group">
	    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
	    <div class="col-sm-4">
			<select 	name="paymentOption"		class="form-control" >
				<option value="1" selected="selected">현금구매</option>
				<option value="2">신용구매</option>
			</select>
	    </div>
	  </div>
      
	  <div class="form-group">
	    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">구매자이름</label>
	    <div class="col-sm-4">
	      	<input type="text" class="form-control" 
	      		id="receiverName" name="receiverName" value="${user.userName}">
	    </div>
	  </div>
      
	  <div class="form-group">
	    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">구매자연락처</label>
	    <div class="col-sm-4">
	      	<input type="text" class="form-control" 
	      		id="receiverPhone" name="receiverPhone" value="${user.phone}">
	    </div>
	  </div>
	  
	  <div class="form-group">
	    <label for="divyPostcode" class="col-sm-offset-1 col-sm-3 control-label">주소</label>
	    <div class="col-sm-2">
			<input type="text" class="form-control" id="postcode" name="divyPostcode" value="${user.postcode}">
	    </div>
		<div class="col-sm-3">
      		<button type="button" id="execPostcode" class="btn btn-info">우편번호 찾기</button>
    	</div>
	  </div>
	  
	  <div class="form-group">
	    <label for="divyAddress" class="col-sm-offset-1 col-sm-3 control-label"></label>
	    <div class="col-sm-4">
			<input type="text" id="address" name="divyAddress" size="50" class="form-control" value="${user.address}">
	    </div>
	  </div>
	  
	  <div class="form-group">
	    <label for="divyAddress2" class="col-sm-offset-1 col-sm-3 control-label"></label>
	    <div class="col-sm-4">
			<input type="text" id="address2" name="divyAddress2" class="form-control" value="${user.address2}">
	    </div>
	  </div>
      
	  <div class="form-group">
	    <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
	    <div class="col-sm-4">
	      	<input type="text" class="form-control" 
	      		id="divyRequest" name="divyRequest">
	    </div>
	  </div>
	  
	  <div class="form-group">
	    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
	    <div class="col-sm-3">
	      	<input type="text" class="form-control" readonly="readonly"
	      		id="divyDate" name="divyDate">
	    </div>
	    <div class="col-sm-3">
	      	<img name="divyDateImg" src="../images/ct_icon_date.gif" width="30" height="30"/>
	    </div>
	  </div>
      
	  <div class="form-group">
	    <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">총 주문금액</label>
	    <div class="col-sm-4">
	      	${sum} 원
	    </div>
	  </div>
		
	  <div class="form-group">
	    <div class="col-sm-offset-4  col-sm-4 text-center">
	      <button type="button" class="btn btn-primary"  >구매</button>
	      <button type="button" class="btn btn-primary"  >취소</button>
	    </div>
	  </div>
		
		
	  </form>
	    
    </div>

</body>
</html>