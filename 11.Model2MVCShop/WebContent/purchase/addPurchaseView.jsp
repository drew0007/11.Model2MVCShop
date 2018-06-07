<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>
<head>

<!-- <link rel="stylesheet" href="/css/admin.css" type="text/css"> -->

<title>Insert title here</title>

<!-- ���� : http://getbootstrap.com/css/   ���� -->
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

<!-- jQuery UI toolTip ��� CSS-->
 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 <!-- jQuery UI toolTip ��� JS-->
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
	            // �˾����� �˻���� �׸��� Ŭ�������� ������ �ڵ带 �ۼ��ϴ� �κ�.
	
	            // �� �ּ��� ���� ��Ģ�� ���� �ּҸ� �����Ѵ�.
	            // �������� ������ ���� ���� ��쿣 ����('')���� �����Ƿ�, �̸� �����Ͽ� �б� �Ѵ�.
	            var fullAddr = ''; // ���� �ּ� ����
	            var extraAddr = ''; // ������ �ּ� ����
	
	            // ����ڰ� ������ �ּ� Ÿ�Կ� ���� �ش� �ּ� ���� �����´�.
	            if (data.userSelectedType === 'R') { // ����ڰ� ���θ� �ּҸ� �������� ���
	                fullAddr = data.roadAddress;
	
	            } else { // ����ڰ� ���� �ּҸ� �������� ���(J)
	                fullAddr = data.jibunAddress;
	            }
	
	            // ����ڰ� ������ �ּҰ� ���θ� Ÿ���϶� �����Ѵ�.
	            if(data.userSelectedType === 'R'){
	                //���������� ���� ��� �߰��Ѵ�.
	                if(data.bname !== ''){
	                    extraAddr += data.bname;
	                }
	                // �ǹ����� ���� ��� �߰��Ѵ�.
	                if(data.buildingName !== ''){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // �������ּ��� ������ ���� ���ʿ� ��ȣ�� �߰��Ͽ� ���� �ּҸ� �����.
	                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	            }
	
	            // �����ȣ�� �ּ� ������ �ش� �ʵ忡 �ִ´�.
	            document.getElementById('postcode').value = data.zonecode; //5�ڸ� �������ȣ ���
	            document.getElementById('address').value = fullAddr;
	
	            // Ŀ���� ���ּ� �ʵ�� �̵��Ѵ�.
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
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����.	
		$("button.btn.btn-primary:contains('����')").on("click", function(){
			fncAddPurchase();
		});
		
		$( "button.btn.btn-primary:contains('���')" ).on("click" , function() {
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
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">��ǰ����</h3>
	    </div>
	    
	    <form class="form-horizontal" name="detailForm">
	    
		<input type="hidden" name="prodNoList" id="prodNoList" value="" />
		<input type="hidden" name="tranCntList" id="tranCntList" value="" />
			    
	    <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th class="text-center">No</th>
            <th class="text-center">��ǰ��</th>
            <th class="text-center">��ǰ�̹���</th>
            <th class="text-center">���ż���</th>
            <th class="text-center">���űݾ�</th>
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
			  <td align="right">${cart.cartProd.price * cart.cartCnt} ��</td>
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
      
      
      
      
	  <div class="form-group">
	    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">�����ھ��̵�</label>
	    <div class="col-sm-4">
	      	<input type="text" class="form-control" readonly="readonly"
	      		id="userId" name="userId" value="${user.userId}">
	    </div>
	  </div>
	  
	  <div class="form-group">
	    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">���Ź��</label>
	    <div class="col-sm-4">
			<select 	name="paymentOption"		class="form-control" >
				<option value="1" selected="selected">���ݱ���</option>
				<option value="2">�ſ뱸��</option>
			</select>
	    </div>
	  </div>
      
	  <div class="form-group">
	    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">�������̸�</label>
	    <div class="col-sm-4">
	      	<input type="text" class="form-control" 
	      		id="receiverName" name="receiverName" value="${user.userName}">
	    </div>
	  </div>
      
	  <div class="form-group">
	    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">�����ڿ���ó</label>
	    <div class="col-sm-4">
	      	<input type="text" class="form-control" 
	      		id="receiverPhone" name="receiverPhone" value="${user.phone}">
	    </div>
	  </div>
	  
	  <div class="form-group">
	    <label for="divyPostcode" class="col-sm-offset-1 col-sm-3 control-label">�ּ�</label>
	    <div class="col-sm-2">
			<input type="text" class="form-control" id="postcode" name="divyPostcode" value="${user.postcode}">
	    </div>
		<div class="col-sm-3">
      		<button type="button" id="execPostcode" class="btn btn-info">�����ȣ ã��</button>
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
	    <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">���ſ�û����</label>
	    <div class="col-sm-4">
	      	<input type="text" class="form-control" 
	      		id="divyRequest" name="divyRequest">
	    </div>
	  </div>
	  
	  <div class="form-group">
	    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">����������</label>
	    <div class="col-sm-3">
	      	<input type="text" class="form-control" readonly="readonly"
	      		id="divyDate" name="divyDate">
	    </div>
	    <div class="col-sm-3">
	      	<img name="divyDateImg" src="../images/ct_icon_date.gif" width="30" height="30"/>
	    </div>
	  </div>
      
	  <div class="form-group">
	    <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">�� �ֹ��ݾ�</label>
	    <div class="col-sm-4">
	      	${sum} ��
	    </div>
	  </div>
		
	  <div class="form-group">
	    <div class="col-sm-offset-4  col-sm-4 text-center">
	      <button type="button" class="btn btn-primary"  >����</button>
	      <button type="button" class="btn btn-primary"  >���</button>
	    </div>
	  </div>
		
		
	  </form>
	    
    </div>

</body>
</html>