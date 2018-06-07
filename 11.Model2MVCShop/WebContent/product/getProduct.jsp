<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<html>
<head>

<!-- <link rel="stylesheet" href="/css/admin.css" type="text/css"> -->

	<!-- ���� : http://getbootstrap.com/css/   ���� -->
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
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
     </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
     
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	//============= "��ٱ���"  Event ���� =============
	 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-primary:contains('��ٱ���')" ).on("click" , function() {
				var tranCnt=$("input[name='tranCnt']").val();
				var prodCnt=$("input[name='prodCnt']").val();
				var prodNo=$("input[name='prodNo']").val();
			
				if(tranCnt == null || tranCnt.length<1){
					alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
					return;
				}
				if(parseInt(tranCnt) > parseInt(prodCnt)){
					alert("��� ������ �ʰ��� �� �����ϴ�.");
					return;
				}
				
				$.ajax( 
						{
							url : "/cart/json/addCart",
							method : "POST" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							data : JSON.stringify({
								prodNo : prodNo,
								tranCnt : tranCnt
							}),
							success : function(JSONData , status) {
								if (confirm("��ǰ�� ��ٱ��Ͽ� �����ϴ�.\n��ٱ��Ϸ� �̵��Ͻðڽ��ϱ�?")){
									$(self.location).attr("href","/cart/listCart");
								}
							}
						});
				
				//$("form").attr("method" , "POST").attr("action" , "/cart/addCart").submit();
			});
		});

	//============= "�ٷα���"  Event ���� =============
	 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-primary:contains('�ٷα���')" ).on("click" , function() {
				var tranCnt=$("input[name='tranCnt']").val();
				var prodCnt=$("input[name='prodCnt']").val();
			
				if(tranCnt == null || tranCnt.length<1){
					alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
					return;
				}
				if(parseInt(tranCnt) > parseInt(prodCnt)){
					alert("��� ������ �ʰ��� �� �����ϴ�.");
					return;
				}
				$("form").attr("method" , "POST").attr("action" , "/purchase/addPurchaseView").submit();
			});
		});
</script>

<title>Insert title here</title>
</head>

<body>


	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">��ǰ����ȸ</h3>
	    </div>
	    
	    <form class="form-horizontal" name="detailForm">
	
		<input type="hidden" name="prodNo" id="prodNo" value="${product.prodNo}"/>
		<input type="hidden" name="prodCnt" id="prodCnt" value="${product.prodCnt}"/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>��ǰ��ȣ</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodNo}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��ǰ��</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��ǰ�̹���</strong></div>
			<div class="col-xs-8 col-md-6">
				<c:forEach var="file" items="${product.fileNameList}">
					<c:if test="${!empty file}">
						<img src="/images/uploadFiles/${file}" width="300"/>
					</c:if>
				</c:forEach>
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��ǰ������</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodDetail}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>��������</strong></div>
			<div class="col-xs-8 col-md-6">${product.manuDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>����</strong></div>
			<div class="col-xs-8 col-md-4">${product.price} ��</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>������</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodCnt}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�������</strong></div>
			<div class="col-xs-8 col-md-4">${product.regDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>����</strong></div>
			<div class="col-xs-8 col-md-4">${product.scoreAvg}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>���ż���</strong></div>
			<div class="col-xs-8 col-md-4">
				<input type="text" class="form-control" style="width: 50px;" maxLength="5"
		      		id="tranCnt" name="tranCnt" value="1">
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-md-12 text-center ">
				<c:if test="${user.role.equals('user') && product.prodCnt > 0 }">
		  			<button type="button" class="btn btn-primary">��ٱ��� ���</button>
		  			<button type="button" class="btn btn-primary">�ٷα���</button>
	  			</c:if>
				<c:if test="${user.role.equals('user') && product.prodCnt == 0 }">
		  			<button type="button" class="btn btn-default" disabled="disabled">ǰ��</button>
	  			</c:if>
	  		</div>
		</div>
		
		</form>
		
		<br/>
		
 	</div>
 	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->



	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">��ǰ�� (${list.size()})</h3>
	    </div>
	    
	    <table>
       
		<tbody>
		
		  <c:forEach var="purchase" items="${list}">
			<tr>
				<td>${purchase.receiverName}</td>
				<td>${purchase.commentDate}</td>
			</tr>
			<tr>
				<td>
				<c:forEach var="i" begin="1" end="5">
					<c:if test="${i <= purchase.score}">
						<img src="/images/uploadFiles/roundstar_01.png" width="15"/>
					</c:if>
					<c:if test="${i > purchase.score}">
						<img src="/images/uploadFiles/roundstar_02.png" width="15"/>
					</c:if>
				</c:forEach>
				</td>
				<td colspan="2">${product.prodName} ${purchase.tranCnt} EA</td>
			</tr>
			<tr>
				<td>
					<c:forEach var="file" items="${purchase.commentImageList}">
						<c:if test="${!empty file}">
							<img src = "/images/uploadFiles/${file}" width="100"/>
						</c:if>
					</c:forEach>
				</td>
			</tr>
			<tr>
				<td>${purchase.commentText}</td>
			</tr>
			<tr>
				<td colspan="20" bgcolor="D6D7D6" height="1"></td>
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
	    
    </div>

</body>
</html>