<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="dashCalcontainer" style="width: 470px;">
	<div id="pno" style="display: none;">${pno }</div>
	<div id="dashCalendar" style="margin-top: 13px;"></div>
	<div id="dashCalBtns" style="margin-top: 7px; text-align: right;">
		<a href="/schedule/calendar.do?pno=${pno }" class="btn btn-sm btn-default">크게보기</a>
		<a href="/schedule/list.do?pno=${pno }" class="btn btn-sm" style="background-color: #ac7339; color: #fff;">일정표보기</a>
	</div>
</div>
<script>
$(function() {
	
	//공용변수
	var pno = $('#pno').text();
	$('#dashCalendar').fullCalendar({
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
	    contentHeight: 200,
		defaultView: 'month'/* {month: {titleFormat: 'MMMM YYYY'}} */,
		editable : false,
		height: 'auto',
		header: {
			left: '',
			center: '',
			right: ''
		}	    
	});	
	
	//해당 플래너의 시작달로 처음에 표시하기
	$.ajax({
		type: 'GET',
		url: '/schedule/getLoadMonth.do',
		data: {pno: pno},
		success: function(result){
			currentDate = new Date(result);
			$('#dashCalendar').fullCalendar('gotoDate', currentDate);
		}
	});
})
</script>	