package action;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.MemberBanService;
import vo.ActionForward;

public class MemberBanAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
		String id = request.getParameter("id");
		MemberBanService mbs = new MemberBanService();
		boolean result = mbs.memberBan(id);
		ActionForward forward = new ActionForward();
		if(result == true) {
			forward.setPath("memberlist.do");
		} else {
			forward.setPath("memberlist.do");

		}
   		return forward;
	}

}
