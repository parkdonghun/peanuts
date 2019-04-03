<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>댓글페이지</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(function() {
	
	/* var replyModify = ('#reply-modify').val();
	var replyDel = ('#reply-del').val();
	*/
	
	// 댓글 수정 클릭시
	$("button[id^=reply-modify]").click(function() {
		
		var no = $(this).attr("id").replace('reply-modify-', '');
		var contents = $('#reply-content-' + no).text();
		$('#reply-form-modal textarea').val(contents);
		$('#reply-form-modal input').val(no);
		
		$("#reply-form-modal").modal("show");
	});
	
	// 댓글 수정완료
	$('#reply-modify-form').submit(function() {
		
		var no = $('#reply-form-modal input').val();
		var contents = $('#reply-form-modal textarea').val();
		
		$.ajax({
			url:"/reply/reModi.do",
			data:{repNo:no, contents:contents},
			dataType:"text",
			success:function(result) {
				if (result == 'success') {
					$('#reply-content-' + no).text(contents);
				}
			},
			complete:function() {
				$("#reply-form-modal").modal("hide");
			}
		});

		return false;
	});
	
	// 삭제 버튼
	$("button[id^=reply-del]").click(function() {
		var no = $(this).attr("id").replace('reply-del-', '');
		
		$.ajax({
			url:"/reply/redel.do",
			data: {repNo:no},
			dataType: "text",
			success: function(result) {
				if (result == 'success') {
					$('#reply-' + no).remove();
				}
			}
		})
		
	}); 
	
	// 신고버튼
	$("button[id^=reply-report-]").click(function() {
		var no = $(this).attr("id").replace('reply-report-', '');
		
		$.ajax({
			url:"/reply/reByNoReport.do",
			data: {repNo:no},
			dataType: "text",
			success: function(result) {
				if (result == 'success') {
					$('#reply-report-' + no).hide();
					$('#reply-content-' + no).empty().append('<span style="color:red">신고된 댓글입니다.</span>');
				}
			}
		})
		
		return false;
	});
	
})
</script>
<style type="text/css">
</style>
</head>
<body>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/top.jsp">
	<jsp:param name="top" value="reply"/>
	<jsp:param name="pno" value="${pno }"/>
