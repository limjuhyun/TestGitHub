<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@page import="java.awt.image.DataBufferInt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- Website template by freewebsitetemplates.com -->
<html>
<head>
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>SB Class</title>
	
	<link rel="stylesheet" href="css/style.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="css/mobile.css">
	<script src="js/mobile.js" type="text/javascript"></script>
</head>

<body>

	
	<div id="page">
		<div id="header">
			<div id="navigation">
				<span id="mobile-navigation">&nbsp;</span>
				<a href="index.jsp" class="logo"><img src="images/sblogo.jpg" alt=""></a>
				<ul id="menu">
					<li class="selected">
						<a href="index.jsp">Home</a>
					</li>
					<li>
						<a href="about.jsp">About</a>
					</li>
				
					<li>
						<a href="./gallery/gallery.jsp">Gallery</a>
					</li>
					<li>
						<a href="./notice/notice.jsp">Board</a>
					</li>
					<li>
						<a href="contact.jsp">Q & A</a>
					</li>
					<%
								
		//각 상단 메뉴에서 공통적으로 사용된 소스 
		//세션 영역에 저장된 값 얻기
		String id = (String)session.getAttribute("id");
		
		if(id == null){//세션값이 존재 하지 않을때..
	%>
			
			<li><a href="./member/login.jsp">Login</a></li> <li><a href="./member/join.jsp" class="k">Join</a></li>
			
	<%
		}else{//세션값이 존재 할때... 
	%>
			
			<li><a href="./member/update.jsp"><%=id %>님 Edit profile</a></li>
			<li><a href="./member/logout.jsp">Logout</a></li>
			
		
	<%
		}
	%>
					
				</ul>
			</div>
		</div>
		<div id="body" class="home">
			<div class="header">
				<div>
					<br><br><br><br>
					<h1>SNOW BOARD<br>CLASS</h1>
					<span><a href="contact.jsp" class="email">Enter Email</a><a href="contact.jsp" class="signup">Q & A</a></span>
					
				</div>
			</div>
			<div class="body">
				<div>
					<h1>SIGN UP</h1>
					
					<a href="./notice/notice.jsp" class="more">Read More</a>
				</div>
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
