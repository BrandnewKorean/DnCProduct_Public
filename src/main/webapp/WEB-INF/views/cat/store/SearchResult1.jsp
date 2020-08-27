<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>food</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
$(function(){
	$('.products').click(function(){
		location.href = "products?productcode="+$(this).attr('id').substr(0,$(this).attr('id').indexOf('_'))+"&seq="+$(this).attr('id').substr($(this).attr('id').indexOf('_')+1);
	});
	
	$('.result1_page').click(function(){
		var i = parseInt($(this).text());
		var str = "${pageMaker1.makeSearch(1)}";
		console.log(str);
		
		$.ajax({
			url: "searchresult1",
			data:{
				currentPage: i,
				perPage: 10,
				keyword: "${search1.keyword}"
			},
			beforeSend: function(){
				$('#result1').append('<div style="position:absolute; left: 50%; top: 25%; width: 100%; height: 100%; z-index: 1;"><img src="resources/image/catloading.gif" style="position:relative; left: -50%; height: 50%;"></div>')
			},
			success: function(result){
				$('#result1').html(result);
			},
		});
	});
});
</script>
</head>
<body>
	${pageMaker1.getTotalRow()}개 중 ${list1.size()} 를 검색했습니다.
	<br>
	<c:choose>
		<c:when test='${list1.size() > 0}'>
			<c:forEach var="pl1" items='${list1}'>
				<div class="products" id="${pl1.productcode}_${pl1.seq}">
					<a class=group>분류 : ${pl1.group1} > ${pl1.group2}</a>
					<div class=product_innerimg>
						<img class=product_image src="resources/productimage/${productimageMap1.get(pl1.seq).get(0).filename}" width=200px height=200px>
					</div>
					${productMap1.get(pl1.seq).name}<br>
					<a class=brand>『${productMap1.get(pl1.seq).brand}』</a><br>
					<a class=price>${priceMap1.get(pl1.seq)}</a>원
				</div>
			</c:forEach>
		</c:when>
		<c:otherwise>결과가 없습니다</c:otherwise>
	</c:choose>
	<div class=blocks>
		<c:if test='${pageMaker1.prev}'>
			<a href='catstoreview${pageMaker1.makeSearch(1)}&group1=${search1.group1}'>First</a>
			<a href='catstoreview${pageMaker1.makeSearch(pageMaker1.startPageNo-1)}&group1=${search1.group1}&group2=${search1.group2}'>Prev&nbsp;</a>
		</c:if>
		<c:forEach begin='${pageMaker1.startPageNo}' end='${pageMaker1.endPageNo}' var="i">
			<c:choose>
				<c:when test='${pageMaker1.search.currentPage==i}'>
					<font size="5" color="orange">${i}</font>&nbsp;
				</c:when>
				<c:otherwise>
					<button class=result1_page>${i}</button>
<%-- 					<a href='searchresult${pageMaker.makeSearch(i)}'>${i}</a>&nbsp; --%>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test='${pageMaker1.next && pageMaker1.endPageNo > 0}'>
			<a href='catstoreview${pageMaker1.makeSearch(pageMaker1.endPageNo+1)}&group1=${search1.group1}&group2=${search1.group2}'>Next&nbsp;&nbsp;</a>
			<a href='catstoreview${pageMaker1.makeSearch(pageMaker1.lastPageNo)}&group1=${search1.group1}&group2=${search1.group2}'>End&nbsp;&nbsp;</a>
		</c:if>
	</div>
</body>
</html>