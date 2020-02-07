<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	//한글처리
	request.setCharacterEncoding("UTF-8");

	//pageNum얻기
	String pageNum = request.getParameter("pageNum");


	//update.jsp페이지에서 요청한 수정할 글정보를 request영역에서 꺼내오기
	//BoardBean객체를 생성 하여 요청한 수정할 글정보들을 각변수에 저장
	
%>    
    <jsp:useBean id="gBean" class="gallery.GalleryBean"/>
    <jsp:setProperty property="*" name="gBean"/>
    
	<%-- UPDATE작업을 위한 BoardDAO객체 생성--%>
	<jsp:useBean id="gdao" class="gallery.GalleryDAO" />
<%
	//UPDATE작업을 위해 메소드 호출시..BoardBean을 전달 하여 UPDATE작업함
	int check = gdao.updateGallery(gBean);

	if(check == 1){//수정 성공! -> notice.jsp로 이동
%>		
	<script type="text/javascript">
		window.alert("수정성공!");
		location.href="gallery.jsp?pageNum=<%=pageNum%>"; 
	</script>

<%		
	}else{//수정실패! 비밀번호 틀림 -> 이전페이지 update.jsp로 되돌아 가게 하기
%>
	<script type="text/javascript">
		alert("비밀번호 틀림");
		history.back();
	</script>
	
<%		
	}
%>
































