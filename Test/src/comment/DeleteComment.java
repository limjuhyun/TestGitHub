package comment;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/DeleteComment")
public class DeleteComment extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
					throws ServletException, IOException {
		doHandle(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
					throws ServletException, IOException {
		doHandle(request, response);
	}
	
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		
		String id = request.getParameter("id");
		int num = Integer.parseInt(request.getParameter("num"));
		
		
		CommentDAO commentdao = new CommentDAO();
		int check = commentdao.deleteComment(num, id);
		
		//PrintWriter객체 얻기
		PrintWriter out = response.getWriter();
		
		//ID중복 여부 결과를 ajax3.html페이지에 메세지로 전송함.
		if(check==1){
			out.print("yes");
		}else{
			out.print("no");
		}
		
		
		
		
	}			 
       
    

}
