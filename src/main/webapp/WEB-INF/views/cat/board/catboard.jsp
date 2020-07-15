<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
    
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="resources/css/cat/board/Catboard.css?ver=<%=System.currentTimeMillis()%>">
<script src="resources/script/jquery-3.2.1.min.js"></script>
<meta charset="UTF-8">
<title>고양이 게시판</title>
</head>
<body>
	<img id="boardimg" onclick="location.href='catmain'" src="resources/image/logoe.png" width=15%>
	<div id=catboard_menu>
		<button onclick="location.href='catboardinsertf'">글쓰기</button>
	</div>
	<div id="table">
		<div class="row" id="rowtitle">
			<span class="cell col1">번호</span>
			<span class="cell col2">작성자</span>
			<span class="cell col3">제목</span>
			<span class="cell col4">작성일</span>
			<span class="cell col5">조회</span>
			<span class="cell col6">댓글</span>
		</div>
		<c:if test="${dnc != '[]'}">
			<c:forEach var="bb" items="${dnc}">
				<div class="row">
					<span class="cell col1">${bb.seq}</span>
					<span class="cell col2">${bb.id}</span>
					<span class="cell col3"><a href="catboardview?seq=${bb.seq}">${bb.title}</a></span>
					<span class="cell col4">${bb.regdate}</span>
					<span class="cell col5">${bb.cnt}</span>
					<span class="cell col6">${bb.comments}</span>
				</div>
			</c:forEach>	
		</c:if>
	</div>
	<c:if test="${dnc == '[]'}">
		<div id=testd>
			<span>등록된 글이 없습니다</span>
		</div>
	</c:if>
</body>
</html>