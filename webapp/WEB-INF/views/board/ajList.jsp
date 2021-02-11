<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>


	<html>
	
	
	<head>
	
		<meta charset="UTF-8">
	
		<title>ajaxBoardList</title>
	
		<link href="${pageContext.request.contextPath }/assets/css/mysite.css" rel="stylesheet" type="text/css">			
		<link href="${pageContext.request.contextPath }/assets/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css">			
		<link href="${pageContext.request.contextPath }/assets/css/board.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.12.4.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/assets/bootstrap/js/bootstrap.js"></script>
		
	</head>
	
	
	<body>
	

	<div id="wrap">

		<!-- header and navi -->

		<c:import url="/WEB-INF/views/include/header.jsp"></c:import>
	
		<!-- boardAside -->
		
		<c:import url="/WEB-INF/views/include/asideBoard.jsp"></c:import>




		<!-- content -->

		<div id="content">

			<div id="content-head">

				<h3>게시판</h3>

			<div id="location">

				<ul>
					<li>홈</li>
					<li>게시판</li>
					<li class="last">일반게시판</li>
				</ul>

			</div>

				<div class="clear"></div>
			</div>
			<!-- //content-head -->
	
			  
	<div id="board">

		<div id="list">

			<form action="${pageContext.request.contextPath }/board/search" method="post">
				
				<input type="hidden" name="page" value="1">

				<div class="form-group text-right">
					<input type="text" name="keyword">
					<button type="submit" id=btn_search>검색</button>
				</div>

			</form>


			<table id="boardTable">

				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>글쓴이</th>
						<th>조회수</th>
						<th>작성일</th>
						<th>관리</th>
					</tr>
				</thead>

			</table>
		
		
			
			<div id="paging">

				<ul>
					<!-- ◀◀첫 페이지 -->
					<li><a href="${pageContext.request.contextPath }/board/list?page=1">◀◀</a></li>


					<!--◀ 이전 페이지  -->
					
					<c:choose>
					
						<c:when test="${param.page <= 1}">

							<li><a href="${pageContext.request.contextPath }/board/list?page=1">◀</a></li>

						</c:when>

						<c:otherwise>

							<li><a href="${pageContext.request.contextPath }/board/list?page=${param.page -1}">◀</a></li>

						</c:otherwise>
						
					</c:choose>

					<!--◀ 이전 페이지  -->

					
					<!-- <<본 페이지>> -->
					
					
					<!-- active 기능 구현 -->
					
				<c:forEach var="page" begin="${pageVo.startPage }" end="${pageVo.endPage }">

					<c:choose>
						<c:when test="${param.page eq page }">
							<li class="active">
								<a href="${pageContext.request.contextPath }/board/list?page=${page }">${page}</a>
							</li>
						</c:when>

						<c:otherwise>
							<li>
								<a href="${pageContext.request.contextPath }/board/list?page=${page }">${page}</a>
							</li>
						</c:otherwise>
					</c:choose>
						
				
				</c:forEach>

			
					<!-- <<본 페이지>> -->

					<!--▶ 다음 페이지 -->
												
					<c:choose>
					
						<c:when test="${param.page >= pageVo.lastPage}">

							<li><a href="${pageContext.request.contextPath }/board/list?page=${pageVo.lastPage}">▶</a></li>

						</c:when>

						<c:otherwise>

							<li><a href="${pageContext.request.contextPath }/board/list?page=${param.page +1}">▶</a></li>

						</c:otherwise>
						
					</c:choose>
					
					<!--▶ 다음 페이지 -->

				<!-- 마지막 페이지 -->
				
				<li><a href="${pageContext.request.contextPath }/board/list?page=${pageVo.lastPage}">▶▶</a></li>
				
				<!-- 마지막 페이지 -->

				</ul>


				<div class="clear"></div>
				
			</div>


			<!-- 로그인시 글쓰기 가능 기능 -->

			<c:if test="${authUser != null }">
				<a id="btn_write" href="${pageContext.request.contextPath }/board/writeForm">글쓰기</a>
			</c:if>

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
	
	<!-- Modal -->
	
	<div class="modal fade" id="delModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h3 class="modal-title">게시글을 삭제하시겠습니까?</h3>
	      </div>
	      
	      <div class="modal-body">
	        <h4>비밀번호를 입력해주세요</h4><br>
	        
	        <input type="password" id="boardPw"> 
	        <input type="hidden" id="modalNo">
	      </div>
	      
	      <div class="modal-footer">
	      
	      <button type="button" class="btn btn-primary" id="delete">삭제</button>
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>  
	      </div>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	
	<!-- Modal -->
	
	</body>
	
	<script type="text/javascript">
		
		$("document").ready(function(){
			console.log("ready");
			
			fetchList();
								
		});
		
		
		$("#boardTable").on("click", "a", function(){
			//a링크의 본기능(default) 기능 막아놓기
			event.preventDefault();
			//modal 실행
			$("#delModal").modal();
			//modal에서 비밀번호 입력시 비밀번호와 삭제하고자 하는 게시글의 no를 같이 넘기기 위한 process
			let no = $(this).data("no");
			//modal에 hidden 속성으로 삭제하고자 하는 게시글의 게시글 번호 담아주기
			$("#modalNo").val(no);
			
			//
				$("#delete").on("click", function(){
					
						
					let BoardVo = {
					
						no: $("#modalNo").val(),
						pw: $("#boardPw").val()
					}
					
					
					$.ajax({
				
						url: "${pageContext.request.contextPath}/api/board/delete",
						
						type: "get",
						
						//contentType: "application/json",
						
						data : BoardVo,
							
						dataType: "json",	
						
						success: function(result){
							
							console.log(result);
						},
						
						error: function(){
							
							console.log("실패");
						}
						
						
					});
								
				});
				
			
		});
		
		
		
		
		
		
	function fetchList(){
			
			let page = {
					page: 1
			};
			
			$.ajax({
				
				url: "${pageContext.request.contextPath}/api/board/list",
				 
				//http 전송방식
				//GET’ 메소드 요청의 경우에는 HTTP Body에 요청이 전달되는 것이 아니라,
				//URL의 파라미터로 전달
				type: "post",
				
				//서버로 전송할 데이터 타입
				//contentType: "application/json",
				
				//서버로부터 받을 데이터 타입
				dataType: "json",
				
				//서버로 전송할 데이터
				data: page,
				
				success: function(boList){
					
					for(var i=0; i<boList.length; i++){
						render(boList[i]);
						
					}
				},
				
				error: function(){
					console.log("실패");
				}
		
				
			});
						
		};
	
	
	
	
	
	
	
	
	
	function render(BoardVo){
			
		let html = "<tbody id='t-"+BoardVo.no+"'>";
			html +=		"<tr>";
			html +="		<td>"+BoardVo.no+"</td>";
			html +="		<td class='text-left'>"+BoardVo.title+"</td>";
			html +="		<td>"+BoardVo.name+"</td>";
			html +="		<td>"+BoardVo.hit+"</td>";
			html +="		<td>"+BoardVo.date+"</td>";
			html +="		<td><a href='' data-no='"+BoardVo.no+"'>삭제</a></td>";
			html +="	</tr>";
			html +="</tbody>";
			
			$("#boardTable").append(html);
			
			
		}
		

		/*
		<tbody>
		
		<tr>
			<td>1</td>
						
			<c:choose>
			
				<c:when test="${boVo.depth > 0 }">
					<td class="text-left"><a href="${pageContext.request.contextPath }/board/read?no=${boVo.no}"><pre>${boVo.title }(${boVo.groupNo}번댓글)</pre></a></td>
				</c:when>
				
				<c:otherwise>
					<td class="text-left"><a href="${pageContext.request.contextPath }/board/read?no=${boVo.no}"><pre>${boVo.title }</pre></a></td>
				</c:otherwise>
			
			</c:choose>
			
			<td>강용수</td>
			<td>조회수:1</td>
			<td>날짜</td>

			<td>
				<a href="${pageContext.request.contextPath }/board/delete?no=${boVo.no}">[삭제]</a>

				<a href="${pageContext.request.contextPath }/board/writeForm?groupNo=${boVo.groupNo}&orderNo=${boVo.orderNo}&depth=${boVo.depth}&type=reply">[댓글달기]</a>
							
			</td>

		</tr>
	
	</tbody>
	*/
	
	
	
	
	
	</script>
	
	
	

	
	
	
</html>