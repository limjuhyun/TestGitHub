<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
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
	<script type="text/javascript">
		function qweasd(){
				window.open("address.jsp","","width=400,height=200");
		}
	</script>
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
					</li>
						<%
								
		//각 상단 메뉴에서 공통적으로 사용된 소스 
		//세션 영역에 저장된 값 얻기
		String id = (String)session.getAttribute("id");
		
		if(id == null){//세션값이 존재 하지 않을때..
	%>
			<script>
				window.alert("로그인 하세요");
				location.href = "../index.jsp";
			</script>
			<li><a href="./login.jsp">Login</a></li> <li><a href="./join.jsp">Join</a></li>
			
	<%
		}else{//세션값이 존재 할때... 
	%>
			
			<li class="selected"><a href="./update.jsp"><%=id %>님 Edit profile</a></li>
			<li><a href="./logout.jsp">Logout</a></li>
			
		
	<%
		}
		MemberDAO dao = new MemberDAO();
		MemberBean memberBean = dao.selectMember(id);
		   String name = memberBean.getName();
		   String email = memberBean.getEmail();
		   String address = memberBean.getAddress();
		   String tel = memberBean.getTel();         
		   String mtel = memberBean.getMtel(); 
		
	%>
				</ul>
			</div>
		</div>
		<div id="body" class="contact">
			<div>
				<h1>Update</h1>
				
			
				<form action="updatememberPro.jsp" id="join" method="post" name="fr">
				    
					<a>PW</a><input type="password" name="passwd" value=<%=memberBean.getPasswd() %> onblur="this.value=!this.value?'Password':this.value;" onfocus="this.select()" onclick="this.value='';">
					<a>RePW</a><input type="password" name="passwd2" value=<%=memberBean.getPasswd() %> onblur="this.value=!this.value?'Password':this.value;" onfocus="this.select()" onclick="this.value='';">
					<a>Name</a><input type="text" name="name" value=<%=name%> onblur="this.value=!this.value?'<%=name%>':this.value;" onfocus="this.select()" onclick="this.value='';">
					<a>Email</a><input type="email" name="email" value=<%=email%> onblur="this.value=!this.value?'<%=email%>':this.value;" onfocus="this.select()" onclick="this.value='';">
					<a>Address</a><input type="text" name="address" value=<%=address%> onblur="this.value=!this.value?'<%=address%>':this.value;" onfocus="this.select()" onclick="this.value='';">
					<input type="button" value="우편번호 검색" class="dup" onclick="qweasd();"><br>
					<a>Tel</a><input type="text" name="tel" value=<%=tel%> onblur="this.value=!this.value?'<%=tel%>':this.value;" onfocus="this.select()" onclick="this.value='';">
					<a>Mtel</a><input type="text" name="mtel" value=<%=mtel%> onblur="this.value=!this.value?'<%=mtel%>':this.value;" onfocus="this.select()" onclick="this.value='';">
					<br>
					<input type="submit" value="수정완료" class="submit">
					<input type="button" value="취소" class="cancel" onclick="location.href='update.jsp'">
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
