package member;

import java.sql.Timestamp;

//VO역할을 하는 클래스
//->DB로 부터 회원 한사람의 정보를 검색해와서 변수에 저장할 용도의 클래스
//->회원가입을 위해(DB에 회원정보 추가) 입력 한 정보를 저장 할 용도

public class MemberBean {

	//변수 -> private,member테이블의 컬럼이름과 자료형을 동일 하게
	private String id;			//아이디
	private String passwd;		//비밀번호
	private String name;		//이름
	private Timestamp reg_date; //가입날짜
	private int age;			//나이
	private String gender;		//성별
	private String email;		//이메일
	private String address;		//주소
	private String tel;			//전화번호
	private String mtel;		//핸드폰번호
	
	
	
	//getter,setter메소드
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getMtel() {
		return mtel;
	}
	public void setMtel(String mtel) {
		this.mtel = mtel;
	}
	
	
	
	
	
}
