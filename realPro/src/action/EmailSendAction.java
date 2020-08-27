package action;


import java.io.PrintWriter;
import java.util.Properties;
import java.util.Random;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import vo.ActionForward;
public class EmailSendAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		String member_id = request.getParameter("id");
		ActionForward forward = new ActionForward();
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
//		int random = 0;
//		random = (int)Math.floor((Math.random()*(99999-10000+1)))+10000;
		
		StringBuffer temp = new StringBuffer();
		Random rnd = new Random();
		for (int i = 0; i < 10; i++) {
			int rIndex = rnd.nextInt(3);
			switch (rIndex) {
			case 0:
				// a-z
				temp.append((char) ((int) (rnd.nextInt(26)) + 97));
				break;
			case 1:
				// A-Z
				temp.append((char) ((int) (rnd.nextInt(26)) + 65));
				break;
			case 2:
				// 0-9
				temp.append((rnd.nextInt(10)));
				break;
			}
		}
		String AuthenticationKey = temp.toString();
		System.out.println(AuthenticationKey);
		
		String sender = "qhsgnl91@naver.com";
		String receiver = member_id;
		String subject = "인증번호";
		String content = "인증번호는 : " + temp;
		
		PrintWriter out = response.getWriter();
		
		try {
			Properties props = System.getProperties();
			 props.put("mail.debug", "true");
	         props.put("mail.smtp.starttls.enable", "true");
	         props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
	         props.put("mail.smtp.host", "smtp.gmail.com");
	         props.put("mail.smtp.auth", "true");
	         props.put("mail.smtp.port", "465");
	         props.put("mail.smtp.ssl.enable", "true");
	         props.put("mail.transport.protocol","smtp");

			javax.mail.Authenticator auth = new GoogleAuthentication();
			Session s = Session.getDefaultInstance(props, auth);
			Message message = new MimeMessage(s);
			Address sender_address = new InternetAddress(sender);
			Address receiver_address = new InternetAddress(receiver);
			message.setHeader("content-type", "text/html;charset=UTF-8");
			message.setFrom(sender_address);
			message.addRecipient(Message.RecipientType.TO, receiver_address);
			message.setSubject(subject);
			message.setContent(content, "text/html;charset=UTF-8");
			message.setSentDate(new java.util.Date());
			Transport.send(message);
			request.setAttribute("pass", temp);
			forward.setPath("passFind.jsp");
		} catch(Exception e) {
			out.println("문제있음");
			e.printStackTrace();
		}
		return forward;
	}
}
