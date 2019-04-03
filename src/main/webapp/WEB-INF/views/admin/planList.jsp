<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title></title>
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
			<jsp:include page="menu.jsp" />
		</nav>
		<div class="col-sm-9" id="contents">
			<!-- 오른쪽 리스트 -->
			<h1>
				<strong>PLANNER</strong>
				<img src="/resources/images/logo/peanutbw.png" width="40px">
				<img src="/resources/images/logo/peanutbw.png" width="40px">
				<img src="/resources/images/logo/peanutbw.png" width="40px">
				
				<span class="pull-right form-inline">
					<form action="searchPlan.do" method="post" id="search-form" class="form-inline">
						<input type="text" class="form-control" name="keyword" />
						<button class="btn btn-xs btn-default form-control" id="search-btn">검색</button>
					</form>
				</span>
			</h1>
			
			<table class="table table-hover">
				<colgroup>
					<col width="10%">
					<col width="*">
					<col width="15%">
					<col width="25%">
					<col width="10%">
					<col width="10%">
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>여행기간</th>
						<th>공개여부</th>
						<th></th>
					</tr>
				</thead>
				<tbody style="font-size: small;" id="plan-list">
					<c:forEach var="planner" items="${planners }">
						<tr>
							<td>${planner.no }</td>
							<td>
								<!-- 제목 누르면 바로 해당 플래너의 대시보드로 넘어가게 하기 -->
								<%-- <a href="qnaDetail.do?no=${planner.no }&currentPageNo=${page.currentPageNo }&currentBlock=${page.currentBlock}"> --%>
								<a href="/planner/dashboard.do?pno=${planner.no }">
									${planner.title }
								</a>
							</td>
							<td>${planner.userId }</td>
							<td>${planner.startDate } - ${planner.endDate }</td>
							<c:if test="${planner.open eq 'Y' }">
								<td style="color: #4682b4;"><strong>공개</strong></td>
							</c:if>
							<c:if test="${planner.open eq 'N' }">
								<td style="color: #808080;"><strong>비공개</strong></td>
							</c:if>
							<td><a style="color:#faebd7;" href="delPlanByNo.do?no=${planner.no }&currentPageNo=${page.currentPageNo }&currentBlock=${page.currentBlock}" class="btn btn-xs btn-danger" id="del-plan">삭제</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div id="pagination">
			<jsp:include page="../include/pagination.jsp">
				<jsp:param value="${page }" name="page"/>
				<jsp:param value="/admin/planList.do" name="url"/>
			</jsp:include>
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
			url: "searchPlan.do",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "json",
			async: false,
			data: {keyword: keyword},
			success: function(planners) {
				var rows = '';
				$.each(planners, function(index, planner) {
					rows += '<tr>';
					rows += '<td>'+planner.no+'</td>';
					rows += '<td>';
					//rows += '<a href="qnaDetail.do?no='+board.no+'&currentPageNo=${page.currentPageNo }&currentBlock=${page.currentBlock}">';
					rows += '<a href="/planner/dashboard.do?pno='+planner.no+'">';
					rows += planner.title;
					rows += '</a></td>';
					rows += '<td>'+planner.userId+'</td>';
					rows += '<td>'+planner.startDate+'-'+planner.endDate+'</td>';
					if (planner.open == "Y") {
						rows += '<td style="color: #4682b4;"><strong>공개</strong></td>';
					}
					if (planner.open == "N") {
						rows += '<td style="color: #808080;"><strong>비공개</strong></td>';
					}
					rows += '<td><a style="color:#faebd7;" href="delPlanByNo.do?no='+planner.no+'&currentPageNo=${page.currentPageNo }&currentBlock=${page.currentBlock}" class="btn btn-xs btn-danger" id="del-search-plan">삭제</a></td>';
					rows += '</tr>';
				});
			
				var cnt = planners.length;
				if (cnt == 0) {
					$('#pagination').empty();
					$('#plan-list').empty().append('<tr><td colspan="5" class="pull-center">검색 결과가 존재하지 않습니다</td></tr>');
					
				} else if (cnt != 0) {
					$('#pagination').empty();
					$('#plan-list').empty().append(rows);
					if (cnt > 10) {
						$('#contents').css('overflow-y', 'scroll').css('height', '680px');
					}
				}
				
			}
		});
	});
})
</script>
</html>