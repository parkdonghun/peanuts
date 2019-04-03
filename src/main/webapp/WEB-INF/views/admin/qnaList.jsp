<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>admin :: qnaList</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
	a:link, a:visited {
		color: #000000;
	}
	a:hover {
		color: #ac7339;
	}
</style>
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
				<strong>QnA</strong>
				<img src="/resources/images/logo/peanutbw.png" width="40px">
				<img src="/resources/images/logo/peanutbw.png" width="40px">
				<img src="/resources/images/logo/peanutbw.png" width="40px">
				
				<span class="pull-right form-inline">
					<form action="searchBoards.do" method="post" id="search-form" class="form-inline">
						<input type="text" class="form-control" name="keyword" />
						<input type="hidden" name="category" value="QNA" />
						<button class="btn btn-xs btn-default form-control" id="search-btn">검색</button>
					</form>
				</span>
			</h1>
			
			<table class="table table-hover">
				<colgroup>
					<col width="10%">
					<col width="*">
					<col width="15%">
					<col width="15%">
					<col width="10%">
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>답변상태</th>
					</tr>
				</thead>
				<tbody style="font-size: small;" id="board-list">
					<c:forEach var="board" items="${boards }">
						<tr>
							<td>${board.no }</td>
							<td>
								<a href="qnaDetail.do?no=${board.no }&currentPageNo=${page.currentPageNo }&currentBlock=${page.currentBlock}">
									${board.title }
									<c:if test="${board.isSameDate}">
										 <span style="background-color: #b22222;" class="badge"> New</span>
									</c:if>
								</a>
							</td>
							<td>${board.userId }</td>
							<td><fmt:formatDate value="${board.createDate }" pattern="yyyy-MM-dd" /></td>
							<td>
							<c:if test="${board.hasReply eq true }">
								<button class="btn btn-xs btn-info">완료</button>
							</c:if>
							<c:if test="${board.hasReply eq false }">
								<button class="btn btn-xs btn-warning">대기</button>
							</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div id="pagination">
			<jsp:include page="../include/pagination.jsp">
				<jsp:param value="${page }" name="page"/>
				<jsp:param value="/admin/qnaList.do" name="url"/>
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
		var category = $('input[name=category]').val();
		if (keyword == null) {
			return false;
		}
		
		$.ajax({
			type: "GET",
			url: "searchBoards.do",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "json",
			async: false,
			data: {
				keyword: keyword,
				category: category
			},
			success: function(boards) {
				var rows = '';
				$.each(boards, function(index, board) {
					rows += '<tr>';
					rows += '<td>'+board.no+'</td>';
					rows += '<td>';
					rows += '<a href="qnaDetail.do?no='+board.no+'&currentPageNo=${page.currentPageNo }&currentBlock=${page.currentBlock}">';
					rows += board.title;
					if (board.isSameDate == true) {
						rows += '<span style="background-color: #b22222;" class="badge"> New</span>';
					}
					rows += '</a></td>';
					rows += '<td>'+board.userId+'</td>';
					rows += '<td>'+board.stringCreateDate+'</td>';
					rows += '<td>';
					if (board.hasReply == true) {
						rows += '<button class="btn btn-xs btn-info">완료</button>';
					} else if (board.hasReply == false) {
						rows += '<button class="btn btn-xs btn-warning">대기</button>';
					}
					rows += '</td>';
					rows += '</tr>';
				});
			
				var cnt = boards.length;
				if (cnt == 0) {
					$('#pagination').empty();
					$('#board-list').empty().append('<tr><td colspan="5" class="pull-center">검색 결과가 존재하지 않습니다</td></tr>');
					
				} else if (cnt != 0) {
					$('#pagination').empty();
					$('#board-list').empty().append(rows);
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