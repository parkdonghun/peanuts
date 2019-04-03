<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>admin :: main</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="https://canvasjs.com/assets/script/jquery.canvasjs.min.js"></script>
<style type="text/css">
@import url(https://fonts.googleapis.com/css?family=Open+Sans:300,700);
body {
  font-family: 'Open Sans', 'Helvetica Neue', Helvetica, Arial, sans-serif;
  font-size: 1em;
  font-weight: 300;
  line-height: 1.5;
  letter-spacing: 0.05em;
}
.timeline {
  margin: 4em auto;
  position: relative;
}
.timeline-event {
  position: relative;
}
.timeline-event:hover .timeline-event-thumbnail {
  -moz-box-shadow: inset 40em 0 0 0 #c68c53;
  -webkit-box-shadow: inset 40em 0 0 0 #c68c53;
  box-shadow: inset 40em 0 0 0 #c68c53;
  color: white;
}

.timeline-event-thumbnail {
  -moz-transition: box-shadow 0.5s ease-in 0.1s;
  -o-transition: box-shadow 0.5s ease-in 0.1s;
  -webkit-transition: box-shadow 0.5s ease-in;
  -webkit-transition-delay: 0.1s;
  transition: box-shadow 0.5s ease-in 0.1s;
  color: black;
  -moz-box-shadow: inset 0 0 0 0em #ffa07a;
  -webkit-box-shadow: inset 0 0 0 0em #ffa07a;
  box-shadow: inset 0 0 0 0em #ffa07a;
}

a#more-chart:hover {
	font-size: large;
	font-weight: 300px;
	color: #c68c53;
}
</style>
</head>
<body>
<jsp:include page="../include/header.jsp" />
<div class="container" style="width: 60%; min-height: 740px;">
	<div class="row">
		<!-- 왼쪽 메뉴바 -->
		<nav class="col-sm-3" id="myScrollspy">
			<jsp:include page="menu.jsp" />
		</nav>
		
		<!-- 오른쪽 통계 -->
		<div class="col-sm-9" id="first" style="overflow-y: scroll; height:680px;">
			<div class="row text-center">
				<h4 style="margin-bottom: 18px;" id="a">땅콩플래너 회원들의 총 여행 일수 : <strong style="font-size: xx-large; color: #c68c53;">${totalDays }</strong>일</h4>
				<div class="col-sm-offset-3 col-sm-6">
					<table class="table table-hover">
						<tr>
							<th>1 ~ 10일 계획</th>
							<td>${totalNumOfTravelDays10 }</td>
						</tr>
						<tr>
							<th>10 ~ 20일 계획</th>
							<td>${totalNumOfTravelDays20 }</td>
						</tr>
						<tr>
							<th>20 ~ 30일 계획</th>
							<td>${totalNumOfTravelDays30 }</td>
						</tr>
						<tr>
							<th>30일 이상 계획</th>
							<td>${totalNumOfTravelDays40 }</td>
						</tr>
						<tr>
							<th>전체 평균 여행일수</th>
							<td>${totalDaysAvg }</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="row">
				<!-- 그래프 -->
				<div class="text-right form-inline" id="b">
					년도별 보기 
					<input type="number" min="2000" max="2099" class="form-control" name="year" />
					<button class="btn btn-xs btn-default form-control" id="search-btn">검색</button>
					<button class="btn btn-xs btn-default form-control" id="all-num" style="margin-right: 10px;">전체보기</button>
				</div>
				<div id="chartContainer" style="height: 280px; width: 840px;"></div>
			</div>
			<div class="row" style="width: 840px;" id="map-and-table">
				<hr>
				<div class="row" style="width: 840px;">
					<h3 style="margin-bottom: 7px; margin-left: 18px; font-weight: 300; color: #dcdcdc; border-bottom: 2px solid #dcdcdc; padding-bottom: 0px;" id="c">
						가장 많이 방문한 도시
					</h3>
					<div id="map1" class="col-sm-7">
						<img src="${mostVisitedImg }">
					</div>
					<div id="table1" class="col-sm-5">
					<br>
						<table class="table">
							<colgroup>
								<col width="80%">
								<col width="20%">
							</colgroup>
							<thead>
								<tr>
									<th>도시명</th>
									<th></th>
								</tr>
							</thead>
							<tbody style="font-size: small;">
								<c:forEach items="${mostVisitedTable}" var="most" begin="0" end="8" step="1">
									<tr class="timeline-event">
										<td class="timeline-event-thumbnail">
											${most.locationCity} ${most.locationName}
										</td>
										<td class="timeline-event-thumbnail">
											${most.cnt}
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<br>
				<br>
				<div class="row" style="width: 840px;">
					<h3 style="margin-bottom: 7px; margin-left: 18px; font-weight: 300; color: #dcdcdc; border-bottom: 2px solid #dcdcdc; padding-bottom: 0px;" id="d">
						가장 오래 머문 도시(전체)
					</h3>
					<div id="map2" class="col-sm-7">
						<img src="${haveStayedTotalImg }">
					</div>
					<div id="table2" class="col-sm-5">
					<br>
						<table class="table">
							<colgroup>
								<col width="80%">
								<col width="20%">
							</colgroup>
							<thead>
								<tr>
									<th>도시명</th>
									<th>일수</th>
								</tr>
							</thead>
							<tbody style="font-size: small;">
								<c:forEach items="${haveStayedTotalTable}" var="stayedTotal" begin="0" end="8" step="1">
									<tr class="timeline-event">
										<td class="timeline-event-thumbnail">
											${stayedTotal.locationCity} ${stayedTotal.locationName}
										</td>
										<td class="timeline-event-thumbnail">
											${stayedTotal.date}
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<br>
				<br>
				<div class="row" style="width: 840px;">
					<h3 style="margin-bottom: 7px; margin-left: 18px; font-weight: 300; color: #dcdcdc; border-bottom: 2px solid #dcdcdc; padding-bottom: 0px;" id="e">
						가장 오래 머문 도시(평균)
					</h3>
					<div id="map3" class="col-sm-7">
						<img src="${haveStayedAvgImg }">
					</div>
					<div id="table3" class="col-sm-5">
					<br>
						<table class="table">
							<colgroup>
								<col width="80%">
								<col width="20%">
							</colgroup>
							<thead>
								<tr>
									<th>도시명</th>
									<th>일수</th>
								</tr>
							</thead>
							<tbody style="font-size: small;">
								<c:forEach items="${haveStayedAvgTable}" var="stayedAvg" begin="0" end="8" step="1">
									<tr class="timeline-event">
										<td class="timeline-event-thumbnail">
											${stayedAvg.locationCity} ${stayedAvg.locationName}
										</td>
										<td class="timeline-event-thumbnail">
											${stayedAvg.date}
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="../include/footer.jsp" />
</body>
<script>
// 월별 여행일을 담을 배열
var cnt = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

