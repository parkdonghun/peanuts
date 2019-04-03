<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<!DOCTYPE html>
<html lang="ko">
<head>
<title>schedule list</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<style type="text/css">
	body {overflow-x: hidden;}
	table th, table td {font-size: 12px;}
	.label {font-size: 11px;}
	#page-menu a:link {color: #737373; text-decoration: none;}
	#page-menu a:visited {color: #737373; text-decoration: none;}
	#page-menu a:visited:hover {color: #ac7339; text-decoration: none;}
	
	.pagination a:link {color: #737373; text-decoration: none;}
	.pagination a:visited {color: #737373; text-decoration: none;}
   	.pagination a.active {background-color: #c68c53; color: #ffffff;}
	.pagination a:hover:not(.active) {color: #c68c53;}	
	
	@media print {
		a {display: none !important;}
		.none-print {display: none !important;}
	}	/* 프린트시, a href link 가리기 */
</style>
<body>
<jsp:include page="../include/header.jsp"/>
<jsp:include page="../include/top.jsp">
	<jsp:param name="top" value="calendar"/>
	<jsp:param name="pno" value="${pno }"/>
</jsp:include>
<br/>
<div class="container" style="width: 60%; min-height: 740px;" id="box">
	<div class="row">
		<span id="page-menu">
			<img src="/resources/images/logo/peanutbw.png" width="auto;" height="20px;" />
			&nbsp;<a href="calendar.do?pno=${pno }">캘린더</a>
			&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
			<a href="list.do?pno=${pno }" style="margin-left: 5px;"><strong>플래너 일정표</strong></a>
		</span>
		<span class="pull-right" style="margin-right: 3px;">
			<a class="btn btn-xs btn-warning" href="#" onclick="printArea();"><span class="glyphicon glyphicon-print"></span> 일정표 인쇄</a>
		</span>
		<p style="display: none" id="pno">${pno }</p>
		<p style="display: none" id="isWriter">${isWriter }</p>
	</div>
	
	<br/>
	<table class="table daily-table">
		<colgroup>
			<col width="5%">
			<col width="15%">
			<col width="10%">
			<col width="20%">
			<col width="*">
			<col width="23%">
		</colgroup>
		<thead>
			<tr>
				<th>-</th>
				<th>날짜</th>
				<th>지역</th>
				<th>교통</th>
				<th>관광일정</th>
				<th>숙박</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="daily" items="${allDaily }">
				<tr id="daily-${daily.key }">
					<td style="height: 100px;">${daily.index }일차</td>
					<td style="height: 100px;">
						<div class="col-sm-3"><h1 style="font-weight: bolder; margin: -2px; text-align: right;">${daily.day }</h1></div>
						<div class="col-sm-9" style="font-size: 12px;">${daily.month }월<br/>${daily.weekDay }</div>					
					</td>
					<td style="height: 100px;"></td>
					<td style="height: 100px;"></td>
					<td style="height: 100px;"></td>
					<td style="height: 100px;"></td>
				</tr>			
			</c:forEach>
		</tbody>
	</table>

	<!-- Modal(교통편) -->
	<div id="transModal" class="modal fade" role="dialog">
	  <div class="modal-dialog modal-sm">
	    <!-- Modal content-->
	    <div class="modal-content">
	    
	      <div class="modal-header" style="background-color: #ac7339; color: #ffffff;">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title" id="trans-atitle" ><span class="glyphicon glyphicon-plane">이동추가</span></h4>
	        <h4 class="modal-title" id="trans-mtitle"><span class="glyphicon glyphicon-plane">이동수정</span></h4>
	      </div>
	    
	      <div class="modal-body">
			<form method="post" id="trans-form">
				<input type="hidden" name="pno" value="${pno }"/>
				<input type="hidden" name="key" id="trans-hidden-key"/>
				<div class="form-group">
					<label>출발지역</label>
					<select name="startLocation" class="form-control"></select>
				</div>
				<div class="form-group">
					<label>출발시간</label>
					<input type="time" name="startTime" class="form-control"/>
				</div>
				<div class="form-group">
					<label>교통수단</label>
					<select name="category" class="form-control">
						<option value="">::교통수단을 선택하세요::</option>
						<option value="AIR">항공</option>
						<option value="TRAIN">기차</option>
						<option value="TAXI">택시</option>
						<option value="BUS">버스</option>
						<option value="ETC">기타</option>
					</select>
				</div>
				<div class="form-group">
					<label>도착지역</label>
					<select name="endLocation" class="form-control"></select>
				</div>
				<div class="form-group">
					<label>도착시간</label>
					<input type="time" name="endTime" class="form-control"/>
				</div>
				<div class="form-group">
					<label>메모</label>
					<textarea rows="1" name="memo" maxlength="15" class="form-control" placeholder="(15자 제한)"></textarea>
				</div>
			</form>
	      </div>
	    
	      <div class="modal-footer">
			<button class="btn" id="btn-add-trans" style="background-color: #ac7339; color: #ffffff;">이동등록</button>
			<button class="btn" id="btn-modify-trans" style="background-color: #ac7339; color: #ffffff;">이동수정</button>
	      </div>
	    
	    </div>
	  </div>
	</div>	

	<!-- Modal(일정/숙박) -->
	<div id="dailyModal" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	    <!-- Modal content-->
	    <div class="modal-content">
	    
	      <div class="modal-header" style="background-color: #ac7339; color: #ffffff;">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title" id="tour-title"><span class="glyphicon glyphicon-plus">일정추가</span></h4>
	        <h4 class="modal-title" id="accom-title"><span class="glyphicon glyphicon-pencil">숙박정보</span></h4>
	      </div>
	    
	      <div class="modal-body">
	      	<table class="table" id="tour-body">
	      		<tbody></tbody>
	      	</table>
	      	<table class="table" id="accom-body">
	      		<tbody></tbody>
	      	</table>
	      </div>
	    
	      <div class="modal-footer">
      		<div id="tour-pagination" class="text-center"></div>
      		<div id="accom-pagination" class="text-center"></div>
	      </div>
	    
	    </div>
	  </div>
	</div>	

</div>
<jsp:include page="../include/footer.jsp" />	
</body>
<script>
	var initBody;
	
	function beforePrint() {
		boxes = document.body.innerHTML;
		document.body.innerHTML = box.innerHTML;
	}
	function afterPrint() {
		document.body.innerHTML = boxes;
	}
	function printArea() {
		window.print();
	};
	
	window.onbeforeprint = beforePrint;
	window.onafterprint = afterPrint;	
	
</script>
<script>
$(function() {	

	//공용변수
	var pno = $('#pno').text();
	var isWriter = $('#isWriter').text();
	var totalCnt;		//전체 컨텐츠 수
	var totalPageNo;	//전체 페이지수 (컨텐츠수 / 10)
	var totalBlocks;	//전체 블록수 (페이지수/nav 반올림)
	var currentBlock;	//현재 블록
	var beginModalPage;	//시작 페이지
	var endModalPage;	//끝 페이지
	var currentAreaCode;
	var currentsigunguCode;
	var currentModalPageNo = 1;
	var nav = 5;	
	var dailyNo;
	
	//페이지 준비됐을 때, 우선 교통/일정/숙박모달내용 가리고 비우기
	var $ttitle = $('#tour-title').hide();
	var $tbody = $('#tour-body').hide();
	var $atitle = $('#accom-title').hide();
	var $abody = $('#accom-body').hide();
	var $tfooter = $('#tour-pagination').hide();
	var $afooter = $('#accom-pagination').hide();
	var $aTTitle = $('#transModal').find('h4[id="trans-atitle"]').hide();
	var $mTTitle = $('#transModal').find('h4[id="trans-mtitle"]').hide();
	var $sLocation = $('#transModal').find('select[name="startLocation"]').empty();
	var $sTime = $('#transModal').find('input[name="startTime"]').val("");	
	var $tranCtgr = $('#transModal').find('select[name="category"]');
	var $eLocation = $('#transModal').find('select[name="endLocation"]').empty();
	var $eTime = $('#transModal').find('input[name="endTime"]').val("");	
	var $tMemo = $('#transModal').find('textarea[name="memo"]').val("");
	var $aTrans = $('#btn-add-trans').hide();
	var $mTrans = $('#btn-modify-trans').hide();
	var $transHiddenKey = $('#trans-hidden-key');

	if(isWriter == 'false') {
		document.getElementById('box').addEventListener("click",handler,true);
	}
	function handler(e){
		e.stopPropagation();
		e.preventDefault();
	}
	
	//교통편 Modal 꺼질 때마다 모달 내용 지우기
	$('#transModal').on('hide.bs.modal',function(){	
		$aTTitle.hide();
		$mTTitle.hide();
		$sLocation.empty();
		$sTime.val("");
		$tranCtgr.val("");
		$eLocation.empty();
		$eTime.val("");
		$tMemo.val("");
		$aTrans.hide();
		$mTrans.hide();
	});
	
	//관광/ 숙박 Modal 꺼질때마다 api 리스트 표시되는 modal body 지우기
	$('#dailyModal').on('hide.bs.modal',function(){
		$tbody.find('tbody').empty();
		$abody.find('tbody').empty();
		$tfooter.empty();
		$afooter.empty();
		currentModalPageNo = 1;
	});			
	
	// 일자별로 행 생성하기
	$('tr[id^=daily-]').each(function() {
		var $tr = $(this);
		var keyword = $tr.attr('id').replace('daily-', ''); //daily키
		var $pno = $('#pno').text();
		
		$.ajax({
			type: 'GET',
			url: 'dailyList.do',
			data: {key:keyword},
			dataType: 'json',
			success: function(result){
				var locations = result.locations;			//List<PlannerLocation>
				var transportations = result.transportations//List<TransLocation>
				var tours = result.tours;					//List<DailyTour>
				var hotels = result.hotels;					//List<DailyHotel>
				
				// 해당일 지역목록
				var row1 = "";
				if(locations.lenth != 0){
					for(var i=0; i<locations.length; i++) {
						row1 += "<p style='margin-bottom: 0px;'>"+locations[i].locationName+"</p>";
						var code = locations[i].locationCode.split(".");
					}
				}
				$tr.find("td:eq(2)").append(row1);

				// 해당일 이동수단 목록
				var row2 = "";
				if (transportations.length != 0) {
					for(var i=0; i<transportations.length; i++){
						row2 += "<p id='modify-trans-"+transportations[i].transKey+"'>";
						row2 += transportations[i].startLocation;
						if(transportations[i].category == 'ETC'){
							row2 += "<label class='label label-default'>이동</label>";	
						}
						if(transportations[i].category == 'AIR'){
							row2 += "<label class='label label-primary'>항공</label>";							
						}
						if(transportations[i].category == 'TRAIN'){
							row2 += "<label class='label label-success'>기차</label>";							
						}
						if(transportations[i].category == 'TAXI'){
							row2 += "<label class='label label-warning'>택시</label>";							
						}
						if(transportations[i].category == 'BUS'){
							row2 += "<label class='label label-danger'>버스</label>";							
						}	
						row2 += transportations[i].endLocation;
						row2 += " <a href='delTrans.do?pno="+$pno+"&tKey="+transportations[i].transKey+"'><span class='glyphicon glyphicon-remove none-print' style='color: #b3b3b3;'></span></a>";
						row2 += "</p>";
					}
				}
				row2 += "<button id='add-trans-"+keyword+"' class='btn btn-xs btn-default none-print'><span class='glyphicon glyphicon-plus'></span>이동추가</button>";					
				$tr.find("td:eq(3)").append(row2);
				
				// 해당일 관광 목록
				var row3 = "";
				if (tours.length != 0) {
					for(var i=0; i<tours.length; i++) {
						row3 += "<p>"+tours[i].title;
						row3 += "<a href='delTour.do?pno="+pno+"&tKey="+tours[i].tourKey+"'>";
						row3 += "<span class='glyphicon glyphicon-remove none-print' style='color: #b3b3b3;'></span>";
						row3 += "</a>";
						row3 += "</p>";
					}
				}
				if(locations.length != 0){
					for (var i=0; i<locations.length; i++) {
						row3 += "<p><button id='add-tour-"+locations[i].locationCode+"' class='btn btn-xs btn-default none-print'><span class='glyphicon glyphicon-plus'></span>"+locations[i].locationName+"관광정보</button></p>";					
					}
				}
				$tr.find("td:eq(4)").append(row3);
				
				// 해당일 숙박 목록
				var row4 = "";
				if (hotels.length != 0) {
					for(var i=0; i<hotels.length; i++){
						row4 += "<p>"+hotels[i].title+"("+hotels[i].term+"박)";
						row4 += "<a href='delHotel.do?pno="+pno+"&hkey="+hotels[i].hotelKey+"'>";
						row4 += "<span class='glyphicon glyphicon-remove none-print' style='color: #b3b3b3;'></span>";
						row4 += "</a>";
						row4 += "</p>";
					}
				}
				if(locations.length != 0){
					for (var i=0; i<locations.length; i++) {
						row4 += "<p><button id='add-accom-"+locations[i].locationCode+"' class='btn btn-xs btn-default none-print'><span class='glyphicon glyphicon-pencil'></span>"+locations[i].locationName+"숙박정보</button></p>";					
					}
				}
				row4 += "<p><button id='accom-form-"+keyword+"' class='btn btn-xs none-print' style='display: block; background-color: #c68c53; color: #ffffff;'><span class='glyphicon glyphicon-pencil'></span>직접입력</button></p>";					
				row4 += "<form class='well' id='accomForm-"+keyword+"' method='post' action='addHotel.do' style='display: none'>";
				row4 += "<input type='hidden' name='pno' value='"+pno+"' />"; 
				row4 += "<input type='hidden' name='key' value='"+keyword+"' />"; 
				row4 += "<div class='form-group'>";
				row4 += "<label style='color: #ac7339;'>숙소명</label>";
				row4 += "<input type='text' name='title' class='form-control' maxlength='16' placeholder='(15자제한)'/></div>";
				row4 += "<div class='form-group'>";
				row4 += "<label style='color: #ac7339;'>숙박일수 (무박의 경우 '0')</label>";
				row4 += "<input type='number' name='term' class='form-control' min='0' value='1'></div>";
				row4 += "<div class='text-right'><button class='btn btn-xs btn-default' id='insert-accom-"+keyword+"' style='color: #ac7339;'>숙박등록</button></div>";
				row4 += "</form>";
				$tr.find("td:eq(5)").append(row4);
			}
		})
	});		
	
	//리스트에서 기존에 등록해놓은 이동수단을 클릭했을 경우
	$('.daily-table tbody').on('click', '[id^=modify-trans-]', function() {	
		var transKey = $(this).attr('id').replace('modify-trans-','').trim(); //trans키
		$mTTitle.show();		
		$mTrans.show();
		$transHiddenKey.val(transKey);	//수정일때는 trans키 넣기
		
		$.ajax({
			type: 'GET',
			url: 'getTrans.do',
			data: {key: transKey},
			dataType: 'json',
			success: function(result) {
				var orgTrans = result.orgTrans;	// 기존의 이동수단
				var orgLocations = result.orgLocations; // 해당일에 이동가능한 지역목록
				
				var rows = "";
				rows += "<option value=''>::지역을 선택하세요::</option>";
				$.each(orgLocations, function(index, olo) {
					rows += "<option value='"+olo.locationId+"'>"+olo.locationName+"</option>";
				});
				$sLocation.append(rows);
				$eLocation.append(rows);	
				
				$sLocation.val(orgTrans.startlocationId);
				$eLocation.val(orgTrans.endlocationId);
				$tranCtgr.val(orgTrans.category);
				if(orgTrans.startTime != null) {
					$sTime.val(orgTrans.startTime);
				}
				if(orgTrans.endTime != null) {
					$eTime.val(orgTrans.endTime);
				}
				if(orgTrans.memo != null) {
					$tMemo.val(orgTrans.memo);
				} 
			}
		});
		$('#transModal').modal('show');
	});

	// 이동 이동수정 버튼을 클릭한 경우
	$mTrans.on('click', function() {
		if($sLocation.val() == ""){
			alert('출발지역을 선택하세요.');
			return false;
		}
		if($tranCtgr.val() == ""){
			alert('이동수단을 선택하세요.');
			return false;
		}
		if($eLocation.val() == ""){
			alert('도착지역을 선택하세요.');
			return false;
		}
		$('#trans-form').attr('action', 'modifyTrans.do');
		$('#trans-form').submit();
	});	
	
	//리스트에서 이동추가 클릭했을 경우 (출발지/도착지 전체범위)
	$('.daily-table tbody').on('click', '[id^=add-trans-]', function() {
		var keyword = $(this).attr('id').replace('add-trans-','').trim(); //데일리키
		$aTTitle.show();		
		$aTrans.show();
		$transHiddenKey.val(keyword);	//신규등록일때는 데일리키넣기
		
		$.ajax({
			type: 'GET',
			url: 'getCities.do',
			data:{key: keyword},
			dataType: 'json',
			success: function(result){
				var pLocations = result;
				
				var rows = "";
				rows += "<option value=''>::지역을 선택하세요::</option>";
				$.each(pLocations, function(index, plo) {
					rows += "<option value='"+plo.locationId+"'>"+plo.locationName+"</option>";
				});
				$sLocation.append(rows);
				$eLocation.append(rows);
			}
		});
		$('#transModal').modal('show');		
	});	
	
	// 이동 이동등록 버튼을 클릭한 경우
	$aTrans.on('click', function() {
		if($sLocation.val() == ""){
			alert('출발지역을 선택하세요.');
			return false;
		}
		if($tranCtgr.val() == ""){
			alert('이동수단을 선택하세요.');
			return false;
		}
		if($eLocation.val() == ""){
			alert('도착지역을 선택하세요.');
			return false;
		}
		$('#trans-form').attr('action', 'addTrans.do');
		$('#trans-form').submit();
	});
	
	//리스트에서 +일정추가를 클릭했을 경우 modal show()
	$('.daily-table tbody').on('click', '[id^=add-tour-]', function() {
		dailyNo = $(this).parents('tr').attr('id').replace('daily-', '').trim(); // 데일리키
		$ttitle.show();
		$tbody.show();
		$tfooter.show();
		$atitle.hide();
		$abody.hide();
		$afooter.hide();
		$('#dailyModal').modal('show');
		
		//해당 지역 알아내기
		var locationCode = $(this).attr('id').replace('add-tour-','').trim().split(".");
		currentAreaCode = locationCode[0];
		currentsigunguCode = locationCode[1];
		getTourData();		
	});		
	
	//관광지api로 데이터 조회하기 (지역코드, 시군구코드, 페이지번호 사용)
	function getTourData() {
		$.ajax({
			type:'GET',
			url:'http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?'
				 +'MobileOS=ETC&'
				 +'MobileApp=AppTest&'
				 +'ServiceKey=MPb4CUSvtcuGivPnZ40jwAOelh5vfHPpZZhYVPadMz2vTZ1BuWcKp3721wDvCpeVe3LnQJEbVNLclZrvkMAG4A%3D%3D&'
				 +'_type=json&'
				 +'areaCode='+currentAreaCode
				 +'&sigunguCode='+currentsigunguCode
				 +'&pageNo='+currentModalPageNo,
			dataType:'json',
			success: function(result) {
	 				//빈칸만들기
					$tbody.find('tbody').empty();
					$tfooter.empty();
					location.href='#tour-title';

					var tourlist = result.response.body.items.item;
					totalCnt = result.response.body.totalCount;
					//$.isArray()는 해당 대상이 배열인지 아닌지를 t/f로 반환해준다.
					if (!$.isArray(tourlist)) {
						tourlist = [tourlist];
					}
					
					var rows = "";
					var pagination = "";
					$.each(tourlist, function(index, tour){
						var addr = '주소: ';
						var addr1 = tour.addr1;
						var addr2 = tour.addr2;
						if (addr1) {
							addr += addr1;
						}
						if (addr2) {
							addr += addr2;
						}
						if (addr1 == null && addr2 == null) {
							addr += "<a href='http://map.daum.net/' class='btn btn-xs btn-default'>위치검색</a>";
						}
					
						var image = tour.firstimage2; 
						if (!image) {
							image = "<img src='/resources/images/defaultTourImage.jpg' width='150px;' height='100px;'/>"; 
						} else {
							image = "<img src='"+tour.firstimage2+"' width='150px;' height='100px;'/>";
						}
						
						var tel = '연락처: ';
						var tel1 = tour.tel;
						if(tel1){
							tel += tel1;
						} else {
						}
						
						var title = tour.title;
						var code = tour.contentid;
						
						rows = "<tr>";
						rows += "<td style='width=180px; height=100px;'>"+image+"</td>";
						rows += "<td>";
						rows += "<p id='title'><strong>"+title+"</strong></p>";
						rows += "<p id='addr'>"+addr+"</p>";
						rows += "<p id='tel'>"+tel+"</p>";
						rows += "<button id='insert-tour-"+title+"' class='btn btn-xs pull-right' style='background-color: #c68c53; color: #ffffff;'><span class='glyphicon glyphicon-ok'></span>일정추가</button>";
						rows += "</td>";
						rows += "</tr>";
						$tbody.find('tbody').append(rows);
					});
					
					//pagination 
					totalPageNo = Math.ceil(totalCnt/10);
					totalBlocks = Math.ceil(totalPageNo/nav);
					currentBlock = Math.ceil(currentModalPageNo/nav);
					beginModalPage = ((currentBlock-1)*nav)+1;
					endModalPage = currentBlock*nav;
					
					pagination = "<nav>";
				    pagination += "<ul class='pagination'>";
					if(currentBlock != 1){
					    pagination += "<li><a href='#' aria-label='Previous'>";
					    pagination += "<span aria-hidden='true'>&laquo;</span></a></li>";
					}
					if(currentBlock == totalBlocks) {
						beginModalPage = ((totalBlocks-1)*nav)+1;
						endModalPage = totalPageNo;
					}
					for (var i=beginModalPage; i<=endModalPage; i++) {
						if (currentModalPageNo == i){
							pagination += "<li><a href='#' class='active'>"+i+"</a></li>";
						} else {
							pagination += "<li><a href='#'>"+i+"</a></li>";
						}
					}
					if(currentBlock != totalBlocks){
					    pagination += "<li><a href='#' aria-label='Next'>";
					    pagination += "<span aria-hidden='true'>&raquo;</span></a></li>";
					}
				    pagination += "</ul></nav>";
				    $tfooter.append(pagination);			
				}
			});	
	}
	
	// #tour-pagination을 클릭한 경우
	$tfooter.on('click', 'a', function(){
		currentModalPageNo = $(this).text();
		getTourData();
		return false;
	});		
	$tfooter.on('click', 'a[aria-label="Previous"]', function(){
		currentBlock = currentBlock == 1 ? currentBlock : currentBlock-1;
		currentModalPageNo = ((currentBlock-1)*nav)+1;
		getTourData();
		return false;
	});		
	$tfooter.on('click', 'a[aria-label="Next"]', function(){
		currentBlock = currentBlock+1;
		currentModalPageNo = ((currentBlock-1)*nav)+1;
		getTourData();
		return false;
	});		
	
	//관광지 모달에서 일정추가를 클릭한 경우
	$tbody.on('click', 'button[id^=insert-tour-]', function() {
		var tourTitle = $(this).attr('id').replace('insert-tour-', '').trim();
		var row = "";
		$.ajax({
			type: 'POST',
			url: 'insertTour.do',
			data: {key: dailyNo, tTitle: tourTitle},
			dataType: 'json',
			success: function(dailyTour) {
				row += "<p>"+dailyTour.title;
				row += "<a href='delTour.do?pno="+pno+"&tKey="+dailyTour.tourKey+"'>";
				row += "<span class='glyphicon glyphicon-remove' style='color: #b3b3b3;'></span>";
				row += "</a>";
				row += "</p>";	
				$('.daily-table tbody').find('tr[id="daily-'+dailyTour.key+'"]').find('td:eq(4)').find('button:eq(0)').before(row);
			}
		});
	});
	
	//리스트에서 +숙소추가를 클릭했을 경우 modal show()
	$('.daily-table tbody').on('click', '[id^=add-accom-]', function() {
		dailyNo = $(this).parents('tr').attr('id').replace('daily-', '').trim(); // 데일리키		
		$ttitle.hide();
		$tbody.hide();
		$tfooter.hide();		
		$atitle.show();
		$abody.show();
		$afooter.show();		
		$('#dailyModal').modal('show');
		
		//해당 지역 알아내기
		var locationCode = $(this).attr('id').replace('add-accom-','').trim().split(".");
		currentAreaCode = locationCode[0];
		currentsigunguCode = locationCode[1];
		getAccomData();	
	});	
	
	//숙박업소api로 데이터 조회하기 (지역코드, 시군구코드, 페이지번호 사용)
	function getAccomData() {
		$.ajax({
			type:'GET',
			url:'http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchStay?'
				+'serviceKey=MPb4CUSvtcuGivPnZ40jwAOelh5vfHPpZZhYVPadMz2vTZ1BuWcKp3721wDvCpeVe3LnQJEbVNLclZrvkMAG4A%3D%3D&'
				+'MobileOS=ETC&'
				+'MobileApp=AppTest&'
				+'_type=json'
				+'&areaCode='+currentAreaCode
				+'&sigunguCode='+currentsigunguCode
				+'&pageNo='+currentModalPageNo,
			dataType:'json',
			success: function(result) {
				//빈칸만들기
 				$abody.find('tbody').empty();
 				$afooter.empty();
				location.href='#accom-title'; 
				
				var accomlist = result.response.body.items.item;
				totalCnt = result.response.body.totalCount;
				if (!$.isArray(accomlist)) {
					accomlist = [accomlist];
				}
				
				var rows = "";
				var pagination = "";	
				$.each(accomlist, function(index, accom){
					var addr = '주소: ';
					var addr1 = accom.addr1;
					var addr2 = accom.addr2;
					if (addr1) {
						addr += addr1;
					}
					if (addr2) {
						addr += addr2;
					}
					if (addr1 == null && addr2 == null) {
						addr += "<a href='http://map.daum.net/' class='btn btn-xs btn-default'>위치검색</a>";
					}
				
					var image = accom.firstimage2; 
					if (!image) {
						image = "<img src='/resources/images/defaultTourImage.jpg' width='150px;' height='100px;'/>"; 
					} else {
						image = "<img src='"+accom.firstimage2+"' width='150px;' height='100px;'/>";
					}
					
					var tel = '연락처: ';
					var tel1 = accom.tel;
					if(tel1){
						tel += tel1;
					} else {
						tel += '등록된 연락처가 존재하지 않습니다.';
					}
					
					var title = accom.title;
					var code = accom.contentid;
					
					rows = "<tr id='"+code+"'>";
					rows += "<td style='width=180px; height=100px;'>"+image+"</td>";
					rows += "<td>";
					rows += "<p id='title'><strong>"+title+"</strong></p>";
					rows += "<p id='addr'>"+addr+"</p>";
					rows += "<p id='tel'>"+tel+"</p>";
					rows += "<a href='https://www.agoda.com/ko-kr/?cid=1430285&tag=911ebde7-5036-68"
							+"5e-58fa-9c8b7e2e4bdb&gclid=CjwKCAjwiurXBRAnEiwAk2GFZg7TC8xg1PfacRdtikxB"
							+"EM0drg5W5hEb3dMLjPG8Be-NWQoNZpQtuxoCYhcQAvD_BwE' "
							+"target='_blank' class='btn btn-xs pull-right' style='background-color: #c68c53; color: #ffffff;'>숙소예약</a>";
					rows += "</td>";
					rows += "</tr>";
					$abody.find('tbody').append(rows);
				});
				
				//pagination 
				totalPageNo = Math.ceil(totalCnt/10);
				totalBlocks = Math.ceil(totalPageNo/nav);
				currentBlock = Math.ceil(currentModalPageNo/nav);
				beginModalPage = ((currentBlock-1)*nav)+1;
				endModalPage = currentBlock*nav;
				
				pagination = "<nav>";
			    pagination += "<ul class='pagination'>";
				if(currentBlock != 1){
				    pagination += "<li><a href='#' aria-label='Previous'>";
				    pagination += "<span aria-hidden='true'>&laquo;</span></a></li>";
				}
				if(currentBlock == totalBlocks) {
					beginModalPage = ((totalBlocks-1)*nav)+1;
					endModalPage = totalPageNo;
				}
				for (var i=beginModalPage; i<=endModalPage; i++) {
					if (currentModalPageNo == i){
						pagination += "<li><a href='#' class='active'>"+i+"</a></li>";
					} else {
						pagination += "<li><a href='#'>"+i+"</a></li>";
					}
				}
				if(currentBlock != totalBlocks){
				    pagination += "<li><a href='#' aria-label='Next'>";
				    pagination += "<span aria-hidden='true'>&raquo;</span></a></li>";
				}
			    pagination += "</ul></nav>";
			    $afooter.append(pagination);					
			}
		});
	}	
	
	// #accom-pagination을 클릭한 경우
	$afooter.on('click', 'a', function(){
		currentModalPageNo = $(this).text();
		getAccomData();
		return false;
	});		
	$afooter.on('click', 'a[aria-label="Previous"]', function(){
		currentBlock = currentBlock == 1 ? currentBlock : currentBlock-1;
		currentModalPageNo = ((currentBlock-1)*nav)+1;
		getAccomData();
		return false;
	});		
	$afooter.on('click', 'a[aria-label="Next"]', function(){
		currentBlock = currentBlock == totalBlocks ? currentBlock : currentBlock+1;
		currentModalPageNo = ((currentBlock-1)*nav)+1;
		getAccomData();
		return false;
	});		
	
	//리스트에서 숙박 직접입력 버튼을 클릭했을 경우
	$('.daily-table tbody').on('click', '[id^=accom-form-]', function() {
		var dkey = $(this).attr('id').replace('accom-form-','').trim();
		$('.daily-table tbody').find('form[id^=accomForm-]').attr('style', 'display: none');
		$('.daily-table tbody').find('form[id=accomForm-'+dkey+']').attr('style', 'display: block');
	});

	//직접입력한 숙박정보를 등록하는 경우
	$('.daily-table tbody').on('click', 'buttom[id^=insert-accom-]', function() {
		var keyword = $(this).attr('id').replace('insert-accom-', '').trim();
		var form = $('#accomForm-'+keyword);
		var title = form.find('input[name=title]').val();
		if(title == ''){
			alert('숙소명을 입력하세요.');
			return false;
		}
		form.submit();
	});
	
})
</script>
</html>