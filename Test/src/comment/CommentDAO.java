package comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import board.BoardBean;

public class CommentDAO {
	
	Connection con = null;
	PreparedStatement pstmt  = null;
	ResultSet rs = null;		
	String sql = "";
	
	private Connection getConnection() throws Exception {		
		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = 
				(DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
		con = ds.getConnection();
		return con;
	}//getConnection메소드 닫는 부분	
	
	
	public void insertComment(CommentBean commentBean,int board_num){		

		int num = 0;
		try{
			con = getConnection();
			sql = "select max(num) from comment where ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			rs = pstmt.executeQuery();
			
			if(rs.next()){//검색한 데이터가 존재 하면?
				num = rs.getInt(1) + 1; //글이 있을 경우 최대글번호 + 1
			}else{//검색이 되지 않으면?
				num = 1; //글이 없을 경우 
			}
			
			sql = "insert into comment "
				+ "(num,board_num,id,date,content) "
				+ "values(?,?,?,?,?)"; 
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);//댓글 번호
			pstmt.setInt(2, board_num);//댓글이 달릴 게시글 번호
			pstmt.setString(3, commentBean.getId());//댓글 쓴 이용자의 ID
			pstmt.setTimestamp(4, commentBean.getDate());
			pstmt.setString(5, commentBean.getContent());//댓글 내용
			
			pstmt.executeUpdate();
			
		}catch(Exception e){
			System.out.println("insertComment메소드 내부에서 오류:" + e);
		}finally {
			if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
		}		
	}//insertBoard메소드 닫는 부분
	
	public int getCommentCount(int board_num){
		int count = 0;
		try {
			con = getConnection();
			sql = "select count(*) from comment where board_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println("getCommentCount()메소드 오류 : " + e);
		} finally {
			if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		return count;
	}
	
	
		public List<CommentBean> getCommentList(int board_num){
			
			List<CommentBean> commentList = new ArrayList<CommentBean>();
			
			try{
				con = getConnection();
				sql = "select * from comment where board_num=? order by num asc";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, board_num);
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					CommentBean commentBean = new CommentBean();
					//rs => BoardBean객체의 각변수에 저장
					commentBean.setNum(rs.getInt("num"));
					commentBean.setBoard_num(rs.getInt("board_num"));
					commentBean.setId(rs.getString("id"));
					commentBean.setDate(rs.getTimestamp("date"));
					commentBean.setContent(rs.getString("content"));
					commentList.add(commentBean);
				}//while문			
				
			}catch(Exception err){
				System.out.println("getBoardList메소드 내부에서 오류 : " + err);
			}finally {
				//자원해제
				if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
				if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
				if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			}
			return commentList;//ArrayList반환
		}

		//삭제할 글번호와 댓글쓴 id를 매개변수로 전달 받아.. 댓글을 DELETE삭제 하는 메소드
		public int deleteComment(int num, String id){
			int check = 0;
			try{
				con = getConnection();
				sql = "select id from comment where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				//검색
				rs = pstmt.executeQuery();
				
				if(rs.next()){//검색한 글이 존재 하면				
					if(id.equals(rs.getString("id"))){
						sql = "delete from comment where num=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, num);
						//DELETE실행
						pstmt.executeUpdate();
						check = 1;
					}else{
						return check;
					}
				}	
			}catch(Exception err){
				System.out.println("deleteComment()메소드 내부 오류 : "+err);
			}finally {
				if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
				if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
				if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}	
			}
			
			return check;
		}//deleteComment() 끝
		
		
}//CommentDAO 끝
