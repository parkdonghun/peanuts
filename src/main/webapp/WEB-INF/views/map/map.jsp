<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>map</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
	#map {
		height: 680px;
		width: 100%;
	}
	input {
		margin: 2px;
	}
	a:link, a:visited {
		color: #000000;
	}
	a#del-last-plan:link, a#del-last-plan {
		color: #ac7339;
	}
	a#del-last-plan:hover {
		background-color: #8b0000;
		color: #faebd7;
	}
	
	/* width */
	::-webkit-scrollbar {
	    width: 10px;
	}
	
	/* Track */
	::-webkit-scrollbar-track {
	    background: #f1f1f1; 
	}
	 
	/* Handle */
	::-webkit-scrollbar-thumb {
	    background: #888; 
	}
	
	/* Handle on hover */
	::-webkit-scrollbar-thumb:hover {
	    background: #555; 
	}
</style>
</head>
<body>
<jsp:include page="../include/header.jsp" />
<div class="container" style="width: 60%; min-height: 740px;" id="mapContents">
	<div class="row">
		<div class="col-sm-3" id="plan" style="overflow-y: scroll; height:680px;">
			<div class="text-center panel panel-default panel-heading">
				<strong style="color: #8b4518">
					<img src="/resources/images/logo/peanutbw.png" width="20px">
					${planner.title }
					<img src="/resources/images/logo/peanutbw.png" width="20px">
				</strong>
			</div>
			<div class="text-center panel panel-default panel-heading">
				<strong>여행 시작일</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<span id="startDate">${planner.startDate }</span>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
					<form action="addPL.do" id="add-form">
						<input type="hidden" id="planNo" name="planNo" value="${planner.no}" />
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
							<select name="locationId" class="form-control">
								<option value="">선택하세요</option>
							</select>
						</p>
						<p>
							<label>해당 여행지의 여행종료일</label>
							<input type="date" name="endDate" class="form-control" min="${minDate }" max="${planner.endDate }" />
						</p>
						<p class="text-right">
							<button class="btn btn-info btn-xs" id="btn-add">저장</button>
							<input type="reset" class="btn btn-default btn-xs" value="취소">
						</p>
					</form>
				</div>
			</div>
			<div class="panel panel-default" id="del-last-plan">
				<div class="panel panel-heading"><strong>여행 일정</strong></div>
				<ul class="nav nav-pills nav-stacked text-center" id="inner-planner-location">
					
				</ul>
				<ul class="nav nav-stacked text-center">
					<li><a href="delPLByPnoAndLid.do"><strong>마지막 일정 삭제</strong></a></li>
				</ul>
			</div>
			<div class="text-center panel panel-default panel-heading">
				<strong>여행 종료일</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<span id="endDate">${planner.endDate }</span>
			</div>
			<div class="text-center panel panel-default panel-heading">
				<input type="radio" name="open" value="Y" checked="checked" /> 공개 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="open" value="N" /> 비공개
			</div>
			<div class="btn-group btn-group-justified">
				<a href="delPlanner.do" class="btn btn-danger" style="color:#fff;">일정 초기화</a>
				<a href="#" class="btn btn-default" id="insertPlan">루트수정 완료</a>
			</div>
		</div>
		<div class="col-sm-9">
			<div id="map"></div>
		</div>
	</div>
</div>
<jsp:include page="../include/footer.jsp" />

<script>
// 지도에서 사용할 위도/경도
var lat;
var lng;

var x = [];
var y = [];

var tlat;
var tlng;

var latlngs = [];

