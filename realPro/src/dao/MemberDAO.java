package dao;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import vo.Member;

public class MemberDAO {
	public static MemberDAO instance;
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	DataSource ds;
	private MemberDAO() {
		
	}
	
	public static MemberDAO getInstance(){
		if(instance == null){
			instance = new MemberDAO();
		}
		return instance;
	}
	
	public void setConnection(Connection conn){
		this.conn = conn;
	}
	
	public String selectLoginId(Member member){		// 로그인
		String loginId = null;
		String sql="SELECT id FROM users WHERE id=? AND pass=HEX(AES_ENCRYPT(?, SHA2('Repass', 256)))";
		
		try{
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPass());
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				loginId = rs.getString("id");
			}
		}catch(Exception ex){
			System.out.println(" 에러 " + ex);			
		}finally{
			close(rs);
			close(pstmt);
		}
		
		return loginId;
	}
	
	public int insertMember(Member member){		// 회원가입
		String sql="INSERT INTO users VALUES (?,?,HEX(AES_ENCRYPT(?, SHA2('Repass', 256))),HEX(AES_ENCRYPT(?, SHA2('Repass', 256))),?,?,?,?,?,?,0)";
													// 비밀번호 암호화, 복호화
		int insertCount=0;
		
		try{
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getPass());
			pstmt.setString(4, member.getPassT());
			pstmt.setString(5, member.getPhone());
			pstmt.setString(6, member.getpCall());
			pstmt.setString(7, member.getGender());
			pstmt.setString(8, member.getBirth());
			pstmt.setString(9, member.geteAgree());
			pstmt.setString(10, member.getsAgree());
			insertCount=pstmt.executeUpdate();
		}catch(Exception ex){
			System.out.println("joinMember 에러: " + ex);			
		}finally{
			close(pstmt);
		}
		
		return insertCount;
	}
	
	public int loginResult(String id, String pass) {		// 로그인 결과
		String pass_sql="";
		String sql = "SELECT id, AES_DECRYPT(UNHEX(pass), SHA2('Repass',256)) pass,ban FROM users WHERE id=?";
		boolean ban = false;

		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				do {
					id = rs.getString("id");
					pass_sql = rs.getString("pass");
					ban =  rs.getBoolean("ban");
				} while(rs.next());
			} else {
				return 0; // 없는 계정
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		if(pass_sql.equals(pass)) {
			if(ban == true) {
				return 3; // 밴 상태
			}
			return 1; // 성공
		} else
			return 2; // 비번 틀림
	}
	
	public Member selectMember(String id) {		// 유저정보 불러오기
		String sql="SELECT name, id, AES_DECRYPT(UNHEX(pass), SHA2('Repass',256)) pass, phone, pcall, gender, birth, eAgree, sAgree, ban FROM users WHERE id=?";
		Member selectMember = new Member();
		
		try{
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs =pstmt.executeQuery();
			rs.next();
			selectMember.setName(rs.getString("name"));
			selectMember.setId(rs.getString("id"));
			selectMember.setPass(rs.getString("pass"));
			selectMember.setPhone(rs.getString("phone"));
			selectMember.setpCall(rs.getString("pcall"));
			selectMember.setGender(rs.getString("gender"));
			selectMember.setBirth(rs.getString("birth"));
			selectMember.seteAgree(rs.getString("eAgree"));
			selectMember.setsAgree(rs.getString("sAgree"));
			selectMember.setBan(rs.getBoolean("ban"));
		}catch(Exception ex){
			System.out.println("joinMember 에러: " + ex);			
		}finally{
			close(pstmt);
		}
		
		return selectMember;
	}
	
	public int updateUser(Member member) {
		System.out.println("유저정보수정 DAO 입장");
		String sql="UPDATE users SET name=?, pass=HEX(AES_ENCRYPT(?,SHA2('Repass', 256))), passT=HEX(AES_ENCRYPT(?,SHA2('Repass', 256))), phone=?, pcall=?, gender=?, birth=?, eAgree=?, sAgree=? WHERE id=?";
		int result=0;
		
		try{
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, member.getName());
			pstmt.setString(2, member.getPass());
			pstmt.setString(3, member.getPassT());
			pstmt.setString(4, member.getPhone());
			pstmt.setString(5, member.getpCall());
			pstmt.setString(6, member.getGender());
			pstmt.setString(7, member.getBirth());
			pstmt.setString(8, member.geteAgree());
			pstmt.setString(9, member.getsAgree());
			pstmt.setString(10, member.getId());
			result =pstmt.executeUpdate();
			return result;
		}catch(Exception ex){
			System.out.println("joinMember 에러: " + ex);			
		}finally{
			close(pstmt);
		}
		
		return result;
	}
	
	public int idCheck(String id) {		// 아이디 중복 체크
		String sql = "select count(id) idcnt from users where id = '" + id + "'";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt("idcnt");
			} else {
				return 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			close(rs);
			close(pstmt);
		}
		return -1;
	}
	
	public Member memberSearch(String id) {		// 유저 검색
		// TODO Auto-generated method stub
		Member member = new Member();
		String sql = "SELECT name,id,gender,birth,ban FROM users WHERE id = '" + id + "'";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				member.setName(rs.getString("name"));
				member.setId(rs.getString("id"));
				member.setGender(rs.getString("gender"));
				member.setBirth(rs.getString("birth"));
				member.setBan(rs.getBoolean("ban"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			close(rs);
			close(pstmt);
		}
		return member;
	}
	
	public boolean deleteMember(String id) {	//	유저 삭제
		System.out.println("삭제 컨트롤" + id);
		boolean result = false;
		int cnt = 0;
		String sql = "delete from users where id = '"+ id + "'";
			try {
				pstmt = conn.prepareStatement(sql);
				cnt = pstmt.executeUpdate();
				if(cnt == 1) {
					result = true;
				}
				conn.commit();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		return result;
	}
	
	public boolean memberBan(String id) {	// 유저 벤 시키기
		String sql = "UPDATE users SET ban=1 WHERE id=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			int result = pstmt.executeUpdate();
			if(result > 0) {
				conn.commit();
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return false;
	}
	
	public boolean memberPermit(String id) {	// 유저 벤 풀어주기
		String sql = "UPDATE users SET ban=0 WHERE id=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			int result = pstmt.executeUpdate();
			if(result > 0) {
				conn.commit();
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return false;
	}
	
	public ArrayList<Member> MemberList() {		// 회원목록
		String sql = "SELECT * FROM users";
		ArrayList<Member> memberList = new ArrayList<Member>();
		Member mb = null;
		try {
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				do {
					mb = new Member();
					mb.setId(rs.getString("id"));
					mb.setName(rs.getString("name"));
					mb.setPass(rs.getString("pass"));
					mb.setPassT(rs.getString("passT"));
					mb.setPhone(rs.getString("phone"));
					mb.setpCall(rs.getString("pcall"));
					mb.setGender(rs.getString("gender"));
					mb.setBirth(rs.getString("birth"));
					mb.seteAgree(rs.getString("eAgree"));
					mb.setsAgree(rs.getString("sAgree"));
					mb.setBan(rs.getBoolean("ban"));
					memberList.add(mb);
				} while(rs.next());
			}
		} catch(Exception ex) {
			System.out.println("getDeatilMember 에러: " + ex);			
		} finally {
			close(rs);
			close(pstmt);
		}
		return memberList;
	}
	
	public int deleteAdmin(String id) {
		String sql = "DELETE FROM users WHERE id=?";
		int deleteCount = 0;

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			deleteCount = pstmt.executeUpdate();
		} catch(Exception ex) {
			System.out.println("deleteAdmin 에러: " + ex);	
		} finally {
			close(pstmt);
		}
		
		return deleteCount;
	}
	
	public int updatePass(Member member) {
		System.out.println("비밀번호수정 DAO 입장");
		String sql="UPDATE users SET pass=HEX(AES_ENCRYPT(?,SHA2('Repass', 256))), passT=HEX(AES_ENCRYPT(?,SHA2('Repass', 256))) WHERE id=?";
		int result=0;
		
		try{
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, member.getPass());
			pstmt.setString(2, member.getPassT());
			pstmt.setString(3, member.getId());
			result =pstmt.executeUpdate();
			return result;
		}catch(Exception ex){
			System.out.println("updatePass 에러: " + ex);			
		}finally{
			close(pstmt);
		}
		
		return result;
	}
}