package membership;

import common.JDBConnect;
/*
 DAO(Data Access Object): 실제 데이터 베이스에 접근하여 
 	여러가지 CRUD작업을 하기 위한 객체
 */
//DB 연결을 위한 클래스를 상속한다.
public class MemberDAO extends JDBConnect {
	
	//인자가 4개인 부모의 생성자를 호출하여 연결한다.(super은 무조건 부모임)
	public MemberDAO(String drv, String url, String id, String pw) {
		super(drv, url, id, pw);
	}
	/*
	 사용자가 입력한 아이디, 패스워드를 통해 회원테이블을 확인한 후
	 존재하는 정보인 경우 DTO객체에 그 정보를 담아 반환한다.
	 */
	public MemberDTO getMemberDTO(String uid, String upass) {
		MemberDTO dto = new MemberDTO();
		//회원로그인을 위한 쿼리문 작성
		String query = "SELECT * FROM member WHERE id=? AND pass=?";
	
		try {
			psmt = con.prepareStatement(query);
			//쿼리문에 사용자가 입력한 아이디,패스워드를 설정
			psmt.setString(1, uid);
			psmt.setString(2, upass);
			//쿼리 실행
			rs = psmt.executeQuery();
			
			//회원정보가 존재한다면 DTO객체에 회원정보를 저장한다.
			if(rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString(3));
				dto.setRegidate(rs.getString(4));
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	public String findIdView(String name1) {
		String findId="";
		MemberDTO dto = new MemberDTO();
		
		String query="SELECT ID FROM member WHERE name=?";
		
		try {
			psmt=con.prepareStatement(query);
			psmt.setString(1, name1);
			rs=psmt.executeQuery();

			if(rs.next()) {
				findId=rs.getString("id");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return findId;
	}
	public String findPassView(String name1,String id) {
		String findPw="";
		MemberDTO dto = new MemberDTO();
		
		String query="SELECT pass FROM member WHERE name=? AND id=?";
		
		try {
			psmt=con.prepareStatement(query);
			psmt.setString(1, name1);
			psmt.setString(2, id);
			//쿼리실행
			rs=psmt.executeQuery();

			if(rs.next()) {
				findPw=rs.getString("pass");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return findPw;
	}
}