<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>qnaDetail</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
	button {
		margin: 3px;
	}
	a:link, a:visited {
		color: #000000;
	}
	a:hover {
		color: #ac7339;
	}
</style>
</head>
<body>
<jsp:include page="../include/header.jsp" />
<div class="container" style="width: 60%; min-height: 740px;">
	<c:if test="${LOGIN_USER.id eq board.userId && board.status eq 'E'}">
		<div class="row" style="width: 75%; margin-right: auto; margin-left: auto;">
			<h3 style="color: #8b4513">
				${board.title }
				<a href="qnaList.do?currentPageNo=${currentPageNo }&currentBlock=${currentBlock}" class="btn btn-default btn-sm pull-right">이전 페이지로</a>
			</h3>
			
			<table class="table">
				<colgroup>
					<col width="*">
					<col width="17%">
				</colgroup>
				<tr>
					<td></td>
					<td style="font-size: small;" class="pull-right">
						<strong><fmt:formatDate value="${board.createDate }" pattern="yyyy-MM-dd" /></strong> | 
						<strong>view:${board.view }</strong>
					</td>
				</tr>
			</table>
		</div>
		<div class="row" style="width: 75%; margin-right: auto; margin-left: auto;">
			${board.contensWithEnter }
		</div>
		<div class="row text-right" style="width: 75%; margin-right: auto; margin-left: auto; font-size:x-small;">
			<p style="font-size: small;" class="pull-right">
				<strong><a href="delBoardByNo.do?no=${board.no }">삭제</a></strong> | <strong><a href="updateBoardForm.do?no=${board.no }">수정</a></strong>
			</p>
			<table class="table">
				<tr><td></td></tr>
			</table>
		</div>
		<img alt="" src="" height="" width="">
		<!-- 댓글 -->
		<input type="hidden" name="boardNo" value="${board.no }" />
		<div class="row" style="width: 75%; margin-right: auto; margin-left: auto;" id="reply-list"></div>
	</c:if>
</div>
<jsp:include page="../include/footer.jsp" />
</body>
<script>
$(function() {
	var no = $('input[name=boardNo]').val();
	var $reply = $('#reply-list');
	
	$.ajax({
		type: "GET",
		url: "/adQna/getReplyByBoardNo.do",
		dataType: "json",
		data: {boardNo:no },
		success: function(result) {
			
			var rows = '';
			var replyUserId = '';
			var replyProfile = '';
			
			$.each(result, function(index, reply) {
				replyUserId += reply.userId;
				$.ajax({
					type: "GET",
					url: "/adQna/getUserByUserId.do",
					dataType: "json",
					async: false,
					data: {userId:replyUserId },
					success: function(user) {
						replyProfile += user.profile;
					}
				});
				
				rows += '<div class="media"><div class="media-left">';
				rows += '<img src="/resources/images/profile/'+replyProfile+'" class="media-object" height="45px" width="45px">';
				rows += '</div>';
				rows += '<div class="media-body">';
				rows += '<h4 class="media-heading">';
				rows += replyUserId+' <small><i>'+reply.createDateToString+'</i></small></h4>'
				rows += '<p>'+reply.contensWithEnter+'</p>';
				rows += '</div></div>';
			});
			
			$reply.empty().append(rows);
		}
	});
})
</script>
</html>