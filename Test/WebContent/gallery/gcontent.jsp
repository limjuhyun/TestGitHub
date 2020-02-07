<%@page import="gallery.GalleryBean"%>
<%@page import="gallery.GalleryDAO"%>
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
	/*글 상세보기 페이지*/
	//gallery.jsp페이지에서 글목록중..하나를 클릭 했을떄...요청받아 넘어온 num,pageNum 한글처리
	request.setCharacterEncoding("UTF-8");

	//gallery.jsp페이지에서 글목록중..하나를 클릭 했을떄...요청받아 넘어온 num,pageNum 얻기
	int num =  Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	//글목록하나를 클릭 했을 떄.. 조회수 증가 DB작업
	GalleryDAO dao = new GalleryDAO();
	
	//조회수1증가 시키는 메소드 호출
	dao.updateReadCount(num); 
	
	//DB로부터 하나의 글정보를 검색해서 얻기
	GalleryBean galleryBean = dao.getGallery(num);
	 
	//DB로 부터 하나의 글정보를 검색해서 가져온 GalleryBean객체의 getter메소드를 호출 하여 리턴 받기
	int DBnum = galleryBean.getNum();//검색한 글번호 
	int DBReadcount = galleryBean.getReadcount();//검색한 글의 조회수 
	String DBName = galleryBean.getName();//검색한 글을 작성한 사람의 이름 
	Timestamp DBDate = galleryBean.getDate();//검색한 글을 작성한 날짜 및 시간 
	String DBSubject = galleryBean.getSubject();//검색한 글의 글제목
	String DBContent = ""; //검색한 글내용을 저장할 용도의 변수
	
	//검색한 글의 내용이 있다면... 내용들 엔터키 처리 
	if(galleryBean.getContent() != null){
		DBContent = galleryBean.getContent().replace("\r\n", "<br>");
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
				
					<li class="selected">
						<a href="gallery.jsp">Gallery</a>
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
		<div id="divcontent">
			<div>
				
				<ul>
			

		<!-- 게시판 -->
		
			<h2>Gallery</h2>
			<table id="content">
				<tr class="con1">
					<td>글번호</td>
					<td><%=DBnum%></td>
					<td>조회수</td>
					<td><%=DBReadcount%></td>
				</tr>
				<tr class="con2">
					<td>작성자</th>
					<td><%=DBName%></td>
					<td>작성일</td>
					<td><%=new SimpleDateFormat("yyyy.MM.dd").format(DBDate)%></td>
				</tr>		
				<tr class="con3">
					<td>글제목</td>
					<td colspan="3"><%=DBSubject%></td>
				</tr>	
				<tr class="con4">
					<td>글내용</td>
					<td colspan="3"><%=DBContent%></td>
				</tr>
				<tr class="con5">
					<td>이미지</td>
					<td colspan="3">
						<% System.out.println(galleryBean.getFile()); %>
						<% if(galleryBean.getFile() != null){ 
						%>
						 <img src="../upload/<%=galleryBean.getFile() %>" width="60" height="100">
						<a style="color:#fc416f;" href="gdownload.jsp?path=upload&name=<%=galleryBean.getFile() %>"><%=galleryBean.getFile() %></a>
						<%}else{
						%>	
						<a>파일 없음</a>	
						<% 	
						}
						%>
					</td>
				</tr>				
			</table>
			
		<div id="table_search">
		<%
			//각각페이지에서 로그인후 이동해 올떄.. session영역의 id전달 받기
			id = (String)session.getAttribute("id");
		
			if(id != null){
		%>
			<input type="button" value="글수정" class="btn" 
			onclick="location.href='gupdate.jsp?num=<%=DBnum%>&pageNum=<%=pageNum%>'">
			
			<input type="button" value="글삭제" class="btn"
			onclick="location.href='gdelete.jsp?num=<%=DBnum%>&pageNum=<%=pageNum%>'">
			
			
		<%			
			}
		%>
			<input type="button" value="글목록" class="btn" 
			onclick="location.href='gallery.jsp?pageNum=<%=pageNum%>'">
	
			</div>
			<div id="page_control"></div>
			
		
			
		
		
		
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