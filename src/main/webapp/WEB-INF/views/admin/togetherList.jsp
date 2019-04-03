<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>admin :: togetherList</title>
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
				<strong>동행게시판 관리</strong>
				<img src="/resources/images/logo/peanutbw.png" width="40px">
				<img src="/resources/images/logo/peanutbw.png" width="40px">
				<img src="/resources/images/logo/peanutbw.png" width="40px">
				
				<span class="pull-right form-inline">
					<form action="searchBoards.do" method="post" id="search-form" class="form-inline">
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
						<th>제목</th>
						<th>작성일</th>
						<th>참가인수</th>
						<th></th>
					</tr>
				</thead>
				<tbody id="together-list">
					<c:forEach var="board" items="${boards }">
						<tr>
							<td>${board.userId }</td>
							<td>
								<a href="#" id="detail-${board.no }">
									${board.title }
									<c:if test="${board.isSameDate}">
										 <span style="background-color: #b22222;" class="badge"> New</span>
									</c:if>
								</a>
							</td>
							<td><fmt:formatDate value="${board.createDate }" pattern="yyyy-MM-dd" /></td>
							<td>${board.people }</td>
							<td>
								<a href="delTogetherByNo.do?boardNo=${board.no }&currentPageNo=${page.currentPageNo }&currentBlock=${page.currentBlock}" class="btn btn-xs btn-danger" style="color: #fff">삭제</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div id="pagination">
			<jsp:include page="../include/pagination.jsp">
				<jsp:param value="${page }" name="page"/>
				<jsp:param value="/admin/togetherList.do" name="url"/>
			</jsp:include>
		</div>
	</div>
</div>

<!-- modal -->
<div class="modal fade" id="detail-modal" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title"></h4>
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
	$('#together-list').on('click', 'a[id^="detail-"]', function(e) {
		e.preventDefault();
		var id = $(this).attr("id");
		var boardNo = id.replace('detail-', '');
		
		// boardNo로 해당 게시글의 detail page(modal) 띄우기
		$.ajax({
			type: "GET",
			url: "togetherDetail.do",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "json",
			async: false,
			data: {boardNo: parseInt(boardNo)},
			success: function(board) {
				
				var titleRows = '';
				var bodyRows = '<table class="table"><colgroup><col width="10%"><col width="*"></colgroup>';

				// 모달의 title
				titleRows += '<h5>';
				titleRows += board.title;
				titleRows += '</h5>';
				
				// 모달의 body
				bodyRows += '<p>';
				bodyRows += board.userId + ' | ' + board.stringCreateDate + ' | 조회수 ' + board.view;
				bodyRows += '</p>';
				bodyRows += '<hr/>';
				bodyRows += '<div style="overflow-y: scroll; height:250px;">';
				bodyRows += board.contensWithEnter;
				bodyRows += '</div>';
				bodyRows += '<hr/>';
				
				// 해당 글의 댓글 가져오기
				$.ajax({
					type: "GET",
					url: "getReplyByBoardNo.do",
					contentType: "application/x-www-form-urlencoded; charset=UTF-8",
					dataType: "json",
					async: false,
					data: {boardNo: boardNo},
					success: function(replys) {
						if(replys.length == 0) {
							bodyRows += '<tr><td colspan="6" class="text-center" style="font-size: 12px; padding-top: 20px;">댓글이 존재하지 않습니다.</td></tr>';
						} else {
							$.each(replys, function(index, reply) {
								bodyRows += "<tr id='rep-"+reply.repNo+"'>";
								bodyRows += "<th style='padding: 20px;'>";
								bodyRows += "<img src='/resources/images/profile/"+reply.profile+"' width=50px; height=50px;/>";
								bodyRows += "</th>";
								bodyRows += "<th>";
								bodyRows += "<span class='row' style='font-size: 12px;'>"+reply.userId+" <small style='color: #a6a6a6; margin-right: 10px;'>"+reply.createDateToString+"</small></span>";
								bodyRows += "<span class='row' id='repContents' style='font-size: 12px; display: block; font-weight: lighter; margin: 0px;'>"+reply.contents+"</span>";
								bodyRows += "<span class='row' id='orgContents' style='display: none;'><textarea class='form-control' rows='3' style='font-size: 12px; font-weight: lighter; width: 95%; margin-left: 10px;'>"+reply.contents+"</textarea></span>";
								bodyRows += "</th>";
								bodyRows += "</tr>";
							});	
							bodyRows += "</table>";
						}
					}
				});
				
				$('.modal-title').empty().append(titleRows);
				$('#insert-contents').empty().append(bodyRows);
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
			url: "searchBoards.do",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "json",
			async: false,
			data: {
				keyword: keyword,
				category: "TOGETHER"
			},
			success: function(items) {
				$('#pagination').empty();
				
				// 검색 결과가 존재하지 않으면 안내 문구 내보내기
				var cnt = items.length;
				if (cnt == 0) {
					$('#together-list').empty().append('<tr><td colspan="5" class="pull-center">검색 결과가 존재하지 않습니다</td></tr>');
				}
			
				var rows = '';
				if (cnt != 0) {
					$.each(items, function(index, item) {
						rows += '<tr>';
						rows += '<td>'+item.userId+'</td>';
						rows += '<td>';
						rows += '<a href="#" id="detail-'+item.no+'">';
						rows += item.title;
						if (item.isSameDate) {
							rows += '<span style="background-color: #b22222;" class="badge"> New</span>';
						}
						rows += '</a></td>';
						rows += '<td>'+item.stringCreateDate+'</td>';
						rows += '<td>'+item.people+'</td>';
						rows += '<td>';
						rows += '<a href="delTogetherByNo.do?No='+item.no+'&currentPageNo=${page.currentPageNo }&currentBlock=${page.currentBlock}" class="btn btn-xs btn-danger" style="color: #fff">삭제</a>';
						rows += '</td>';
						rows += '</tr>';
					});
					
					$('#together-list').empty().append(rows);
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