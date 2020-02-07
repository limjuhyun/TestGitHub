package comment;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/AddComment")
public class AddComment extends HttpServlet {

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
		String content = request.getParameter("content");
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		
		
		CommentBean commentBean = new CommentBean();
		commentBean.setId(id);
		commentBean.setBoard_num(board_num);
		commentBean.setContent(content);
		commentBean.setDate(new Timestamp(System.currentTimeMillis()));
		
		CommentDAO commentdao = new CommentDAO();
		commentdao.insertComment(commentBean, board_num);
		
		
	}			 
       
    

}
