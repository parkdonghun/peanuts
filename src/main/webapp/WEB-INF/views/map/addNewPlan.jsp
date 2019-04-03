<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>addNewPlan</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
	.tag {
		margin: 2px;
	}
	.noticeBox p {font-size: 13px; color: #737373; font-weight: bolder; margin: 10px;}
</style>
<script>
$(function() {
	var clickk = 0;
	$('#logo').click(function() {
		clickk++;
		if (clickk == 4) {
			$('#logo').attr('src', '/resources/images/logo/peanuts_1.jpg');
		}
		if (clickk == 8) {
			$('#logo').attr('src', '/resources/images/logo/peanuts_2.jpg');
		}
		if (clickk == 12) {
			$('#logo').attr('src', '/resources/images/logo/peanuts_3.jpg');
		}
		if (clickk == 16) {
			$('#logo').attr('src', '/resources/images/logo/peanuts_4.jpg');
		}
		if (clickk == 20) {
			$('#logo').attr('src', '/resources/images/logo/peanuts_5.jpg');
		}
		if (clickk == 24) {
			$('#logo').attr('src', '/resources/images/logo/peanuts_6.jpg');
		}
		if (clickk == 28) {
			$('#logo').attr('src', '/resources/images/logo/peanuts_7.jpg');
		}
		if (clickk == 32) {
			$('#logo').attr('src', '/resources/images/logo/peanuts.png');
			clickk = 0;
		}
	});
});
</script>
</head>
<body>
<jsp:include page="../include/header.jsp" />
<div class="container" style="width: 60%; min-height: 740px;">
	<div class="row noticeBox" style="border: 2px solid #c68c53; border-radius: 7px;">
		<p><img src="/resources/images/logo/peanutbw.png" width="20px;" /> 땅콩플레너에서 새로운 여행 계획을 세워보세요!</p>
		<p><img src="/resources/images/logo/peanutbw.png" width="20px;" /> <span style="color: #c68c53;">해시태그</span>를 사용해서 당신의 여행계획을 표현해 보세요!</p>
		<p><img src="/resources/images/logo/peanutbw.png" width="20px;" /> 플래너 작성은 로그인한 회원만 가능합니다.</p>
		<p><img src="/resources/images/logo/peanutbw.png" width="20px;" /> 플래서 생성시 공개 플래너는 땅콩 5개, 비공개 플래너는 땅콩 10개가 필요합니다.</p>
		<p><img src="/resources/images/logo/peanutbw.png" width="20px;" /> 땅콩은 게시판 글쓰기를 통해 획득할 수 있습니다!</p>
		<!-- <p><img src="/resources/images/logo/peanutbw.png" width="20px;" /> 땅콩은 게시판 글쓰기를 통해 획득하거나 땅콩 구매 사이트를 통해 구매할 수 있습니다! <a href="#" style="color: #c68c53;">구매사이트 방문</a></p> -->
	</div>
	<br>
	<div class="row">
		<div class="col-sm-8">
			<form method="post" class="well" action="addPlan.do" style="color: #ac7339;" id="add-plan-form">
				<div class="form-group">
					<label>plan title</label>
					<input type="text" class="form-control" name="title" maxlength="50" />
				</div>
				<div class="form-group">
					<label>여행 시작일</label>
					<input type="date" class="form-control" name="startDate" />
				</div>
				<div class="form-group">
					<label>여행 종료일</label>
					<input type="date" class="form-control" name="endDate" disabled />
				</div>
				<div class="form-group">
					<label>여행인원</label>
					<input type="number" class="form-control" name="member" min="1" max="100" value="1" />
				</div>
				<label>#해시태그 추가</label>
				<div class="form-group form-inline">
					<select name="hashtag" class="form-control">
						<option value="">-- 선택하세요 --</option>
						<option value="산">산</option>
						<option value="강">강</option>
						<option value="바다">바다</option>
						<option value="봄">봄</option>
						<option value="여름">여름</option>
						<option value="가을">가을</option>
						<option value="겨울">겨울</option>
						<option value="가족">가족</option>
						<option value="기념">기념</option>
						<option value="기차">기차</option>
						<option value="내일로">내일로</option>
						<option value="덕질">덕질</option>
						<option value="먹방">먹방</option>
						<option value="방학">방학</option>
						<option value="버스">버스</option>
						<option value="배낭">배낭</option>
						<option value="우정">우정</option>
						<option value="이별">이별</option>
						<option value="자유">자유</option>
						<option value="졸업">졸업</option>
						<option value="주말">주말</option>
						<option value="즉흥">즉흥</option>
						<option value="청춘">청춘</option>
						<option value="첫">첫</option>
						<option value="커플">커플</option>
						<option value="테마">테마</option>
						<option value="퇴사">퇴사</option>
						<option value="홀로">홀로</option>
						<option value="휴가">휴가</option>
						<option value="힐링">힐링</option>
					</select>
					<span>여행</span>
				</div>
				<div class="form-group" id="hash-box">
				</div>
				<div class="text-right">
		            <button class="btn btn-default" id="submit-button">등록</button>
		        </div>
			</form>
		</div>
		<div class="col-sm-4">
			<img src="/resources/images/logo/peanuts.png" width="100%" id="logo" />
		</div>
	</div>
</div>
<jsp:include page="../include/footer.jsp" />
</body>
<script type="text/javascript">
$(function() {
	// 전송 버튼을 눌렀을 때 실행되는 메소드
	// 한 칸이라도 비어있으면 다음 단계로 못넘어가게 하기
	$('#submit-button').click(function(event) {
		event.preventDefault();
		
		var title = $('input[name="title"]').val();
		var startDate = $('input[name="startDate"]').val();
		var endDate = $('input[name="endDate"]').val();
		var member = $('input[name="member"]').val();
		
		if (title == null) {
			alert('title을 입력해 주세요');
			return false;
		} 
		if (startDate == '') {
			alert('여행 시작일을 입력해 주세요');
			return false;
		}
		if (endDate == '') {
			alert('여행 종료일을 입력해 주세요');
			return false;
		}
		if (member == '') {
			alert('여행 인원을 입력해 주세요');
			return false;
		}
		
		// 배열을 생성해서 선택된 태그들을 담고 문자열 형식으로 바꿔서 hidden으로 저장한다
		var texts = $('.tag');
		var text = '';
		
		for (var i=0; i<texts.length; i++) {
			text += texts[i].text + ',';
		}
		
		// 나중에 히든으로 바꾸기
		$('#add-plan-form').append('<input type="hidden" name="hashTag" value="'+text+'">');
		
		$('#add-plan-form').submit();
	});
	
	// 여행 시작일을 누르면 여행 종료일이 활성화되고, 여행시작일을 min값으로 가진다
	$('input[name="startDate"]').change(function() {
		var strDate = $('input[name="startDate"]').val();
		$('input[name="endDate"]').attr("disabled", false).attr("min", strDate);
	});
	
	// 해시태그 추가하는 메소드
	$('select[name=hashtag]').change(function() {
		var hashText = $(this).val();
		if (hashText == "") {
			return false;
		}
		
		var rows = '<a href="#" class="tag btn btn-xs btn-default">'+hashText+'</a>';
		$('#hash-box').append(rows);
		
		$('option[value='+hashText+']').hide();
	});
	
	// mouseenter, mouseleave 이벤트
	var hash = '';
	$('div').on('mouseenter', '.tag', function(e) {
		e.stopImmediatePropagation();
		hash = $(this).text();
		$(this).css('color', '#8b0000').text('취소');
		
		$(this).click(function() {
			$('option[value='+hash+']').show();
			$(this).remove();
			hash = '';
			
		});
	});
	$('div').on('mouseleave', '.tag', function(e) {
		e.stopImmediatePropagation();
		$(this).css('color', 'black').text(hash);
		hash = '';
	});
	
})
</script>
</html>