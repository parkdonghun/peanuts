<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>advertising :: adboardlist</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body style="overflow-x: hidden;">
<jsp:include page="../include/header.jsp" />
<div class="container" style="width: 60%; min-height: 740px;">
	<div class="row">
		<nav class="col-sm-3" id="myScrollspy">
			<!-- 왼쪽 메뉴바 -->
			<jsp:include page="../admin/menu.jsp" />
		</nav>
		<div class="col-sm-9">
			<h1>
				<strong>광고 신청 관리</strong>
				<img src="/resources/images/logo/peanutbw.png" width="40px">
				<img src="/resources/images/logo/peanutbw.png" width="40px">
				<img src="/resources/images/logo/peanutbw.png" width="40px">
				
				<span class="pull-right form-inline">
					<form action="/advertising/searchAdBoard.do" method="post" id="search-form" class="form-inline">
						<input type="text" class="form-control" name="keyword" />
						<button class="btn btn-xs btn-default form-control" id="search-btn">검색</button>
					</form>
				</span>
			</h1>
			<div class="form-group">
				<table class="table">
					<colgroup>
						<col width="*">
						<col width="15%">
						<col width="25%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
					</colgroup>
					<thead>
						<tr class="table">
							<th>제목</th>
							<th>담당자</th>
							<th>기간</th>
							<th>사이즈</th>
							<th>승인유무</th>
							<th></th>
						</tr>
					</thead>
					<tbody style="font-size: small;" id="adBoard-list">
						<c:forEach var="adBoard" items="${adBoards }">
							<tr>
								<td><a target="_blank" href="/resources/images/advertising/${adBoard.image }">${adBoard.title }</a></td>
								<td>${adBoard.manager }</td>
								<td>${adBoard.startDate } ~ ${adBoard.endDate }</td>
								<td style="font-weight: bolder;">
									<c:if test="${adBoard.type eq '1' }">1900X500</c:if>
									<c:if test="${adBoard.type eq '2' }">175X620</c:if>
									<c:if test="${adBoard.type eq '3' }">370X370</c:if>
								</td>
								<c:if test="${adBoard.status eq 'W' }">
									<td style="font-weight: bolder; color: #8b4513;">대기</td>
								</c:if>
								<c:if test="${adBoard.status eq 'P' }">
									<td style="font-weight: bolder; color: #32cd32;">승인</td>
								</c:if>
								<c:if test="${adBoard.status eq 'U' }">
									<td style="font-weight: bolder; color: #800000;">거절</td>
								</c:if>
								<td>
									<select id="status-opt-${adBoard.no }">
										<option value="W" ${adBoard.status eq 'W' ? 'selected=selected' : '' }>대기</option>
										<option value="P" ${adBoard.status eq 'P' ? 'selected=selected' : '' }>승인</option>
										<option value="U" ${adBoard.status eq 'U' ? 'selected=selected' : '' }>거절</option>
									</select>
								</td>
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
	$('#adBoard-list').on('change', 'select[id^=status-opt]', function() {
		var no = $(this).attr("id").replace('status-opt-', '');
		var status = $(this).val();
		
		location.href="updateAdStatus.do?no="+no+"&status=" + status;
	});
	
	$('#search-btn').click(function(e) {
		e.preventDefault();
		
		var keyword = $('input[name=keyword]').val();
		if (keyword == null) {
			return false;
		}
		
		$.ajax({
			type: "GET",
			url: "/advertising/searchAdBoard.do",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "json",
			async: false,
			data: {keyword: keyword},
			success: function(items) {
				var rows = '';
				$.each(items, function(index, item) {
					rows += '<tr>';
					rows += '<td><a target="_blank" href="/resources/images/advertising/'+item.image+'">'+item.title+'</a></td>';
					rows += '<td>'+item.manager+'</td>';
					rows += '<td>'+item.startDate+' ~ '+item.endDate+'</td>';
					rows += '<td style="font-weight: bolder;">';
					if (item.type == "1") {
						rows += '1900X500';
					}
					if (item.type == "2") {
						rows += '175X620';
					}
					if (item.type == "3") {
						rows += '370X370';
					}
					rows += '</td>'
					if (item.status == "W") {
						rows += '<td style="font-weight: bolder; color: #8b4513;">대기</td>';
					}
					if (item.status == "P") {
						rows += '<td style="font-weight: bolder; color: #32cd32;">승인</td>';
					}
					if (item.status == "U") {
						rows += '<td style="font-weight: bolder; color: #800000;">거절</td>';
					}
					rows += '<td>';
					rows += '<select id="status-opt-'+item.no+'">';
					if (item.status == "W") {
						rows += '<option value="W" selected="selected">대기</option>';
						rows += '<option value="P">승인</option>';
						rows += '<option value="U">거절</option>';
					}
					if (item.status == "P") {
						rows += '<option value="W">대기</option>';
						rows += '<option value="P" selected="selected">승인</option>';
						rows += '<option value="U">거절</option>';
					}
					if (item.status == "U") {
						rows += '<option value="W">대기</option>';
						rows += '<option value="P">승인</option>';
						rows += '<option value="U" selected="selected">거절</option>';
					}
					rows += '</select>';
					rows += '</td>';
					rows += '</tr>';
				});
				var cnt = items.length;
				if (cnt == 0) {
					$('tbody#adBoard-list').empty().append('<tr><td colspan="5" class="pull-center">검색 결과가 존재하지 않습니다</td></tr>');
				} else {
					$('tbody#adBoard-list').empty().append(rows);
				}
			}
		});
	});
})
</script>
</html>