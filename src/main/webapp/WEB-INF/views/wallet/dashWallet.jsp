<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<style type="text/css">
	div.panel-body {width:320px; height: 35px; padding-top: 8px; font-weight:bold; color: #4d4d4d;}
	div.panel-default {margin-bottom: 1px; margin-left: 20px;}
	.pull-right {font-size: 12px;}
	.glyphicon {color: #b35900;}
	
</style>
<script type="text/javascript">
$(function(){
	var pno = ${param.pno};
	
	function comma(str) {
   		str = String(str);
    	return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}
 	 $.ajax({
		type: 'GET',
		url: '/wallet/dashboard.do',
		dataType: 'json',
		data: {pno:pno},
		success: function(result){
			var total = 0;

			$.each(result, function(n, item){				
				if(item.category == 'HOTEL'){
					$('#money-hotel').text(comma(item.money));
					total += item.money;
				}
				if(item.category == 'TRANS'){
					$('#money-trans').text(comma(item.money));
					total += item.money;
				}
				if(item.category == 'TOUR'){
					$('#money-tour').text(comma(item.money));
					total += item.money;
				}
				if(item.category == 'FOOD'){
					$('#money-food').text(comma(item.money));
					total += item.money;
				}
				if(item.category == 'SHOP'){
					$('#money-shop').text(comma(item.money));
					total += item.money;
				}
				if(item.category == 'ETC'){
					$('#money-etc').text(comma(item.money));
					total += item.money;
				}
			});
			$('#money-total').text(comma(total));
			
			var hotel = document.getElementById("money-hotel").innerHTML.replace(/[^\d]+/g, '');
			var trans = document.getElementById("money-trans").innerHTML.replace(/[^\d]+/g, '');
			var food = document.getElementById("money-food").innerHTML.replace(/[^\d]+/g, '');
			var shop = document.getElementById("money-shop").innerHTML.replace(/[^\d]+/g, '');
			var tour = document.getElementById("money-tour").innerHTML.replace(/[^\d]+/g, '');
			var etc = document.getElementById("money-etc").innerHTML.replace(/[^\d]+/g, '');
			
			dashWalletChart(hotel, trans, food, shop, tour, etc);
		}
		
	}); 
 	
		//차트 이벤트
		function dashWalletChart(hotel, trans, food, shop, tour, etc) {
			
			var chart = new CanvasJS.Chart("chart-table", {
				animationEnabled : true,
				data : [ {
					type : "doughnut",
					startAngle : 60,
					//innerRadius: 60,
					indexLabelFontSize : 13,
					indexLabel : "{label} ",
					toolTipContent : "<b>{label}:</b> {y}", //#percent%
					dataPoints : [ {
						y : hotel,
						label : "숙소"
					}, {
						y : trans,
						label : "교통"
					}, {
						y : food,
						label : "식비"
					}, {
						y : tour,
						label : "관광"
					}, {
						y : shop,
						label : "쇼핑"
					}, {
						y : etc,
						label : "Etc."
					} ]
				} ]
			});
			chart.render();
		}
});

</script>
<div class="container" style="align-items: center; padding-left: 50px;">
	<div class="col-sm-3">
		<div class="row">
			<div id="chart-table" class="col-sm-6" style="height: 250px; width: 100%; margin-bottom: 15px; padding-left: 40px;"></div>
		</div>
		<div class="row" id="dash-wallet" style="width: 350px;">
			<div class="panel panel-default">
				<div class="panel-body">
					<span class="glyphicon glyphicon-ok"></span> 합계
					<span class="pull-right"><span id="money-total">0</span>원</span>
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-body">
					<span class="glyphicon glyphicon-home"></span> 숙소
					<span class="pull-right"><span id="money-hotel">0</span>원</span>
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-body">
					<span class="glyphicon glyphicon-road"></span> 교통
					<span class="pull-right"><span id="money-trans">0</span>원</span>
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-body">
					<span class="glyphicon glyphicon-globe"></span> 관광
					<span class="pull-right"><span id="money-tour">0</span>원</span>
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-body">
					<span class="glyphicon glyphicon-cutlery"></span> 식비
					<span class="pull-right"><span id="money-food">0</span>원</span>
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-body">
					<span class="glyphicon glyphicon-shopping-cart"></span> 쇼핑
					<span class="pull-right"><span id="money-shop">0</span>원</span>
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-body">
					<span class="glyphicon glyphicon-folder-close"></span> Etc.
					<span class="pull-right"><span id="money-etc">0</span>원</span>
				</div>
			</div>
		</div>
	</div>
</div>