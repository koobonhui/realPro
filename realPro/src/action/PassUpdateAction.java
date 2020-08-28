package action;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vo.ActionForward;

public class PassUpdateAction implements Action{
	 public ActionForward execute(HttpServletRequest request,HttpServletResponse response) 
	 	throws Exception{
		 	response.setCharacterEncoding("UTF-8");
		 	response.setContentType("text/html; charset=UTF-8");
		 	String id = request.getParameter("id");
		 	System.out.println(id);
		 	request.setAttribute("reid", id);		 	
		 	ActionForward forward = new ActionForward();
		 	forward.setRedirect(false);
		 	forward.setPath("updatePass.jsp");
		 	return forward;
	}
}