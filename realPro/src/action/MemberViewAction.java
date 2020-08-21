package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.MemberViewService;
import vo.ActionForward;
import vo.Member;

 public class MemberViewAction implements Action {
	 
	 public ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception{ 
	   	
		String id = request.getParameter("id");
		MemberViewService memberViewService = new MemberViewService();
		Member memberview = memberViewService.getmemberview(id);	
		ActionForward forward = new ActionForward();
	   	request.setAttribute("memberview", memberview);
   		forward.setPath("userViewForm.jsp");
   		return forward;
	 }
	 
}