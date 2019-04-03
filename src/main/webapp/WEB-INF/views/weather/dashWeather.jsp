<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">	 
	/* 이전 날씨  */

	#content h4 {
	    margin: 20px 0 7px 12px;
	    padding: 0 10px;
	    background: url(https://ssl.pstatic.net/static/n/local/206/weather/ico_arw02.gif) no-repeat 0 3px;
	    font-size: 10px;
	    line-height: 10px;
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
	    font-size: 12px !important;
	    letter-spacing: -1px;
	    text-align: left;
	}
	table {
	    color: #666;
	    font-size: 11px;
	    font-family: '돋움',Dotum,sans-serif;
	}
	.tbl_calendar {
		margin-left: -7px;
	    width: 482px;
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
	    margin: 12px 0 0 0;
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
	.timeline-article p {
    margin: 0 0 0 0px;
    padding: 0;
    font-weight: 450;
    color: #242424;
    font-size: 12px;
    line-height: 15px;
    position: relative;
    
    }
    
}
</style>
<script type="text/javascript">
$(function() {

	$.ajax({
		type:"GET",
		url: "/weather/getWeatherLocations.do",
		data:{pno:'${param.pno}'},
		dataType:'json',
		success: function(result) {
			
			$.ajax({
				type:"GET",
				url:"/weather/getPastWeather.do",
				data: {pno: '${param.pno}',  locationId: result[0].weatherId},
				dataType:"html",
				success: function(result) {
					$("#print_content").empty().html(result).append();
				
					$('.st_total').hide();
					$('.tbl_total').hide();
				}
			});
			
		}
	});
	
	
	
})
</script>
	<div class="dashWeathercontainer" style="470px;">
		<div id="print_content" class="text-center" style="margin-top: 13px;"></div>
	</div>

	

















