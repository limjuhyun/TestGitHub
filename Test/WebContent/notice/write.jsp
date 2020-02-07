<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
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
					<li class="selected">
						<a href="./notice.jsp">Board</a>
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
			
			<li><a href="../member/login.jsp">Login</a></li> <li><a href="../member/join.jsp">Join</a></li>
			
	<%
		}else{//세션값이 존재 할때... 
	%>
			
			<li><a href="../member/update.jsp"><%=id %>님 Edit profile</a></li>
			<li><a href="../member/logout.jsp">Logout</a></li>
			
		
	<%
		}
	%>
					
				</ul>
			</div>
		</div>
		<div id="kkk">
			<div>
				<ul>
				
			<%
		//session영역에서 저장되어 있는 값 얻기
		//얻는 이유 : 글쓰기 화면에 글작성자의 이름을? id로 출력하기 위해..
		id = (String)session.getAttribute("id");
		//session영역에 값이 저장되어 있지 않으면?
		if(id==null){//로그인 페이지로
			response.sendRedirect("../member/login.jsp");
		}

%>


		<!-- 게시판 -->
		<article>
			<h2>Board Writer</h2>
			<form action="writePro.jsp" method="post" enctype="multipart/form-data">
			
			<table id="notice">
				<tr>
					<td>이름</td>
					<td><input type="text" name="name" value="<%=id%>" readonly> </td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="passwd"> </td>
				</tr>
				<tr>
					<td>글제목</td>
					<td><input type="text" name="subject"> </td>
				</tr>
				<tr>
					<td>글내용</td>
					<td><textarea rows="13" cols="40" name="content"></textarea> </td>
				</tr>
				<tr>
					<td>파일 선택 :</td>
					<td><input type="file" name="file"></td>
				</tr>
				</table>
				
				
			
			<div id="table_search">
				<input type="submit" value="글쓰기" class="btn"> 
				<input type="reset" value="다시작성" class="btn">
				<input type="button" value="글목록" class="btn" onclick="location.href='notice.jsp'">
			</div>
		</form>
			<div class="clear"></div>
			
		</article>
		
				</ul> 
		
			</div>
		 
		</div>
		<!-- 게시판 -->
		<!-- 본문들어가는 곳 -->
		<div class="clear"></div>
		
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
</body>
</html>