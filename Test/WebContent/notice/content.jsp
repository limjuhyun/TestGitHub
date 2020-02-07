<%@page import="comment.CommentBean"%>
<%@page import="comment.CommentDAO"%>
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
	
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript">
function writeCmt(){
	var _content = $("#comment_content").val();
	var _id = $("#comment_id").val();
	var _board_num = $("#comment_board").val();
	
	if(_content == ''){
		alert("댓글을 입력하세요.");
		return;
	}
	$.ajax({
		type:"post",
		async:false,
		url:"http://localhost:8090/Test/AddComment",
		dataType:"xml",
		data:{id:_id,content:_content,board_num:_board_num},
		success:function(data,textStatus){
			location.href = location.href;
		}
	}); //ajax끝
}

function deleteCmt(_dbnum){
	
	var _dbid = $("#comment_id").val();
	var _num = _dbnum;
	var _id = _dbid;
	
	
	$.ajax({
		type:"post",
		async:false,
		url:"http://localhost:8090/Test/DeleteComment",
		dataType:"text",
		data:{id:_id,num:_num},
		success:function(data,textStatus){
			location.href = location.href;
			if(data == 'yes'){
			}else{
				alert("댓글 쓴 본인만 지울 수 있습니다.");
			}
			
		}
	}); //ajax끝
	
	
	
}

</script>
	
</head>
<%
	/*글 상세보기 페이지*/
	//notice.jsp페이지에서 글목록중..하나를 클릭 했을떄...요청받아 넘어온 num,pageNum 한글처리
	request.setCharacterEncoding("UTF-8");

	//notice.jsp페이지에서 글목록중..하나를 클릭 했을떄...요청받아 넘어온 num,pageNum 얻기
	int num =  Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	//글목록하나를 클릭 했을 떄.. 조회수 증가 DB작업
	BoardDAO dao = new BoardDAO();
	
	//조회수1증가 시키는 메소드 호출
	dao.updateReadCount(num); 
	
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
		DBContent = boardBean.getContent().replace("\r\n", "<br>");
	}
	//답변 달기에 관한 검색한 값3개 저장
	int DBRe_ref = boardBean.getRe_ref();//주글과 답글이 같은 값을 가질수 있는 유일한 그룹값
	int DBRe_lev = boardBean.getRe_lev();//주글(답글)의 들여쓰기 정도값
	int DBRe_seq = boardBean.getRe_seq();//주글(답글)들을 board테이블에 추가하면 글의 순서
	
	CommentDAO commentDAO = new CommentDAO(); 
	int count = commentDAO.getCommentCount(num); // 몇번째 댓글?
	int currentPage = Integer.parseInt(pageNum);
	
	
	List<CommentBean> list = null;  
	if(count > 0){ 
		list = commentDAO.getCommentList(DBnum);
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
		
			<h2>Board Content</h2>
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
					<td>파일</td>
					<td colspan="3">
						<% System.out.println(boardBean.getFile()); %>
						<% if(boardBean.getFile() != null){ 
						%>
						<a style="color:#fc416f;" href="download.jsp?path=upload&name=<%=boardBean.getFile() %>"><%=boardBean.getFile() %></a>
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
		<!-- 댓글 부분 -->
	<div id="comment">
		<h4>Comment[전체 댓글개수 : <%=count %>]</h4>
        <table id="commentDB">
        <tr>
			<th class="tno">작성자</th>
			<th class="ttitle">내용</th>
			<th class="twrite">작성날짜</th>
			<th></th>
		</tr>
        <%
			if(count > 0){
				for(int i=0;  i<list.size(); i++){
					CommentBean bean = list.get(i);
		%>
            <tr>
	                <td id="notice">
	                    <div id="DBcomment_id"><%=bean.getId()%></div>
	                </td>
	                <td width="600" id="DBcomment_content_td">
	                    <div  style="white-space:pre;" id="DBcomment_content"><%=bean.getContent() %></div>
	                </td>
	                <td>
	                	<%=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss a").format(bean.getDate()) %>
	                </td>
	                <td>
	                		<p id="deletebtn"><a onclick="deleteCmt(<%=bean.getNum()%>)">삭제</a></p>
	                </td>
            </tr>
          <%			 			
				}
			}else{
		%>		
				<tr>
					<td colspan="5" align="center">댓글 없음</td>	
				</tr>
		<%		
			}
		%>
        </table>
    </div>
		<%
			//각각페이지에서 로그인후 이동해 올떄.. session영역의 id전달 받기
			id = (String)session.getAttribute("id");
		
			if(id != null){
		%>
			
    <div id="comment1">
        <table>
            <tr>
            <input type="hidden" id="comment_board" value=<%=DBnum%>>
            <input type="hidden" id="comment_id" value=<%=id %>>
				
                <td id="notice">
                    <div id="cmtid">
                        <%=id %>
                    </div>
                </td>
                <!-- 본문 작성-->
                <td width="550">
                    <div>
                        <textarea style="resize: none;" id="comment_content" name="comment_content" rows="1" cols="50" ></textarea>
                    </div>
                </td>
                <!-- 댓글 등록 버튼 -->
                <td width="100">
                    <div id="btn" style="text-align:center;">
                        <p><a onclick="writeCmt()">등록</a></p>    
                    </div>
                </td>
            </tr>
        </table>
    </div>
			
			<input type="button" value="글수정" class="btn" 
			onclick="location.href='update.jsp?num=<%=DBnum%>&pageNum=<%=pageNum%>'">
			
			<input type="button" value="글삭제" class="btn"
			onclick="location.href='delete.jsp?num=<%=DBnum%>&pageNum=<%=pageNum%>'">
			
			<input type="button" value="답글쓰기" class="btn"
			onclick="location.href='reWrite.jsp?num=<%=DBnum%>&re_ref=<%=DBRe_ref%>&re_lev=<%=DBRe_lev%>&re_seq=<%=DBRe_seq%>'">
		<%			
			}
		%>
		<input type="button" value="글목록" class="btn" 
		onclick="location.href='notice.jsp?pageNum=<%=pageNum%>'">

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