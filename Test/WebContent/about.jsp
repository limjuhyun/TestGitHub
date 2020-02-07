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
					<li>
						<a href="index.jsp">Home</a>
					</li>
					<li class="selected">
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
			
			<li><a href="./member/login.jsp">Login</a></li> <li><a href="./member/join.jsp">Join</a></li>
			
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
		<div id="body">
			<div>
				<h1>ABOUT SB</h1>
				<img src="images/snowboarder.jpg" alt="">
				<h2>We Have Free Templates for Everyone</h2>
				<p>Our website templates are created with inspiration, checked for quality and originality and meticulously sliced and coded. Whatâs more, theyâre absolutely free! You can do a lot with them. You can modify them.  You can use them to design websites for clients, so long as you agree with the <a href="http://www.freewebsitetemplates.com/about/terms/">Terms of Use</a>. You can even remove all our links if you want to.</p>
				<h2>We Have More Templates for You</h2>
				<p>Looking for more templates? Just browse through all our <a href="http://www.freewebsitetemplates.com/">Free Website Templates</a> and find what youâre looking for. But if you donât find any website template you can use, you can try our <a href="http://www.freewebsitetemplates.com/freewebdesign/">Free Web Design</a> service and tell us all about it. Maybe youâre looking for something different, something special. And we love the challenge of doing something different and something special.</p>
				<h2>Be Part of Our Community</h2>
				<p>If youare experiencing issues and concerns about this website template, join the discussion <a href="http://www.freewebsitetemplates.com/forums/">on our forum</a> and meet other people in the community who share the same interests with you.</p>
				<h2>Template Details</h2>
				<p>Design Version 2. Code Version 1. Website Template details, discussion and updates for this <a href="http://www.freewebsitetemplates.com/discuss/running/">Running Website Template</a>. Website Template design by <a href="http://www.freewebsitetemplates.com/">Free Website Templates</a>. Please feel free to remove some or all the text and links of this page and replace it with your own About content.</p>
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
