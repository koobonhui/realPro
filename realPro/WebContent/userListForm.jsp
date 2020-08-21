<%@page import="java.util.ArrayList"%>
<%@page import="vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = (String) session.getAttribute("id");
	ArrayList<Member> memberList = (ArrayList<Member>)request.getAttribute("memberList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review Me : 유저목록</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<link rel="stylesheet" href="css/main.css">
</head>
<body>
<header class="container mt-5">
	<div class="col-2" id="logo" onclick="location.href='index.do'" style="cursor: pointer;"><img src="imgs/logo3.png" alt="Logo"/></div>
	<div class="col-2 ml-5" id="board"><button onclick="location.href='boardList.do'">전체 리뷰</button></div>
	<form id="searchForm" method="post" action="totalSearch.do">
		<input name="keyword" id="search" class="col-5" type="text"
			placeholder="제품명 혹은 모델번호로 검색하세요." required />
	</form>
	<% if(id == null){ %>
		<div class="col-2" id="login">
			<b><a href="loginForm.do"> 로그인</a> / 
			<a href="joinForm.do"> 회원가입</a></b>
		</div>
	<% } else { %>
		<div class="col-2" id="login">
			<h6> <a href="selectMember.do?id=<%=id %>"><%=id%></a>님 환영합니다.</h6>
			<b><a href="logout.do"> 로그아웃</a></b>
		<%if(id.equals("admin")) { %><b><a style="float:right;" href="./memberSearchForm.do" onclick="window.open(this.href, '_blank', 'width=500px,height=300px,toolbars=no,scrollbars=no'); return false;">멤버 관리</a></b><%} %>
		</div>
	<% } %>
</header>

<div class="clearfix"></div>

<hr/>
	
<div class="container pt-3 mt-5">
	<div class="row">
		<%
			if(memberList != null) {
		%>	
		<table class="table text-center table-bordered table-hover" style="table-layout: fixed">
			<thead class="thead-dark">
				<tr>
					<th>아이디</th>
					<th>Ban 하기</th>
					<th>삭제</th>
				</tr>
			</thead>
			
			<tbody>	
				<%
					for(int i = 0; i < memberList.size(); i++) {
				%>			
				<tr>
					<td><a href = "memberViewAction.do?id=<%=memberList.get(i).getId() %>"><%=memberList.get(i).getId() %></a></td>
					<%if(!memberList.get(i).isBan()) { %>
						<td><a href = "memberBan.do?id=<%=memberList.get(i).getId()%>" class="btn btn-outline-danger" onclick = "return confirm('정말 벤 하시겠습니까?')">Ban 하기</a></td>
					<% } else { %>
						<td><a href = "memberPermit.do?id=<%=memberList.get(i).getId()%>" class="btn btn-outline-danger">Ban 풀기</a></td>
					<% } %>
					<td><a href = "admindelete.do?id=<%=memberList.get(i).getId() %>" class="btn btn-outline-danger" onclick = "return confirm('정말 삭제하시겠습니까?')">삭제</a></td>
				</tr>
				<%
					} 
				%>				
			</tbody>
		</table>
		<%
			}
		%>
	</div>
</div>
</body>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<!-- 페이지 새로고침 -->
<script>	
	if(self.name != 'reload') {
		self.name = 'reload';
		self.location.reload(true);
	} else self.name = '';
</script>
</html>