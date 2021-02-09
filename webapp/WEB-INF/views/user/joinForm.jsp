<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>



<!DOCTYPE html>
	
	<html>
	
	
	<head>
		<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.12.4.js"></script>
		<meta charset="UTF-8">
		
		<title>JoinForm</title>
		
		<link href="${pageContext.request.contextPath }/assets/css/mysite.css" rel="stylesheet" type="text/css">
		<link href="${pageContext.request.contextPath }/assets/css/user.css" rel="stylesheet" type="text/css">
		
		<!-- 
		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		 -->

		
		<script type="text/javascript">
		

		
		/*
		function checkNull(){
			
			if(!document.userInfo.id.value){
				alert("아이디를 입력하세요");
				return false;
			}
			if(!document.userInfo.pw.value){
				alert("패스워드를 입력하세요")
				return false;
			}
			if(!document.userInfo.gender.value){
				alert("성별을 체크해주세요");
				return false;
			}
			if(!document.userInfo.name.value){
				alert("이름을 입력해주세요");
				return false;
			}
			
			
		}
		*/
		</script>
		
		
	</head>
	
	<body>
		
		<div id="wrap">
			
			
			<!-- header and navi -->
			
			<c:import url="/WEB-INF/views/include/header.jsp"></c:import>
			
			<!-- //aside -->
			
			<c:import url="/WEB-INF/views/include/asideUser.jsp"></c:import>
			
			
			<div id="content">
				
				<div id="content-head">
				
	            	<h3>회원가입</h3>
	            	
	            	<div id="location">
	            	
	            		<ul>
	            			<li>홈</li>
	            			<li>회원</li>
	            			<li class="last">회원가입</li>
	            		</ul>
	            		
	            	</div>
	            	
	                <div class="clear"></div>
	                
	            </div>
	            <!-- //content-head -->
	
				<div id="user">
				
					
					<div id="joinForm">
					action="${pageContext.request.contextPath }/user/join" 
						<form id="joinfrm" method="post" name="userInfo" 
						onsubmit = "return checkAll();">
						
						<!-- 아이디 -->
						
							<div class="form-group">
								<label class="form-text" for="input-uid">아이디</label> 
								<input type="text" id="input-uid" name="id" value="" placeholder="아이디를 입력하세요">
								<button type="button" id="btnCheck" onclick="checkId()">중복체크</button>
								<p id="msg"></p>
							</div>
	
							<!-- 비밀번호 -->
							<div class="form-group">
								<label class="form-text" for="input-pass">패스워드</label> 
								<input type="password" id="input-pass" name="pw" value="" placeholder="비밀번호를 입력하세요"	>
							</div>
	
							<!-- 이름 -->
							<div class="form-group">
								<label class="form-text" for="input-name">이름</label> 
								<input type="text" id="input-name" name="name" value="" placeholder="이름을 입력하세요">
							</div>
	
							<!-- 성별 -->
							<div class="form-group">
								<span class="form-text">성별</span> 
								
								<label for="rdo-male">남</label> 
								<input type="radio" id="rdo-male" name="gender" value="male" > 
								
								<label for="rdo-female">여</label> 
								<input type="radio" id="rdo-female" name="gender" value="female" > 
	
							</div>
	
							<!-- 약관동의 -->
							<div class="form-group">
								<span class="form-text">약관동의</span> 
								
								<input type="checkbox" id="chk-agree" value="" name="">
								<label for="chk-agree">서비스 약관에 동의합니다.</label> 
							</div>
							
							<!-- 버튼영역 -->
			                <div class="button-area">
			                    <button type="submit" id="btn-submit">회원가입</button>
			                </div>
							
							
						</form>
						
					</div>
					<!-- //joinForm -->
				</div>
				<!-- //user -->
			</div>
			<!-- //content  -->
			<div class="clear"></div>
			
	
			
			<!-- //footer -->
			<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
	
	
		</div>
		<!-- //wrap -->
	
	</body>
	
	<script type="text/javascript">
		
		function checkAll(){
			
			let chkId = $("#input-uid").val();
			let chkPw = $("#input-pass").val();
			let chkName = $("#input-name").val();
			let chkGender = $("input[name='gender']:checked").val();
			let chkAgree = $("#chk-agree").is(":checked");
			
			
			let idPatt = /[^a-zA-Z0-9]/g;
			let pwPatt = /[a-zA-Z0-9]/g;
			let white = /[\s]/;
			let special = /[^A-Za-z0-9]{1}/g;
			
			if(!chkId){
				alert("아이디를 입력해주세요");
				return false;
			}
			
			if(idPatt.test(chkId)){
				
				alert("아이디는 영 소-대문자 숫자만 가능합니다");
				return false;
			}
												
			if(!chkPw){
				alert("패스워드를 입력해주세요");
				return false;
			}	
			
			if(chkPw.length <8){
				alert("패스워드는 8글자 이상 가능합니다");
				return false;
			}
			
			if(white.test(chkPw) || special.exec(chkPw)== null){
				
				alert("비밀번호는 영 소-대문자 하나 이상의 특수문자를 비밀번호에 넣어주세요");
				return false;
			}
			
			if(!chkName){
				alert("이름을 입력해주세요");
				return false;
			}	
			
			if(!chkGender){
				alert("성별을 체크해주세요");
				return false;
			}
			
			if(!chkAgree){
				alert("약관에 동의해주세요");
				return false;
			}
				
			
			
			return false;
		}
		
	

	
		function checkId(){
			let uid = $("#input-uid").val();
			
			let idPatt = /[^a-zA-Z0-9]/g;
			
			if(idPatt.test(uid)){
				alert("아이디는 영 소-대문자와 숫자만 가능합니다");
				return false;
			}
			
			
			
			
			$.ajax({
				
				url : "${pageContext.request.contextPath}/user/idCheck",
				type : "post",
				dataType : "text",
				
				
				data : { id: uid },
							
				success : function(result){
					
					if(result === "can"){
						alert("사용할 수 있는 아이디입니다");
						
					}
					else{
						alert("중복된 아이디입니다");
						
					}
				},
				
				error : function(XHR, status, error){
					console.log(status + ":" + error);
				}
				
			})
			
			
		}
	
		
	
	</script>
	
	
	
	
	
</html>