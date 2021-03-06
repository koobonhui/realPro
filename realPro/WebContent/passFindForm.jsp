<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review Me : 비밀번호 찾기</title>
<link rel = "stylesheet" href = "css/login3.css">
</head>
<body>
<!-- header -->
<div id="header">
    <a href="index.do" title="리뷰미 회원가입 페이지 보기"><img src="imgs/logo3.png" id="logo"></a>
</div>

<!-- wrapper -->
<div id = "wrapper">
<form action="passupdate.do" method = "POST">
    <!-- content-->
    <div id = "content">
        <!-- ID -->
        <div>
            <h3 class = "join_title">
                <label for = "id">아이디</label>
            </h3>
            <span class = "box int_id" style = "width: 70%; float: left;">
                <input type = "text" id = "id" class = "int" maxlength = "20" name = "id" placeholder="아이디(이메일)을 입력하세요.">
            </span>
            
            <button type = "button" id="Cernum" onclick = "return check_join();" style = "width: 30%; height: 51px; float: right; line-height: 15px;">인증번호</button>
            
            <span class = "error_next_box"></span>
        </div>
        
        <!-- CerNumber -->
        <div>
            <h3 class = "join_title"><label for = "CerNumber">인증번호</label></h3>
            <span class = "box int_pass">
                <input type = "text" id = "CerNumber" class = "int" maxlength = "20" name = "CerNumber" placeholder="인증번호">
            </span>
            <span class = "error_next_box"></span>
        </div>
        
        <!-- BTN-->
        <div class = "btn_area">
            <button type = "submit" id="btnJoin" onclick="return gogo();">
                <span>확인</span>
            </button>            
        </div>
        
        <hr>
        
        <div class = "join_area">
        	<span><a href = "joinForm.do">회원가입</a></span>
        	<span>&nbsp;&nbsp;</span>
        	<span><a href = "find.do">비밀번호 찾기</a></span>
        </div>
    </div> 
</form>
    <!-- content-->
</div> 
</body>
<script src="https://code.jquery.com/jquery-3.5.1.min.js" ></script>
<script>
var id = document.querySelector('#id');
var btnJoin = document.querySelector('#btnJoin');
var Cernum = document.querySelector('#Cernum');
var re = "";
var hiddenbox = document.querySelector('.hiddenbox');
var cernumber = document.querySelector('#CerNumber');
var error = document.querySelectorAll('.error_next_box');

var check_id = false;
var check_pass = false;
var all_check = false;

id.addEventListener("blur", checkId);
Cernum.addEventListener("mouseover", checkId);
btnJoin.addEventListener("mouseover", checkpass);
cernumber.addEventListener("focus", checkpass);
cernumber.addEventListener("blur", checkpass);
cernumber.addEventListener("paste", checkpass);

function checkId() {
	if(id.value === "") {
        error[0].innerHTML = "아이디(이메일)을 입력하세요.";
        error[0].style.color = "red";
        error[0].style.display = "block";
        check_id = false;
    } else {
    	error[0].innerHTML = "";
    	overlap();
    }
}
// $('#Cernum').click(function(
// 		id.addEventListener("click", checkId);
// 		){});

function overlap() {
	$.ajax({
		type : "GET",
		url : "idCheck.do?id="+id.value,
		error : function() {
			alert('통신실패!! 관리자에게 문의해주세요.');
		},
		success : function(data) {
			console.log(data);
			if(data == 0) {
				error[0].innerHTML = "확인완료";
				error[0].style.color = "green";
	            error[0].style.display = "block";
				check_id = true;
				console.log("있을때 체크 : ", check_id);
			} else {
				error[0].innerHTML = "회원가입이 되지 않은 아이디 입니다.";
	            error[0].style.color = "red";
	            error[0].style.display = "block";
	            check_id = false;
	            console.log("없을때 체크 : ", check_id);
			}
		}
	});
}

function check_join() {
	var check_all = check_id;
	console.log("체크 : ", check_all);
	if(check_all === false) {
		alert("아이디를 확인해주세요.");
		return false;
	} else {
		$.ajax({
			type : "GET",
			url : "emailsend.do?id="+id.value,
			error : function(data) {
				alert('통신실패!! 관리자에게 문의해주세요.');
			},
			success : function(data) {
				alert('발송완료 인증번호 확인.');
				if(data.trim() != null) {
					re = data.trim();
			    } else {
			    	alert('관리자에게 문의');
			    }
			}
		});
		return true;
	}
}

function checkpass() {
	if(cernumber.value === "") {
		error[1].innerHTML = "인증번호를 입력해주세요.";
        error[1].style.color = "red";
        error[1].style.display = "block";
        check_pass = false;
        return false;
    } else if(cernumber.value === re) {
    	error[1].innerHTML = "맞음";
        error[1].style.color = "green";
        error[1].style.display = "block";
    	check_pass = true;
    	return true;
    } else {   
    	error[1].innerHTML = "틀림";
    	error[1].style.color = "red";
        error[1].style.display = "block";
    	check_pass = false;
    	return false;  	
    }
}

function gogo() {
	all_check = check_id && check_pass;
	if(all_check === false) {
		alert('이메일 및 인증번호를 확인해 주세요.');
		return false;
	} else {
		return true;
	}
}
</script>
</html>