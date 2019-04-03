<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>     
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>search result</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<style>
	p.pageTitle {font-size: 2em; color: #c68c53; margin-top: -20px; margin-bottom: -5px;}
	p.pageSubTitle {font-size: 20px; color: #666666; margin-top: -15px; margin-bottom: 10px; margin-left: -35px; letter-spacing: -3px;}
	p.pageBottomTitle {font-size: 25px; color: #666666; margin-top: -15px; margin-bottom: 10px; letter-spacing: -4px;}
	p.no-result {font-size: 35px; color: #ccc; margin-top: 45px; margin-bottom: 10px; letter-spacing: -4px; font-weight: lighter; text-align: center;}
	p.no-result-bg {font-size: 60px; color: #ccc; margin-top: -15px; margin-bottom: 10px; letter-spacing: -4px; font-weight: lighter; text-align: center;}
	#mentoBox .mentoList {width: 152px; height: 150px; background-color: #996633; opacity: 0.7; border-radius: 50%; margin-top: -150px;}
	#mentoCircle {text-align: center; padding-top: 60px; padding-right: auto; padding-left: auto; font-size: 20px; color: #fff; letter-spacing: 3px;}
	.plan-detail {width: 260px; height: 300px; background-color: #996633; opacity: 0.8; margin-bottom: -300px; padding: 10px;}
	.plan-detail p {color: #ffffff; font-size: 12px; font-weight: lighter;}
</style>
<body>
<jsp:include page="../include/header.jsp" />
<br/>
<div class="container" style="width: 60%; min-height: 740px;">
	<!-- 상단 사이드 결과 갯수 -->
	<div class="row">
		<p class="pageTitle">검색결과 [총<span style="font-weight: bolder; color: #996633;" id="resultCnt">${resultCnt }</span>건]</p>
	</div>
	<c:choose>
		<c:when test="${not empty mentos}">
			<div class="row" style="margin: 20px;" id="mentoBox">
			<p class="pageSubTitle">원하는 여행을 다녀온 회원들의 다른 플래너들도 알아보세요!</p>
				<c:forEach var="mento" items="${mentos }">
					<div class="col-sm-2">
						<div class="row text-center" style="padding: 10px;" >
							<img src="/resources/images/profile/${mento.profile }" width="150px;" height="150px;" style="border-radius: 50%" id="mentoInfo" />
							<div class="mentoList" id="miniUser-${mento.id }" style="display: none;">
								<p id='mentoCircle'>${mento.id }</p>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</c:when>
	</c:choose>
	
	<hr>
	
	<div class="row resultList-box" style="margin-top: 25px;">
	<c:choose>
		<c:when test="${not empty result }">
		<p class="pageBottomTitle">이런 여행 코스는 어떠세요?</p>
			<c:forEach var="item" items="${result }">
				<div class="col-sm-3" style="margin-top: 15px; margin-bottom: 15px;">
					<div class="row planner-info-box" style="width: 260px; padding-bottom: 5px; border-bottom: 5px solid #c68c53;">
						<div class="col-sm-3">
							<img src="/resources/images/profile/${item.profile.profile }" width="50px;" height="50px;" style="border-radius: 50%;"/>
						</div>
						<!-- 마우스 온하면 슬라이드로 날짜, 지역(3개정도), 해시태그 나옴  -->
						<div class="col-sm-9" style="text-align: left; padding-left: 25px;">
							<div class="row">
								<p style="font-size: 12px; margin-bottom: 0px; padding-top: 8px; color: #996633; font-weight: bolder;">${item.titleWithDots }</p>
								<p style="font-size: 12px; margin-top: 0px; color: #666666;">${item.userId }</p>					
							</div>
						</div>
					</div>
					<div class="row plan-detail" id="plan-detail-${item.no }" style="display: none;">
						<p><strong>여행출발</strong></p>
						<p style="margin-top: -10px;">${item.startMonth }</p>
						<p><strong>여행지역</strong></p>
						<p id="plan-locations-${item.no }" style="margin-top: -10px;"></p>
						<p><strong>해시태그</strong></p>
						<c:choose>
							<c:when test="${empty item.hashTags }">
								<p style="margin-top: -10px;">없 음</p>							
							</c:when>
							<c:otherwise>
								<p style="margin-top: -10px;"><c:forEach var="tag" items="${item.hashTags }">${tag } </c:forEach></p>
							</c:otherwise>
						</c:choose>
					</div>					
					<div class="row" id="plan-map-${item.no }"></div>					
				</div>
			</c:forEach>
		</c:when>
		<c:when test="${empty result }">
			<p class="no-result">해당하는 플래너가 존재하지않습니다.</p>
			<p class="no-result-bg">:(</p>
		</c:when>
	</c:choose>
	</div>

</div>
<jsp:include page="../include/miniUser.jsp" />	
<jsp:include page="../include/footer.jsp" />	
</body>
<script>
$(function() {
	
	var currPlanNo;
	//유저 아이디 보이기
	$('#mentoBox img[id=mentoInfo]').mouseenter(function() {
		$(this).siblings('.mentoList').fadeIn();
	});
	$('#mentoBox img[id=mentoInfo]').mouseleave(function() {
		$(this).siblings('.mentoList').fadeOut();
	});
	
	//플래너 리스트 로딩시, 지도 이미지랑 지역 정보 가져오기
	$('.resultList-box div[id^=plan-map-]').each(function() {
		//현재 플래너번호
		var planNo =  $(this).attr('id').replace('plan-map-', '').trim();
		var imgBox = $(this);
		var locationBox = $(this).siblings('.plan-detail').find('[id^=plan-locations-]');
		//지역명
 		$.ajax({
			type: 'GET',
			url: '/search/resultLocation.do',
			data: {pno: planNo},
			async: false,
			dataType: 'json',
			success: function(result) {
				var rows = "";
				if(result.length == 0) {
					rows += "없 음";
				} else {
					$.each(result, function(index, item) {
						rows += item;
						rows += " ";
					})
				}
				locationBox.append(rows);
			}
		}); 
		//지도 이미지
		$.ajax({
			type: 'GET',
			url: '/search/resultMap.do',
			data: {pno: planNo},
			async: false,
			success: function(result) {
				imgBox.append('<img src="'+result+'"/>');					
			}
		});
	});	
	
	//플래너지도에 마우스 온 시, 플래너 간략정보 보여주기
	$('.resultList-box div[id^=plan-map-]').mouseenter(function() {
		currPlanNo =  $(this).attr('id').replace('plan-map-', '').trim();
		$('.resultList-box div[id^=plan-detail-').slideUp('fast');			
		$('.resultList-box div[id=plan-detail-'+currPlanNo+']').slideDown('fast');			
	});
	$('.resultList-box div[id^=plan-detail-]').mouseout(function() {
		$('.resultList-box div[id^=plan-detail-').slideUp('fast');			
	})
	
	$('.resultList-box div[id^=plan-detail-]').click(function(){
		location.href = "/planner/dashboard.do?pno=" + currPlanNo;
	})
	
})
</script>
</html>