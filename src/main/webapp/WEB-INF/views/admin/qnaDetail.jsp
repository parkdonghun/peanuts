<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>admin :: qnaDetail</title>
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
<body style="overflow-x: hidden;">
<jsp:include page="../include/header.jsp" />
<div class="container" style="width: 60%; min-height: 740px;">
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
			<strong><a href="delQnaByNo.do?no=${board.no }">삭제</a></strong>
		</p>
		<table class="table">
			<tr><td></td></tr>
		</table>
	</div>
	
	<!-- 댓글 -->
	<input type="hidden" name="boardNo" value="${board.no }" />
	<div class="row" style="width: 75%; margin-right: auto; margin-left: auto;">
		<c:if test="${board.hasReply eq false }">
			<form method="post" action="answerQna.do" class="form-inline" id="reply-form">
				<textarea rows="2" name="contents" class="form-control" style="resize: none; width: 90%;"></textarea>
				<input type="hidden" name="boardNo" value="${board.no }" />
				<input type="hidden" name="currentPageNo" value="${currentPageNo }" />
				<input type="hidden" name="currentBlock" value="${currentBlock }" />
				<button class="btn btn-default" id="submit-btn">입력</button>
			</form>
		</c:if>
	</div>
	<div class="row" id="reply-list" style="width: 75%; margin-right: auto; margin-left: auto;"></div>
</div>
<jsp:include page="../include/footer.jsp" />
</body>
<script>
$(function() {
	var no = $('input[name=boardNo]').val();
	var $reply = $('#reply-list');
	
	$.ajax({
		type: "GET",
		url: "getReplyByBoardNo.do",
		dataType: "json",
		async: false,
		data: {boardNo:no },
		success: function(result) {
			
			var rows = '';
			var replyUserId = '';
			var replyProfile = '';
			
			$.each(result, function(index, reply) {
				replyUserId += reply.userId;
				
				$.ajax({
					type: "GET",
					url: "getUserByUserId.do",
					dataType: "json",
					async: false,
					data: {userId: replyUserId },
					success: function(user) {
						replyProfile += user.profile;
					}
				});
				
				rows += '<div class="media"><div class="media-left">';
				rows += '<img src="/resources/images/profile/'+replyProfile+'" class="media-object" height="45px" width="45px">';
				rows += '</div><div class="media-body"><h4 class="media-heading">';
				rows += replyUserId+' <small><i>'+reply.createDateToString+'</i></small></h4>'
				rows += '<p>'+reply.contensWithEnter;
				rows += '<span class="pull-right">';
				rows += '<a id="updateReply-'+reply.repNo+'" href="">수정</a>';
				rows += '&nbsp;|&nbsp;';
				rows += '<a href="delQnaReply.do?no='+reply.boardNo+'&repNo='+reply.repNo+'&currentPageNo=${currentPageNo }&currentBlock=${currentBlock}">삭제</a>';
				rows += '</span></p></div></div>';
				
				$reply.empty().append(rows);
			});
		}
	});
	
	$('a[id^="updateReply-"]').on('click', function(e) {
		e.preventDefault();
		
		// 바뀌는건 contents, repNo를 통해서 해당 댓글을 찾아서 바꾼다
		var id = $(this).attr('id');
		var replyNo = id.replace('updateReply-', '');
		
		var rows = '';
		$.ajax({
			type: "GET",
			url: "getReplyByRepNo.do",
			dataType: "json",
			async: false,
			data: {repNo: replyNo },
			success: function(reply) {
				rows += '<div class="media">';
				rows += '<form method="post" action="updateQnaReply.do" class="form-inline" id="reply-update-form">';
				rows += '<textarea id="update-reply-contents" rows="2" name="contents" class="form-control" style="resize: none; width: 90%;">';
				rows += reply.contents
				rows += '</textarea>';
				rows += '<input type="hidden" name="boardNo" value="'+reply.boardNo+'" />';
				rows += '<input type="hidden" name="repNo" value="'+reply.repNo+'" />';
				rows += '<input type="hidden" name="currentPageNo" value="${currentPageNo }" />';
				rows += '<input type="hidden" name="currentBlock" value="${currentBlock }" />';
				rows += '<button class="btn btn-default" id="update-submit-btn">수정</button>';
				rows += '</form>';
				rows += '</div>';
			}
		});

		$reply.empty().append(rows);
	});
	
	$('#submit-btn').click(function(e) {
		e.preventDefault();
		
		var contents = $('textarea[name="contents"]').val();
		
		if (contents == '') {
			alert('내용을 입력해 주세요');
			return false;
		}
		$('#reply-form').submit();
	});
	
	$('#reply-list').on('click', '#update-submit-btn', function(e) {
		e.preventDefault();
		
		var contents = $('#update-reply-contents').val();
		
		if (contents == '') {
			alert('내용을 입력해 주세요');
			return false;
		}
		$('#reply-update-form').submit();
	});
})
</script>
</html>