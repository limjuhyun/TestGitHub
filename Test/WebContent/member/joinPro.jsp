<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	//1. 회원가입 을 위해 join.jsp에서 입력한 회원정보들은 request내장객체 영역에 
	//   저장 되어 있다.
	//   request내장객체 영역에 저장된 데이터중 한글 이 존재 하면 한글 꺠짐 방지를 위해
	//   문자셋 방식을 UTF-8로 설정 함.
	request.setCharacterEncoding("UTF-8");

	//2.join.jsp에서 입력한 새회원 정보(요청정보)를 
	//  request내장객체 영역에서 꺼내어서 얻기
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String address = request.getParameter("address");
	String tel = request.getParameter("tel");
	String mtel = request.getParameter("mtel");	
	//현재 회원 가입 하는  날짜 생성
	Timestamp time = new Timestamp(System.currentTimeMillis());
	
	//3. join.jsp에서 입력한 DB에 추가할 정보를  MemberBean(VO)의 각변수에 저장
	MemberBean memberbean = new MemberBean();
	//MemberBean의 setter메소드를 호출 하여 각변수에 요청값을 저장
	memberbean.setId(id);
	memberbean.setPasswd(passwd);
	memberbean.setName(name);
	memberbean.setEmail(email);
	memberbean.setAddress(address);
	memberbean.setTel(tel);
	memberbean.setMtel(mtel);
	memberbean.setReg_date(time);
	
	//4.입력 한 회원정보 즉! MemberBean의 정보를 DB에 INSERT하기 위해..
	//MemberDAO객체 생성
	MemberDAO memberdao = new MemberDAO();
	
	//MemberBean의 정보를 DB에 INSERT하기 위해 
	//insertMember(MemberBean bean)메소드 호출시..
	//메소드의 인자로 MemberBean객체를 전달 함.
	memberdao.insertMember(memberbean); 
	
	//5. 회원 가입에 성공 했다면..login.jsp로 이동 하기 위해 포워딩(재요청)
	response.sendRedirect("login.jsp");
%>
    







    
    