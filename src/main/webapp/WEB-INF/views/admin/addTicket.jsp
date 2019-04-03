<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>admin :: ticketManagement</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script type="text/javascript">
  $(function() {
	  $('select[name="cityname"]').change(function() {
		// 클릭하는 순간 db에서 데이터 읽어와서 city의 셀렉트 박스에 뿌려주기
		$.ajax({
			type: "POST",
			url: "/map/getLocation.do",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "json",
			data: {city: $(this).val()},
			success: function(result) {
				var rows = '<option value="">선택하세요</option>';
				$.each(result, function(index, location) {
					rows += '<option value="'+location.id+'">'+location.name+'</option>';
				});
				$('select[name="locationCity"]').empty().append(rows);
			}
		});
	});
	$('#add-form').submit(function() {
		var name = $('#ticket-name').val();
		var price = $('#ticket-price').val();
		var category = $('#ticket-category').val();
		var discountRate = $('#ticket-discountRate').val();
		var sellingEnd = $('#ticket-sellingEnd').val();
		var locationCity = $('#ticket-locationCity').val();
		var topImg = $('#top-img').val();
		var mainImg = $('#main-img').val();
		var explainImg = $('#explain-img').val();
		
		if(name =='') {
			alert('티켓명을 입력해주세요.');
			return false;
		}
		if(price =='') {
			alert('가격을 입력해주세요.');
			return false;
		}
		if(category =='') {
			alert('카테고리를 선택해주세요.');
			return false;
		}
		if(discountRate =='') {
			alert('할인율을 입력해주세요.');
			return false;
		}
		if(sellingEnd =='') {
			alert('마감일을 입력해주세요.');
			return false;
		}
		if(locationCity =='') {
			alert('지역을 선택해주세요.');
			return false;
		}
		if(mainImg =='') {
			alert('메인 이미지를 등록해주세요.');
			return false;
		}
		if(topImg =='') {
			alert('상단 이미지를 등록해주세요.');
			return false;
		}
		if(explainImg =='') {
			alert('설명 이미지를 선택해주세요.');
			return false;
		}
	})
  })
  </script>
</head>
<body>
<jsp:include page="../include/header.jsp" />
<div class="container" style="width: 60%; min-height: 740px;">
	<div class="row">
		<nav class="col-sm-3" id="myScrollspy">
			<!-- 왼쪽 메뉴바 -->
			<jsp:include page="menu.jsp" />
		</nav>
		<div class="col-sm-9">
			<h1>
				<strong>티켓등록</strong>
				<img src="/resources/images/logo/peanutbw.png" width="40px">
				<img src="/resources/images/logo/peanutbw.png" width="40px">
				<img src="/resources/images/logo/peanutbw.png" width="40px">
			</h1>
			<form method="post" id="add-form" action="addTicket.do" enctype="multipart/form-data">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>티켓명</th>
							<td>
								<input type="text" id="ticket-name" name="name">
							</td>
						</tr>
						<tr>
							<th>가격</th>
							<td>
								<input type="number" id="ticket-price" name="price">
							</td>
						</tr>
						<tr>
							<th>카테고리</th>
							<td>
								<select id="ticket-category" name="category" class="form-control">
									<option value="WATER_PARK">워터파크</option>
									<option value="TEMA_PARK">테마파크</option>
									<option value="SPA">스파</option>
									<option value="AQUARIUM">아쿠아리움</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>티켓메인이미지</th>
							<td>
								<input type="file" id="main-img" name="image" accept="image/*">
							</td>
						</tr>
						<tr>
							<th>티켓상단이미지</th>
							<td>
								<input type="file" id="top-img" name="topImages" multiple="multiple" accept="image/*">
							</td>
						</tr>
						<tr>
							<th>티켓설명이미지</th>
							<td>
								<input type="file" id="explain-img" name="mainImages" multiple="multiple" accept="image/*">
							</td>
						</tr>
						<tr>
							<th>할인율</th>
							<td>
								<input type="number" id="ticket-discountRate" max="100" name="discountRate">
							</td>
						</tr>
						<tr>
							<th>판매종료일</th>
							<td>
								<input type="date" id="ticket-sellingEnd" name="sellingEnd">
							</td>
						</tr>
						<tr>
							<th>지역</th>
							<td>
								<p>
									<select name="cityname" class="form-control">
										<option value="">선택하세요</option>
										<option value="서울특별시">서울특별시</option>
										<option value="부산광역시">부산광역시</option>
										<option value="대구광역시">대구광역시</option>
										<option value="인천광역시">인천광역시</option>
										<option value="광주광역시">광주광역시</option>
										<option value="대전광역시">대전광역시</option>
										<option value="울산광역시">울산광역시</option>
										<option value="경기도_경기남부">경기도(경기남부)</option>
										<option value="경기도_경기북부">경기도(경기북부)</option>
										<option value="강원도">강원도</option>
										<option value="충청북도">충청북도</option>
										<option value="충청남도">충청남도</option>
										<option value="전라북도">전라북도</option>
										<option value="전라남도">전라남도</option>
										<option value="경상북도">경상북도</option>
										<option value="경상남도">경상남도</option>
										<option value="제주특별자치도">제주특별자치도</option>
										<option value="세종특별자치시">세종특별자치시</option>
									</select>
									<select name="locationCity" id="ticket-locationCity" class="form-control">
										<option value="">선택하세요</option>
									</select>
								</p>
							</td>
						</tr>
					</thead>
				</table>
				<div class="pull-right">
					<button class="btn btn-default">등록</button>
					<a href="ticketList.do" class="btn btn-default">취소</a>
				</div>
			</form>
		</div>
	</div>
</div>
<jsp:include page="../include/footer.jsp" />
</body>
</html>