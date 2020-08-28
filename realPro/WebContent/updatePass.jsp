<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String id = (String)request.getAttribute("reid");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review Me : 새 비밀번호</title>
<link rel = "stylesheet" href = "css/login.css">
</head>
<body>
<!-- header -->
<div id="header">
    <a href="index.do" title="리뷰미 회원가입 페이지 보기"><img src="imgs/logo3.png" id="logo"></a>
</div>

<!-- wrapper -->
<div id="wrapper">
<form id = "joinform" action="updatepass.do" method="post"> 
    <!-- content-->
    <div id="content">   
        <!-- PW1 -->
        <div>
            <h3 class="join_title"><label for="pass">새 비밀번호</label></h3>
            <span class="box int_pass">
                <input type="password" id="pass" class="int" maxlength="20" name = "pass">
                <span id="alertTxt"></span>
                <input type="hidden" id="id" name="id" value="<%=id %>">
                <img src="imgs/m_icon_pass.png" id="pswd1_img1" class="pswdImg">
            </span>
            <span class="error_next_box"></span>
        </div>
        
        <!-- PW2 -->
        <div>
            <h3 class="join_title"><label for="passT">새 비밀번호 재확인</label></h3>
            <span class="box int_pass_check">
                <input type="password" id="passT" class="int" maxlength="20" name ="passT">
                <span id="alertTxt"></span>
                <img src="imgs/m_icon_check_disable.png" id="pswd2_img1" class="pswdImg">
            </span>
            <span class="error_next_box"></span>
        </div>
        
        <!-- JOIN BTN-->
        <div class="btn_area">
            <button type = "submit" id = "btnJoin" onclick="return clearCheck();">
                <span>변경하기</span>
            </button>
        </div>    
    </div> 
    <!-- content-->
</form>
</div> 
<!-- wrapper -->
</body>
<script src="https://code.jquery.com/jquery-3.5.1.min.js" ></script>
<script>
var pass = document.querySelector('#pass');
var passT = document.querySelector('#passT');
var pwMsg = document.querySelector('#alertTxt');
var pwImg1 = document.querySelector('#pswd1_img1');
var pwImg2 = document.querySelector('#pswd2_img1');
var error = document.querySelectorAll('.error_next_box');

var check_pw = false;
var check_pw2 = false;
var clear = false;

pass.addEventListener("keyup", checkPw);
pass.addEventListener("keydown", checkPw);
pass.addEventListener("change", checkPw);
pass.addEventListener("focus", checkPw);
passT.addEventListener("keyup", comparePw);
passT.addEventListener("change", comparePw);
passT.addEventListener("focus", comparePw);

function checkPw() {
    if(pass.value === "") {
        error[0].innerHTML = "필수 정보입니다.";
        pwMsg.style.display = "none";
        pwMsg.style.color = "red";
        pwImg1.src = "imgs/m_icon_pass.png";
        error[0].style.display = "block";
        check_pw = false;
    } else {
        error[0].style.display = "none";
        pwMsg.innerHTML = "안전";
        pwMsg.style.display = "block";
        pwMsg.style.color = "#03c75a";
        pwImg1.src = "imgs/m_icon_safe.png";
        check_pw = true;
    }
    console.log("비밀번호 : ", check_pw);
}

function comparePw() {
    if(passT.value === pass.value && !(passT.value === "" && pass.value === "")) {
        pwImg2.src = "imgs/m_icon_check_enable.png";
        error[1].style.display = "none";
        check_pw2 = true;
    } else if(passT.value !== pass.value) {
        pwImg2.src = "imgs/m_icon_check_disable.png";
        error[1].innerHTML = "비밀번호가 일치하지 않습니다.";
        error[1].style.display = "block";
        check_pw2 = false;
    } 

    if(passT.value === "") {
        error[1].innerHTML = "필수 정보입니다.";
        error[1].style.display = "block";
        check_pw2 = false;
    }
    console.log("비밀번호 확인 : ", check_pw2);
		console.log("clear 확인 : ", clear);
}

function clearCheck() {
	clear = check_pw && check_pw2;
	if(clear === false) {
		alert('비밀번호 양식을 확인해 주세요.');
		console.log("clear 확인 : ", clear);
		return false;
	} else {
		console.log("clear 확인 : ", clear);
		return true;
	}
}
</script>
</html>