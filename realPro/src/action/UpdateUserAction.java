package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.UpdateUserService;
import vo.ActionForward;
import vo.Member;

public class UpdateUserAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("회원정보수정 액션 입장");
		Member member=new Member();
   		boolean updateResult=false;
   		
   		member.setName(request.getParameter("name"));
   		member.setId(request.getParameter("id"));
   		member.setPass(request.getParameter("pass"));
   		member.setPassT(request.getParameter("passT"));
   		member.setPhone(request.getParameter("phone"));
   		String pcall = request.getParameter("pcall1")+"-"+request.getParameter("pcall2")+"-"+request.getParameter("pcall3");
   		member.setpCall(pcall);
   		member.setGender(request.getParameter("gender"));
   		member.setBirth(request.getParameter("birth"));
   		member.seteAgree(request.getParameter("eAgree"));
   		member.setsAgree(request.getParameter("sAgree"));
   		
   		UpdateUserService uus = new UpdateUserService();
   		updateResult = uus.updateUser(member);
   		
   		ActionForward forward = null;
   		if(updateResult==false){
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
   		forward.setPath("./index.do");
   		}
   		return forward;
	}

}
