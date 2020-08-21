package svc;

import java.sql.Connection;
import dao.MemberDAO;
import vo.Member;
import static db.JdbcUtil.*;

public class MemberViewService {

	public Member getmemberview(String id) throws Exception {
		// TODO Auto-generated method stub
		Connection conn = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(conn);
		Member member = memberDAO.selectMember(id);
		close(conn);
		return member;
		
		
		
	}

}
