<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- Website template by freewebsitetemplates.com -->
<html>
<head>
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>SB Class</title>
	<link rel="stylesheet" href="../css/style.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="../css/mobile.css">
	<script src="../js/mobile.js" type="text/javascript"></script>
</head>
<body>
	<div id="page">
		<div id="header">
			<div id="navigation">
				<span id="mobile-navigation">&nbsp;</span>
				<a href="../index.jsp" class="logo"><img src="../images/sblogo.jpg" alt=""></a>
				<ul id="menu">
					<li>
						<a href="../index.jsp">Home</a>
					</li>
					<li>
						<a href="../about.jsp">About</a>
					</li>
				
					<li>
						<a href="../gallery/gallery.jsp">Gallery</a>
						
					</li>
					<li>
						<a href="../notice/notice.jsp">Board</a>
					</li>
					<li>
						<a href="../contact.jsp">Q & A</a>
							<%
								
		//각 상단 메뉴에서 공통적으로 사용된 소스 
		//세션 영역에 저장된 값 얻기
		String id = (String)session.getAttribute("id");
		
		if(id == null){//세션값이 존재 하지 않을때..
	%>
			
			<li class="selected"><a href="./login.jsp">Login</a></li> <li><a href="./join.jsp">Join</a></li>
			
	<%
		}else{//세션값이 존재 할때... 
	%>
			<script>
				window.alert("로그인중입니다.");
				location.href = "../index.jsp";
			</script>
			<li><a href="./update.jsp"><%=id %>님 Edit profile</a></li>
			<li><a href="./logout.jsp">Logout</a></li>
			
		
	<%
		}
	%>
					
				</ul>
			</div>
		</div>
		<div id="body" class="contact">
			<div>
				<h1>LOGIN</h1>
				
				
				<form action="loginPro.jsp" id="login" method="post">
					<input type="text" name="id" value="ID" onblur="this.value=!this.value?'ID':this.value;" onfocus="this.select()" onclick="this.value='';">
					<input type="password" name="passwd" value="password" onblur="this.value=!this.value?'password':this.value;" onfocus="this.select()" onclick="this.value='';">
					
					<input type="submit" value="LOGIN" id="submit">
				</form>
			</div>
		</div>
		<div id="footer">
			<div>
				<div class="connect">
					<a href="http://freewebsitetemplates.com/go/twitter/" class="twitter">twitter</a>
					<a href="http://freewebsitetemplates.com/go/facebook/" class="facebook">facebook</a>
					<a href="http://freewebsitetemplates.com/go/googleplus/" class="googleplus">googleplus</a>
					<a href="http://pinterest.com/fwtemplates/" class="pinterest">pinterest</a>
				</div>
				<p>&copy; 2023 by SB. All rights reserved.</p>
			</div>
		</div>
	</div>
</body>
</html>
