<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">


<html>
<head>
<title>�Ǹ� ������ȸ</title>

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
<script type="text/javascript">
	function fncListPage(currentPage) {
		$("#currentPage").val(currentPage);
		$("form").attr("method", "POST").attr("action", "/purchase/historyPurchase").submit();
	}
	
	$(function(){
		$("td:nth-child(2)").on("click", function(){
			var index = $("td:nth-child(2)").index(this);
			var tranNo = $($("input[name='tranNoList']")[index]).val();
			self.location="/purchase/getPurchase?tranNo="+tranNo;
		});
		
		$("td:nth-child(10)").on("click", function(){
			var index = $("td:nth-child(10)").index(this);
			var prodNo = $("input[name='prodNo']").val();
			var tranNo = $($("input[name='tranNoList']")[index]).val();
			var tranCnt = $($("input[name='tranCntList']")[index]).val();
			var text = $($("td:nth-child(10)")[index]).text().trim();
			if(text == "����ϱ�"){
				if (confirm("�ֹ���ȣ : "+tranNo+"\n��ۻ��·� �����Ͻðڽ��ϱ�?")){
					$.ajax( 
							{
								url : "/purchase/json/updateTranCode",
								method : "POST" ,
								dataType : "json" ,
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								},
								data : JSON.stringify({
									prodNo : prodNo,
									tranNo : tranNo,
									tranCnt : tranCnt,
									tranCode : 2
								}),
								success : function(JSONData , status) {
									$($("td:nth-child(9)")[index]).text('����� ����');
									$($("td:nth-child(10)")[index]).text('');
									alert('��ۻ��� ���� �Ϸ�');
								}
							});
				}else{
				    return;
				}
			}else if(text == "�������"){
				if (confirm("�ֹ���ȣ : "+tranNo+"\n������һ��·� �����Ͻðڽ��ϱ�?")){
					$.ajax( 
							{
								url : "/purchase/json/updateTranCode",
								method : "POST" ,
								dataType : "json" ,
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								},
								data : JSON.stringify({
									prodNo : prodNo,
									tranNo : tranNo,
									tranCnt : tranCnt,
									tranCode : 5
								}),
								success : function(JSONData , status) {
									$($("td:nth-child(9)")[index]).text('������� ����');
									$($("td:nth-child(10)")[index]).text('');
									alert('������һ��� ���� �Ϸ�');
								}
							});
				}else{
				    return;
				}
			}
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
	
		<div class="page-header text-info">
	       <h3>�Ǹ� ������ȸ</h3>
	    </div>
	    
		<form class="form-inline" name="detailForm">
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	    <input type="hidden" id="prodNo" name="prodNo" value="${list[0].purchaseProd.prodNo}"/>
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
		  <input type="hidden" id="currentPage" name="currentPage" value="0"/>
	    	
		</div>
		<!-- table ���� �˻� Start /////////////////////////////////////-->
		<br>
		
		</form>
		
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th class="text-center">No</th>
            <th class="text-center">�ֹ���ȣ</th>
            <th class="text-center">���̵�</th>
            <th class="text-center">�̸�</th>
            <!-- <th class="text-center">��ȭ��ȣ</th> -->
            <!-- <th class="text-center">�ּ�</th> -->
            <th class="text-center">����</th>
            <!-- <th class="text-center">���Ź��</th> -->
            <th class="text-center">�ֹ��Ͻ�</th>
            <th class="text-center">����������</th>
            <th class="text-center">���ſ�û����</th>
            <th class="text-center">����</th>
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
			  <td align="center">
				${purchase.buyer.userId}
			  </td>
			  <td align="center">
				${purchase.receiverName}
			  </td>
			  <%-- <td align="center">
			    ${purchase.receiverPhone}
			  </td> --%>
			  <%-- <td align="left">
			    (${purchase.divyPostcode}) ${purchase.divyAddress} ${purchase.divyAddress2}
			  </td> --%>
			  <td align="center">
			    ${purchase.tranCnt}
				<input type="hidden" name="tranCntList" value="${purchase.tranCnt}">
			  </td>
			  <%-- <td align="center">${purchase.paymentOption.equals('1')?"���ݱ���":"�ſ뱸��"}</td> --%>
			  <td align="center">${purchase.orderDate}</td>
			  <td align="center">${purchase.divyDate}</td>
			  <td align="center">${purchase.divyRequest}</td>
			  <td align="center">
			  	${purchase.tranCode.equals('1')?"���ſϷ�":purchase.tranCode.equals('2')?"�����":purchase.tranCode.equals('3')?"��ۿϷ�":purchase.tranCode.equals('4')?"������ҿ�û":purchase.tranCode.equals('5')?"�������":"" }
			   	����
			  </td>
			  <td align="center">
				${purchase.tranCode.equals('1')?"����ϱ�":purchase.tranCode.equals('4')?"�������":"" }
			  </td>
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
 	</div>
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->
   	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->

</body>
</html>