<%@page import="gallery.GalleryBean"%>
<%@page import="gallery.GalleryDAO"%>
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
<style type="text/css">
a:link {text-decoration: none; color: white;}
a:visited {text-decoration: none; color:#fc416f;}
a:hover{text-decoration: underline; color: lime;}
a:focus {text-decoration: underline; color: green;}
</style>
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
		<div id="gallery">
			<div>
				
				<ul>
			<%
			//게시판에 새글을 추가 했다면..gallery.jsp페이지에
			//DB에 저장된 새글 정보를 검색하여 가져와서 글리스트 목록을 아래에 출력 해주어야 함.
			GalleryDAO galleryDAO = new GalleryDAO();  
		
			//게시판에 저장되어 있는 전체 글개수 검색해서 얻기
			int count = galleryDAO.getGalleryCount();
			
			//한페이지에 보여줄 글 개수 5개로 지정
			int pageSize = 9;
			
			//gallery.jsp화면의 아래쪽 페이지번호를 클릭시..클릭한 페이지 번호 받아오기
			String pageNum = request.getParameter("pageNum");
			
			//gallery.jsp화면 요청시...아래쪽의 페이지번호를 클릭 하지 않은 상태이다...
			//이럴때는 현재 클릭한 페이지 번화가 없으면? 현재 보여지는 페이지를 1페이지로 지정
			if(pageNum==null){
				pageNum="1";
			}
			
			//위의 pageNum변수값을 정수로 변환해서  저장
			int currentPage = Integer.parseInt(pageNum);
			//-------------------------------------------------------------------------------
			
			//각페이지 마다... 첫번째로 보여질 시작 글번호 구하기
			//(현재 보여지는 페이지번호 -1 )* 한페이지당 보여줄 글개수 5
			int startRow = (currentPage -1 )* pageSize;
			
			//gallery테이블에서 검색한 글의 정보를 저장할 용도의 List 인터페이스 타입의 변수 list선언
			List<GalleryBean> list = null; 
			
			//만약 gallery테이블에 글이 존재 한다면
			if(count > 0){
				
				//gallery테이블에 모든 글 검색
				//(각페이지 마다 맨위에 첫번째로 보여질 시작 글번호, 한페이지당 보여줄 글개수)
				list = galleryDAO.getGalleryList(startRow, pageSize);
				
			}
			
			
		%>

		<!-- 게시판 -->
			
			<h3>Gallery[Total : <%=count %>]</h3>
			<table id="gnotice">
      <%
            if(count > 0){//게시판에 글이 존재하면
               %><tr>
               <%int f=0;
            for(int i=0;i<list.size();i++){//ArrayList 사이즈 만큼 반복(GalleryBean객체 개수 만큼)
            	
               //ArrayList배열의 각 인덱스 위치에 저장된 GalleryBean객체 얻기
               GalleryBean gallerybean = list.get(i);
               f++;
               
            if(!(f%3==0)){ 
               %>
                        
               <td  onclick="location.href='gcontent.jsp?num=<%=gallerybean.getNum()%>&pageNum=<%=pageNum%>'">
               <img src="../upload/<%=gallerybean.getFile() %>" width="250" height="250">
               </h4>
               </td>
            
               <%  }else{//if문 종료 %>
                     
                        
                     <td  onclick="location.href='gcontent.jsp?num=<%=gallerybean.getNum()%>&pageNum=<%=pageNum%>'">
                        <img src="../upload/<%=gallerybean.getFile() %>" width="250" height="250">
                     </td> 
                  </tr>
                  <tr>
               <%
               }
               }//for문 종료%><% 
            }else{//존재하지 않으면
            %>
               <tr>
                  <td colspan="5">게시판 글 없음</td>   
               </tr>
            <%
            }
            %>
            </table>
				<%
					//각각 페이지에서 로그인후.. 현재 게시판페이지로 이동 해올때..
					//session영역은 유지가 됨.
					//session영역에 저장되어 있는 값이 있냐 없냐에 따라..
					//글쓰기 버튼을 보이게 보이지 않게 설정 하자
					id = (String)session.getAttribute("id"); 
				
					//session영역에 저장되어 있으면 .. 글쓰기 버튼을 만들어 보이게 설정
					if(id != null){
				%>
				
				
			<div id="table_search">
						<input type="button" value="글쓰기" class="btn" onclick="location.href='gwrite.jsp'">
			</div>
				<%
					}
				%>
			<div id="table_search">
				<input type="text" name="search" class="input_box"> 
				<input type="button" value="검색" class="btn">
			</div> 
			
			<div class="clear"></div>
			<div id="page_control" class="pgnum">
			
			<%
				if(count > 0){
					//전체 페이지수 구하기
					//예) 글 20개 -> 한페이지당 보여줄 글수 10개 => 2개의 페이지
					//예) 글 25개 -> 한페이지당 보여줄 글수 10개 => 3개의 페이지
					//전체 페이지수 = 전체글  / 한페이지당 보여줄 글수 + (전체글수를 한페이지에 보여줄 글수로 나눈 나머지값) 
						int pageCount = count/pageSize + (count%pageSize==0?0:1);
					//한 화면에 보여질 페이지수 설정
						int pageBlock = 3;
					//시작 페이지 번호 구하기
					//1~10 =>1   11~20 =>11  21~30 =>21		
					//( (아래쪽에 클릭한 페이지 번호 / 한 화면에 보여줄 페이지수)-
					//  (아래쪽에 클릭한 페이지 번호를 한화면에 보여주 페이지수로 나눈 나머지값) )
					// * 하나의 화면에 보여줄 페이지수 + 1
					
						int startPage = ((currentPage/pageBlock)-(currentPage%pageBlock==0?1:0)) * pageBlock + 1;
						
						//끝페이지 번호 구하기 
						// 1~10 => 10   11~20 =>20  21~30 => 30
						//시작페이지번호 + 현재블럭(한화면)에 보여줄 페이지수 - 1
						int endPage = startPage + pageBlock - 1;
						
						//끝페이지 번호가 전체페이지수보다 클때...
						if(endPage > pageCount){
							//끝페이지 번호를 전체페이지수로 저장
							endPage = pageCount;
						}
						//[이전] 시작페이지번호가 한화면에 보여줄 페이지수보다 클때..
						if(startPage > pageBlock){
						%>
							<a href="gallery.jsp?pageNum=<%=startPage-pageBlock%>">[이전]</a>
						<%
						}
						//[1] [2]....페이지번호 나타내기
						for(int i = startPage; i<=endPage; i++){
							
						%>
							<a href="gallery.jsp?pageNum=<%=i %>">[<%=i %>]</a>
						<%
							
						}
						//[다음] 끝페이지 번호가 전체페이지 수보다 작을때...
						if(endPage<pageCount){
						%>
							<a href="gallery.jsp?pageNum=<%=startPage+pageBlock %>">[다음]</a>
						<%
						}
						
						
						
				}
					
					%>
			
		
		
			</div>
		
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