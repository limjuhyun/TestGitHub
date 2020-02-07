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
<%
	
	String id = (String)session.getAttribute("id");

	//세션값이 없으면.. login.jsp로 이동
	if(id == null){
		response.setCharacterEncoding("UTF-8");
	}
	
	
	//content.jsp페이지에서 답글쓰기 버튼을 클릭해서 요청받아 넘어온 데이터 한글처리
	request.setCharacterEncoding("UTF-8");

	//content.jsp페이지에서 답글쓰기 버튼을 클릭해서 요청받아 넘어온 데이터 전달 받기 
	int num =  Integer.parseInt(request.getParameter("num"));// 주글번호
	int re_ref = Integer.parseInt(request.getParameter("re_ref"));//주글 그룹값
	int re_lev = Integer.parseInt(request.getParameter("re_lev"));//주글 들여쓰기
	int re_seq = Integer.parseInt(request.getParameter("re_seq"));//주글 순서
	
	
%>
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
		id = (String)session.getAttribute("id");
		
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
			<article>
			<h2>Board ReWrite</h2>
			<form action="reWritePro.jsp" method="post">
				
			<%--주글에 대한 정보 전달 --%>	
			<input type="hidden" name="num" value="<%=num %>">
			<input type="hidden" name="re_ref" value="<%=re_ref %>">
			<input type="hidden" name="re_lev" value="<%=re_lev %>">
			<input type="hidden" name="re_seq" value="<%=re_seq %>">
			
			<%--답글에 대한 정보 전달 --%>	
			<table id="notice">
				<tr>
					<td>이름</td>
					<td><input type="text" name="name"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="passwd"></td>
				</tr>
				<tr>
					<td>제목</td>
					<td><input type="text" name="subject" value="[RE]"></td>
				</tr>
				<tr>
					<td>글내용</td>
					<td>
						<textarea name="content" rows="13" cols="40">
						
						</textarea>
					</td>
				</tr>
				
				
				
			</table>
			
		<div id="table_search">
			<input type="submit" value="답글작성" class="btn">
			<input type="reset" value="다시작성" class="btn">
			<input type="button" value="글목록화면" class="btn"
			 onclick="location.href='notice.jsp'">
		</div>
		</form>
		<div class="clear"></div>
		<div id="page_control"></div>
			
			
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