$(function() {
	// 페이지가 로딩되면서 한번 실행됨
	getCharts(null);
	
	// 년도별 검색을 눌렀을 때
	$('#search-btn').click(function() {
		// cnt를 비운다
		cnt = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		// chart를 그린다
		var keyword = $('input[name=year]').val();
		if (keyword == '') {
			return false;
		}
		getCharts(keyword);
	});
	
	// 전체보기를 눌렀을 때
	$('#all-num').click(function() {
		// cnt를 비운다
		cnt = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		// chart를 그린다
		getCharts(null);
	})
	
	// chart를 그리는 기능
	function getCharts(year) {
		$.ajax({
			type: "GET",
			url: "/admin/totalDaysOfMonth.do",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "json",
			async: false,
			data: {year: year},
			success: function(results) {
				$.each(results, function(index, result) {
					cnt[result.month - 1] = result.cnt; 
				});
				var options = {
					title: {
						text: "월별 여행일"              
					},
					data: [{
						// Change type to "doughnut", "line", "splineArea", etc.
						type: "column",
						dataPoints: [
							{ label: "01월", y: cnt[0] },
							{ label: "02월", y: cnt[1] },
							{ label: "03월", y: cnt[2] },
							{ label: "04월", y: cnt[3] },
							{ label: "05월", y: cnt[4] },
							{ label: "06월", y: cnt[5] },
							{ label: "07월", y: cnt[6] },
							{ label: "08월", y: cnt[7] },
							{ label: "09월", y: cnt[8] },
							{ label: "10월", y: cnt[9] },
							{ label: "11월", y: cnt[10] },
							{ label: "12월", y: cnt[11] }
						]
					}]
				};
			
				$("#chartContainer").CanvasJSChart(options);		
			}
		});
	}
});

</script>
</html>