</jsp:include>
<div class="container" style="width: 60%; min-height: 740px;">
	<div class="row" >
		<div class="col-sm-1"></div>
		<div class="col-sm-10" style="padding-top: 10px;">
			<div class="media" style="margin-left: 10px;">
				<div class="media-left">
					<img src="/resources/images/profile/${LOGIN_USER.profile }" class="media-object" height="80px" width="80px">
				</div>
				<div class="media-body">
					<h4 class="media-heading">
						<form action="/reply/addBoard.do" method="post" class="form-inline">
							<input type="hidden" name="planNo" value="${param.pno }" />
							<textarea class="form-control" style="resize: none; width: 90%; " rows="3" name="contents" placeholder="플래너에게 글을 입력해주세요"></textarea>
							<button class="btn" class="form-control" style="background-color: #e6e6e6; font-size: 12px;">확인</button>
						</form>
					</h4>
				</div>
			</div>
		</div>
	</div>
	<c:forEach var="board" items="${boardList }">
		<div class="row" style="border-top: 1px solid #ccc; padding-top: 10px;">
			<div class="col-sm-1"></div>
			<div class="col-sm-10">
				<div class="media" style="margin-left: 10px;">
					<div class="media-left">
						<img src="../resources/images/profile/${board.profile }" class="media-object" height="80px" width="80px">
					</div>
					<div class="media-body">
						<h4 class="media-heading">
							<span style="font-size: small;"><strong>${board.userId }</strong></span>
							<span style="font-size: smaller;"><small><i><fmt:formatDate value="${board.createDate }" pattern="yyyy-MM-dd" /></i></small></span> 
						</h4>
						<p>${board.contents }</p>
						<form action="addReply.do" method="post" style="margin-top: -4px;">
							<input type="hidden" name="planNo" value="${param.pno }">
							<input type="hidden" name="boardNo" value="${board.no }">
							<input type="hidden" name="category" value="${board.category }">
							<div class="form-group form-inline">
								<textarea class="form-control" style="resize: none; height: 28px; font-size: 10px; width: 700px;" name="contents" placeholder="댓글을 입력하세요" rows="1"></textarea>
								<button class="btn btn-default btn-xs" style="background-color: #e6e6e6; font-size: 12px;">등록</button>
							</div>
						</form>
						<c:forEach var="reply" items="${board.replyList }">
							<div class="row" style="margin-left: 10px; margin-top: 1px; margin-bottom: 1px;" id="reply-${reply.repNo }">
								<img width="30px;" height="30px;" src="../resources/images/profile/${reply.profile }">
								<span><strong>${reply.userId }</strong></span>
								<c:if test="${reply.status eq 'NORMAL' }">
									<span id="reply-content-${reply.repNo }">${reply.contents }</span>
									<span><fmt:formatDate value="${reply.createDate }" pattern="yy-MM-dd" /></span>
									<c:if test="${not empty LOGIN_USER && LOGIN_USER.id ne reply.userId }">
										<button id="reply-report-${reply.repNo }" class="btn btn-xs btn-info">신고</button>
									</c:if>
								</c:if>
								<c:if test="${reply.status eq 'REPORT' }">
									<span style="color: red">신고된 댓글입니다.</span>
									<span><fmt:formatDate value="${reply.createDate }" pattern="yy-MM-dd" /></span>
								</c:if>
								<c:if test="${not empty LOGIN_USER && LOGIN_USER.id eq reply.userId }">
									<button id="reply-modify-${reply.repNo }" class="btn btn-xs btn-warning">수정</button>
									<button id="reply-del-${reply.repNo }" class="btn btn-xs btn-danger">삭제</button>
								</c:if>
							</div>
							<div class="row">
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			
			
			
			
			<%-- 
			<div class="col-sm-2"> 
				<div class="form-group">											
					<img width="100px;" src="../resources/images/profile/${board.profile }">						
				</div>
			</div>
			<div class="col-sm-10">
				<div id="rep_userId">
					<span><strong>${board.userId }</strong></span>
					<fmt:formatDate value="${board.createDate }"/> 
				</div>
				<div id="rep_contents">
					<span>${board.contents }</span>
				</div> 
				<hr>
				<form class="form-horizontal" action="addReply.do" method="post">
					<input type="hidden" name="planNo" value="${param.pno }">
					<input type="hidden" name="boardNo" value="${board.no }">
					<input type="hidden" name="category" value="${board.category }">
						<div class="form-group">
  							<div class="col-sm-10">
    								<textarea class="form-control" style="resize: none; width: 670px;" name="contents" placeholder="내용을 입력하세요" rows="3"></textarea>
  							</div>
  							<div class="col-sm-2">
    								<button class="btn btn-default pull-right" style="background-color: #e6e6e6; font-size: 12px;" >등록</button>
  							</div>
							</div>
						</form>
				<c:forEach var="reply" items="${board.replyList }">
					<div class="row" style="margin-left: 10px;" id="reply-${reply.repNo }">
						<img width="30px;" src="../resources/images/profile/${reply.profile }">
						<span><strong>${reply.userId }</strong></span>
						<c:if test="${reply.status eq 'NORMAL' }">
							<span id="reply-content-${reply.repNo }">${reply.contents }</span>
							<c:if test="${not empty LOGIN_USER && LOGIN_USER.id ne reply.userId }">
								<button id="reply-report-${reply.repNo }" class="btn btn-xs btn-info">신고</button>
							</c:if>
						</c:if>
						<c:if test="${reply.status eq 'REPORT' }">
							<span style="color: red">신고된 댓글입니다.</span>
						</c:if>
						<span><fmt:formatDate value="${reply.createDate }" pattern="yy-MM-dd" /></span>
						<c:if test="${not empty LOGIN_USER && LOGIN_USER.id eq reply.userId }">
							<button id="reply-modify-${reply.repNo }" class="btn btn-xs btn-warning">수정</button>
							<button id="reply-del-${reply.repNo }" class="btn btn-xs btn-danger">삭제</button>
						</c:if>
					</div>
					<div class="row">
					</div>
				</c:forEach>
			</div> --%>
		</div>
	</c:forEach>
	
</div>
<div id="reply-form-modal" class="modal fade" role="dialog">
 	<div class="modal-dialog">
	   	<!-- Modal content-->
	   	<form action="modifyReply.do" method="post" id="reply-modify-form">
	    	<div class="modal-content">
		   		<div class="modal-header">
		      		<button type="button" class="close" data-dismiss="modal">&times;</button>
		     		<h4 class="modal-title">댓글 수정폼</h4>
		   		</div>
		   		<div class="modal-body">
		      		<div class="form-group">
		       			<input type="hidden" class="form-control" name="repNo"/>
		       			<textarea rows="3" class="form-control" name="contents"></textarea>
		      		</div>
		   		</div>
		  		<div class="modal-footer">
		       		<button type="submit" class="btn btn-default" id="btn-modify-reply">확인</button>
		       		<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
		   		</div>
		   	</div>
	    </form>
	</div>
</div>
<jsp:include page="../include/footer.jsp" />
</body>
</html>

