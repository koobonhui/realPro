package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.IdCheckService;
import vo.ActionForward;

public class IdCheckAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
   		boolean joinResult=false;
   		String id = request.getParameter("id");
   		
   		IdCheckService idSVC = new IdCheckService();
   		joinResult = idSVC.idChecksvc(id);
   		
   		ActionForward forward = null;
   		if(joinResult == true){
   			response.setContentType("text/html;charset=UTF-8");
   			PrintWriter out = response.getWriter();
   			out.println("0");
	   	}
   		else{
   			response.setContentType("text/html;charset=UTF-8");
   			PrintWriter out = response.getWriter();
   			out.println("1");
   		}
   		return forward;
	}

}
