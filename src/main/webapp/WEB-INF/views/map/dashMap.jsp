<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/top.jsp">
	<jsp:param name="top" value="map"/>
	<jsp:param name="pno" value="${pno }"/>
</jsp:include>
<div class="container">
	<div id="map" style="width: 100%; height: 610px;"></div>
	<c:if test="${status eq 'N' && isWriter eq true}">
		<div class="text-right">
			<a href="/map/map.do?pno=${pno }" class="btn btn-sm btn-default">루트 수정하기</a>
		</div>
	</c:if>
</div>
<input type="hidden" id="planNo" value="${pno }">
<jsp:include page="../include/footer.jsp" />
<script> 
//지도에서 사용할 위도/경도
var lat;
var lng;

var x = [];
var y = [];

var latlngs = [];

$(function() {
	// planner_no에 따른 planner_location을 불러와서 지도에 마커찍고 선그리기
	x = [];
	y = [];
	
	var no = $('#planNo').val();
	$.ajax({
		type: "GET",
		url: "/map/getPLByPno.do",
		dataType: "json",
		data: {planNo: no},
		success: function(result) {
			$.each(result, function(index, location) {
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

// 지도 생성
function initMap() {
	var zoom = 7;
	var slat = 36.5482253;
	var slng = 127.99063309999997;
	var map = createMap(slat, slng, zoom);
	
	// DB에 저장하기 눌렀을 때 배열에 들어가서 저장된 위치를 기반으로 만들어져서 쌓이는 마커 
	if (lat) {
		addMarkers(lat, lng, map);
	}
	
	// DB에 저장하기 눌렀을 때 배열에 들어가서 저장된 위치를 기반으로 그려지는 line
	if (lat) {
		line(lat, lng, map);
	}
}
</script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAcgMtwv2kWUn9CyEd7ID1zm7gPbxFBykU&callback=initMap">
</script>
<!-- </body>
</html> -->