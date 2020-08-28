package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.UpdatePassService;
import vo.ActionForward;
import vo.Member;

public class UpdatePassAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("비밀번호수정 액션 입장");
		Member member = new Member();
   		boolean updateResult=false;
   		
   		member.setId(request.getParameter("id"));
   		member.setPass(request.getParameter("pass"));
   		member.setPassT(request.getParameter("passT"));
   		
   		UpdatePassService ups = new UpdatePassService();
   		updateResult = ups.updatePass(member);
   		
   		ActionForward forward = null;
   		if(updateResult == false){
   			response.setContentType("text/html;charset=UTF-8");
   			PrintWriter out = response.getWriter();
   			out.println("<script>");
   			out.println("alert('에러')");
   			out.println("history.back()");
   			out.println("</script>");
	   	}
   		else{
   	    forward = new ActionForward();
   		forward.setRedirect(true);
   		forward.setPath("loginForm.do");
   		}
   		return forward;
	}

}
