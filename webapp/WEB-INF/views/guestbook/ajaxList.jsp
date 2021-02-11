<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>



<!DOCTYPE html>


<html>

	<head>
	
		<meta charset="UTF-8">
		
		<title>AjaxGuestbook</title>
		
		<link href="${pageContext.request.contextPath }/assets/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css">
		<link href="${pageContext.request.contextPath }/assets/css/mysite.css" rel="stylesheet" type="text/css">
		<link href="${pageContext.request.contextPath }/assets/css/guestbook.css" rel="stylesheet" type="text/css">
		
		<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.12.4.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/assets/bootstrap/js/bootstrap.js"></script>
	
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
									<td><input id="input-pass" type="password" name="pw"></td>
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
			
			
			
					<div id="guestList"></div>

					
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
	
	<!-- 모달창 영역 -->
	
	<div class="modal fade" id="delModal">
  		<div class="modal-dialog">
    		<div class="modal-content">
      			<div class="modal-header">
       				 <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        			 <h4 class="modal-title">방명록 삭제</h4>
      </div>
     
      <div class="modal-body">
      	
      	<label>비밀번호</label>
      	<input type="text" name="password" value="" id="guestPw">
        <input type="text" value="" id="modalNo">
             
      </div>
      
      <div class="modal-footer">
        
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="delBtn">삭제</button>
      
      </div>
      
   		    </div><!-- /.modal-content -->
 		 </div><!-- /.modal-dialog -->
 	</div><!-- /.modal -->
	
	<!-- 모달창 영역 -->
	
	
	</body>
	
	
	<script type="text/javascript">
		
		//방명록 리스트 로딩되면서 바로 출력
		$("document").ready(function(){
			
			fetchList();
						
		})
		
		
		$("#guestList").on("click", "a", function(){
			event.preventDefault();
			
			$("#modalNo").val($(this).data("no"));
			
			$("#delModal").modal();

			
			
			//방명록 삭제 method
			$("#delBtn").on("click",function(){
				

				let GuestVo = {
						no: $("#modalNo").val(),
						pw: $("#guestPw").val()
				};
				
				$.ajax({
					
					url: "${pageContext.request.contextPath}/api/guest/remove",
					type: "post",
					//contentType: "application/json",
					dataType: "json",
					
					data: GuestVo,
					
					success: function(count){
						
						if(count ==1){
							
							$("#delModal").modal("hide");
							$("#t-"+GuestVo.no).remove();
						}
						
						else{
							alert("비밀번호가 틀렸습니다");
							$("#guestPw").val("");
						}
						
					},
					
					error: function(){
						
						
					}
				
				})
			
				
			});
			
			
		});
		

		//방명록 게시글 쓰기 method
		$("#btn").on("click", function(){
			
			let GuestVo = {
				
				name: $("[name='name']").val(),
				pw: $("[name='pw']").val(),
				content: $("[name='content']").val()
				
				
			};
			
			
			$.ajax({
					
				url: "${pageContext.request.contextPath }/api/guest/write",
				
				//http 메소드 타입
				type: "post",
				
				//서버로 전송할 데이터 타입
				contentType: "application/json",
				
				//서버로 전송할 데이터
				data: JSON.stringify(GuestVo),
				
				//서버로부터 수신할 데이터
				dataType: "json",
				
				success: function(GuestVo){
					
					render(GuestVo, "asc");
					$("[name='name']").val("");
					$("[name='pw']").val("");
					$("[name='content']").val("");
				},
				
				error: function(XHR, status, error){
					console.log(status+ ":" + error);
		
				}	
				
				
				
			});
			
		});
	
		
		
		//방명록 html 그리기
		//data-? 툴은 소문자만 인식한다!!!!
		function render(GuestVo, order){
			
			var str="";
			str +="<table id='t-"+GuestVo.no+"' class='guestRead'>";
			str +="   <colgroup>";
			str +="   	  <col style='width: 10%;'>";
			str +="   	  <col style='width: 40%;'>";
			str +="   	  <col style='width: 40%;'>";
			str +="   	  <col style='width: 10%;'>";
			str +="   </colgroup>";
			
			str +="   	  		<tr>";
			str +="   	  			<td id='guestNo'>"+GuestVo.no+"</td>";
			str +="   	  			<td>"+GuestVo.name+"</td>";
			str +="   	  			<td>"+GuestVo.date+"</td>";
			str +="   	  			<td><a href='' data-no='"+GuestVo.no+"'>[삭제]</a></td>";
			str +="   	  		</tr>";
			
			str +="   	  		<tr>";
			str +="   	  			<td colspan=4 class='text-left'>"+GuestVo.content+"</td>";
			str +="   	  		</tr>";
			
			str +="</table>";
			
			if(order=="desc"){
				$("#guestList").append(str);
			}
			else{
				$("#guestList").prepend(str);
			}
			
		}
										
		
		//전체 리스트 출력
		function fetchList(){
			
			$.ajax({
				
				url: "${pageContext.request.contextPath}/api/guest/list",
				type: "post",
				//contentType: "application/json",
				dataType: "json",
				
						
				success: function(guList){
					
					for(var i=0; i< guList.length; i++){
						
						render(guList[i], "desc");
					}
				
					
				},
				
				error: function(XHR, status, error){
					console.log(status+ ":" + error);
				}
				
				
				
			});
						
		};
		
		
		
	</script>
	

</html>
