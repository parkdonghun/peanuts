<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>qnaForm</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<jsp:include page="../include/header.jsp" />
<div class="container" style="width: 60%; min-height: 740px;">
	<div class="row">
		<div class="col-sm-1"></div>
		<div class="col-sm-10">
			<h1>
				새 QnA 등록하기
				<a href="qnaList.do" class="btn btn-default btn-sm pull-right">이전 페이지로</a>
			</h1>
			<form method="post" action="addNewQna.do" class="well" id="qna-form">
				<div class="form-group">
					<label>제목</label>
					<input type="text" class="form-control" name="title" />
				</div>
				<div class="form-group">
					<label>내용</label>
					<span class="pull-right"><span>남은 글자수 | </span><span id="textRange">650</span></span>
					<textarea rows="10" name="contents" class="form-control" style="resize: none;"></textarea>
				</div>
				<div class="text-right">
		            <button class="btn btn-default btn-sm" id="submit-button">등록</button>
		            <input type="reset" value="취소" class="btn btn-sm btn-danger" />
		        </div>
			</form>
		</div>
	</div>
</div>
<jsp:include page="../include/footer.jsp" />
</body>
<script>
$(function() {
	$('textarea[name=contents]').keyup(function (){
        //메시지 내용길이
    	var content = $(this).val();
        //메시지 내용길이 카운트하기
		var counter = 650 - content.length
        if(counter <= 0) {
        	counter = 0;
        }
        if(counter == 0) {
        	$('#textRange').css('color', 'red');	
        }
		$('#textRange').text(counter);
    });
	
	$('#submit-button').click(function(e) {
		e.preventDefault();
		
		var title = $('input[name="title"]').val();
		var contents = $('textarea[name="contents"]').val();
		
		if (title == '') {
			alert('제목을 입력해 주세요');
			return false;
		}
		if (contents == null) {
			alert('내용을 입력해 주세요');
			return false;
		}
		
		$('#qna-form').submit();
	});
})
</script>
</html>