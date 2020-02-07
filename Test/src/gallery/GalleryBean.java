package gallery;

import java.sql.Timestamp;

//VO역할을 하는 클래스
//-> DB에 저장되어 있는 하나의 게시글을 검색해서 가져와서 저장할 용도의 클래스
//-> 입력한 새글의 내용을 DB에 전달 하기 전에... 각변수에 저장할 용도의 클래스
public class GalleryBean {
	//변수만들기
	//-> gallery테이블의 컬럼이름과 동일하게 변수명 작성.
	//-> gallery테이블의 컬럼 데이터타입과 동일하게 타입을 설정 해서 변수 만들기
	private int num;
	private String name,passwd,subject,content,file,ip;
	private int readcount;
	private Timestamp date;
	
	//getter,setter메소드 만들기
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	
	
	
	
	
	
	
	
	
}
