package gallery;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

//DAO
//DB에 관련한 모든 작업을 하는 클래스
public class GalleryDAO {
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	
	
	//jspbeginner데이터베이스와 연결을 맺는 메소드
		private Connection getConnection() throws Exception {
			
			Connection con = null;
			Context init = new InitialContext();
			//커넥션풀 얻기
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
			//커넥션풀로 부터 커넥션객체(DB와 미리 연결 되어 있는 접속을 알리는 객체) 빌려오기
			con = ds.getConnection();
			
			return con;
		}
		
		
		
		
		
		
		//수정할 글정보(GalleryBean)객체를 매개변수로 전달 받아.. DB에 존재하는 비밀번호와
		//글 수정 화면에서 입력한 비밀번호가 일치하면? 글 정보 UPDATE!!
		public int updateGallery(GalleryBean gbean){
			int check = 0;
			
			try {
				//DB연결
				con = getConnection();
				//SELECT구문 -> 수정할 글번호에 해당하는 비밀번호 검색
				sql = "select passwd from gallery where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, gbean.getNum());
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					if(gbean.getPasswd().equals(rs.getString("passwd"))){
						check = 1;
						sql = "update gallery set name=?, subject=?, content=? where num=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, gbean.getName());
						pstmt.setString(2, gbean.getSubject());
						pstmt.setString(3, gbean.getContent());
						pstmt.setInt(4, gbean.getNum());
						
						pstmt.executeUpdate();
						
					}else{
						check = 0;
					}
				}
				
				
			} catch (Exception e) {
				System.out.println("updateGallery메소드 오류 : " + e);
			}finally{
				//자원해제
				if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
				if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
				if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
				
			}
			return check;
			
		}
		
		
		
		
		
		
		
		
		
		//삭제할 글 번호와 삭제할글의 비밀번호를 매개변수로 전달 받아 .. 글을 DELETE삭제 하는 메소드
		public int deleteGallery(int num,String passwd){
			
			int check = 0; //삭제 성공,삭제 실패 판단값 1또는 0저장할 변수
			try {
				con = getConnection();
				//매개변수로 전달 받은 삭제할 글번에 해당하는 비밀번호 검색
				sql = "select passwd from gallery where num=?";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, num);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()){//검색한 글이 존재 하면
					if(passwd.equals(rs.getString("passwd"))){
						check=1;
						sql = "delete from gallery where num=?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, num);
						//DELETE실행
						pstmt.executeUpdate();
						
					}else{//입력한 비밀번호가 DB에 존재 하지 않으면
						check=0;
					}
					
				}
				
				
			} catch (Exception err) {
				err.printStackTrace();
			}finally{
				//자원해제
				if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
				if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
				if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			}
			return check;//비밀번호 일치 유무 1또는 0 리턴
		}
		
		
		//글번호를 매개변수로 전달 받아... 글번호에 해당하는 하나의 글 검색해서 반환
		public GalleryBean getGallery(int num){//content.jsp에서 호출 한 메소드
			
			GalleryBean galleryBean = null;
			try {
				con = getConnection();
				//매개변수로 전달 받은 글번호에 해당되는 글 검색 SQL문
				sql = "select * from gallery where num=?";
				pstmt = con.prepareStatement(sql);
				//?에 대응되는 글번호 설정
				pstmt.setInt(1, num);
				//select 실행후 검색된 하나의 글정보를 ResultSet임시저장소에 저장 하여 반환
				rs = pstmt.executeQuery();
				if(rs.next()){//검색된 글이 존재 하면
					galleryBean = new GalleryBean();//검색한 정보를 rs에서 꺼내와서 저장할 용도
					//setter메소드를 활용 해서 변수에 검색한 값들을 저장
					galleryBean.setContent(rs.getString("content"));
					galleryBean.setDate(rs.getTimestamp("date"));
					galleryBean.setFile(rs.getString("file"));
					galleryBean.setIp(rs.getString("ip"));
					galleryBean.setName(rs.getString("name"));
					galleryBean.setNum(rs.getInt("num"));
					galleryBean.setPasswd(rs.getString("passwd"));
					galleryBean.setReadcount(rs.getInt("readcount"));
					galleryBean.setSubject(rs.getString("subject"));
							
				}//if끝
			}catch (Exception e) {
				e.printStackTrace();
			}finally{
				//자원해제
				if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
				if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
				if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			}
			
			
			return galleryBean;//GalleryBean객체 리턴
			
			
		}//메소드 끝
		
		
		
		
		
		
		//글번호를 매개변수로 전달 받아.. 글번호에 해당되는 글의 조회수 1증가 시키는 메소드
		public void updateReadCount(int num){// content.jsp에서 호출 하는 메소드
			
			try {
				//커넥션풀로 부터 커넥션 객체 얻기 (DB와 미리 연결을 맺은 Connection객체 얻기)
				con = getConnection();
				
				sql = "update gallery set readcount=readcount+1 where num=?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, num);
				
				pstmt.executeUpdate();
			
			} catch (Exception e) {
				e.printStackTrace();
			}finally{
				//자원해제
				if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
				if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
				if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			}
			
		}
		
		
		
		//각페이지 마다 맨위에 첫번째로 보여질 시작글번호, 한페이지당 보여줄 글개수를 매개변수로 전달 받아.
		//SELECT검색한 결과를 ArrayList에 저장후 리턴 하는 메소드
		public List<GalleryBean> getGalleryList(int startRow,int pageSize){
			
			List<GalleryBean> galleryList = new ArrayList<GalleryBean>();
			try {
				//Connection객체 얻기
				con = getConnection();
				//SELECT구문 만들기
				sql = "select * from gallery order by num desc limit ?,?";
				//SELECT구문 실행할 PreparedStatement실행 객체 얻기
				pstmt = con.prepareStatement(sql);
				//?값 설정
				pstmt.setInt(1, startRow);				
				pstmt.setInt(2, pageSize);		
				//SELECT구문 실행후 검색 한 결과 받기
				rs = pstmt.executeQuery();
				
				while (rs.next()){
					GalleryBean gBean = new GalleryBean();
					//rs => GalleryBean객체의 각변수에 저장
					gBean.setContent(rs.getString("content"));
					gBean.setDate(rs.getTimestamp("date"));
					gBean.setFile(rs.getString("file"));
					gBean.setIp(rs.getString("ip"));
					gBean.setName(rs.getString("name"));
					gBean.setNum(rs.getInt("num"));
					gBean.setPasswd(rs.getString("passwd"));
					gBean.setReadcount(rs.getInt("readcount"));
					gBean.setSubject(rs.getString("subject"));
					
					//GalleryBean객체 -> ArrayList배열에 추가
					galleryList.add(gBean);
					
					
					
				}
						
				
				
			} catch (Exception err) {
				System.out.println("getGalleryList메소드 내부에서 오류 : " +err);
			}finally{
				//자원해제
				if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
				if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
				if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
			}
			
			return galleryList;//ArrayList반환
			
		}
		
		
		
		
		//게시판에 저장되어 있는 전체 글 개수 검색 메소드
		public int getGalleryCount(){
			
			int count = 0;//검색한 전체 글 갯수를 저장할 변수
			
			try {
				//커넥션풀로 부터 커넥션 객체 얻기(DB접속정보를 지니고 있는 Connection얻기)
				con = getConnection();
				//sql SELECT -> 전체 글개수 검색
				sql = "select count(*) from gallery";
				//SELECT문 실행 객체 얻기
				pstmt = con.prepareStatement(sql);
				//SELECT문 실행 후 검색한 결과 얻기
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					count = rs.getInt(1);//검색한 글의 개수
				}
			
				
			} catch (Exception e) {
				System.out.println("getGalleryCount()메소드 오류 : "+ e);
			}finally{
				//자원해제
				if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
				if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
				if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
				
			}
			
			return count;
			
		}
		
		
		
		
		//갤러리 새글 추가(주글)
		//-> gwritePro.jsp에서 insertGallery()메소드 호출시..
		//   전달한 GalleryBean객체를 이용하여 insert SQL문을 만들자.
		public void insertGallery(GalleryBean gbean){
			
			
			
			int num = 0;//추가할 글번호 저장 용도
			
			try {
				//커넥션풀로 부터 커넥션 객체 얻기(DB접속정보를 지니고 있는 Connection얻기)
				con = getConnection();
				//새글 추가시.. 글번호 구하기
				//-> gallery테이블에 저장되어 있는 가장 큰글번호 얻기
				//-> 글이 없을 경우 : 글번호 1로 지정
				//-> 글이 있을 경우 : 최근 글번호(번호가 가장큰값) + 1로 지정
				sql = "select max(num) from gallery";//가장 큰글번호 검색
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				if(rs.next()){//검색한 데이터가 존재 하면?
					num = rs.getInt(1) + 1;//글이 있을 경우 최대글번호 +1
				}else{//검색이 되지 않으면?
					num = 1;//글이 없을 경우
				}
				//insert구문 만들기
				sql = "insert into gallery "
						+"(num,name,passwd,subject,"
						+"content,file,"
						+"readcount,date,ip)"
						+"values(?,?,?,?,?,?,?,?,?)";
				//insert구문을 실행할 PreparedStatement 얻기
				pstmt = con.prepareStatement(sql);
				//?대응 되는 추가할 값을 설정
				pstmt.setInt(1, num);//추가할 새글번호
				pstmt.setString(2, gbean.getName());//새글을 추가한 작성자 이름
				pstmt.setString(3, gbean.getPasswd());//추가할 새글의 비밀번호
				pstmt.setString(4, gbean.getSubject());//추가할 새글의 글제목
				pstmt.setString(5, gbean.getContent());//추가할 새글의 글내용
				pstmt.setString(6, gbean.getFile());//추가할 새글 데이터중 업로드할 파일명
				pstmt.setInt(7, 0);//추가할 글의 조회수 readcount 0
				pstmt.setTimestamp(8, gbean.getDate());//글 작성 날짜
				pstmt.setString(9, gbean.getIp());//글쓴사람의 IP주소
				
				//insert실행
				pstmt.executeUpdate();
						
						
				
			} catch (Exception e) {
				System.out.println("insertGallery메소드 내부에서 오류 : "+e);
			}finally{
				//자원해제
				if(rs!=null)try{rs.close();}catch(Exception err){err.printStackTrace();}
				if(pstmt!=null)try{pstmt.close();}catch(Exception err){err.printStackTrace();}
				if(con!=null)try{con.close();}catch(Exception err){err.printStackTrace();}
				
			}
			
			
		}
		
		
		
		
}



















