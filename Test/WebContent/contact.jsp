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
	<script type="text/javascript">
function send_mail(){
    window.open("./test_mail.jsp", "", "width=370, height=360, resizable=no, scrollbars=no, status=no");
}
</script>


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
					<li>
						<a href="about.jsp">About</a>
					</li>
				
					<li>
						<a href="./gallery/gallery.jsp">Gallery</a>
					</li>
					<li>
						<a href="./notice/notice.jsp">Board</a>
					</li>
					<li class="selected">
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
		<div id="body" class="contact">
			<div>
				<h1>Q & A</h1>
				<img src="images/mapsb.png" alt="">
				<h2>ADDRESS</h2>
				<p>109 Samhan Golden Gate, Dongcheon-ro, Busan, 7F</p>
				<h2>NUMBERS</h2>
				<a href="index.jsp">+123456789 or +123456789</a>
				<h2>Email</h2>
				<a href="index.jsp">info@sbclass.com</a>
				<h4>Send Email</h4>
				<form name="a" action="mailSend.jsp" method="post">
					<input type="text" name="name" value="Name" onblur="this.value=!this.value?'Name':this.value;" onfocus="this.select()" onclick="this.value='';">
					<input type="text" name="number" value="Number" onblur="this.value=!this.value?'Number':this.value;" onfocus="this.select()" onclick="this.value='';">
					<input type="text" name="email" value="Email" onblur="this.value=!this.value?'Email':this.value;" onfocus="this.select()" onclick="this.value='';">
					<input type="text" name="subject" value="Subject" onblur="this.value=!this.value?'Subject':this.value;" onfocus="this.select()" onclick="this.value='';">
					<textarea name="content" cols="50" rows="7" onblur="this.value=!this.value?'Content':this.value;" onfocus="this.select()" onclick="this.value='';">Content</textarea>
					<input type="button" value="메일발송" onclick="check()">
					<input type="hidden" name="to" value="kmn0030@naver.com"> 
					<input type="hidden" name="from" value="kmn0030@naver.com">
				</form>
				<script> 
					 function check() {
					    document.a.submit();
					}
				</script>
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
