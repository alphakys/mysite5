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
	
						<form action="${pageContext.request.contextPath }/board" method="post">
							
							<input type="hidden" name="page" value="1">
	
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
	
	
							<c:forEach items="${boList}" var="boVo">
	
								<tbody>
	
									<tr>
										<td>${boVo.no }</td>
										<td class="text-left">
										<a href="${pageContext.request.contextPath }/board/read?no=${boVo.no}">${boVo.title }</a></td>
										<td>${boVo.name}</td>
										<td>${boVo.hit}</td>
										<td>${boVo.date}</td>
	
										<td><c:if test="${sessionScope.authUser.no eq boVo.userNo}">
	
												<a href="${pageContext.request.contextPath }/board/delete&no=${boVo.no}">[삭제]</a>
	
											</c:if></td>
	
									</tr>
	
								</tbody>
	
							</c:forEach>
	
	
						</table>
	
						<div id="paging">
	
							<ul>
	
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
								
								<c:choose>
	
									<c:when test="${totalPost%10 > 0}">
	
										<c:forEach var="page" begin="1" end="${(totalPost/10) +1}">
	
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
	
									</c:when>
	
									<c:otherwise>
	
										<c:forEach var="page" begin="1" end="${totalPost/10}">
	
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
	
									</c:otherwise>
	
								</c:choose>
	
	
								<!-- <<본 페이지>> -->


								<!--▶ 다음 페이지 -->
								
								<c:choose>
						
									<c:when test="${totalPost%10 > 0}">
										
										<c:choose>
											<c:when test="${param.page >= (totalPost/10)+1}">
	
												<li><a href="${pageContext.request.contextPath }/board/list?page=${(totalPost/10)+1}">▶</a></li>
	
											</c:when>
	
											<c:otherwise>
	
												<li><a href="${pageContext.request.contextPath }/board/list?page=${param.page +1}">▶</a></li>
	
											</c:otherwise>
										</c:choose>
														
									</c:when>
						
									<c:otherwise>
										<c:choose>
											<c:when test="${(totalPost/10) <= param.page}">
	
												<li><a href="${pageContext.request.contextPath }/board/list?page=${totalPost/10}">▶</a></li>
	
											</c:when>
	
											<c:otherwise>
	
												<li><a href="${pageContext.request.contextPath }/board/list?page=${param.page +1}">▶</a></li>
	
											</c:otherwise>
										</c:choose>
									</c:otherwise>
						
								</c:choose>
								<!--▶ 다음 페이지 -->
	
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