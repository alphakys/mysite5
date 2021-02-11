<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"><script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.12.4.js"></script>
<title>Insert title here</title>
</head>
<body>

</body>


	<script type="text/javascript">
		
	<script type="text/javascript">
	
	//DOM 객체가 생성되면(모든 data를 뿌려줄 준비를 시키고 실행)
		$("document").ready(function(){
			
			console.log("ready");
			
			$.ajax({
				
				url: "${pageContext.request.contextPath}/api/guest/list",
				type: "post",
				dataType: "json",
				
				success: function(guList){
					
					for(var i=0;i<guList.length; i++){
						
						render(guList[i]);
					}
				},
				
				error: function(XHR, status, error){
					console.log(status+":"+error);
					
				}
				
			})
		
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
	
	
	
	
	
	
	</script>





</html>