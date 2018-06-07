<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<html>
<head>

<!-- <link rel="stylesheet" href="/css/admin.css" type="text/css"> -->

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
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
     </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
     
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	//============= "장바구니"  Event 연결 =============
	 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-primary:contains('장바구니')" ).on("click" , function() {
				var tranCnt=$("input[name='tranCnt']").val();
				var prodCnt=$("input[name='prodCnt']").val();
				var prodNo=$("input[name='prodNo']").val();
			
				if(tranCnt == null || tranCnt.length<1){
					alert("수량은 반드시 입력하셔야 합니다.");
					return;
				}
				if(parseInt(tranCnt) > parseInt(prodCnt)){
					alert("재고 수량을 초과할 수 없습니다.");
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
								if (confirm("상품이 장바구니에 담겼습니다.\n장바구니로 이동하시겠습니까?")){
									$(self.location).attr("href","/cart/listCart");
								}
							}
						});
				
				//$("form").attr("method" , "POST").attr("action" , "/cart/addCart").submit();
			});
		});

	//============= "바로구매"  Event 연결 =============
	 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-primary:contains('바로구매')" ).on("click" , function() {
				var tranCnt=$("input[name='tranCnt']").val();
				var prodCnt=$("input[name='prodCnt']").val();
			
				if(tranCnt == null || tranCnt.length<1){
					alert("수량은 반드시 입력하셔야 합니다.");
					return;
				}
				if(parseInt(tranCnt) > parseInt(prodCnt)){
					alert("재고 수량을 초과할 수 없습니다.");
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
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">상품상세조회</h3>
	    </div>
	    
	    <form class="form-horizontal" name="detailForm">
	
		<input type="hidden" name="prodNo" id="prodNo" value="${product.prodNo}"/>
		<input type="hidden" name="prodCnt" id="prodCnt" value="${product.prodCnt}"/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품번호</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodNo}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>상품명</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>상품이미지</strong></div>
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
	  		<div class="col-xs-4 col-md-2 "><strong>상품상세정보</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodDetail}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>제조일자</strong></div>
			<div class="col-xs-8 col-md-6">${product.manuDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>가격</strong></div>
			<div class="col-xs-8 col-md-4">${product.price} 원</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>재고수량</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodCnt}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>등록일자</strong></div>
			<div class="col-xs-8 col-md-4">${product.regDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>평점</strong></div>
			<div class="col-xs-8 col-md-4">${product.scoreAvg}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매수량</strong></div>
			<div class="col-xs-8 col-md-4">
				<input type="text" class="form-control" style="width: 50px;" maxLength="5"
		      		id="tranCnt" name="tranCnt" value="1">
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-md-12 text-center ">
				<c:if test="${user.role.equals('user') && product.prodCnt > 0 }">
		  			<button type="button" class="btn btn-primary">장바구니 담기</button>
		  			<button type="button" class="btn btn-primary">바로구매</button>
	  			</c:if>
				<c:if test="${user.role.equals('user') && product.prodCnt == 0 }">
		  			<button type="button" class="btn btn-default" disabled="disabled">품절</button>
	  			</c:if>
	  		</div>
		</div>
		
		</form>
		
		<br/>
		
 	</div>
 	<!--  화면구성 div Start /////////////////////////////////////-->



	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">상품평 (${list.size()})</h3>
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