// window가 시작하자마자 실행되는 함수
$(function() {
	$('#mapContents #openY').attr('checked', true);
	
	// 일정 저장을 눌렀을 때, 컨펌confirm창을 이용해서 한번 더 확인받기
	$('#mapContents #insertPlan').click(function(e) {
		e.preventDefault();
		
		var isOk = confirm('루트 수정을 완료하시겠습니까?\n(※ 확인을 누르시면 루트 수정을 더이상 할 수 없습니다 ※)');
		if (isOk == true) {
			// ajax로 status를 Y로 업데이트 시키기
			// 단, 여행 종료 날짜와 마지막 일정 날짜가 같아야 한다
			// planner_location의 마지막 일정의 마지막 날짜와 planner의 end_date가 같아야 한다
			$.ajax({
				type: "POST",
				url: "completePlan.do",
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: "json",
				success: function(result) {
					if (result) {
						var open = $('#mapContents :radio[name="open"]:checked').val();
						location.href='completePlanStatus.do?open='+open;
					} else {
						alert('여행 루트를 모두 정한 후 완료해주세요\n*** 모든 루트는 중간저장됩니다');
					}
				}
			});
			
			
		}
	});
	
	$('#mapContents #del-last-plan').hide();
	
	$('#mapContents select[name="cityname"]').change(function() {
		// 클릭하는 순간 db에서 데이터 읽어와서 city의 셀렉트 박스에 뿌려주기
		$.ajax({
			type: "POST",
			url: "getLocation.do",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "json",
			data: {city: $(this).val()},
			async: false,
			success: function(result) {
				var rows = '<option value="">선택하세요</option>';
				$.each(result, function(index, location) {
					rows += '<option value="'+location.id+'">'+location.name+'</option>';
				});
				$('#mapContents select[name="locationId"]').empty().append(rows);
			}
		});
	});
	
	$('#mapContents select[name="locationId"]').change(function() {
		// 클릭하는 순간 db에서 데이터 읽어와서 해당 위치의 위도/경도에 맞는곳에 위치 표시하기
		$.ajax({
			type: "POST",
			url: "getLocation.do",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "json",
			data: {id: $(this).val()},
			success: function(result) {
				tlat = result[0].lineX;
				tlng = result[0].lineY;
				initMap();
			}
		});
	});
	
	// 저장버튼을 눌렀을 때 실행되는 함수
	// 빈칸을 허용하지 않음
	$('#mapContents #btn-add').click(function(event) {
		event.preventDefault();
		
		// 빈칸으로 넘기려고 하면 알람창 띄우기
		var city = $('#mapContents select[name="cityname"]').val();
		var name = $('#mapContents select[name="locationId"]').val();
		var endDate = $('#mapContents input[name="endDate"]').val();
		
		if (city == '') {
			alert('도시 정보를 입력해 주세요');
			return false;
		}
		if (name == '') {
			alert('도시 상세정보를 입력해 주세요');
			return false;
		}
		if (endDate == '') {
			alert('해당 여행지의 여행 종료일을 선택해 주세요')
			return false;
		}
		
		$('#mapContents #add-form').submit();
		
	});
	
	// 저장을 눌렀을 때 db에서 값을 받아와서 화면에 새로운 div를 만들어준다
	var no = $('#mapContents #planNo').val();
	x = [];
	y = [];
	
	$.ajax({
		type: "POST",
		url: "getPLByPno.do",
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		dataType: "json",
		data: {planNo: no},
		success: function(result) {
			
			if (result.length != 0) {
				$('#mapContents #del-last-plan').show();
			}
			
			var row = '';
			$.each(result, function(index, location) {
				row += '<li><a href="#"><strong>';
				row += location.locationCity + ' ' + location.locationName;
				row += '</strong><br/>'; 
				row += location.startDate + " ~ " + location.endDate;
				row += '</a></li>';
				
				$('#mapContents #inner-planner-location').empty().append(row);
				lat = location.lineX;
				lng = location.lineY;
				initMap();
			});
			
		}
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

// 마커를 여러개 생성하는 함수
function addMarkers(lat, lng, map) {
	x.push(lat);
	y.push(lng);
	
	for (var i=0; i<x.length; i++) {
		var newMarker = new google.maps.LatLng(x[i], y[i]);
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
}

// 마커끼리 연결선을 만드는 함수
function line(lat, lng, map) {
	var latlng = {};
	
	for (var i=0; i<x.length; i++) {
		latlng['lat'] = Number(x[i]);
		latlng['lng'] = Number(y[i]);
	}
	latlngs.push(latlng);
	
	var flightPath = new google.maps.Polyline({
		path: latlngs,
		geodesic: true,
		strokeColor: '#FF0000',
		strokeOpacity: 1.0,
		strokeWeight: 3
	});

	flightPath.setMap(map);
}


// 마커를 한개 생성하는 함수
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
	
	// DB에 저장하기 눌렀을 때 배열에 들어가서 저장된 위치를 기반으로 만들어져서 쌓이는 마커 
	if (lat) {
		addMarkers(lat, lng, map);
	}
	
	// DB에 저장하기 눌렀을 때 배열에 들어가서 저장된 위치를 기반으로 그려지는 line
	if (lat) {
		line(lat, lng, map);
	}
	
	// 처음 여러군데 찍어볼 때 하나씩 나타나는 마커
	if (tlat) {
		addMarker(tlat, tlng, map);
	}
	
}
</script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCOUv6PtH7XPdvPxZdqklHVocb4tLYqwFQ&callback=initMap">
</script>
</body>
</html>