<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>ticketing</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script>
		var currentModalPageNo = "";
		var currentModalPageNo2 = "";
		var currentModalPageNo3 = "";
	function getlist(evnet,j,k,l) {
		currentModalPageNo = j;
		currentModalPageNo2 = k;
		currentModalPageNo3 = l;
		var criteria = $('#criteria').val();
		var value = $('#val').val();
		var category = $('#category').val();
		$.ajax({
			type: "GET",
			url: "/ticket/list.do",
			dataType: 'json',
			data:{currentModalPageNo:currentModalPageNo,criteria:criteria,value:value,category:category,currentModalPageNo2:currentModalPageNo2,currentModalPageNo3:currentModalPageNo3},
			success: function(result) {
				$('#search-value').val('');
				var tickets = result.tickets;
				var newTickets = result.nTickets;
				var deadLineTickets = result.deadLineTickets;
				var $tfooter = $('div#homeNav');
				$('#list').empty();
				$('#newList').empty();
				$('#deadlineList').empty();
				
				//전체 티켓
				var row1 = "";
				if(tickets.length == 0) {
					row1 += "<div class='row' style='height: 600px; padding-top: 150px;'>";
					row1 += "<p class='noContents'>현재 상품이 존재하지 않습니다.</p>";
					row1 += "<p class='noContents-bg'>:(</p>";
					row1 += "</div>";
				} else if(tickets.length != 0) {
					$.each(tickets, function(index, ticket) {
						row1 +=	"<div class='col-md-6'>";
						row1 +=	"<div class='thumnail'>";
						row1 +=	"<a href='detail.do?ticketNo="+ticket.no+"'><img src='/resources/images/ticket/"+ticket.images+"' class='thumbnailImg'></a>";
						row1 += "<div class='deadLine'>"+ticket.sellingStartToString+" ~ "+ticket.sellingEndToString+"</div>";
						row1 +=	"<div class='caption'>";
						row1 += "<span class='caption-name'>["+ticket.locationCity+"]"+ticket.name+"</span><br />";
						row1 += "<span class='caption-price'>"+ticket.priceToString+"원</span>";
						row1 +=	"</div>";
						row1 +=	"</div>";
						row1 +=	"</div>";
					})
				}
				$('#list').append(row1);
				
				var nav = 5;
				var totalCnt = result.totalCnt;
				var totalPageNo = Math.ceil(totalCnt/10);
				var totalBlocks = Math.ceil(totalPageNo/nav);
				var currentBlock = Math.ceil(currentModalPageNo/nav);
				var beginModalPage = ((currentBlock-1)*nav)+1;
				var endModalPage = currentBlock*nav;
				var previousPage = Math.floor((currentModalPageNo-1)/5)*5;
				var	nextPage = Math.ceil(currentModalPageNo/5)*5+1;
				
				var pagination = "<nav>";
				 	pagination += "<ul class='pagination'>";
					if(currentBlock != 1){
					    pagination += "<li><a href='#' onclick='getlist(event,"+previousPage+",1,1)' aria-label='Previous'>";
					    pagination += "<span aria-hidden='true'>&laquo;</span></a></li>";
					}
					if(currentBlock == totalBlocks) {
					   beginModalPage = ((totalBlocks-1)*nav)+1;
					   endModalPage = totalPageNo;
					}
					for (var i=beginModalPage; i<=endModalPage; i++) {
					   if (currentModalPageNo == i){
					      pagination += "<li><a class='selected' href='#'>"+i+"</a></li>";
					   } else {
					      pagination += '<li><a href="#" onclick="getlist(event,'+i+',1,1)">'+i+'</a></li>';
					   }
					}
					if(currentBlock != totalBlocks){
					    pagination += "<li><a href='#' onclick='getlist(event,"+nextPage+",1,1)' aria-label='Next'>";
					    pagination += "<span aria-hidden='true'>&raquo;</span></a></li>";
					}
				pagination += "</ul></nav>";
				$tfooter.empty();
				if(totalCnt != 0) {						
					$tfooter.append(pagination);
				}
				
				//새로등록한 티켓
				var row2 = "";
				if(newTickets.length == 0) {
					row2 += "<div class='row' style='height: 600px; padding-top: 150px;'>";
					row2 += "<p class='noContents'>새로 등록된 상품이 존재하지 않습니다.</p>";
					row2 += "<p class='noContents-bg'>:(</p>";
					row2 += "</div>";
				} else if(newTickets.length != 0) {
					$.each(tickets, function(index, ticket) {
						row2 +=	"<div class='col-md-6'>";
						row2 +=	"<div class='thumnail'>";
						row2 +=	"<a href='detail.do?ticketNo="+ticket.no+"'><img src='/resources/images/ticket/"+ticket.images+"' class='thumbnailImg'></a>";
						row2 += "<div class='deadLine'>"+ticket.sellingStartToString+" ~ "+ticket.sellingEndToString+"</div>";
						row2 +=	"<div class='caption'>";
						row2 += "<span class='caption-name'>["+ticket.locationCity+"]"+ticket.name+"</span><br />";
						row2 += "<span class='caption-price'>"+ticket.priceToString+"원</span>";
						row2 +=	"</div>";
						row2 +=	"</div>";
						row2 +=	"</div>";
					})
				}
				$('#newList').append(row2);
				
				var totalCnt2 = result.nTicketCnt;
				var totalPageNo2 = Math.ceil(totalCnt2/10);
				var totalBlocks2 = Math.ceil(totalPageNo2/nav);
				var currentBlock2 = Math.ceil(currentModalPageNo2/nav);
				var beginModalPage2 = ((currentBlock2-1)*nav)+1;
				var endModalPage2 = currentBlock2*nav;
				var previousPage2 = Math.floor((currentModalPageNo2-1)/5)*5;
				var	nextPage2 = Math.ceil(currentModalPageNo2/5)*5+1;
				
				var pagination2 = "<nav>";
				 	pagination2 += "<ul class='pagination'>";
					if(currentBlock2 != 1){
					    pagination2 += "<li><a href='#' onclick='getlist(event,1,"+previousPage2+",1)' aria-label='Previous'>";
					    pagination2 += "<span aria-hidden='true'>&laquo;</span></a></li>";
					}
					if(currentBlock2 == totalBlocks2) {
					   beginModalPage2 = ((totalBlocks2-1)*nav)+1;
					   endModalPage2 = totalPageNo2;
					}
					for (var i=beginModalPage2; i<=endModalPage2; i++) {
					   if (currentModalPageNo2 == i){
					      pagination2 += "<li><a class='selected' href='#'>"+i+"</a></li>";
					   } else {
					      pagination2 += '<li><a href="#" onclick="getlist(event,1,'+i+',1)">'+i+'</a></li>';
					   }
					}
					if(currentBlock2 != totalBlocks2){
					    pagination2 += "<li><a href='#' onclick='getlist(event,1,"+nextPage2+",1)' aria-label='Next'>";
					    pagination2 += "<span aria-hidden='true'>&raquo;</span></a></li>";
					}
				pagination2 += "</ul></nav>";
				$('#menu1Nav').empty();
				if(totalCnt2 != 0){						
					$('#menu1Nav').append(pagination2);
				}
				
				//기한일 티켓
				
				var row3 = "";
				if(deadLineTickets.length == 0) {
					row3 += "<div class='row' style='height: 600px; padding-top: 150px;'>";
					row3 += "<p class='noContents'>마감예정인 상품이 존재하지 않습니다.</p>";
					row3 += "<p class='noContents-bg'>:(</p>";
					row3 += "</div>";
				} else if(deadLineTickets.length != 0) {
					$.each(deadLineTickets, function(index, ticket) {
						row3 +=	"<div class='col-md-6'>";
						row3 +=	"<div class='thumnail'>";
						row3 +=	"<a href='detail.do?ticketNo="+ticket.no+"'><img src='/resources/images/ticket/"+ticket.images+"' class='thumbnailImg'></a>";
						row3 += "<div class='deadLine'>"+ticket.sellingStartToString+" ~ "+ticket.sellingEndToString+"</div>";
						row3 +=	"<div class='caption'>";
						row3 += "<span class='caption-name'>["+ticket.locationCity+"]"+ticket.name+"</span><br />";
						row3 += "<span class='caption-price'>"+ticket.priceToString+"원</span>";
						row3 +=	"</div>";
						row3 +=	"</div>";
						row3 +=	"</div>";
					})
				}				
				$('#deadlineList').append(row3);
				
				var totalCnt3 = result.deadLineTicketCnt;
				var totalPageNo3 = Math.ceil(totalCnt3/10);
				var totalBlocks3 = Math.ceil(totalPageNo3/nav);
				var currentBlock3 = Math.ceil(currentModalPageNo3/nav);
				var beginModalPage3 = ((currentBlock3-1)*nav)+1;
				var endModalPage3 = currentBlock3*nav;
				var previousPage3 = Math.floor((currentModalPageNo3-1)/5)*5;
				var	nextPage3 = Math.ceil(currentModalPageNo3/5)*5+1;
				
				var pagination3 = "<nav>";
				 	pagination3 += "<ul class='pagination'>";
					if(currentBlock3 != 1){
					    pagination3 += "<li><a href='#' onclick='getlist(event,1,1,"+previousPage3+")' aria-label='Previous'>";
					    pagination3 += "<span aria-hidden='true'>&laquo;</span></a></li>";
					}
					if(currentBlock3 == totalBlocks3) {
					   beginModalPage3 = ((totalBlocks3-1)*nav)+1;
					   endModalPage3 = totalPageNo3;
					}
					for (var i=beginModalPage3; i<=endModalPage3; i++) {
					   if (currentModalPageNo3 == i){
					      pagination3 += "<li><a class='selected' href='#'>"+i+"</a></li>";
					   } else {
					      pagination3 += '<li><a href="#" onclick="getlist(event,1,1,'+i+')">'+i+'</a></li>';
					   }
					}
					if(currentBlock3 != totalBlocks3){
					    pagination3 += "<li><a href='#' onclick='getlist(event,1,1,"+nextPage3+")' aria-label='Next'>";
					    pagination3 += "<span aria-hidden='true'>&raquo;</span></a></li>";
					}
				pagination3 += "</ul></nav>";
				$('#menu2Nav').empty();
				if(totalCnt3 != 0) {						
					$('#menu2Nav').append(pagination3);
				}
			}
		})
	}
	
	function pnoReset() {
		currentModalPageNo = 1;
		currentModalPageNo2 = 1;
		currentModalPageNo3 = 1;
	}
	
