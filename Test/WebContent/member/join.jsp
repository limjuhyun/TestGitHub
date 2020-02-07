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
	<script type="text/javascript">
 		//아이디 중복 체크버튼 클릭시 호출 되는 함수 
 		
 		function winopen() {
			//id를 입력 했는지 체크
			//입력한 ID값을 얻어...빈공백인지 파악
			if(document.fr.id.value == ""){//아이디를 입력 하지 않았다면...
				alert("아이디를 입력 하세요.");
				//아이디 입력란에 포커스 깜빡
				document.fr.id.focus();
				return;
			}
			
			//새창 열때... 우리가 입력한 ID를 전달 할수 있도록
			var fid = document.fr.id.value;
			window.open("join_IDCheck.jsp?userid=" + fid,"","width=400,height=200");
			
		}
 		function qweasd(){
 			window.open("address.jsp","","width=400,height=200");
 		}
 		
 		
 	
 	</script>
 	
 	
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
			
			<li><a href="./login.jsp">Login</a></li> <li class="selected"><a href="./join.jsp">Join</a></li>
			
	<%
		}else{//세션값이 존재 할때... 
	%>
			
			<li><a href="./update.jsp"><%=id %>님 Edit profile</a></li>
			<li><a href="./logout.jsp">Logout</a></li>
			
		
	<%
		}
	%>
				</ul>
			</div>
		</div>
		<div id="body" class="contact">
			<div>
				<h1>Join US</h1>
				
			
				<form action="joinPro.jsp" id="join" method="post" name="fr">
				    <input type="text" name="id" class="id" value="ID" onblur="this.value=!this.value?'ID':this.value;" onfocus="this.select()" onclick="this.value='';">
					<input type="button" value="ID중복체크" class="dup" onclick="winopen();"><br>
					<input type="password" name="passwd" value="Password" onblur="this.value=!this.value?'Password':this.value;" onfocus="this.select()" onclick="this.value='';">
					<input type="password" name="passwd2" value="Password" onblur="this.value=!this.value?'Password':this.value;" onfocus="this.select()" onclick="this.value='';">
					<input type="text" name="name" value=Name onblur="this.value=!this.value?'Name':this.value;" onfocus="this.select()" onclick="this.value='';">
					<input type="email" name="email" value=E-Mail onblur="this.value=!this.value?'E-Mail':this.value;" onfocus="this.select()" onclick="this.value='';">
					<input type="text" name="address" class="address" value=Address onblur="this.value=!this.value?'Address':this.value;" onfocus="this.select()">
					<input type="button" value="우편번호 검색" class="dup" onclick="qweasd();"><br>
					<input type="text" name="tel" value=Tel onblur="this.value=!this.value?'Tel':this.value;" onfocus="this.select()" onclick="this.value='';">
					<input type="text" name="mtel" value=Mobile onblur="this.value=!this.value?'Mobile':this.value;" onfocus="this.select()" onclick="this.value='';">
					<input type="submit" value="회원가입" class="submit">
					<input type="reset" value="취소" class="cancel">
				</form>
			</div>
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
	</div>
</body>
</html>
