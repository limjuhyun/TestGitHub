<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	//1. update.jsp에서 입력한 password request영역에서 꺼내오기
	String id = (String)session.getAttribute("id");
	String passwd = request.getParameter("passwd");
	
	//2. 입력한 PASSWORD가 DB에 존재 하는지 유무 체크
	MemberDAO memberdao = new MemberDAO();
	
	//유무체크를 위한 메소드 호출!
	//check = 1 -> 비밀번호가 DB에 존재
	//check = 0 -> 비밀번호 틀림
	
	int check = memberdao.updateCheck(id,passwd); 
	
	if(check == 1){//DB에 저장되어 있는 비밀번호가 입력한 비밀번호와 같을때...
		
		//index.jsp로 이동(재요청 하여 이동)
		response.sendRedirect("./updatemember.jsp");
		
			
			
	}else if(check == 0){//아이디 맞음 , 비밀번호 틀림
	%>
			
		<script>
			alert("비밀번호 틀림");
			history.go(-1);//이전페이지로 이동
		
		</script>
	<%	
		
		
	}else{//check == -1 비밀번호 틀림 -> 이전페이지(login.jsp)로 이동
	%>
	 	<script>
	 		alert("비밀번호 틀림")
	 		history.back();//이전 페이지로 이동
	 	
	 	</script>
	<%
	}
	


%>