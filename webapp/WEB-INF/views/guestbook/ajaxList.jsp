<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>



<!DOCTYPE html>


<html>

	<head>
	
		<meta charset="UTF-8">
		
		<title>AjaxGuestbook</title>
		
		<link href="${pageContext.request.contextPath }/assets/css/mysite.css" rel="stylesheet" type="text/css">
		<link href="${pageContext.request.contextPath }/assets/css/guestbook.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.12.4.js"></script>
	
	</head>

	<body>
	
	
		<div id="wrap">
	
			<!-- header and navi -->
			
			<c:import url="/WEB-INF/views/include/header.jsp"></c:import>
	
			
			<!-- //aside -->
			
			<c:import url="/WEB-INF/views/include/asideGuestbook.jsp"></c:import>
	
	
	
	
			<div id="content">
				
				<div id="content-head">
	            	
	            	<h3>일반방명록</h3>
	            	
	            	<div id="location">
	            		
	            		<ul>
	            			<li>홈</li>
	            			<li>방명록</li>
	            			<li class="last">일반방명록</li>
	            		
	            		</ul>
	            		
	            	</div>
	            	
	                <div class="clear"></div>
	            </div>
	            <!-- //content-head -->
	
				<div id="guestbook">
													
						<table id="guestAdd">
							
							<colgroup>
								<col style="width: 70px;">
								<col>
								<col style="width: 70px;">
								<col>
							</colgroup>
							
							<tbody>
								
								<tr>
									<th><label class="form-text" for="input-uname">이름</label></th>
									<td><input id="input-uname" type="text" name="name"></td>
									<th><label class="form-text" for="input-pass">패스워드</label></th>
									<td><input id="input-pass"type="password" name="pw"></td>
								</tr>
								
								<tr>
									<td colspan="4"><textarea name="content" cols="72" rows="5"></textarea></td>
								</tr>
								
								<tr class="button-area">
									<td colspan="4"><button type="submit" id="btn">등록</button></td>
								</tr>
								
							</tbody>
							
						</table>
						
					
					<!-- //guestWrite -->
			
					<div id="guestRead"></div>

					
					<!-- //guestRead -->
	
				</div>
				<!-- //guestbook -->
			</div>
			<!-- //content  -->
			<div class="clear"></div>
			
			
			
			<!-- //footer -->
			<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
	
	
	
		</div>
		<!-- //wrap -->
	
	</body>
	
	<script type="text/javascript">
		
	//DOM 객체가 생성되면(모든 data를 뿌려줄 준비를 시키고 실행)
		$("document").ready(function(){
			
			console.log("ready");
			
			$.ajax({
				
				url: "${pageContext.request.contextPath}/api/guest/list",
				type: "post",
				//contentType: "application/json",
				dataType: "json",
				
						
				success: function(guList){
					
					for(var i=0; i< guList.length; i++){
						
						render(guList[i]);
					}
				
					
				},
				
				error: function(XHR, status, error){
					console.log(status+ ":" + error);
				}
				
				
				
			});		
		});   
			
			
	
		
		$("#btn").on("click", function(){
			
			let name = $("[name='name']").val();
			let password = $("[name='pw']").val();
			let content = $("[name='content']").val();
			
			$.ajax({
			
				url: "${pageContext.request.contextPath}/api/guest/write",
				type: "post",
				//contentType: "application/json",
											
				data: {name: name, pw: password, content: content},
				dataType: "json",
				
						
				success: function(GuestVo){
										
					render(GuestVo);
				},
				
				error: function(XHR, status, error){
					console.log(status+ ":" + error);
				}
								
				
			});		
		});   
			
	function render(GuestVo){
		
		var str="";
		str +="<table class='guestRead'>";
		str +="   <colgroup>";
		str +="   	  <col style='width: 10%;'>";
		str +="   	  <col style='width: 40%;'>";
		str +="   	  <col style='width: 40%;'>";
		str +="   	  <col style='width: 10%;'>";
		str +="   </colgroup>";
		
		str +="   	  		<tr>";
		str +="   	  			<td>"+GuestVo.no+"</td>";
		str +="   	  			<td>"+GuestVo.name+"</td>";
		str +="   	  			<td>"+GuestVo.date+"</td>";
		str +="   	  			<td><a href='${pageContext.request.contextPath }/guest/deleteForm?no='>[삭제]</a></td>";
		str +="   	  		</tr>";
		
		str +="   	  		<tr>";
		str +="   	  			<td colspan=4 class='text-left'>"+GuestVo.content+"</td>";
		str +="   	  		</tr>";
		
		str +="</table>";
		
		$("#guestRead").prepend(str);

	}

		/*
						<table class="guestRead">
							
							<colgroup>
								<col style="width: 10%;">
								<col style="width: 40%;">
								<col style="width: 40%;">
								<col style="width: 10%;">
							</colgroup>
							
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td><a href="${pageContext.request.contextPath }/guest/deleteForm?no=">[삭제]</a></td>
							</tr>
							
							<tr>
								<td colspan=4 class="text-left"></td>
							</tr>
							
						</table>
		
		*/
		
	
	</script>
	

</html>
