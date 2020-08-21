package action;

import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.MemberListService;
import vo.ActionForward;
import vo.Member;

public class MemberListAction implements Action {

	public ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception{
		 
		ArrayList<Member> memberList = new ArrayList<Member>();	  			
		MemberListService memberListService = new MemberListService();
		memberList = memberListService.getmemberList();
		request.setAttribute("memberList", memberList);
		ActionForward forward= new ActionForward();
   		forward.setPath("userListForm.jsp");
   		return forward;
   		
	 }

}
