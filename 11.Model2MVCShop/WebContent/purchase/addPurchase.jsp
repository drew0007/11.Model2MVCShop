<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<html>
<head>
<title>Insert title here</title>
<!-- <link rel="stylesheet" href="/css/admin.css" type="text/css"> -->
</head>

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
	$(function(){
		$("td:nth-child(2)").on("click", function(){
			var index = $("td:nth-child(2)").index(this);
			var val = $($("input[name='prodNo']")[index]).val();
			self.location = "/product/getProduct?prodNo="+val+"&menu=search";
		});
	});
</script>

<body>


	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">���ſϷ�</h3>
	       <h5 class="text-muted">������ ���� ���Ű� �Ǿ����ϴ�.</h5>
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
		  <c:forEach var="purchase" items="${list }">
		  <c:set var="i" value="${i+1 }"/>
		  <c:set var="sum" value="${sum + purchase.purchaseProd.price * purchase.tranCnt}"/>
			<tr>
			  <td align="center">
			  	${ i }
			  	<input type="hidden" name="prodNo" id="prodNo" value="${purchase.purchaseProd.prodNo}" />
			  </td>
			  <td align="left">
			  	${purchase.purchaseProd.prodName}
			  </td>
			  <td align="center">
				<c:if test="${!empty purchase.purchaseProd.fileNameList[0]}">
					<img src = "/images/uploadFiles/${purchase.purchaseProd.fileNameList[0]}" width="150"/>
				</c:if>
				<c:if test="${empty purchase.purchaseProd.fileNameList[0]}">
					<img src = "/images/uploadFiles/1298310238.png" width="150"/>
				</c:if>
			  </td>
			  <td align="center">
			  	${purchase.tranCnt}
			  </td>
			  <td align="right">${purchase.purchaseProd.price * purchase.tranCnt} ��</td>
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>

	  <div class="form-group">
	    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">�����ھ��̵�</label>
	    <div class="col-sm-4">
		    <div class="form-control">${user.userId}</div>
	    </div>
	  </div>
	  
	  <div class="form-group">
	    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">���Ź��</label>
	    <div class="col-sm-4">
			<div class="form-control">${list[0].paymentOption.equals('1')?"���ݱ���":"�ſ뱸��" }</div>
	    </div>
	  </div>
      
	  <div class="form-group">
	    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">�������̸�</label>
	    <div class="col-sm-4">
	      	<div class="form-control">${list[0].receiverName}</div>
	    </div>
	  </div>
      
	  <div class="form-group">
	    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">�����ڿ���ó</label>
	    <div class="col-sm-4">
	      	<div class="form-control">${list[0].receiverPhone}</div>
	    </div>
	  </div>
	  
	  <div class="form-group">
	    <label for="divyPostcode" class="col-sm-offset-1 col-sm-3 control-label">�������ּ�</label>
	    <div class="col-sm-4">
			<div class="form-control">(${list[0].divyPostcode}) ${list[0].divyAddress} ${list[0].divyAddress2}</div>
	    </div>
	  </div>
      
	  <div class="form-group">
	    <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">���ſ�û����</label>
	    <div class="col-sm-4">
	      	<div class="form-control">${list[0].divyRequest}</div>
	    </div>
	  </div>
	  
	  <div class="form-group">
	    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">����������</label>
	    <div class="col-sm-4">
	      	<div class="form-control">${list[0].divyDate}</div>
	    </div>
	  </div>
      
	  <div class="form-group">
	    <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">�� �ֹ��ݾ�</label>
	    <div class="col-sm-4">
	      	<div class="form-control">${sum} ��</div>
	    </div>
	  </div>		
		
	  </form>
	    
    </div>

</body>
</html>