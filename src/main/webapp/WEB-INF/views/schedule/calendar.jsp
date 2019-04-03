<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>     
<!DOCTYPE html>
<html lang="ko">
<head>
<title>schedule calendar</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel='stylesheet' href='/resources/fullcalendar/fullcalendar.css' />
<script src='/resources/fullcalendar/lib/jquery.min.js'></script>
<script src='/resources/fullcalendar/lib/moment.min.js'></script>
<script src='/resources/fullcalendar/fullcalendar.js'></script>
<script src='/resources/fullcalendar/locale/ko.js'></script>
</head>
<style>
	body {overflow-x: hidden;}
	#page-menu a:link {color: #737373; text-decoration: none;}
	#page-menu a:visited {color: #737373; text-decoration: none;}
	#page-menu a:visited:hover {color: #ac7339; text-decoration: none;}
</style>
<body>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/top.jsp">
	<jsp:param name="top" value="calendar"/>
	<jsp:param name="pno" value="${pno }"/>
</jsp:include>
<br/>
<div class="container" style="width: 60%; min-height: 740px;">
	<div class="row">
		<span id="page-menu">
			<img src="/resources/images/logo/peanutbw.png" width="auto;" height="20px;" />
			&nbsp;<a href="calendar.do?pno=${pno }"><strong>캘린더</strong></a>
			&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
			<a href="list.do?pno=${pno }" style="margin-left: 5px;">플래너 일정표</a>
		</span>
		<p style="display: none" id="pno">${pno }</p>
	</div>
	<br/>
	<div id="calendar"></div>
</div>
<jsp:include page="../include/footer.jsp" />	
</body>
<script>
$(function() {
	
	//공용변수
	var pno = $('#pno').text();
	$('#calendar').fullCalendar({
	    events: function(start, end, timezone, callback) {
	    	var currMomentParam = {start: start.format(), end: end.format(), pno: pno};
	        $.ajax({
	            url: '/schedule/calEvent.do',
	            data: currMomentParam,
	            dataType: 'json',
	            success: function(result) {
               			callback(result);
            	},
	        });
	    },
	    contentHeight: 650,
		defaultView: 'month'/* {month: {titleFormat: 'MMMM YYYY'}} */,
		editable : false,
		height: 'auto',
		header: {
			left:   'prev,today,next',
			center: 'title',
			right:  'month,listWeek,day '
		},
		buttonText : {
			today: '이번달',
			month : '월별',
			listWeek : '주간',
			day : '일별'
		},
		buttonIcons : {
			  prev: 'left-single-arrow',	
			  next: 'right-single-arrow'
		}	    
	});	
	
	//해당 플래너의 시작달로 처음에 표시하기
	$.ajax({
		type: 'GET',
		url: '/schedule/getLoadMonth.do',
		data: {pno: pno},
		success: function(result){
			currentDate = new Date(result);
			$('#calendar').fullCalendar('gotoDate', currentDate);
		}
	});
})
</script>	
</html>