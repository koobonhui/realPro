package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import action.AdminDeleteAction;
import action.BoardListAction;
import action.BoardWriteProAction;
import action.CateListAction;
import action.DeleteMemberAction;
import action.DeleteReviewAction;
import action.EmailSendAction;
import action.IdCheckAction;
import action.JoinAction;
import action.LoginAction;
import action.MemberBanAction;
import action.MemberListAction;
import action.MemberPermitAction;
import action.MemberSearchAction;
import action.MemberViewAction;
import action.PassUpdateAction;
import action.RecCountAction;
import action.ReplyAction;
import action.ReplyDeleteAction;
import action.ReplyWriteAction;
import action.ReviewReadAction;
import action.ReviewRecommendAction;
import action.ReviewsAction;
import action.SelectMemberAction;
import action.TotalSearchAction;
import action.UpdateMemberAction;
import action.UpdatePassAction;
import action.UpdateReviewAction;
import action.UpdateUserAction;
import vo.ActionForward;

@WebServlet("*.do")
public class Controller extends javax.servlet.http.HttpServlet 
{
	private static final long serialVersionUID = 1L;

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		String RequestURI=request.getRequestURI();
		String contextPath=request.getContextPath();
		String command=RequestURI.substring(contextPath.length());
		ActionForward forward=null;
		Action action=null;
		Action action1 = null;
		
		if(command.equals("/loginForm.do")) {		// 로그인 폼
			forward=new ActionForward();
			forward.setPath("/loginForm.jsp");
		} else if(command.equals("/find.do")) {		// 비번찾기 폼
			forward=new ActionForward();
			forward.setPath("/passFindForm.jsp");
		} else if(command.equals("/login.do")) {	// 로그인 액션
			action = new LoginAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if(command.equals("/logout.do")) {		// 로그아웃
			HttpSession session = request.getSession();
			session.invalidate();
			response.sendRedirect("./index.do");
		} else if(command.equals("/joinForm.do")) {		// 회원가입 폼
			forward=new ActionForward();
			forward.setPath("/joinForm.jsp");
		} else if(command.equals("/joinAction.do")) {		// 회원가입 액션
			action = new JoinAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(command.equals("/index.do")) {	// 메인화면으로 (게시글 넘겨주면서)
			action = new ReviewsAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(command.equals("/passupdate.do")) {	// 새 비밀번호
			action = new PassUpdateAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(command.equals("/updatepass.do")) {	// 새 비밀번호 수정
			action = new UpdatePassAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(command.equals("/reviewWriteForm.do")) {		// 게시글 쓰기 폼
			forward=new ActionForward();
			forward.setPath("/reviewWriteForm.jsp");
			forward.setRedirect(false);
		} else if(command.equals("/reviewReadForm.do")) {		// 선택한 게시글 읽기
			action = new ReviewReadAction();
			action1 = new ReplyAction();
			try {
				forward = action.execute(request, response);
				forward = action1.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if(command.equals("/replyWrite.do")) {		// 게시글 댓글 쓰기
			action = new ReplyWriteAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if(command.equals("/boardWritePro.do")) {	// 게시글 쓰기
			action = new BoardWriteProAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if(command.equals("/boardList.do")) {		// 게시글 전체 보기
			action = new BoardListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if(command.equals("/deleteReview.do")) {		// 게시글 삭제
			action = new DeleteReviewAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if(command.equals("/updateReview.do")) {		// 게시글 수정
			action = new UpdateReviewAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if(command.equals("/replyDelete.do")) {		// 게시글 댓글 수정
			action = new ReplyDeleteAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if(command.equals("/selectMember.do")) {		// 자기 회원정보 보기
			action = new SelectMemberAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if(command.equals("/userUpdate.do")) {		// 회원정보 수정(필요없는거 같은데 무섭다)
			action = new UpdateUserAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if(command.equals("/totalSearch.do")) {		//	전체리뷰
			action = new TotalSearchAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		} else if(command.equals("/idCheck.do")) {		// 아이디 중복 체크
			action = new IdCheckAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if(command.equals("/cateList.do")) {		// 카테고리 게시글 검색
			action = new CateListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if(command.equals("/recommendReview.do")) {		// 좋아요 누르기
			action = new ReviewRecommendAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if(command.equals("/recCount.do")) {		// 좋아요 카운트
			action = new RecCountAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if(command.equals("/memberSearchForm.do")) {		// 회원찾기 폼
			forward=new ActionForward();
			forward.setPath("/memberSearchForm.jsp");
		} else if(command.equals("/memberSearch.do")) {		// 회원찾기(아이디 입력)
			action = new MemberSearchAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if(command.equals("/updateMember.do")) {		// 회원 정보 수정
			action = new UpdateMemberAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if(command.equals("/deleteMember.do")) {		// 회원 탈퇴
			System.out.println("삭제 컨트롤");
			action = new DeleteMemberAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if(command.equals("/memberBan.do")) {		// 회원 Ban
			action = new MemberBanAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if(command.equals("/memberPermit.do")) {		// Ban 풀어주기
			action = new MemberPermitAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if(command.equals("/memberlist.do")) {		// 회원 리스트 보기
			action = new MemberListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if(command.equals("/memberViewAction.do")) {		// 회원 상세 보기
			action = new MemberViewAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if(command.equals("/admindelete.do")) {		// 관리자 유저 삭제
			action = new AdminDeleteAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if(command.equals("/emailsend.do")) {		// 비밀번호 찾기
			action = new EmailSendAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		if(forward != null){
			
			if(forward.isRedirect()){
				response.sendRedirect(forward.getPath());
			}else{
				RequestDispatcher dispatcher=
						request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
			
		}
		
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doProcess(request,response);
	}  	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doProcess(request,response);
	}   
	
}