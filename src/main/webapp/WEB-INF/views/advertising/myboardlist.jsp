<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>advertising :: myboardlist</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
	a:link, a:visited {
		color: #000000;
	}
</style>
</head>
<body style="overflow-x: hidden;">
<jsp:include page="../include/header.jsp" />
<div class="container" style="width: 60%; min-height: 740px;">
	<h2>
		내 광고
		<a href="/advertising/addAdBoardForm.do" class="btn btn-sm btn-default pull-right">새 광고 등록</a>
	</h2>
	<br>
	<table class="table">
		<colgroup>
			<col width="*">
			<col width="15%">
			<col width="15%">
			<col width="15%">
			<col width="15%">
		</colgroup>
		<thead>
			<tr>
				<th>제목</th>
				<th>시작일</th>
				<th>종료일</th>
				<th>상태</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="adBoard" items="${adBoards }">
				<tr style="font-size: small;">
					<td><a target="_blank" href="/resources/images/advertising/${adBoard.image }">${adBoard.title }</a></td>
					<td>${adBoard.startDate }</td>
					<td>${adBoard.endDate }</td>
					<c:if test="${adBoard.status eq 'W' }">
						<td style="font-weight: bolder; color: #8b4513;">대기</td>
					</c:if>
					<c:if test="${adBoard.status eq 'P' }">
						<td style="font-weight: bolder; color: #32cd32;">승인</td>
					</c:if>
					<c:if test="${adBoard.status eq 'U' }">
						<td style="font-weight: bolder; color: #800000;">거절</td>
					</c:if>
					<td style="font-weight: bolder;">
						<c:if test="${adBoard.status eq 'W' }">
							<span class="buttons-${adBoard.no }">
								<a href="#" id="updateAdBoard-${adBoard.no }">수정</a>
								|
								<a href="#" id="delAdBoard-${adBoard.no }">삭제</a>
							</span>
						</c:if>
						<c:if test="${adBoard.status eq 'U' }">
							<span class="buttons-${adBoard.no }">
								<a href="#" id="delAdBoard-${adBoard.no }">삭제</a>
							</span>
						</c:if>
						<span style="display: none;" id="password-${adBoard.no }" class="form-inline">
							<input type="password" name="pwd" id="pwd-form-${adBoard.no }" class="form-control" style="height: 24px; width: 80px; margin-right: -5px;" placeholder="비밀번호" />
							<button class="btn btn-xs btn-default" id="pwd-c-btn-${adBoard.no }" style="margin-left: 5px;">취소</button>
						</span>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>		
</div>

<!-- modal -->
<div class="modal fade" id="update-modal" role="dialog">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title"></h4>
			</div>
			<div class="modal-body">
				<form action="/advertising/updateAdBoard.do" class="form-inline" method="post" enctype="multipart/form-data" id="file-upload-form">
					<input type="file" class="form-control" name="imageFile" style="width: 200px; padding: 3.5px;">
					<select name="type" class="form-control" style="width: 98px; height: 25px; font-size: 11px;">
						<option value=""> -- --</option>
						<option value="1"> 1900X500</option>
						<option value="2"> 175X620</option>
						<option value="3"> 370X370</option>
					</select>
					<button class="btn btn-default btn-xs" style="margin:2px;" id="update-btn">수정</button>
					<input type="hidden" name="no" id="update-adBoardNo">
				</form>
			</div>
		</div>
	</div>
</div>

<jsp:include page="../include/footer.jsp" />
</body>
<script>
$(function() {
	// 비밀번호 입력창 지우기
	$('button[id^="pwd-c-btn-"]').click(function() {
		$('span[class^="buttons-"]').css('display', '');
		$('span[id^="password-"]').css('display', 'none');
	});
	
	// 삭제하기
	$('a[id^="delAdBoard-"]').click(function() {
		// adBoardNo 찾아오기
		var id = $(this).attr('id');
		var adBoardNo = id.replace('delAdBoard-', '');
		
		// 삭제 누르면 비밀번호 입력창 띄우기
		$('span[class^="buttons-"]').css('display', '');
		$('span[id^="password-"]').css('display', 'none');
		$('.buttons-'+adBoardNo).css('display', 'none');
		$('#password-'+adBoardNo).css('display', '');
		
		$('#password-'+adBoardNo).keypress(function(e) {
			if (e.keyCode == 13) {
				// 엔터키 눌렀을 때 해당 글의 비밀번호와 입력한 비밀번호가 다르면 알람창 띄우기
				var writePwd = $('#pwd-form-'+adBoardNo).val();
				var originPwd;
				$.ajax({
					type: "GET",
					url: "/advertising/checkBoard.do",
					contentType: "application/x-www-form-urlencoded; charset=UTF-8",
					dataType: "json",
					async: false,
					data: {no: adBoardNo},
					success: function(items) {
						$.each(items, function(index, item) {
							originPwd = item.noPwd;
						})
					}
				});
				
				if (writePwd != originPwd) {
					alert('비밀번호가 일치하지 않습니다');
				} else {
					var isOk = confirm('해당 광고문의를 삭제하시겠습니까?');
					if (isOk == true) {
						location.href='/advertising/delAdBoard.do?no='+adBoardNo;
					}
				}
			}
		})
	});
	
	// 수정폼 모달 띄우기
	$('a[id^="updateAdBoard-"]').click(function(e) {
		// adBoardNo 찾아오기
		var id = $(this).attr('id');
		var adBoardNo = id.replace('updateAdBoard-', '');
		
		// 수정 누르면 비밀번호 입력창 띄우기
		$('span[class^="buttons-"]').css('display', '');
		$('span[id^="password-"]').css('display', 'none');
		$('.buttons-'+adBoardNo).css('display', 'none');
		$('#password-'+adBoardNo).css('display', '');
		
		$('#password-'+adBoardNo).keypress(function(e) {
			if (e.keyCode == 13) {
				// 엔터키 눌렀을 때 해당 글의 비밀번호와 입력한 비밀번호가 다르면 알람창 띄우기
				var writePwd = $('#pwd-form-'+adBoardNo).val();
				var originPwd;
				
				// 업데이트시 필요한 변수
				var image;
				var type;
				
				$.ajax({
					type: "GET",
					url: "/advertising/checkBoard.do",
					contentType: "application/x-www-form-urlencoded; charset=UTF-8",
					dataType: "json",
					async: false,
					data: {no: adBoardNo},
					success: function(items) {
						$.each(items, function(index, item) {
							originPwd = item.noPwd;
							image = item.image;
							type = item.type;
						})
					}
				});
				
				console.log(writePwd);
				console.log(originPwd);
				
				if (writePwd != originPwd) {
					alert('비밀번호가 일치하지 않습니다');
				} else {
					$('#update-adBoardNo').val(adBoardNo);
					$('#update-modal').modal();
				}
			}
		})
		
		// 수정 버튼을 눌렀을 때
		$('#file-upload-form').submit(function(e) {
			//e.preventDefault();
			var i = $('input[name=imageFile]').val();
			var t = $('select[name=type]').val();
			if (i == '') {
				return false;
			}
			if (t == '') {
				return false;
			}
			return true;
		});
	});
	
})
</script>
</html>