$(function() {
	
	//전체 티켓목록 가져오기
	getlist(event,1,1,1);

	//지역명에 마우스가 위치한 경우
	$('th[id^=list-]').hover(function() {
		$(this).css('background-color', 'rgb(198, 140, 83, 0.7)');
	}, function() {
		$(this).css('background-color', 'rgb(0,0,0,0.4)');
	});
	
	//지역명을 클릭한 경우
	$('th[id^=list-]').click(function() {
		$('#criteria').val('list');
		var value = $(this).attr('id').replace('list-','');
		$('#val').val(value);
		getlist(event,1,1,1);
		location.href = '#here';
	})
	
	//검색실행
	$('#search-form').submit(function() {
		$('#criteria').val('search');
		var value = $('#search-value').val();
		$('#val').val(value);
		getlist(event,1,1,1);
		return false;
	})
	
	//검색란에서 카테고리를 변경시킨 경우
	$('#categorySelector').on('change',function() {
		var category = $('#categorySelector').val();
		$('#category').val(category);
	})
	
	//티켓목록 상단 탭 클릯
	$('#ticketExpiredTab li').on('click', function() {
		location.href = "#here";
	})
	
	//티켓 마우스온 경우
	$('#list').on('mouseenter', '.thumnail', function(){
		$(this).attr('style', 'width: 500px; height: 410px; border: 3px solid #ac7339; margin: 10px;');
	});
	$('#list').on('mouseleave', '.thumnail', function(){
		$(this).attr('style', 'width: 500px; height: 410px; border: 1px solid #ccc; margin: 10px;');
	});
})
</script>
<style>
	body {overflow-x: hidden;}
	.ticketSubTitle {font-size:20px; color: #fff; font-weight: lighter; letter-spacing: -4px; margin: 5px;}
	.ticketMainTitle {font-size: 4em; color: #fff; font-weight: lighter; letter-spacing: -7px; margin-top: -20px; margin-left: 0px;}
	.ticketTopFloat {position:absolute; top: 160px; left: 28%;}
	.ticketTopFloat #search-value {background-color: transparent; color: #fff; width: 300px; height: 30px; border: none; border-bottom: 1px solid #fff;}
	.ticketTopFloat #search-value:-webkit-autofill {-webkit-box-shadow: inset 0 0 0px 9999px #00001a;}
	.ticketTopFloat #search-btn {background-color: transparent; color: #fff; font-size: 12px; margin-left: -10px;}
	#ticketLocationTab {position: absolute; width: 100%; position:absolute; top: 147px; margin: 0px;}
	#ticketLocationTab th {text-align: center; background-color: rgb(0,0,0,0.4); color: #fff; font-size: 13px; font-weight: lighter; border: none;}
	.ticketUnder-container .noContents {font-size: 35px; color: #ccc; margin-top: 45px; margin-bottom: 10px; letter-spacing: -4px; font-weight: lighter; text-align: center;}
	.ticketUnder-container .noContents-bg {font-size: 60px; color: #ccc; margin-top: -15px; margin-bottom: 10px; letter-spacing: -4px; font-weight: lighter; text-align: center;}
	#ticketExpiredTab a:link {text-decoration: none; color: #666;}
	#ticketExpiredTab a:hover {text-decoration: underline; color: #ac7339;}
	
	.thumnail {width: 500px; height: 410px; border: 1px solid #ccc; margin: 10px;}
	.deadLine {width: 460px; margin-top: 0px; margin-left: 19px; padding-left: 5px; text-align: left; background-color: #e69900; color: #fff; font-size: 13px;}
	.caption {width: 460px; margin-top: 10px; text-align: left; padding-left: 20px;}
	.caption-name {font-size: 14px; font-weight: bolder; color: #404040;}
	.caption-price {font-size: 22px; font-weight: bolder; color: #996633; letter-spacing: -2px;}
	.thumbnailImg {width: 460px; height: 296px; margin-top: 18px;}
	
	.ticketUnder-container .pagination a:link {color: #737373; text-decoration: none;}
	.ticketUnder-container .pagination a:visited {color: #737373; text-decoration: none;}
   	.ticketUnder-container .pagination a.selected {background-color: #c68c53; color: #ffffff;}
	.ticketUnder-container .pagination a:hover:not(.selected) {color: #c68c53;}	
}	
</style>	
</head>
<body>
<jsp:include page="../include/header.jsp">
	<jsp:param value="ticket" name="header"/>
</jsp:include>
	<div class="ticketTop-container" style="width: 100%; margin-top: -30px;">
		
		<div class="row">
			<img src="/resources/images/cssmain3.jpg" width="100%;"	/>
		</div>
		
		<div class="row" id="ticketLocationTab" style="margin-top: -40px;">
			<table class="table">
				<colgroup>
					<col width="16%">
					<col width="18%">
					<col width="16%">
					<col width="18%">
					<col width="16%">
					<col width="16%">
				</colgroup>
				<thead>
					<tr>
						<th id="list-all">전체</th>
						<th id="list-seoul">서울 / 경기 / 인천</th>
						<th id="list-kangwon">강원</th>
						<th id="list-chungcheong">충청 / 전라</th>
						<th id="list-kyeongsang">경상 / 부산</th>
						<th id="list-jeju">제주</th>
					</tr>
				</thead>
			</table>
		</div>
		
		<div class="row ticketTopFloat">
			<p class="ticketSubTitle">즐거운 여행을 위한</p>
			<p class="ticketMainTitle">티켓이라면?</p>
			<div class="ticketSearch">
				<form id="search-form"> 
					<div class="form-group">
						<div class="form-inline">
							<input type="hidden" id="criteria" value="list" />
							<input type="hidden" id="val" value="all" />
							<input type="hidden" id="category" value="All" />
							<select id="categorySelector" style="background-color: transparent; color: #fff; border: 1px solid 1px; height: 30px;">
								<option value="All" style="background-color: #00001a; color: #fff;">전체</option>
								<option value="TEMA_PARK" style="background-color: #00001a; color: #fff;">테마파크</option>
								<option value="AQUARIUM" style="background-color: #00001a; color: #fff;">아쿠아리움</option>
								<option value="WATER_PARK" style="background-color: #00001a; color: #fff;">워터파크</option>
								<option value="SPA" style="background-color: #00001a; color: #fff;">스파</option>
							</select>
							<input type="text" id="search-value">
							<button class="btn btn-sm" id="search-btn">검색</button>
						</div> 
					</div>
				</form>		
			</div>
		</div>
		
	</div>

	<p id="here"></p>

	<div class="ticketUnder-container" style="width: 60%; margin-right: auto; margin-left: auto;">
		<div class="row" style="margin-top: 30px;">
			<ul class="nav nav-tabs" id="ticketExpiredTab">
				<li class="active"><a data-toggle="tab" href="#home" id="ticketTabAll">전체보기</a></li>
				<li><a data-toggle="tab" href="#menu1" id="ticketTabNew">신규상품</a></li>
				<li><a data-toggle="tab" href="#menu2" id="ticketTabDead">오늘마감</a></li>
			</ul>
			
			<hr style="border: 2px solid #ac7339; margin-top: 0px; margin-bottom: 20px;">
	
			<div class="tab-content">
				<div id="home" onclick="pnoReset()" class="tab-pane fade in active">
					<div id="list" class="text-center">
					
					</div>
					<div id="homeNav" class="row text-center">
					
					</div>
				</div>
				<div id="menu1" onclick="pnoReset()" class="tab-pane fade">
					<div id="newList" class="text-center">
					
					</div>
					<div id="menu1Nav" class="row text-center">
					
					</div>
				</div>
				<div id="menu2" onclick="pnoReset()" class="tab-pane fade">
					<div id="deadlineList" class="text-center">
					
					</div>
					<div id="menu2Nav" class="row text-center">
					
					</div>				
				</div>
			</div>
		</div>
		
	</div>
	<jsp:include page="../include/footer.jsp" />
</body>
</html>