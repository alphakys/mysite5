<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>


	<html>
	
	
	<head>
	
		<meta charset="UTF-8">
	
		<title>BoardList</title>
	
		<link href="${pageContext.request.contextPath }/assets/css/mysite.css" rel="stylesheet" type="text/css">
			
		<link href="${pageContext.request.contextPath }/assets/css/board.css" rel="stylesheet" type="text/css">
		
		
	</head>
	
	
	<body>
	

	<div id="wrap">

		<!-- header and navi -->

		<c:import url="/WEB-INF/views/include/header.jsp"></c:import>


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

			<form action="${pageContext.request.contextPath }/board/list" method="get">
				
				<div class="form-group text-right">
					
					<input type="text" name="keyword">
					
					<button type="submit" id=btn_search>검색</button>
				</div>

			</form>


			<table>

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


				<c:forEach items="${paMap.boList}" var="boVo">
				
					<tbody>
					
						<tr>
							<td>${boVo.no }</td>
							
							
							<c:choose>
							
								<c:when test="${boVo.depth > 0 }">
									<td class="text-left"><a href="${pageContext.request.contextPath }/board/read?no=${boVo.no}"><pre>${boVo.title }(${boVo.groupNo}번댓글)</pre></a></td>
								</c:when>
								
								<c:otherwise>
									<td class="text-left"><a href="${pageContext.request.contextPath }/board/read?no=${boVo.no}"><pre>${boVo.title }</pre></a></td>
								</c:otherwise>
							
							</c:choose>
							
							<td>${boVo.name}</td>
							<td>${boVo.hit}</td>
							<td>${boVo.date}</td>

							<td>
								<c:if test="${authUser.no eq boVo.userNo}">

									<a href="${pageContext.request.contextPath }/board/delete?no=${boVo.no}">[삭제]</a>

								</c:if>
								
								<c:if test="${not empty authUser }">
									
									<a href="${pageContext.request.contextPath }/board/writeForm?groupNo=${boVo.groupNo}&orderNo=${boVo.orderNo}&depth=${boVo.depth}&type=reply">[댓글달기]</a>
								
								</c:if>
							</td>

						</tr>
					
					</tbody>
				
				</c:forEach>


			</table>
		
		
			
			<div id="paging">

				<ul>
					<!-- ◀◀첫 페이지 -->
					<li><a href="${pageContext.request.contextPath }/board/list?crtPage=1&keyword=${param.keyword}">◀◀</a></li>


					<!--◀ 이전 페이지  -->
					
					<c:choose>
					
						<c:when test="${param.crtPage <= 1}">

							<li><a href="${pageContext.request.contextPath }/board/list?crtPage=1&keyword=${param.keyword}">◀</a></li>

						</c:when>

						<c:otherwise>

							<li><a href="${pageContext.request.contextPath }/board/list?crtPage=${param.crtPage -1}&keyword=${param.keyword}">◀</a></li>

						</c:otherwise>
						
					</c:choose>

					<!--◀ 이전 페이지  -->

					
					<!-- <<본 페이지>> -->
					
					
					<!-- active 기능 구현 -->
					
				<c:forEach var="page" begin="${paMap.startPage }" end="${paMap.endPage }">

					<c:choose>
						<c:when test="${param.crtPage eq page }">
							<li class="active">
								<a href="${pageContext.request.contextPath }/board/list?crtPage=${page }&keyword=${param.keyword}">${page}</a>
							</li>
						</c:when>

						<c:otherwise>
							<li>
								<a href="${pageContext.request.contextPath }/board/list?crtPage=${page }&keyword=${param.keyword}">${page}</a>
							</li>
						</c:otherwise>
					</c:choose>
						
				
				</c:forEach>

			
					<!-- <<본 페이지>> -->

					<!--▶ 다음 페이지 -->
												
					<c:choose>
					
						<c:when test="${param.crtPage >= paMap.lastPage}">

							<li><a href="${pageContext.request.contextPath }/board/list?crtPage=${paMap.lastPage}">▶</a></li>

						</c:when>

						<c:otherwise>

							<li><a href="${pageContext.request.contextPath }/board/list?crtPage=${param.crtPage +1}">▶</a></li>

						</c:otherwise>
						
					</c:choose>
					
					<!--▶ 다음 페이지 -->

				<!-- 마지막 페이지 -->
				
				<li><a href="${pageContext.request.contextPath }/board/list?crtPage=${paMap.lastPage}">▶▶</a></li>
				
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

	</body>

</html>