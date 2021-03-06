<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
		
	String id = (String)session.getAttribute("id");
	Member member = new Member();
	member = (Member)request.getAttribute("member");
%>
<%
	if(!id.equals(member.getId())) {
		out.println("<script>alert('잘못된 접근입니다.');</script>");
		out.println("<script>history.back();</script>");
	}
%>
<!doctype html>
<html lang="ko">
  <head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <link rel = "stylesheet" href = "css/main.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" />
    <title>Review Me : 마이 페이지</title>
  </head>
  <body>
  <header class="container mt-5">
		<div class="col-2" id="logo" onclick="location.href='index.do'" style="cursor: pointer;"><img src="imgs/logo3.png" alt="Logo"/></div>
<!-- 		<div class="col-2 ml-5" id = "board"><button onclick="location.href='boardList.do'">전체 리뷰</button></div> -->
		<form id="searchForm" method="post" action="totalSearch.do">
			<input name="keyword" style= "margin-left: 13%; margin-top: 3%;" id="search" class="col-5" type="text"
				placeholder="제목 / 작성자로 검색하세요." required />
		</form>
			<div class="col-2" id="login">
				<h6> <a href="selectMember.do?id=<%=id %>"><%=id%></a>님 환영합니다.</h6>
				<b><a href="logout.do"> 로그아웃</a></b>
				<b><%if(id.equals("admin")) { %><a style="float:right;" href="memberlist.do">멤버 관리</a></b><%} %>
			</div>
	</header>
	<div class="clearfix"></div>
	<hr/>
  <section>
  	<form name = "joinForm" action = "userUpdate.do" method = "post">
    <div class = "container">
		<h2 class = "text-center mt-5">회원 정보</h2>
		<div>
			<table class="table table-bordered">
				<tbody>
					<tr>
						<th scope="row">* 이름</th>
						<td>
							<div class="form-group">
								<input type="text" class="form-control col-6" name = "name" id="name" required="required" value="<%=member.getName()%>"disabled>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">* 회원 아이디(이메일)</th>
						<td>
							<div class="form-inline">
								<input type="email" class="form-control col-6" id="id" required="required" value="<%=id%>" disabled>
								<input type="hidden" name="id" value="<%=id %>"/>
							</div>
						</td>
					</tr>
					<tr>
					<tr>
						<th scope="row">* 이동통신사</th>
						<td>
							<select class="custom-select col-1" name="phone" id="phone" required="required" disabled>
								<option value="SKT" <%if(member.getPhone().equals("SKT")) { %>selected="selected" <%} %>>SKT</option>
								<option value="LG" <%if(member.getPhone().equals("LG")) { %>selected="selected" <%} %>>LG</option>
								<option value="KT" <%if(member.getPhone().equals("KT")) { %>selected="selected" <%} %>>KT</option>
								<option value="others" <%if(member.getPhone().equals("알뜰폰")) { %>selected="selected" <%} %>>알뜰폰</option>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">* 휴대전화번호</th>
						<%String pNum[] = member.getpCall().split("-"); System.out.println(pNum.length); %>
						<td>
							<div class = "form-inline">
								<select class="custom-select col-2" name="pcall1" id="call1" required="required"disabled>
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="017">017</option>
									<option value="050">050</option>
								</select>&nbsp;-&nbsp; 
								<input type="text" class="form-control col-3" name = "pcall2" id="call2" maxlength = "4"required="required" value="<%=pNum[1]%>" disabled>&nbsp;-&nbsp;
								<input type="text" class="form-control col-3" name = "pcall3" id="call3" maxlength = "4"required="required" value="<%=pNum[2]%>" disabled>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">* 성별</th>
						<td>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="gender" id="gender1" value="남" <%if(member.getGender().equals("남")){ %>checked="checked"<% } %>disabled>
								<label class="form-check-label" for="gender1">남</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="gender" id="gender2" value="여" <%if(member.getGender().equals("여")){ %>checked="checked"<% } %>disabled>
								<label class="form-check-label" for="gender2">여</label>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">* 생년월일</th>
						<td>
								<input type = "date" name = "birth" value="<%=member.getBirth()%>"disabled/>
						</td>
					</tr>
					<tr>	
						<th scope="row">* 이메일 수신동의</th>
						<td>
							<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="eAgree" id="agree1" value="agree" <%if(member.geteAgree().equals("agree")) { %>checked="checked" <% }%> disabled>						
									<label class="form-check-label" for="agree1"> 수신함</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="eAgree" id="disagree1" value="disagree" <%if(member.geteAgree().equals("disagree")) { %>checked="checked" <% }%>disabled>
								<label class="form-check-label" for="disagree1">수신안함</label>
							<small class="form-text text-muted ml-3"> * 가입하신 Email로 학습정보 등 정보성 메일이 발송됩니다.</small>
							</div>
						</td>
					</tr>
					<tr>	
						<th scope="row">* SMS 수신동의</th>
						<td>
							<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="sAgree" id="agree2" value="agree" <%if(member.getsAgree().equals("agree")) { %>checked="checked" <% }%>disabled>
									<label class="form-check-label" for="agree2">수신함</label>
								</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="sAgree" id="disagree2" value="disagree" <%if(member.getsAgree().equals("disagree")) { %>checked="checked" <% }%>disabled>
								<label class="form-check-label" for="disagree2">수신안함</label>
							</div>
						</td>
					</tr>
				
				</tbody>
				</table>
		</div>
		<input type = "button" class="btn btn-outline-warning" value ="정보 수정" onclick = "location.href='updateMember.do?id=<%=id %>'">
		<input type = "button" class="btn btn-outline-danger" value ="회원 탈퇴" id = "deleteMember">
	</div>
	</form>
  </section>
  <div class="clearfix"></div>
  </body>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js" ></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" ></script>
    <script>
    	$("#deleteMember").click(function(){
    		if(confirm("삭제하시겠습니까?")) {
    			location.href="deleteMember.do?id=<%=id %>";
    		}
    	});
    </script>
</html>