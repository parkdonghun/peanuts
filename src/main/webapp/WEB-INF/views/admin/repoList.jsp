<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>admin :: repoReply</title>
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
		<div class="col-sm-9">
			<!-- 오른쪽 신고댓글 리스트 -->
			<h1>
				<strong>신고 댓글 관리</strong>
				<img src="/resources/images/logo/peanutbw.png" width="40px">
				<img src="/resources/images/logo/peanutbw.png" width="40px">
				<img src="/resources/images/logo/peanutbw.png" width="40px">
				
				<span class="pull-right form-inline">
					<form action="searchRepo.do" method="post" id="search-form" class="form-inline">
						<input type="text" class="form-control" name="keyword" />
						<button class="btn btn-xs btn-default form-control" id="search-btn">검색</button>
					</form>
				</span>
			</h1>
			
			<table class="table table-hover" style="font-size: small;">
				<colgroup>
					<col width="15%">
					<col width="*">
					<col width="15%">
					<col width="15%">
					<col width="15%">
				</colgroup>
				<thead>
					<tr>
						<th>아이디</th>
						<th>내용</th>
						<th>게시판</th>
						<th>작성일</th>
						<th></th>
					</tr>
				</thead>
				<tbody id="repo-list">
					<c:forEach var="reply" items="${replys }">
						<tr>
							<td>${reply.userId }</td>
							<td>
								<a href="" id="detail-${reply.repNo }">
									<c:set var="contentsLength" value="${fn:length(reply.contents) }" />
									<c:choose>
										<c:when test="${contentsLength > 24 }">
											<c:set var="longContents" value="${reply.contents }" />
											<c:set var="contents" value="${fn:substring(longContents, 0, 24)  }" />
											${contents }...
										</c:when>
										<c:otherwise>${reply.contents }</c:otherwise>
									</c:choose>
								</a>
							</td>
							<td>${reply.categoryName }</td>
							<td>${reply.createDateToString }</td>
							<td>
								<a href="returnRepoByNo.do?repNo=${reply.repNo }&currentPageNo=${page.currentPageNo }&currentBlock=${page.currentBlock}" class="btn btn-xs btn-default">취소</a>
								<a href="delRepoByNo.do?repNo=${reply.repNo }&currentPageNo=${page.currentPageNo }&currentBlock=${page.currentBlock}" class="btn btn-xs btn-danger" style="color: #fff">접수</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div id="pagination">
			<jsp:include page="../include/pagination.jsp">
				<jsp:param value="${page }" name="page"/>
				<jsp:param value="/admin/repoList.do" name="url"/>
			</jsp:include>
		</div>
	</div>
</div>

<!-- modal -->
<div class="modal fade" id="detail-modal" role="dialog">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">신고댓글 전문</h4>
			</div>
			<div class="modal-body" id="insert-contents"></div>
		</div>
	</div>
</div>

<jsp:include page="../include/footer.jsp" />
</body>
<script>
$(function() {
	// 모달 띄우기
	$('#repo-list').on('click', 'a[id^="detail-"]', function(e) {
		e.preventDefault();
		var id = $(this).attr("id");
		var repNo = id.replace('detail-', '');
		
		$.ajax({
			type: "GET",
			url: "getRepoByRepNo.do",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "json",
			async: false,
			data: {repNo: parseInt(repNo)},
			success: function(reply) {
				var row = "<span style='font-size: 12px; display: block; font-weight: lighter; margin: 0px;'>"+reply.contents+"</span>";
				$('#insert-contents').empty().append(row);
			}
		});
		
		$('#detail-modal').modal();
	});
	
	// 검색기능
	$('#search-btn').click(function(e) {
		e.preventDefault();
		
		var keyword = $('input[name=keyword]').val();
		if (keyword == null) {
			return false;
		}
		
		$.ajax({
			type: "GET",
			url: "searchRepo.do",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "json",
			async: false,
			data: {keyword: keyword},
			success: function(items) {
				$('#pagination').empty();
				
				// 검색 결과가 존재하지 않으면 안내 문구 내보내기
				var cnt = items.length;
				if (cnt == 0) {
					$('#repo-list').empty().append('<tr><td colspan="5" class="pull-center">검색 결과가 존재하지 않습니다</td></tr>');
				}
			
				var rows = '';
				if (cnt != 0) {
					$.each(items, function(index, item) {
						rows += '<tr>';
						rows += '<td>'+item.userId+'</td>';
						rows += '<td>';
						rows += '<a href="#" id="detail-'+item.no+'">';
						if (item.contents.length < 24) {
							rows += item.contents;
						} else {
							var scontent = item.contents.substring(0, 24);
							rows += scontent;
						}
						rows += '</a></td>';
						rows += '<td>'+item.categoryName+'</td>';
						rows += '<td>'+item.createDateToString+'</td>';
						rows += '<td>';
						rows += '<a href="returnRepoByNo.do?repNo='+item.repNo+'&currentPageNo=${page.currentPageNo }&currentBlock=${page.currentBlock}" class="btn btn-xs btn-default">취소</a>';
						rows += '<a href="delRepoByNo.do?repNo='+item.repNo+'&currentPageNo=${page.currentPageNo }&currentBlock=${page.currentBlock}" class="btn btn-xs btn-danger" style="color: #fff">접수</a>';
						rows += '</td>';
						rows += '</tr>';
					});
					
					$('#repo-list').empty().append(rows);
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