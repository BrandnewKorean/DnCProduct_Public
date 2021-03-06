<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	#viewtoggle{
		position: relative;
		display: inline-block;
		width: 50px;
		background-color: gray;
		border: none;
		vertical-align: middle;
		border: 1px solid;
		padding: 1px;
	}
	#viewtoggle > span{
		position: absolute;
		background-color: white;
		width: 20px;
		height: 20px;
		left: 3px;
		transition: .4s;
	}
	#viewtoggle > input:checked + span{
		transform: translateX(26px);
	}
	#viewtoggle > input{
		opacity: 0;
	}
</style>
<link rel="stylesheet" type="text/css" href="resources/css/cat/board/Catboard.css?ver=<%=System.currentTimeMillis()%>">
<meta charset="UTF-8">
<title>고양이 게시판</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
$(function(){
	var view = document.getElementById('view');
	
	$('#view').click(function(){
		if(view.checked){
			location.replace('catboard?code=image');
		}else{
			location.replace('catboard?code=list');
		}
	});
	
	$('#searchButton').on("click",function(){
		var code;
		if(view.checked) code = "image";
		else code = "list";
		
		self.location='catboard'
		+"${pageMaker.makeQuery(1)}"
		+"&searchType="
		+$("#searchType").val()
		+"&keyword="
		+$("#keyword").val()
		+"&code="
		+code;
	});
	
	$('.heart').click(function(){
		var seq = parseInt($(this).attr('id').substr($(this).attr('id').indexOf('_')+1));
		console.log(seq);
		
		$.ajax({
			url: 'likeCheck',
			data: {seq: seq},
			success: function(data){
				switch(data.code){
				case 0:
					alert('좋아요 취소');
					location.reload();
					break;
				case 1:
					alert('좋아요 취소 실패');
					location.reload();
					break;
				case 2:
					alert('좋아요 추가');
					location.reload();
					break;
				case 3:
					alert('좋아요 추가 실패');
					location.reload();
					break;
				case 4:
					alert('로그인 후 이용하세요');
					location.reload();
					break;
				default:
					alert('error');
					location.reload();
					break;
				}
			}
		});
	});
});
</script>
</head>
<body>
	<div class=container>
		<img id="boardimg" onclick="location.href='catmain'" src="resources/image/logoe.png" width=15%>
		<div id=catboard_menu>
			<label id=viewtoggle>
				<c:if test="${!view}">
					<input id=view type="checkbox">
				</c:if>
				<c:if test="${view}">
					<input id=view type="checkbox" checked="checked">
				</c:if>
				<span></span>
			</label>
			<button onclick="location.href='catboardinsertf'">글쓰기</button>
		</div>
		<c:if test="${!view}">
			<div id="table">
				<div class="row" id="rowtitle">
					<span class="cell col1">번호</span>
					<span class="cell col2">작성자</span>
					<span class="cell col3">제목</span>
					<span class="cell col4">작성일</span>
					<span class="cell col5">조회</span>
					<span class="cell col6">댓글</span>
					<span class="cell col7">좋아요</span>
				</div>
				<c:if test="${noticelist.size() > 0 }">
					<c:forEach var="notice" items="${noticelist}">
						<div class="row">
							<span class="cell col1">공지</span>
							<span class="cell col2">${notice.id}</span>
							<span class="cell col3"><a href="catboardnoticeview?seq=${notice.seq}">${notice.title}</a></span>
							<span class="cell col4">${notice.regdate}</span>
							<span class="cell col5">${notice.cnt}</span>
							<span class="cell col6"> </span>
						</div>
					</c:forEach>
				</c:if>
				<c:if test="${list != '[]'}">
					<c:forEach var="bb" items="${list}">
						<div class="row">
							<span class="cell col1">${bb.seq}</span>
							<span class="cell col2">${bb.id}</span>
							<span class="cell col3"><a href="catboardview?seq=${bb.seq}">${bb.title}</a></span>
							<span class="cell col4">${bb.regdate}</span>
							<span class="cell col5">${bb.cnt}</span>
							<span class="cell col6">${bb.comments}</span>
							<c:choose>
								<c:when test="${likeMap.get(bb.seq)}">
									<button class=heart id="heart_${bb.seq}" style="background-color: snow; outline:none; border: none;"><img src="/resources/image/heart1.png" width=50px height=50px></button>
								</c:when>
								<c:otherwise>
									<button class=heart id="heart_${bb.seq}" style="background-color: snow; outline:none; border: none;"><img src="/resources/image/heart_empty.png" width=50px height=50px></button>
								</c:otherwise>
							</c:choose>
							${bb.heart}
						</div>
					</c:forEach>
				</c:if>
			</div>
		
			<c:if test="${list != '[]'}">
				<div>
					<c:if test="${pageMaker.prev}">
						<a href="catboard${pageMaker.makeSearch(1)}&code=list">《</a>
						<a href="catboard${pageMaker.makeSearch(pageMaker.startPageNo-1)}&code=list">&nbsp;</a>
					</c:if>
					
					<c:forEach begin="${pageMaker.startPageNo}" end="${pageMaker.endPageNo}" var="i">
						<c:choose>
							<c:when test="${pageMaker.search.currentPage==i}">
								<font size="5" color="orange">${i}</font>&nbsp;
							</c:when>
							
							<c:otherwise>
								<a href="catboard${pageMaker.makeSearch(i)}&code=list">${i}</a>&nbsp;
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
					<c:if test="${pageMaker.next && pageMaker.endPageNo > 0}">
						<a href="catboard${pageMaker.makeSearch(pageMaker.endPageNo+1)}&code=list">&nbsp;&nbsp;</a>
						<a href="catboard${pageMaker.makeSearch(pageMaker.lastPageNo)}&code=list">》&nbsp;&nbsp;</a>
					</c:if>
				</div>
			</c:if>
		</c:if>
		<c:if test="${view}">
			<c:forEach var="bb" items="${list}">
				<div class=block>
					<div class=image>
						<a href="catboardview?seq=${bb.seq}">
							<c:choose>
								<c:when test="${uploadlistMap.get(bb.seq).size() > 0}">
									<img src="resources/catboardupload/${bb.seq}_${uploadlistMap.get(bb.seq).get(0).getUploadfile()}" width="100%" height="100%">
								</c:when>
								<c:otherwise>
									<img src="resources/catboardupload/noimage.png" width="100%" height="100%">
								</c:otherwise>
							</c:choose>
						</a>
					</div>
					<a href="catboardview?seq=${bb.seq}" style="text-decoration: none;">${bb.title}</a><br>
					조회수 : ${bb.cnt}&nbsp;댓글 : ${bb.comments}
				</div>
			</c:forEach>
			<div>
				<c:if test="${pageMaker.prev}">
					<a href="catboard${pageMaker.makeSearch(1)}&code=image">《</a>
					<a href="catboard${pageMaker.makeSearch(pageMaker.startPageNo-1)}&code=image">&nbsp;</a>
				</c:if>
				
				<c:forEach begin="${pageMaker.startPageNo}" end="${pageMaker.endPageNo}" var="i">
					<c:choose>
						<c:when test="${pageMaker.search.currentPage==i}">
							<font size="5" color="orange">${i}</font>&nbsp;
						</c:when>
						
						<c:otherwise>
							<a href="catboard${pageMaker.makeSearch(i)}&code=image">${i}</a>&nbsp;
						</c:otherwise>
					</c:choose>
				</c:forEach>
				
				<c:if test="${pageMaker.next && pageMaker.endPageNo > 0}">
					<a href="catboard${pageMaker.makeSearch(pageMaker.endPageNo+1)}&code=image">&nbsp;&nbsp;</a>
					<a href="catboard${pageMaker.makeSearch(pageMaker.lastPageNo)}&code=image">》&nbsp;&nbsp;</a>
				</c:if>
			</div>
		</c:if>
		<c:if test="${list == '[]'}">
			<div>
				<span>등록된 글이 없습니다</span>
			</div>
		</c:if>
		<br>
		<div id="searchBar">
			<select name="searchBar" id="searchType">
				<option value="null" <c:out value="${pageMaker.search.searchType==null ? 'selected':''}" />>-----</option>
				<option value="title" <c:out value="${pageMaker.search.searchType eq 'title' ? 'selected':'' }" />>제목</option>
				<option value="content" <c:out value="${pageMaker.search.searchType eq 'content' ? 'selected':''}" />>내용</option>
				<option value="id" <c:out value="${pageMaker.search.searchType eq 'id' ? 'selected':''}" />>작성자</option>
				<option value="titlecontent" <c:out value="${pageMaker.search.searchType eq 'titlecontent' ? 'selected':''}" />>제목+내용</option>
			</select>
			
			<input type="text" name="keyword" id="keyword" value="${pageMaker.search.keyword}">
			<button id="searchButton">검색</button>
		</div>
		<br>
	</div>
	<jsp:include page="../../Footer.jsp"></jsp:include>
</body>
</html>