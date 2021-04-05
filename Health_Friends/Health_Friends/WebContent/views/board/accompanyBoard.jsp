<%@page import="com.login.dto.RegistDto"%>
<%@page
	import="org.apache.commons.collections.bag.SynchronizedSortedBag"%>
<%@page import="com.board.dto.BoardDto"%>
<%@page import="java.util.List"%>
<%@page import="com.common.Paging"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	response.setContentType("text/html; charset=UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="assets/css/commonBoard.css" rel="stylesheet" type="text/css" />

<title>동행 게시판</title>
	<%
		List<BoardDto> list = (List<BoardDto>) request.getAttribute("list");
	
		int pageNum = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
		int totalCount = Integer.parseInt(request.getAttribute("totalCount") + "");
		
		Paging paging = new Paging();
		paging.setPageNo(pageNum);
		paging.setPageSize(10);
		paging.setTotalCount(totalCount);
	%>
<style>

.board_list tbody tr td:nth-child(1) {
	text-align: left;
}

</style>

<script type="text/javascript">
	function loginChk() {
		alert("로그인 이후 사용가능합니다");
	}
</script>


<script>
$(document).ready(function(){
	
	var pageNum = <%=pageNum-1%>;
	
	if(pageNum >= 10){
		pageNum %= 10;
	}
	
	$(".pagination>a").eq(pageNum).addClass("on");
	
})
</script>
<style>
	.pagination {
		padding: 10px 0;
	}
	
	.pagination a {
		padding: 5px;
		margin: 5px;
		cursor: pointer;
	}
	
	.pagination a.on {
		font-weight: bold;
		font-size: 20px;
	}
</style>
</head>
<body>

	<%@include file="../../header.jsp" %>


	<div class="main01">
		<img
			src="https://www.imgacademy.co.kr/sites/default/files/inline-images/coaching.jpg"
			style="width: 100%; height: auto">
		<div class=text01 style="font-size: 40px; font-weight: bold">게시판
			입니다</div>
		<br>
		<div class=text02 style="font-size: 24px;">오늘도 즐거운 운동 즐기시길 바랍니다</div>
		<br>
	</div>

	<div class="main02" style="text-align: center">
		<div style="font-size: 40px; font-weight: bold">동행 게시판</div>
		<br>
		<p>우리 동네 운동 친구를 만나보세요.</p>
		<br> <a href="  " class="btn btn02">메인 페이지</a> <a
			href="./board.do?command=list  " class="btn btn01">동행 구해요</a> <a
			href="./review.do?command=list  " class="btn btn01">사진 후기</a> <a
			href="./notice.do?command=list " class="btn btn01">공지사항</a>
	</div>

	<div class="board">
		<div class="board_list_wrap">
			<table class="board_list">
				<%--게시판목록 --%>
				<caption>게시판 목록</caption>
				<thead>
					<tr>
						<th>제목</th>
						<th>성별</th>
						<th>작성자</th>
						<th>날짜</th>
					</tr>
				</thead>
				<tbody id="accompanyBoard_list">
					<c:forEach items="${list }" var="dto">

						<tr>
							<td><c:choose>
									<c:when test="${dto.postDelflag eq'Y' }">
										<c:out value="---삭제된 게시글입니다---"></c:out>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${empty Ldto.member_no}">
												<a href="javascript:loginChk();">${dto.postTitle}</a>
											</c:when>
											<c:otherwise>
												<a href="./board.do?command=select&postId=${dto.postId }">${dto.postTitle }</a>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose></td>
							<td>${Ldto.member_gender }</td>
							<td>${Ldto.member_id }</td>
							<td>${dto.postRegdate}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<c:choose>
				<c:when test="${empty Ldto.member_no}">
				<div class="bt_wrap">
						<a href="javascript:loginChk();" class="on" value="글작성">글작성</a>
				</div>
				</c:when>
				<c:otherwise>
					<div class="bt_wrap">
						<a href="./board.do?command=insert" class="on" value="글작성">글작성</a>
					</div>
				</c:otherwise>
			</c:choose>
<br>
<br>
			<%--  pagination --%>
			<div class="pagination board_list_warp02">
				<input type="button" onclick="pageMove(<%=paging.getFirstPageNo()%>)" value="◀" class="bt">
				<input type="button" onclick="pageMove(<%=paging.getPrevPageNo()%>)" value="◁" class="bt">
				<%
					for (int i = paging.getStartPageNo(); i <= paging.getEndPageNo(); i++) {
				%>
				<a onclick="pageMove(<%=i%>)"><%=i%></a>
				<%
					}
				%>
				<input type="button" onclick="pageMove(<%=paging.getNextPageNo()%>)" value="▷" class="bt">
				<input type="button" onclick="pageMove(<%=paging.getFinalPageNo()%>)" value="▶" class="bt">
			</div>
		
			<script>
					function pageMove(page){
						location.href='board.do?command=listPaging&page='+page
					}
			</script>

			<div class="board_list_warp02">

				<div class="paging">
					<a href="#" class="bt">첫 페이지</a>
					<a href="#" class="bt">이전 페이지</a>
					<a href="#" class="num on">1</a>
					<a href="#" class="num">2</a>
					<a href="#" class="num">3</a>
					<a href="#" class="bt">다음 페이지</a>
					<a href="#" class="bt">마지막 페이지</a>
				</div>

			</div>
		</div>
	</div>
	


	<%--
	<%@include file="footer.jsp" %>
 --%>

</body>
</html>















