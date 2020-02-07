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
		
		//content.jsp(글상세보기화면)에서 삭제 버튼 클릭시.. 요청받는 삭제할 글번호, 페이지번호 얻기
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		
		

%>


		<!-- 게시판 -->
		<article>
			<h2>Board Delete</h2>
			<form action="deletePro.jsp?pageNum=<%=pageNum %>" method="post">
			
			<!-- deletePro.jsp로 삭제할 글번호 요청! -->
			<input type="hidden" name="num" value="<%=num%>">
			
			
			<table id="notice">
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="passwd"></td>
				</tr>
			</table>
				
				
			
			<div id="table_search">
				<input type="submit" value="글삭제" class="btn"> 
				<input type="reset" value="다시작성" class="btn">
				<input type="button" value="글목록" class="btn" onclick="location.href='notice.jsp?pageNum=<%=pageNum%>'">
			</div>
		</form>
			<div class="clear"></div>
			
		</article>
		
		</ul>
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