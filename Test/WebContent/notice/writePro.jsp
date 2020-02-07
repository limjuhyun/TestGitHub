<%@page import="board.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="board.BoardBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	//session값 얻기
	String id = (String)session.getAttribute("id");
	
	//session값이 저장되어 있지 않다면 .. login.jsp로 이동
	if(id==null){
		response.sendRedirect("../member/login.jsp");
		
	}
	//1. 문자셋 방식 지정 (한글처리)
	request.setCharacterEncoding("UTF-8");
	
	//현재 실행중인 웹프로젝트애 대한 정보들이 저장되어 있는 객체 얻기
			ServletContext ctx = getServletContext();
			
			//실제 파일이 업로드되는 경로 얻기
			String realPath = ctx.getRealPath("/upload");
			//D:\workspace_jsp6\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\
			//   wtpwebapps\FileUploadDownload\ upload
			out.println(realPath);
			 
			
			//업로드할 수 있는 파일의 최대사이즈 지정 10MB
			int max = 10 * 1024 * 1024;
			
			//실제 파일 업로드 
			//1.request :  form태그에서 요청한  데이터가 저장된 request를 전달
			//2.realPath : 업로드될 파일의 위치를 의미
			//3.max : 최대 크기 
			//4."UTF-8" : 업로드 되는 파일 이름이 한글일 경우 문제가 되므로 인코딩 방식 지정
			//5. new DefaultFileRenamePolicy() : 
			//업로드될 경로에 이미 업로드된 파일이름이 동일할경우
			//파일이름 중복을 방지를 위해 파일이름을 자동으로 변환 해주는 객체 전달         
			MultipartRequest multi 
			= new MultipartRequest(request,
									realPath, //"D://upload",				   
								 	max,
								 	"UTF-8",
								 	new DefaultFileRenamePolicy());
			
			
	//1.1 write.jsp 페이지(글작성 페이지)에서 입력한 요청값을 request메모리에서 꺼내오기
	//1.2 얻는 요청값을.. BoardBean객체의 각변수에 저장
	

	BoardBean bBean = new BoardBean();
	bBean.setName(multi.getParameter("name"));
	bBean.setPasswd(multi.getParameter("passwd"));
	bBean.setSubject(multi.getParameter("subject"));
	bBean.setContent(multi.getParameter("content"));
	bBean.setFile(multi.getFilesystemName("file"));
	
   
	// 1.1 + 1.2 요청값을 request영역에서 얻어..BoardBean객체의 각변수에 저장
//	BoardBean b = new BoardBean();
	
// 		액션 태그란? jsp페이지 내에서 자바코드와 html디자인이 섞여 있으므로 복잡하다.
// 				    자바 코드 대신 JSP문법중에서 액션태그를 사용하면 디자인 소스 화면을 구분 하기 쉽다.
// 		useBean액션태그 -> 객체 생성 용도
// 		setProperty액션태그 -> setter메소드 호출 하여 변수에 값 초기화 
	%>
		<%--  <jsp:useBean id="bBean" class="board.BoardBean"/> --%>
		
		<%-- request객체에서 꺼내온 모든값을? BoardBean객체의 모든 setter메소드 호출 하여 모든 변수에 저장 --%>
		<%-- <jsp:setProperty property="*" name="bBean"/> --%>
		
		<%--<jsp:setProperty property="num" name="bBean" value="1"/>
		<jsp:setProperty property="name" name="bBean" value="홍길동"/>--%>
	<%-- 
		setProperty액션태그를 사용  하여
		request에서 꺼내온값을 한꺼번에 BoardBean에 저장 하기 위한 조건
		1.BoardBean클래스의 각변수이름과 write.jsp페이지의 각<input>태그의 name속성값이 동일 해야함
		
	 --%>



	<%
	//1.2.1현재 글쓴 날짜, 시간 정보...를 추가로 BoardBean에 저장
	bBean.setDate(new Timestamp(System.currentTimeMillis()));
	//1.2.2글쓴사람의 ip주소를 추가로 BoardBean에 저장
	bBean.setIp(request.getRemoteAddr());
	
	//2.jspbeginner데이터베이스의 board테이블에 우리가 입력한 새글 정보를 INSERT
	BoardDAO bdao = new BoardDAO();//DB작업
	//DB의 board테이블에 새글 정보를 INSERT하기 위해 inserBoard(BoardBean bean)메소드 호출시..
	//매개변수 인자로 ... BoardBean객체 전달
	bdao.insertBoard(bBean);
	
	//notice.jsp를 재요청(포워딩) 해 이동
	response.sendRedirect("notice.jsp");
	
%>
    
    
    
    
    
    
    
    