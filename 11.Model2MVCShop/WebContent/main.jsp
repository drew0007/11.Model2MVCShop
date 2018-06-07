<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--   jQuery , Bootstrap CDN  -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
	
	<!--  CSS �߰� : ���ٿ� ȭ�� ������ ���� �ذ� :  �ּ�ó�� ��, �� Ȯ��-->
	<style>
        body {
            padding-top : 70px;
        }
   	</style>
   	
 	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">

		$(function(){
			if("${checkUserMail}" == "true"){
				alert("���� ������ �Ϸ�Ǿ����ϴ�.");
				self.location = "/index.jsp"
			}
			if("${empty list}" == "true"){
				self.location = "/product/listProductMain"
			}
		});
		
	</script>
	 	
	
</head>
	
<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<!--  �Ʒ��� ������ http://getbootstrap.com/getting-started/  ���� -->	
<!--    	<div class="container ">
      Main jumbotron for a primary marketing message or call to action
      <div class="jumbotron">
        <h1>Model2MVCShop </h1>
        <p>J2SE , DBMS ,JDBC , Servlet & JSP, Java Framework , HTML5 , UI Framework �н� �� Mini-Project ����</p>
     </div>
    </div>

	���� : http://getbootstrap.com/css/   : container part.....
	<div class="container">
        <h3>���������� �̷��� ���ߴ�.</h3>
        <p>"���� ���� ������ ������ ���� �߸� ���� �ð��� �����̴�."</p>
  	 	<h3>"... �庮�� �����ϰ� ������ �ʴ� ������� �ɷ������� �����մϴ�. �庮��. ����� �ƴ϶� '�ٸ�' ������� ���߰� �Ϸ��� �ű� �ִ� ��������."</h3>
         <h3>��������</h3>
         <p>�ູ�� ���� �����.</p>
         <p>�����ϴ� ���� �ϴ� ���� �Ƹ���,</p>
         <p>���� �ϴ� ���� �����ϴ� ���Դϴ�.</p>
  	 </div> -->
  	 
  	 
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