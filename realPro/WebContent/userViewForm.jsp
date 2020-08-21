<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="vo.Member"%>
<%
	String id = (String) session.getAttribute("id");
	Member memberview = (Member)request.getAttribute("memberview");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review Me : 유저 상세보기</title>
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
		<table class="table table-hover table-dark">		
		  <tbody>
		    <tr>
			    <th style="width: 20%;">아이디</th>
			    <td><%=memberview.getId() %></td>
		    </tr>
		    
		    <tr>
			    <th>이름</th>
			    <td><%=memberview.getName() %></td>
		    </tr>
		    
		    <tr>
				<th>비밀번호</th>
				<td><%=memberview.getPass() %></td>
		    </tr>
		    
		    <tr>
				<th>통신사</th>
				<td><%=memberview.getPhone() %></td>
		    </tr>
		    
		    <tr>
				<th>휴대폰</th>
				<td><%=memberview.getpCall() %></td>
		    </tr>
		    
		    <tr>
				<th>성별</th>
				<td><%=memberview.getGender() %></td>
		    </tr>
		    
		    <tr>
				<th>생일</th>
				<td><%=memberview.getBirth() %></td>
		    </tr>
		    
		    <tr>
				<th>이메일 동의</th>
				<td><%=memberview.geteAgree() %></td>
		    </tr>
		    
		    <tr>
				<th>SMS 동의</th>
				<td><%=memberview.getsAgree() %></td>														
		    </tr>
		    
		    <tr>
				<th>Ban 처리</th>
				<td>
					<%if(!memberview.isBan()) { %>
						Ban 안됨
					<% } else { %>
						Ban
					<% } %>
				</td>														
		    </tr>
		  </tbody>
		</table>
		
		<div class = "clearfix">
			<a href="memberlist.do" class="btn btn-primary float-right" id="writeBtn">목록</a>		
		</div>
	</div>
</div>
</body>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
</html>