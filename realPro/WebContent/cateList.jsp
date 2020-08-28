<%@page import="vo.PageInfo"%>
<%@page import="java.util.*"%>
<%@page import="vo.Reviews"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	String category = null;
	if(request.getParameter("category") != null) {
		category = request.getParameter("category");
	}
	String id = (String)session.getAttribute("id");
   String name = (String)session.getAttribute("name");
   Reviews articleList = (Reviews)request.getAttribute("articleList");
	PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	int listCount=pageInfo.getListCount();
	int nowPage=pageInfo.getPage();
	int maxPage=pageInfo.getMaxPage();
	int startPage=pageInfo.getStartPage(); 
	int endPage=pageInfo.getEndPage(); 
 %> 
<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"/>
	<link rel="stylesheet" href="css/main.css">
	<title>Review Me : <%=category %>게시판</title>
</head>
<body>
	<header class="container mt-5">
		<div class="col-2" id="logo" onclick="location.href='index.do'" style="cursor: pointer;"><img src="imgs/logo3.png" alt="Logo"/></div>
<!-- 		<div class="col-2 ml-5" id="board"><button onclick="location.href='boardList.do'">전체 리뷰</button></div> -->
		<form id="searchForm" method="post" action="totalSearch.do">
			<input style= "margin-left: 13%; margin-top: 3%;" name="keyword" id="search" class="col-5" type="text"
				placeholder="제목 / 작성자로 검색하세요." required />
		</form>
		<% if(id == null){ %>
			<div class="col-2" style= "margin-top: 2%;" id="login">
				<b><a href="loginForm.do" class="btn btn-primary btn-lg"> 로그인</a></b>
			</div>
		<% } else { %>
			<div class="col-2" id="login">
				<h6> <a href="selectMember.do?id=<%=id %>"><%=id%></a>님 환영합니다.</h6>
				<b><a href="logout.do"> 로그아웃</a></b>
			<%if(id.equals("admin")) { %><b><a style="float:right;" href="memberlist.do">멤버 관리</a></b><%} %>
			</div>
		<% } %>
	</header>
	<div class="clearfix"></div>
	<hr/>
	<div class="container"><h5><%=category %> 게시물 검색결과</h5></div>
	<section class = "container" id="listForm">
		<p style="float: left; margin-top: 1%;"><%=category %> 리뷰<small>(<%=listCount %>개)</small></p>
		<div class="col-3 ml-5" style="float:right; margin-bottom: 1%;" id="board"><button type="button" class="btn btn-info" onclick="location.href='reviewWriteForm.do'">리뷰 작성</button></div>
		<div class="card-group" style="clear: both;">
		
			<%
			if(articleList != null ){
			%>
			<%
			for(int i= 0, j = 1 ; j<=articleList.getContent().size();j++, i++){
				if(j % 4 == 0){ %>
			<div id="cardList" class="p-0 card col-3" onclick="location.href='reviewReadForm.do?board_num=<%=articleList.getNum().get(i) %>'" style="cursor:pointer;">
				<img src="./boardUpload/<%=articleList.getImage().get(i) %>" class="card-img-top" alt="...">
				<div class="card-body">
					<small class="text-muted">작성자: <%=articleList.getUser().get(i) %></small>
					<h5 style="white-space: nowrap; overflow:hidden;" class="mt-2 card-title"><%=articleList.getTitle().get(i)%></h5>
					<p class="card-text"><%=articleList.getContent().get(i)%></p>
				</div>
				<div class="card-footer">
					<b>카테고리: <%=articleList.getCategory().get(i) %></b><br/>
				</div>
			</div>
			</div>
			<div class = "card-group">	
			<%		
				} else { 
			%>
			<div id="cardList" class="p-0 card col-3" onclick="location.href='reviewReadForm.do?board_num=<%=articleList.getNum().get(i) %>'" style="cursor:pointer;">
				<img src="./boardUpload/<%=articleList.getImage().get(i) %>" class="card-img-top" alt="...">
				<div class="card-body">
					<small class="text-muted">작성자: <%=articleList.getUser().get(i) %></small>
					<h5 style="white-space: nowrap; overflow:hidden;" class="mt-2 card-title"><%=articleList.getTitle().get(i)%></h5>
					<p class="card-text"><%=articleList.getContent().get(i)%></p>
				</div>
				<div class="card-footer">
					<b>카테고리: <%=articleList.getCategory().get(i) %></b><br/>
				</div>
			</div>
			<%} }%>
			<%
		    }else{
				out.println("등록된 글이 없습니다.");
			}
			%>
		</div>
	</section>
	<div class = "container mt-3">
		<ul class="pagination justify-content-center">
	   		<!-- 탭 안되게 할려면 -1 -->
    		<li class="page-item <%=nowPage == 1 ? "disabled" : ""%>">
       			<a <%=nowPage == 1 ? "tabindex='-1'" : ""%> class="page-link" href="cateList.do?page=<%=nowPage-1 %>&&category=<%=category%>">&lt;</a>
   			</li>
   			<%
   				for(int i = startPage; i <= endPage; i++) {
   			%>
	    	<li class="page-item <%=nowPage == i ? "active" : ""%>">
	    		<a class="page-link" href="cateList.do?page=<%=i %>&&category=<%=category%>"><%=i%></a>
	    	</li>
	    	<%
   				}
	    	%>
	    	<li class="page-item <%=maxPage == nowPage ? "disabled" : ""%>">
        		<a <%=maxPage == nowPage ? "tabindex='-1'" : ""%> class="page-link" href="cateList.do?page=<%=nowPage+1 %>&&category=<%=category%>">&gt;</a>
	    	</li>	
	 	</ul>
	</div>
</body>
<script src="https://code.jquery.com/jquery-3.5.1.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" ></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" ></script>
<script>
$(function(){
	$("#search").keydown(function(key){
		if(key.keyCode == 13) {
			$("#searchForm").submit();								
		}
	});
});
</script>
<script>	// 페이지 새로고침하기
		if(self.name != 'reload') {
			self.name = 'reload';
			self.location.reload(true);
		} else self.name = '';
</script>
</html>