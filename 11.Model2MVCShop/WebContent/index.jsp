<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- ///////////////////////////// �α��ν� Forward  /////////////////////////////////////// -->
 <c:if test="${ ! empty user }">
 	<jsp:forward page="main.jsp"/>
 </c:if>
 <!-- //////////////////////////////////////////////////////////////////////////////////////////////////// -->


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style></style>
   	
   	<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
		$(function(){
			if("${checkUserMail}" == "true"){
				alert("���� ������ �Ϸ�Ǿ����ϴ�.");
				self.location = "/index.jsp"
			}
			if("${empty list}" == "true"){
				self.location = "/product/listProductIndex"
			}
			
		});
		
		//============= ȸ�������� ȭ���̵� =============
		$( function() {
			//==> �߰��Ⱥκ� : "addUser"  Event ����
			$("a[href='#' ]:contains('ȸ������')").on("click" , function() {
				self.location = "/user/addUser"
			});
		});
		
		//============= �α��� ȭ���̵� =============
		$( function() {
			//==> �߰��Ⱥκ� : "addUser"  Event ����
			$("a[href='#' ]:contains('�� �� ��')").on("click" , function() {
				self.location = "/user/login"
			});
		});
		
	</script>	
	
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<div class="navbar  navbar-default">
		
        <div class="container">
        
        	<a class="navbar-brand" href="#">Model2 MVC Shop</a>
			
			<!-- toolBar Button Start //////////////////////// -->
			<div class="navbar-header">
			    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
			        <span class="sr-only">Toggle navigation</span>
			        <span class="icon-bar"></span>
			        <span class="icon-bar"></span>
			        <span class="icon-bar"></span>
			    </button>
			</div>
			<!-- toolBar Button End //////////////////////// -->
			
			<div class="collapse navbar-collapse"  id="target">
	             <ul class="nav navbar-nav navbar-left">
	                 <li><a href="/product/listProduct?menu=search">��ǰ�˻�</a></li>
	           	</ul>
	             <ul class="nav navbar-nav navbar-right">
	                 <li><a href="#">ȸ������</a></li>
	                 <li><a href="#">�� �� ��</a></li>
	           	</ul>
	       </div>
   		
   		</div>
   	</div>
   	<!-- ToolBar End /////////////////////////////////////-->
   	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	
	<div class="container">	      
	      <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
	        <ol class="carousel-indicators">
	          <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
	          <li data-target="#carousel-example-generic" data-slide-to="1"></li>
	          <li data-target="#carousel-example-generic" data-slide-to="2"></li>
	        </ol>
	        
	        <div class="carousel-inner" role="listbox">
	          
	          <div class="item active">
	            <img src="/images/uploadFiles/displayitem1.jpg" alt="First slide">
	          </div>
	          
	          <div class="item">
	            <img src="/images/uploadFiles/displayitem2.jpg" alt="Second slide">
	          </div>
	          
	          <div class="item">
	            <img src="/images/uploadFiles/displayitem3.jpg" alt="Third slide">
	          </div>
	        </div>
	        
	        <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
	          <!-- <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span> -->
	          <!-- <span class="sr-only">Previous</span> -->
	        </a>
	        
	        <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
	          <!-- <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span> -->
	          <!-- <span class="sr-only">Next</span> -->
	        </a>
	     </div>
	</div>
	
	<br><br>
	
	
	<c:if test="${!empty list}">
	<div class="container">	      
	<div class="row">
		<c:forEach var="product" items="${list}">
        <div class="col-lg-3 col-md-4 col-sm-6 portfolio-item" style="height: 300px;">
          <div class="card h-100">
            <a href="/product/getProduct?prodNo=${product.prodNo }">
				<c:if test="${!empty product.fileNameList[0]}">
					<img src = "/images/uploadFiles/${product.fileNameList[0]}" width="200"/>
				</c:if>
				<c:if test="${empty product.fileNameList[0]}">
					<img src = "/images/uploadFiles/1298310238.png" width="150"/>
				</c:if>
            </a>
            <div class="card-body">
              <h4 class="card-title">
                <a href="/product/getProduct?prodNo=${product.prodNo }">${product.prodName}</a>
              </h4>
              <p class="card-text">${product.price} ��</p>
            </div>
          </div>
        </div>
        </c:forEach>
      </div>
      </div>
      </c:if>

</body>

</html>