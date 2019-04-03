<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>weather</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">	 
	 
	#content h4 {
	    margin: 20px 0 7px 14px;
	    padding: 0 10px;
	    background: url(https://ssl.pstatic.net/static/n/local/206/weather/ico_arw02.gif) no-repeat 0 3px;
	    font-size: 12px;
	    line-height: 14px;
	    color: #333;
	    letter-spacing: -1px;
	    zoom: 1;
	}
	h4.st_cal {
	    clear: both;
	    margin: 18px 0 7px 14px ;
	    padding-left: 10px;
	    background: url(https://ssl.pstatic.net/static/n/local/206/weather/ico_arw02.gif) no-repeat 0 3px;
	    color: #333;
	    font-size: 14px !important;
	    letter-spacing: -1px;
	    text-align: left;
	}
	table {
	    color: #666;
	    font-size: 14px;
	    font-family: '돋움',Dotum,sans-serif;
	}
	.tbl_calendar {
		margin-left: 10px;
	    width: 547px;
	    border: 1px solid #d9d9d9;
	    border-collapse: collapse;
	}
	.tbl_calendar th {
	    height: 30px;
	    border-right: 1px solid #e8e8e8;
	    border-bottom: 1px solid #dcdde0;
	    background: #f6f6f6;
	    color: #333;
	    text-align: center;
	}
	.tbl_total td {
	    height: 56px;
	}
	.tbl_calendar td {
	    height: 70px;
	    border-right: 1px solid #eaecee;
	    border-bottom: 1px solid #eaecee;
	    text-align: center;
	}
	.tbl_calendar td.no {
	    background: #fafafa;
	}
	.tbl_total td .icon {
	    margin: 0 0 5px 0;
	}
	.tbl_calendar td .text {
	    margin-top: 4px;
	}
	
	.tbl_calendar td .icon {
	    margin-top: 2px;
	}
	.tbl_calendar .line {
    border-right: 1px solid #d9d9d9;
	}
	
	.st_total {
	    overflow: hidden;
	    clear: both;
	    margin: 17px 0 0 0;
	    padding-bottom: 6px;
	}
	.blind, h4.blind {
	    visibility: hidden;
	    overflow: hidden;
	    position: static;
	    width: 0;
	    height: 0;
	    margin: 0;
	    padding: 0;
	    font-size: 0;
	    line-height: 0;
	    
	}
	/* 
		현재 날씨
	 */    
	table {
	    border-spacing: 0;
	    border-collapse: collapse;
	}
	table {
	    border-spacing: 0;
	    border-collapse: collapse;
	}
	table {
	    color: #666;
	    font-size: 12px;
	    font-family: '돋움',Dotum,sans-serif;
	}
	table {
	    border-spacing: 0;
	    border-collapse: collapse;
	}
	table {
	    border-spacing: 0;
	    border-collapse: collapse;
	}
	user agent stylesheet
	table {
	    white-space: normal;
	    line-height: normal;
	    font-weight: normal;
	    font-size: medium;
	    font-style: normal;
	    color: -internal-quirk-inherit;
	    text-align: start;
	    font-variant: normal;
	}
	user agent stylesheet
	table {
	    display: table;
	    border-collapse: separate;
	    border-spacing: 2px;
	    border-color: grey;
	}
</style>
<script>
//지도에서 사용할 위도/경도
var tlat;
var tlng;

// 장소 선택시 변경
$(function() {
	$('#sido').change(function() {
		var city = $(this).val();
		$.ajax({
			type: "POST",
			url: "/weather/searchLocationByCity.do",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "json",
			data: {city: city},
			success: function(result) {
				$("#cw-sido").empty().text(city);
				$('#cw-gugun').empty();
				$('#cw-weather').hide();
				var rows = '<option value="">선택하세요</option>';
				$.each(result, function(index, location) {
					rows += '<option value="'+location.id+'">'+location.name+'</option>';
				});
				$('#gugun').empty().append(rows);
			}
		}); 		
  	});
  	
	// 위치에 맞게 구군 나오게 
	$('#gugun').change(function() {
		$.ajax({
			type: "POST",
			url: "/weather/searchLocationById.do",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "json",
			data: {id: $(this).val()},
			success: function(result) {
				var cityname = result.name;
				$('#cw-gugun').empty().text(cityname);
				$('#cw-weather').show();
				$('div#weatherId').empty().append(result.weatherId);
				tlat = result.lineX;
				tlng = result.lineY;
				initMap();
			}
		});
		
	});
  	
	// 선택 버튼 눌렀을때 밑에 상세조회창 띄우기
	$('#select-city').click(function(event) {
		event.preventDefault();
		
		var $form = $('#weather-form');
		
	  	// 빈칸으로 조회하면 경고창 띄우기
	  	var sido = $form.find('#sido').val();
	  	var gugun = $form.find('#gugun').val();
	  	var date = $form.find('#select-date').val();
	  	
	  	if (sido == "") {
	  		alert('도시 정보를 입력해 주세요')
	  		return false;		
	  	}
	  	if (gugun == "") {
	  		alert('구군 정보를 입력해 주세요')
	  		return false;		
	  	}
	  	if (date == "" || date == null) {
	  		alert('날짜를 지정해 주세요')
	  		return false;
	  	}
	  	
	  	// 현재 날씨 데이터 가져오기
	  	$.ajax({
			type:"GET",
			url:"current.do",
			data: {locationId: gugun},
			dataType:"json",
			success:function(result) {
				
				var $tbody = $("#cw-table tbody").empty();
				
				$.each(result, function(index, item) {
					
					if (item.day == 0) {
						var row = "";
						row += "<tr>";
						row += "<td>"+item.hour+"시</td>";						
						row += "<td>"+item.temp+" ℃</td>";
						if (item.tmx == "-999.0") {
							row += "<td> - </td>";	
						} else {
							row += "<td>"+item.tmx+" ℃</td>";	
						} 
						if (item.tmn == "-999.0") {
							row += "<td> - </td>";
						} else {
							row += "<td>"+item.tmn+" ℃</td>";						
						}
						row += "<td>"+item.wfKor+"</td>";						
						row += "<td>"+item.pop+" %</td>";						
						row += "<td>"+item.reh+" %</td>";																
						row += "</tr>";
						
						$tbody.append(row); 
					}
				});
				$("#cw-table").show();
			}
		});
	  	
	  	var weatherId = $('div#weatherId').text();
	  	console.log(weatherId);
	 	// 이전 날씨 데이터 가져오기
	 	var selectedDate = $('#select-date').val();
	 	var dateItems = selectedDate.split("-");
	 	var year = dateItems[0] - 1;
	 	var month = dateItems[1];
	 	
	 	
		$.ajax({
			type:"GET",
			url:"past.do",
			data: {locationId: weatherId, date: year+month},
			dataType:"html",
			success:function(result) {
				$("#weather_peanuts").remove();
				$("#print_content").empty().html(result).append();
			}
		});
	});
 })
  
// 지도 생성하는 함수
function createMap(slat, slng, zoom) {
	var map;
	if (map) {
		return;
	}
		
	map = new google.maps.Map(document.getElementById('map'), {
		zoom: zoom,
		center: {lat:slat, lng:slng}
	});
	return map;
}

// 마커 한개 생성
function addMarker(tlat, tlng, map) {
	
	var newMarker = new google.maps.LatLng(tlat, tlng);
		map.setOptions({
		zoom: 14,
		center: newMarker
	});
	  
	var marker = new google.maps.Marker({
		position: newMarker,
		map: map
	});
	  
	marker.setMap(map);
}
  
// 지도 생성
function initMap() {
	  
	var zoom = 8;
	var slat = 37.5729503;
	var slng = 126.97935789999997;
	var map = createMap(slat, slng, zoom);
	
	if (tlat) {
		addMarker(tlat, tlng, map);
	}
}  
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCOUv6PtH7XPdvPxZdqklHVocb4tLYqwFQ&callback=initMap" async defer></script>
<style>
	#map {
		width: 100%;
		height: 75%;
	}
