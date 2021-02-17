<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GalleryList</title>

<link href="${pageContext.request.contextPath }/assets/css/mysite.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/assets/css/gallery.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/assets/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.12.4.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/bootstrap/js/bootstrap.js"></script>

</head>


<body>
	<div id="wrap">

		<c:import url="/WEB-INF/views/include/header.jsp"></c:import>
		<!-- //header -->
		<!-- //nav -->

		<c:import url="/WEB-INF/views/include/galleryAside.jsp"></c:import>
		<!-- //aside -->


		<div id="content">

			<div id="content-head">
				<h3>갤러리</h3>
				<div id="location">
					<ul>
						<li>홈</li>
						<li>갤러리</li>
						<li class="last">갤러리</li>
					</ul>
				</div>
				<div class="clear"></div>
			</div>
			<!-- //content-head -->


			<div id="gallery">
				<div id="list">
					
					
					<c:if test="${authUser !=null }">
					
						<button id="btnImgUpload">이미지올리기</button>
						<div class="clear"></div>
					
					</c:if>
			
			
					<ul id="viewArea">
						
						<!-- 이미지반복영역 -->
						
						<c:forEach items="${gaList}" var="galVo">
						
							<li>
								<div class="view" data-no="${galVo.no }" 
												  data-content="${galVo.content}"
												  data-savename="${galVo.saveName }"
												  data-userno="${galVo.userNo }">
									<img class="imgItem" src="${pageContext.request.contextPath}/gallery/list/${galVo.saveName}">
									<div class="imgWriter">작성자: <strong>${galVo.userName}</strong></div>
									
								</div>
							</li>
						<!-- 이미지반복영역 -->
						
						</c:forEach>
						
					</ul>
				</div>
				<!-- //list -->
				
			</div>
			<!-- //board -->
			
		 </div>
		<!-- //content  -->
		
		<div class="clear"></div>

		<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
		<!-- //footer -->

	</div>
	<!-- //wrap -->

	
		
	<!-- 이미지등록 팝업(모달)창 -->
	<div class="modal fade" id="addModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">이미지등록</h4>
				</div>
				
				<form method="post" action="${pageContext.request.contextPath}/gallery/upload" enctype="multipart/form-data">
					<div class="modal-body">
						<div class="form-group">
							<label class="form-text">글작성</label>
							<input id="addModalContent" type="text" name="content" value="" >
						</div>
						<div class="form-group">
							<label class="form-text">이미지선택</label>
							<input id="file" type="file" name="mulFile" value="" >
						</div>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn" id="btnUpload">등록</button>
					</div>
				</form>
				
				
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	


	<!-- 이미지보기 팝업(모달)창 -->
	<div class="modal fade" id="viewModal">
		<div class="modal-dialog" >
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">이미지보기</h4>
				</div>
				<div class="modal-body">
					
					<div class="formgroup" >
						<img id="viewModelImg" src =""> <!-- ajax로 처리 : 이미지출력 위치-->
					</div>
					
					<div class="formgroup">
						<p id="viewModelContent"></p>
					</div>
					
				</div>
				
					<div class="modal-footer">
					
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					
					<c:if test="${authUser!= null}">
					</c:if>			
						<button type="button" class="btn btn-danger" id="btnDel">삭제</button>
						
					
				</div>
				
				
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->	


</body>

<script type="text/javascript">


	$("#btnImgUpload").on("click", function(){
		
		$("#addModal").modal();
			
	});
	
	/*
	//1번 방법
	$(".view").on("click", function(){
		
		$("#viewModal").modal();
		
		let no = $(this).data("no");
		
		
		$.ajax({
			
			url: "${pageContext.request.contextPath}/gallery/view",
			type: "get",
			
			data: {no: no},
			dataType: "json",
			
			success: function(galVo){
				
				
				$("#viewModelImg").attr("src", "${pageContext.request.contextPath}/gallery/list/"+galVo.saveName);
				$("#viewModelContent").text(galVo.content);
			},
			
			error: function(XHR, status, error){
				console.log(status+ ":" + error);

			}
			
		});
		
	});
		
	*/
	
	
	$(".view").on("click", function(){
		
		$("#viewModal").modal();
	
		let no = $(this).data("no");
		let content = $(this).data("content");
		let saveName = $(this).data("savename");
		let userNo = $(this).data("userno");
		
		$("#viewModelImg").attr("src", "${pageContext.request.contextPath}/gallery/list/"+saveName);
		$("#viewModelContent").text(content);
		
		
		let authUserNo = '${authUser.no}';
					
			
		if(authUserNo != userNo){
						
			$("#btnDel").hide();
		}
		else{
			$("#btnDel").show();
		}	
		
		
		$("#btnDel").on("click", function(){
		
			$.ajax({
				
				url: "${pageContext.request.contextPath}/gallery/delete",
				type: "get",
				
				data: {no: no},
				dataType: "json",
				
				success: function(result){
					
					alert("삭제했습니다");
					$("#viewModal").modal("hide");
					
				},
				
				
				error: function(XHR, status, error){
					console.log(status+ ":" + error);

				}
				
			});
		
		});
		
		
	});

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
</script>




</html>

