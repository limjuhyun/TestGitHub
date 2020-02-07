<%@page import="java.sql.Timestamp"%>
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
	/*글수정을 위한 하나의 글정보를 검색해서 가져와서 화면에 출력하는  페이지*/
	
	String id = (String)session.getAttribute("id");
	
	//세션값이 없으면.. loing.jsp로 이동
	if(id == null){
		response.sendRedirect("../member/login.jsp");
	}
	
	//content.jsp페이지에서 글수정버튼을 클릭해서  요청받아 넘어온 num,pageNum 한글처리
	request.setCharacterEncoding("UTF-8");

	//content.jsp페이지에서 글수정버튼을 클릭해서  요청받아 넘어온 num,pageNum 얻기
	int num =  Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	//글수정을 위한 하나의 글정보 검색 DB작업을 위한 객체 생성
	BoardDAO dao = new BoardDAO();
	
	//DB로부터 하나의 글정보를 검색해서 얻기
	BoardBean boardBean = dao.getBoard(num);
	 
	//DB로 부터 하나의 글정보를 검색해서 가져온 BoardBean객체의 getter메소드를 호출 하여 리턴 받기
	int DBnum = boardBean.getNum();//검색한 글번호 
	int DBReadcount = boardBean.getReadcount();//검색한 글의 조회수 
	String DBName = boardBean.getName();//검색한 글을 작성한 사람의 이름 
	Timestamp DBDate = boardBean.getDate();//검색한 글을 작성한 날짜 및 시간 
	String DBSubject = boardBean.getSubject();//검색한 글의 글제목
	String DBContent = ""; //검색한 글내용을 저장할 용도의 변수
	
	//검색한 글의 내용이 있다면... 내용들 엔터키 처리 
	if(boardBean.getContent() != null){
		DBContent = boardBean.getContent().replace("<br>", "\r\n");
	}
		
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
			<h2>Board Update</h2>
		<form action="updatePro.jsp?pageNum=<%=pageNum%>" method="post">
			
			<input type="hidden" name="num" value="<%=num%>">
				
			<table id="notice">
				<tr>
					<td>이름</td>
					<td><input type="text" name="name" value="<%=DBName%>"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="passwd"></td>
				</tr>
				<tr>
					<td>글제목</td>
					<td><input type="text" name="subject" value="<%=DBSubject%>"></td>
				</tr>
				<tr>
					<td>글내용</td>
					<td>
						<textarea name="content" rows="13" cols="40">
						<%=DBContent%>
						</textarea>
					</td>
				</tr>				
			</table>
			
		<div id="table_search">
			<input type="submit" value="글수정" class="btn">
			<input type="reset" value="다시작성" class="btn">
			<input type="button" value="글목록화면" class="btn" 
				   onclick="location.href='notice.jsp?pageNum=<%=pageNum%>'">
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