<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
//http://localhost:8090/N_Funweb/center/dowonload.jsp?path=center/upload&name=TortoiseGit-LanguagePack-2.8.0.0-64bit-ko (1).msi


//path=upload&name=<%=saveFile.get(i)
//서버에 올려진 파일의 이름을 가져옴
	String filename = request.getParameter("name");
	
//multi_pro.jsp에서 가상경로를 이용해 실제경로를 만든 값을 전달받아 저장 (upload) 
/*이클립스에 만들고(가상) 서버(실제)에 가져오는것(웹컨텍스트경로(server.xml확인)) -> 웹프로젝트명까지 */
	String path = request.getParameter("path");
	String realFolder =  getServletContext().getRealPath(path);
	System.out.println(path);
	System.out.println(realFolder);
	
	
	
	//실제경로+파일이름을 해서 파일의 경로를 잡아줌
	String filePath = realFolder + "\\" + filename;
	
	try{
		//버퍼의 내용을 비웁니다. 만약 버퍼가 이미 플러시 되었다면 IOException을 발생!
		//out.clearBuffer()도 같은기능을 함 단! 이미플러쉬 되어도 IOException을 발생시키지않는다
		//flush한적이없으므로 예외가 발생하지않는다.
		//찾아보니 out객체는 출력뿐아니라 jsp내부 버퍼에 관련된 일을한다. <%@page buffer로 지정가능하며 기본값은 8kb다
		//------------------------------------------------------------------------------------
		// JSP파일이 로직부분을 처리하기위해 Servlet로 변환될때 자동적으로 내장객체를 가져온다.
		// ★그래서! response.getOutputStream()을 통해 가져오면 동일객체가 2개있으므로 기존에있던 내장객체를 비워줘야한다.
		// [1]즉 기존 out객체가 가지고있던 정보를 보낸후(flush)			-> [2]번으로
		out.clear();
		//pageContext 객체는 현재 JSP 페이지의 컨텍스트(Context)를 나타내며, 
		//주로 다른 내장 객체를 구하거나 페이지의 흐름 제어 그리고 에러 데이터를 얻어낼 때 사용된다
		//-> 메서드확인결과 진짜 다른내장객체만 얻는게 대부분이다 
		// pushbody의 반환타입은 BodyContent이다
		//----------------------------------------
		// [2]out내장객체를 Body태그 밖으로 밀어버린다!! 이러면 기존 내장객체가없다!
		// https://docs.oracle.com/javaee/7/api/에서는 사용법만 나와있다... 
		out = pageContext.pushBody();
		
		//위에 설정한 파일경로를 통해 파일객체에 파일을 담음
		File file = new File(filePath);
		
		//한번에 읽어들일 데이터양을 정함! byte단위
		byte b[] = new byte[4096];
		
		//버퍼에 존재하는 모든 데이터와 상태 코드, 헤더를 지웁니다. -> 
		response.reset();
		//MIME타입 -> 타입/서브타입
		// 그중 application 모든 바이너리파일(이진데이터->전체)를 의미한다.
		//octet-stream은 기본값이다.
		response.setContentType("application/octet-stream");
		
		//기존 파일을 전달할때 ASCII코드를 사용해서 텍스트파일을 넘겼는데 이게 음악,비디오 등 바이너리 파일을 넘길때 문제가 생김
		//그래서 이 파일들을 넘길때 텍스트파일로 변환해줘야하는데 이를 ★인코딩 이라고한다. 반대는 디코딩
		//즉 위에 setContType(MIME)타입을 이진(바이너리)타입으로 했으므로 인코딩을 해줘야한다.
		//String(byte[] bytes, String charsetName) 바이트배열을 charset으로 바꿔줌
		//getBytes() -> 바이트배열로 추출
		//ASCII코드를 사용해서 넘기므로 UTF-8형식으로 받았다(한글) 이걸 컴퓨터가 읽을수있게 ASCII코드인 ISO-8859_1로바꿈!
		String Encoding = new String(filename.getBytes("UTF-8"),"8859_1");
		
		//Content-Disposition은 본문부분의 대한 정보를 표시 
		//disposition_type; parameter1=value;parameter2=value..로 사용된다 즉
		//content-Disposition 본문부분에! attatchment(복사할 파일이름으로 표시하며) 인코딩된 값을 filename파라메터로 주겠다!
		response.setHeader("Content-Disposition", "attatchment; filename = " + Encoding);
		
		//파일을 이어주는 InputStream생성
		FileInputStream is = new FileInputStream(filePath);
		
		//서블릿에서 outputStream을 가져옴 위에서 기존내장객체를 밀어냈기때문에 사용가능!
		ServletOutputStream sos = response.getOutputStream();
		
		
		//데이터가 있는지 여부를 확인할 변수 읽어온 바이트만큼 값이 설정되고 없으면 -1이 된다.
		int numRead;
		
		// b의 크기(4096)만큼 읽어서 b배열 0번째 인덱스부터 저장한다! 
		while((numRead = is.read(b,0,b.length))!=-1){
			//b배열에 numRead(읽어들인byte)수만큼 0번째 인덱스부터 출력한다!
			sos.write(b,0,numRead);
		}
		//만약 numRead가 4096미만이라면 보내지지않으므로 강제로 출력시킨다.
		sos.flush();
		//자원을 종료!
		sos.close();
		//자원을 종료!
		is.close();
		
	}catch(Exception err){
		err.printStackTrace();
	}
 
%>




