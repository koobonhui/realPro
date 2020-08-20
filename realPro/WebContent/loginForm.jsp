<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Review Me : 로그인</title>
    <link rel = "stylesheet" href = "css/login.css">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
</head>
<body>

<!-- header -->
<div id="header">
    <a href="index.do" title="리뷰미 회원가입 페이지 보기"><img src="imgs/logo3.png" id="logo"></a>
</div>

<!-- wrapper -->
<div id = "wrapper">
<form action="login.do" method = "POST">
    <!-- content-->
    <div id = "content">
        <!-- ID -->
        <div>
            <h3 class = "join_title">
                <label for = "id">아이디</label>
            </h3>
            <span class = "box int_id">
                <input type = "text" id = "id" class = "int" maxlength = "20" name = "id" onkeypress="caps_lock(event)">
            </span>
        </div>
        
        <!-- PW -->
        <div>
            <h3 class = "join_title"><label for = "pswd1">비밀번호</label></h3>
            <span class = "box int_pass">
                <input type = "password" id = "pswd1" class = "int" maxlength = "20" name = "passwd">
            </span>
        </div>
        
        <!-- Login BTN-->
        <div class = "btn_area">
            <button type = "submit" id="btnJoin">
                <span>로그인</span>
            </button>            
        </div>
        
        <hr>
        
        <div class = "join_area">
        	<span><a href = "joinForm.do">회원가입</a></span>
        </div>
    </div> 
</form>
    <!-- content-->
</div> 
</body>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js" ></script>
	
	<!-- 중복 로그인 방지 -->
	<script>
		$(function(){
			<%if(session.getAttribute("id") != null){ %>
				alert("<%=session.getAttribute("id")%>님 께서는 이미 로그인 중 입니다.");
				history.back();
			<%} %>
		})
	</script>
</html>