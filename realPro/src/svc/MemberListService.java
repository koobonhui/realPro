package svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.util.ArrayList;
import dao.MemberDAO;
import vo.Member;

public class MemberListService {
	public ArrayList<Member> getmemberList() throws Exception {
		
		ArrayList<Member> memberList = null;
		Connection con = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		memberList = memberDAO.MemberList();
		close(con);
		return memberList;		
	}

}
