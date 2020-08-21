package svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import dao.MemberDAO;

public class AdminDeleteService {

	public boolean deleteMember(String id) throws Exception {
		
		boolean isRemoveSuccess = false;
		Connection conn = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(conn);
		int deleteCount = memberDAO.deleteAdmin(id);
		
		if(deleteCount > 0) {
			commit(conn);
			isRemoveSuccess = true;
		}
		else {
			rollback(conn);
		}		
		close(conn);
		return isRemoveSuccess;
	}

}