</style>

</head>
<body>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/top.jsp">
	<jsp:param name="top" value="weather"/>
	<jsp:param name="pno" value="${pno }"/>
</jsp:include>
<div class="container" style="width: 60%; margin-bottom: 150px;">
	<div class="row">
		<div class="col-sm-6">
			<div class="row">
				<!-- 지도 -->
				<div id="map" class="text-center"></div>
			</div>
			<div class="row">
				<!-- 요즘 날씨 API -->
				<div id="current-weather-detail">
					<h4 class="st_cal" style="margin-left:2px;">
						<span id="cw-sido"></span> <span id="cw-gugun" style="font-weight: bolder"></span> <span id="cw-weather" style="display: none;">오늘날씨</span>
					</h4>
					<table class="table table-bordered" id="cw-table" style="display: none; width: 100%; padding: 70%;">
						<thead>
							<tr>
								<th>시</th>	
								<th>기온</th>
								<th>낮 최고기온</th>
								<th>아침 최저기온</th>
								<th>날씨</th>
								<th>강수확률(%)</th>
								<th>습도(%)</th>
							</tr>
						</thead>
						<tbody></tbody>
					</table>	
				</div>					
			</div>
		</div>
		<div class="col-sm-6">
			<div class="row">
				<form id="weather-form" class="well"  style="margin-left: 1%;">
					<div class="form-group">
						<label>장소</label>
						<input type="hidden" id="plannerNo"  />
						<select name="sido" id="sido" class="form-control">
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
						<select name="gugun" id="gugun" class="form-control">
							<option value="">선택하세요</option>
						</select>
						<div id="weatherId" style="display: none;">
						</div>
					</div>
					<div class="form-group">
						<label>날짜</label>
						<input id="select-date" type="date" class="form-control">
					</div>
					<div class="text-right">
						<button id="select-city" class="btn btn-sm btn-default ">선택</button>
					</div>
				</form>	
			</div>
			<div class="row">
				<!-- 처음 땅콩 화면 -->
				<div id="weather-detail">
					<img src="/resources/images/logo/peanuts.png" id="weather_peanuts" style="height: 45%"/>
					<!-- 이전 날씨 API -->
					<div id="past-weather-detail">
						<div id="content">
							<div id="print_content" class="text-center"></div>
						</div>
					</div>
				</div>	
			</div>
		</div>		
	</div>	
</div>
<jsp:include page="../include/footer.jsp" />
</body>
</html>

