package action;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.MemberPermitService;
import vo.ActionForward;

public class MemberPermitAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
		String id = request.getParameter("id");
		MemberPermitService mbs = new MemberPermitService();
		boolean result = mbs.memberPermit(id);
		ActionForward forward = new ActionForward();
		if(result == true) {
			forward.setPath("memberlist.do");
		} else {
			forward.setPath("memberlist.do");

		}
   		return forward;
	}

}
