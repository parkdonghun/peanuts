<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>업체 관리게시판</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body style="overflow-x: hidden;">
<jsp:include page="../include/header.jsp" />
<div class="container" style="width: 60%;">
	<div class="row">
		<nav class="col-sm-3" id="myScrollspy">
			<!-- 왼쪽 메뉴바 -->
			<jsp:include page="../admin/menu.jsp" />
		</nav>
		<div class="col-sm-9" style="overflow-y: scroll; height:680px;">
			<!-- 오른쪽 유저 리스트 -->
			<h1>
				<strong>업체관리</strong>
				<img src="/resources/images/logo/peanutbw.png" width="40px">
				<img src="/resources/images/logo/peanutbw.png" width="40px">
				<img src="/resources/images/logo/peanutbw.png" width="40px">
				
				<span class="pull-right form-inline">
					<form action="/advertising/searchAdvertising.do" method="post" id="search-form" class="form-inline">
						<input type="text" class="form-control" name="keyword" />
						<button class="btn btn-xs btn-default form-control" id="search-btn">검색</button>
					</form>
				</span>
			</h1>
			
			<br>
			
			<div class="form-group">
				<table class="table table-hover">
					<colgroup>
						<col width='10%'>
						<col width='*'>
						<col width='15%'>
						<col width='15%'>
						<col width='15%'>
						<col width='20%'>
					</colgroup>
					<thead>
						<tr class="table table-striped">
							<th>업종</th>
							<th>상호명</th>
							<th>담당자</th>
							<th>이메일</th>
							<th>전화번호</th>
							<th>사업자번호</th>
						</tr>
					</thead>
					<tbody style="font-size: small;" id="ad-list">
						<c:forEach var="ad" items="${ads }">
							<tr>
								<td>${ad.category}</td>
								<td>${ad.name }</td>
								<td>${ad.manager }</td>
								<td>${ad.email }</td>
								<td>${ad.tel }</td>
								<td>${ad.serial }</td>
							</tr>
						</c:forEach>
					</tbody>			
				</table>
			</div>
		</div>
	</div>	
</div>
<jsp:include page="../include/footer.jsp" />
</body>
<script>
$(function() {
	$('#search-btn').click(function(e) {
		e.preventDefault();
		
		var keyword = $('input[name=keyword]').val();
		if (keyword == null) {
			return false;
		}
		
		$.ajax({
			type: "GET",
			url: "/advertising/searchAdvertising.do",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "json",
			async: false,
			data: {keyword: keyword},
			success: function(items) {
				var rows = '';
				$.each(items, function(index, item) {
					rows += '<tr>';
					rows += '<td>'+item.category+'</td>';
					rows += '<td>'+item.name+'</td>';
					rows += '<td>'+item.manager+'</td>';
					rows += '<td>'+item.email+'</td>';
					rows += '<td>'+item.tel+'</td>';
					rows += '<td>'+item.serial+'</td>';
					rows += '</tr>';
				});
				var cnt = items.length;
				if (cnt == 0) {
					$('tbody#ad-list').empty().append('<tr><td colspan="6" class="pull-center">검색 결과가 존재하지 않습니다</td></tr>');
				} else {
					$('tbody#ad-list').empty().append(rows);
				}
			}
		});
	});
})
</script>
</html>