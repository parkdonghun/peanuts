<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>advertising :: boardform</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(function() {
	// 시작일 선택하고 지정 개월 선택시 종료일 변경
	function date2str(x, y) {
	    var z = {
	        M: x.getMonth() + 1,
	        d: x.getDate(),
	        h: x.getHours(),
	        m: x.getMinutes(),
	        s: x.getSeconds()
	    };
	    y = y.replace(/(M+|d+|h+|m+|s+)/g, function(v) {
	        return ((v.length > 1 ? "0" : "") + eval('z.' + v.slice(-1))).slice(-2)
	    });

	    return y.replace(/(y+)/g, function(v) {
	        return x.getFullYear().toString().slice(-v.length)
	    });
	}
	
	
	function getEndDate(startDate, term) {
		var items = startDate.split("-");
		var year = parseInt(items[0]);
		var month = parseInt(items[1]) - 1;
		var day = parseInt(items[2]);
		
		var date = new Date(year, month, day);		
		date.setDate(date.getDate() + term);
		
		return date2str(date, 'yyyy-MM-dd');
		
	}
	
	$('#date-min').change(function() {
		var dateString = $('input[name="startDate"]').val();
		var period = $(':radio[name=term]:checked').val() * 30;
		var endDate = getEndDate(dateString, period);
		
		$('#endDate').val(endDate);
	});
	
	$(':radio[name=term]').change(function() {
		var dateString = $('input[name="startDate"]').val();
		var period = $(':radio[name=term]:checked').val() * 30;
		var endDate = getEndDate(dateString, period);
		
		$('#endDate').val(endDate);
	});
	
	// 경고창 띄우기
	$('#ad-form').submit(function() {
		
		var file = $('#img-file').val();
		var title = $('#adt-title').val();
		var pwd = $('#adt-pwd').val();
		var startDate = $('input[name="startDate"]').val();
		
		if (file == '') {
			alert("파일을 등록하세요.");
			return false;
		}
		if (title == '') {
			alert("제목을 입력하세요.");
			return false;
		}
		if (pwd == '') {
			alert("비밀번호를 입력하세요.");
			return false;
		}
		if (startDate == '') {
			alert("시작일을 선택하세요.");
			return false;
		}
		
		return true;
	})
})

// 등록버튼 

</script>
<style type="text/css">
	div.row {
		margin-bottom: 30px;
	}
</style>
</head>
<body style="overflow-x: hidden;">
<jsp:include page="../include/header.jsp" />
<div class="container" style="width: 60%; min-height: 740px;">
	<div class="row" style="margin-top: 50px;">
		<form id="ad-form" class="form-horizontal" action="/advertising/addAdBoard.do" method="post" enctype="multipart/form-data">
			<div class="form-group" id="img-select">
				<div class="col-sm-4 text-center">
					<img src="/resources/images/adFormImg/advertising_1type.jpg" width="100%">	
				 	<input type="radio" name="type" value="1" checked="checked"> 1900X500
				</div>
				<div class="col-sm-4 text-center">
					<img src="/resources/images/adFormImg/advertising_2type.jpg" width="100%">
					<input type="radio" name="type" value="2"> 160X600
				</div>
				<div class="col-sm-4 text-center">
					<img src="/resources/images/adFormImg/advertising_3type.jpg" width="100%">
					<input type="radio" name="type" value="3"> 370X370 
				</div>
			</div>
			<br>
			<div class="form-group">
				<label class="col-sm-1 control-label">이미지</label>
				<div class="col-sm-3" >
			      	<input type="file" class="form-control" name="imageFile" id="img-file">
			    </div>
				<label class="col-sm-1 control-label">제목</label>
				<div class="col-sm-3">
			      	<input type="text" class="form-control" name="title" id="adt-title" placeholder="광고 제목을 입력해주세요" maxlength="45">
			    </div>
				<label class="col-sm-1 control-label">비밀번호</label>
				<div class="col-sm-2">
			      	<input type="password" class="form-control" name="noPwd" id="adt-pwd">
			    </div>
			</div>
			<br>
			<div class="form-group">
				<label class="col-sm-1 control-label">시작일</label>
				<div class="col-sm-3">
		      		<input type="date" class="form-control" name="startDate" id="date-min" min="${dateDay }">
		    	</div>
				<div class="col-sm-1">
		    		<input type="radio" name="term" id="t1" value="1"> 1개월 
		    	</div>
		    	<div class="col-sm-1">
		    		<input type="radio" name="term" id="t3" value="3"> 3개월 
		    	</div>
		    	<div class="col-sm-1">
		    		<input type="radio" name="term" id="t6" value="6" checked="checked"> 6개월 
		    	</div>
		      	<label class="col-sm-2 control-label">종료일자</label>
		      	<div class="col-sm-2">
		      		<input type="text" class="form-control" name="endDate" id="endDate" readonly="readonly">
		      	</div>
			</div>
			<div class="form-group text-right row" style="margin-right: 50px;">
				<button id="board-submit" class="btn btn-default pull-right">등록</button>
			</div>
		</form>
	</div>
</div>
<jsp:include page="../include/footer.jsp" />
</body>
</html>