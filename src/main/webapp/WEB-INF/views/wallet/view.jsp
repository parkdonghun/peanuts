<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>ddangkong planer</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
  <style type="text/css">
  .active { font-weight:bold;}
  </style>
</head>
<body>
	<jsp:include page="../include/header.jsp" />
	<jsp:include page="../include/top.jsp" />
	<div class="container" style="width: 60%; min-height: 740px; margin-bottom: 80px; margin-top: 50px;">
		<div class="row">
			<ul class="nav nav-tabs" id="plan-tab">
				<li class="active"><a data-toggle="tab" href="#home" style="color: #b33c00">한눈에보기</a></li>
				<c:forEach var="day" items="${days }">				
					<li><a data-toggle="tab" href="#menu${day.key}" target="_blank" style="color: #b33c00">${day.month}월
							${day.day }일</a></li>
				</c:forEach>

			</ul>
		</div>
		<div class="tab-content">
			<div id="home" class="tab-pane fade in active">
				<div class="row">
					<div id="chart-table" class="col-sm-6"
						style="height: 370px; width: 50%; margin-top: 80px;"></div>
						
					<div id="total-table" class="col-sm-6 tab-pane fade in active"
						style="width: 35%; margin-left: 5%">

						<div style="margin-top: 20px;">
							<span class="glyphicon glyphicon-ok"></span> 합계 <strong><span
								class="pull-right" id="total-sub" style="font-size: 20px;">0</span></strong>
						</div>
						<hr />
						<div id="wallet-cost">
							<div class="panel panel-default">
								<div class="panel-heading">
									<span class="glyphicon glyphicon-home"></span> 숙소
									<button id="btn-view" class="btn btn-default btn-xs pull-right">
										<span class="glyphicon glyphicon-chevron-down"></span>
									</button>
									<strong><span class="pull-right" id="hotel-sub-cost">0</span></strong>
								</div>
								<div class="panel-body" id="panelbody-hotel">
									<table class="table-condensed" id="hotel-table"
										style="font-size: 13px">
										<colgroup>
											<col width="75%">
											<col width="*">
										</colgroup>
										<tbody>
											<c:forEach var="item" items="${wallet}">
												<c:choose>
													<c:when test="${item.category == 'HOTEL' }">
														<tr>
															<td>${item.title }</td>
															<td class="pull-right"><span><fmt:formatNumber value="${item.money }" pattern="#,###"/></span>원</td>
														</tr>
													</c:when>
												</c:choose>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
							<div class="panel panel-default">
								<div class="panel-heading">
									<span class="glyphicon glyphicon-road"></span> 교통
									<button id="btn-view" class="btn btn-default btn-xs pull-right">
										<span class="glyphicon glyphicon-chevron-down"></span>
									</button>
									<strong><span class="pull-right" id="trans-sub-cost">0</span></strong>
								</div>
								<div class="panel-body" id="panelbody-trans">
									<table class="table-condensed" id="trans-table"
										style="font-size: 13px">
										<colgroup>
											<col width="75%">
											<col width="*">
										</colgroup>
										<tbody>
											<c:forEach var="item" items="${wallet}">
												<c:choose>
													<c:when test="${item.category == 'TRANS' }">
														<tr>
															<td>${item.title }</td>
															<td class="pull-right"><span><fmt:formatNumber value="${item.money }" pattern="#,###"/></span>원</td>
														</tr>
													</c:when>
												</c:choose>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>

							<div class="panel panel-default">
								<div class="panel-heading">
									<span class="glyphicon glyphicon-globe"></span> 관광
									<button id="btn-view" class="btn btn-default btn-xs pull-right">
										<span class="glyphicon glyphicon-chevron-down"></span>
									</button>
									<strong><span class="pull-right" id="tour-sub-cost">0</span></strong>
								</div>
								<div class="panel-body" id="panelbody-tour">
									<table class="table-condensed" id="tour-table"
										style="font-size: 13px">
										<colgroup>
											<col width="75%">
											<col width="*">
										</colgroup>
										<tbody>
											<c:forEach var="item" items="${wallet}">
												<c:choose>
													<c:when test="${item.category == 'TOUR' }">
														<tr>
															<td>${item.title }</td>
															<td class="pull-right"><span><fmt:formatNumber value="${item.money }" pattern="#,###"/></span>원</td>
														</tr>
													</c:when>
												</c:choose>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>

							<div class="panel panel-default">
								<div class="panel-heading">
									<span class="glyphicon glyphicon-cutlery"></span> 식비
									<button id="btn-view" class="btn btn-default btn-xs pull-right">
										<span class="glyphicon glyphicon-chevron-down"></span>
									</button>
									<strong><span class="pull-right" id="food-sub-cost">0</span></strong>
								</div>
								<div class="panel-body" id="panelbody-food">
									<table class="table-condensed" id="food-table"
										style="font-size: 13px">
										<colgroup>
											<col width="75%">
											<col width="*">
										</colgroup>
										<tbody>
											<c:forEach var="item" items="${wallet}">
												<c:choose>
													<c:when test="${item.category == 'FOOD' }">
														<tr>
															<td>${item.title }</td>
															<td class="pull-right"><span><fmt:formatNumber value="${item.money }" pattern="#,###"/></span>원</td>
														</tr>
													</c:when>
												</c:choose>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>

							<div class="panel panel-default">
								<div class="panel-heading">
									<span class="glyphicon glyphicon-shopping-cart"></span> 쇼핑
									<button id="btn-view" class="btn btn-default btn-xs pull-right">
										<span class="glyphicon glyphicon-chevron-down"></span>
									</button>
									<strong><span class="pull-right" id="shop-sub-cost">0</span></strong>
								</div>
								<div class="panel-body" id="panelbody-shop">
									<table class="table-condensed" id="shop-sub-cost"
										style="font-size: 13px">
										<colgroup>
											<col width="75%">
											<col width="*">
										</colgroup>
										<tbody>
											<c:forEach var="item" items="${wallet}">
												<c:choose>
													<c:when test="${item.category == 'SHOP' }">
														<tr>
															<td>${item.title }</td>
															<td class="pull-right"><span><fmt:formatNumber value="${item.money }" pattern="#,###"/></span>원</td>
														</tr>
													</c:when>
												</c:choose>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>

							<div class="panel panel-default">
								<div class="panel-heading">
									<span class="glyphicon glyphicon-folder-close"></span> Etc.
									<button id="btn-view" class="btn btn-default btn-xs pull-right">
										<span class="glyphicon glyphicon-chevron-down"></span>
									</button>
									<strong><span class="pull-right" id="etc-sub-cost">0</span></strong>
								</div>
								<div class="panel-body" id="panelbody-etc">
									<table class="table-condensed" id="etc-sub-cost"
										style="font-size: 13px">
										<colgroup>
											<col width="75%">
											<col width="*">
										</colgroup>
										<tbody>
											<c:forEach var="item" items="${wallet}">
												<c:choose>
													<c:when test="${item.category == 'ETC' }">
														<tr>
															<td>${item.title }</td>
															<td class="pull-right"><span><fmt:formatNumber value="${item.money }" pattern="#,###"/></span>원</td>
														</tr>
													</c:when>
												</c:choose>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<c:forEach var="daily" items="${days }">
			<p style="display: none" id="isWriter">${isWriter }</p>
				<div id="menu${daily.key }" class="tab-pane fade" style="margin-top: 30px;">
				<div class="row" style="margin-bottom: 20px;">
					<strong>숙박과 교통 카테고리는 금액 및 메모 수정만 가능합니다. (일정표에서 입력 가능)</strong>
				</div>
					<div id="daily-cost">
						<div class="panel-group">
							<div class="row">
							<div class="col-sm-5" style="margin-right: 80px;">
								<div class="panel">
									<div class="panel-heading"
										style="background-color: #4775d1; color: white;">
										<span class="glyphicon glyphicon-home"></span> 숙소
										<strong><span class="pull-right" id="daily-hotel-sub">0
										</span></strong>
									</div>
									<div class="panel-body">
										<table class="table-condensed" style="font-size: 13px">
											<tbody>
												<c:forEach var="dailyWallet" items="${wallet }">
													<c:choose>
														<c:when
															test="${dailyWallet.daily == daily.key and dailyWallet.category == 'HOTEL'}">
															<tr>
																<td>${dailyWallet.title }</td>
																<td class="pull-right"><span><fmt:formatNumber value="${dailyWallet.money }" pattern="#,###"/></span>원</td>
																<td style="color: gray;">${dailyWallet.memo }</td>
																<td class="notUser"><button	id="modify${dailyWallet.walletKey }" class="btn btn-default btn-xs">
																	<span class="glyphicon glyphicon-pencil"></span>
																	</button>
																</td>
															</tr>
														</c:when>
													</c:choose>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
							</div>
							<div class="col-sm-5" style="margin-right: 80px;">
								<div class="panel">
									<div class="panel-heading"
										style="background-color: #a72b25; color: white;">
										<span class="glyphicon glyphicon-road"></span> 교통
										<strong><span class="pull-right">0원</span></strong>
									</div>
									<div class="panel-body">
										<table class="table-condensed" style="font-size: 13px">
											<tbody>
												<c:forEach var="dailyWallet" items="${wallet }">
													<c:choose>
														<c:when
															test="${dailyWallet.daily == daily.key and dailyWallet.category == 'TRANS'}">
															<tr>
																<td>${dailyWallet.title }</td>
																<td><span><fmt:formatNumber value="${dailyWallet.money }" pattern="#,###"/></span>원</td>
																<td style="color: gray;">${dailyWallet.memo }</td>
																<td class="notUser"><button	id="modify${dailyWallet.walletKey }" class="btn btn-default btn-xs">
																	<span class="glyphicon glyphicon-pencil"></span>
																	</button>
																</td>
															</tr>
														</c:when>
													</c:choose>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
							</div>
							</div>
						<hr />

							<div class="row">
							<div class="col-sm-5" style="margin-right: 80px;">
								<div class="panel">
									<div class="panel-heading"
										style="background-color: #00b3b3; color: white;">										
										<span class="glyphicon glyphicon-home"></span> 관광
										<button id="btn-plus-TOUR"
											class="btn btn-default btn-xs pull-right">
											<span class="glyphicon glyphicon-plus"></span>
										</button>
										<strong><span class="pull-right" id="daily-hotel-sub">0
										</span></strong>
									</div>
									<div class="panel-body">
										<table class="table-condensed" style="font-size: 13px">
											<tbody>
												<c:forEach var="dailyWallet" items="${wallet }">
													<c:choose>
														<c:when
															test="${dailyWallet.daily == daily.key and dailyWallet.category == 'TOUR'}">
															<tr>
																<td>${dailyWallet.title }</td>
																<td><span><fmt:formatNumber value="${dailyWallet.money }" pattern="#,###"/></span>원</td> 
																<td style="color: gray;">${dailyWallet.memo }</td>
																<td class="notUser"><button	id="modify${dailyWallet.walletKey }" class="btn btn-default btn-xs">
																	<span class="glyphicon glyphicon-pencil"></span>
																	</button>
																	<a href="del.do?pno=${dailyWallet.planNo }
																				&dno=${dailyWallet.daily}
																				&keyno=${dailyWallet.walletKey}"
																			 	class="btn btn-default btn-xs">
																			 	<span class="glyphicon glyphicon-remove"></span>
																	</a>
																</td>															
															</tr>
														</c:when>
													</c:choose>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
							</div>
							<div class="col-sm-5" style="margin-right: 80px;">
								<div class="panel">
									<div class="panel-heading"
										style="background-color: #39ac39; color: white;">
										<span class="glyphicon glyphicon-road"></span> 식비
										<button id="btn-plus-FOOD"
											class="btn btn-default btn-xs pull-right">
											<span class="glyphicon glyphicon-plus"></span>
										</button>
										<strong><span class="pull-right">0원</span></strong>
									</div>
									<div class="panel-body">
										<table class="table-condensed" style="font-size: 13px">
											<tbody>
												<c:forEach var="dailyWallet" items="${wallet }">
													<c:choose>
														<c:when
															test="${dailyWallet.daily == daily.key and dailyWallet.category == 'FOOD'}">
															<tr>
																<td>${dailyWallet.title }</td>
																<td><span><fmt:formatNumber value="${dailyWallet.money }" pattern="#,###"/></span>원</td>
																<td style="color: gray;">${dailyWallet.memo }</td>
																<td class="notUser"><button	id="modify${dailyWallet.walletKey }" class="btn btn-default btn-xs">
																	<span class="glyphicon glyphicon-pencil"></span>
																	</button>
																	<a href="del.do?pno=${dailyWallet.planNo }
																				&dno=${dailyWallet.daily}
																				&keyno=${dailyWallet.walletKey}"
																			 	class="btn btn-default btn-xs">
																			 	<span class="glyphicon glyphicon-remove"></span>
																	</a>
																</td>
															</tr>
														</c:when>
													</c:choose>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
							</div>
							</div>						
						<hr />
						
							<div class="row">
							<div class="col-sm-5" style="margin-right: 80px;">
								<div class="panel">
									<div class="panel-heading"
										style="background-color: #5f00b3; color: white;">										
										<span class="glyphicon glyphicon-home"></span> 쇼핑
										<button id="btn-plus-SHOP"
											class="btn btn-default btn-xs pull-right">
											<span class="glyphicon glyphicon-plus"></span>
										</button>
										<strong><span class="pull-right" id="daily-hotel-sub">0
										</span></strong>
									</div>
									<div class="panel-body">
										<table class="table-condensed" style="font-size: 13px">
											<tbody>
												<c:forEach var="dailyWallet" items="${wallet }">
													<c:choose>
														<c:when
															test="${dailyWallet.daily == daily.key and dailyWallet.category == 'SHOP'}">
															<tr>
																<td>${dailyWallet.title }</td>
																<td><span><fmt:formatNumber value="${dailyWallet.money }" pattern="#,###"/></span>원</td>
																<td style="color: gray;">${dailyWallet.memo }</td>
																<td class="notUser"><button	id="modify${dailyWallet.walletKey }" class="btn btn-default btn-xs">
																	<span class="glyphicon glyphicon-pencil"></span>
																	</button>
																	<a href="del.do?pno=${dailyWallet.planNo }
																				&dno=${dailyWallet.daily}
																				&keyno=${dailyWallet.walletKey}"
																			 	class="btn btn-default btn-xs">
																			 	<span class="glyphicon glyphicon-remove"></span>
																	</a>
																</td>
															</tr>
														</c:when>
													</c:choose>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
							</div>
							<div class="col-sm-5" style="margin-right: 80px;">
								<div class="panel">
									<div class="panel-heading"
										style="background-color: #00a3cc; color: white;">
										<span class="glyphicon glyphicon-road"></span> Etc
										<button id="btn-plus-ETC"
											class="btn btn-default btn-xs pull-right">
											<span class="glyphicon glyphicon-plus"></span>
										</button>
										<strong><span class="pull-right">0원</span></strong>
									</div>
									<div class="panel-body">
										<table class="table-condensed" style="font-size: 13px">
											<tbody>
												<c:forEach var="dailyWallet" items="${wallet }">
													<c:choose>
														<c:when
															test="${dailyWallet.daily == daily.key and dailyWallet.category == 'ETC'}">
															<tr>
																<td>${dailyWallet.title }</td>
																<td><span><fmt:formatNumber value="${dailyWallet.money }" pattern="#,###"/></span>원</td>
																<td style="color: gray;">${dailyWallet.memo }</td>
																<td class="notUser"><button	id="modify${dailyWallet.walletKey }" class="btn btn-default btn-xs">
																	<span class="glyphicon glyphicon-pencil"></span>
																	</button>
																	<a href="del.do?pno=${dailyWallet.planNo }
																				&dno=${dailyWallet.daily}
																				&keyno=${dailyWallet.walletKey}"
																			 	class="btn btn-default btn-xs">
																			 	<span class="glyphicon glyphicon-remove"></span>
																	</a>
																</td>
															</tr>
														</c:when>
													</c:choose>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
							</div>
							</div>												
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<jsp:include page="../include/footer.jsp" />

	<!-- Modal -->
	<div id="wallet-modal" class="modal fade" role="dialog">
		<div class="modal-dialog modal-sm">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header"
					style="background-color: #ac7339; color: white;">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">비용 등록</h4>
				</div>
				<div class="modal-body">
					<form class="form-group" id="plus-form" action="add.do" method="post">
						<div class="form-group">
							<input id="modal-pno" type="hidden" name="pno" value="${param.pno }" />
							<input id="modal-day" type="hidden" name="dayIndex" value="${param.dno }" />
							<input id="modal-category" type="hidden" name="category" value="" />
							<input id="modal-walletkey" type="hidden" name="walletkey" value="" />
						</div>
						<div class="form-group">
							<input type="hidden" value="">
							<label>제 목</label> <input type="text" class="form-control"
								name="title" placeholder="10글자 이하로 입력해주세요" maxlength="10" value="" />
						</div>
						<div class="form-group">
							<label>금 액</label> <input type="number" class="form-control"
								name="money" value="0" min="0" />
						</div>
						<div class="form-group">
							<label>메 모</label> <input type="text" class="form-control"
								name="memo" placeholder="10글자 이하로 입력해주세요" maxlength="10" value=""/>
						</div>
						<button
							class="btn btn-primary btn-xs" id="btn-add-wallet">등록</button>
						<button type="button" class="btn btn-default btn-xs" data-dismiss="modal">닫기</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">

	$(function() {
		
		var isWriter = $('#isWriter').text();
		if(isWriter == 'false') {
			$('td[class="notUser"]').hide();
			$('button[id^="btn-plus"]').hide();
		
		}
		// 페이지가 열릴 때 특정한 탭이 활성화되게 하기
		var dno = '${param.dno}';
		if (dno) {
			$('#plan-tab a[href="#menu'+dno+'"]').trigger('click')
		}
		
		//천단위 콤마 찍기
		function comma(str) {
	   		str = String(str);
	    	return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
		}
		//화살표 버튼 클릭 시 목록 펼치기
		$('div[id^="panelbody-"').hide();

		$('[id="btn-view"]').on(
				'click',
				function() {
					$(this).parent().siblings().toggle();
					var text = $(this).children().attr('class');
					if (text == 'glyphicon glyphicon-chevron-down') {
						$(this).children().removeClass();
						$(this).children().addClass(
								'glyphicon glyphicon-chevron-up');
					} else {
						$(this).children().removeClass();
						$(this).children().addClass(
								'glyphicon glyphicon-chevron-down');
					}
				});
		//한눈에 보기 카테고리별 비용합계 구하기
		$('#wallet-cost .panel').each(function(index, items) {
			var subcost = 0;
			$(this).find('tbody tr').each(function(index, item) {
				var cost = $(this).find('span').text().replace(/[^\d]+/g, '');
				subcost += parseInt(cost);
			});
			$(this).find('.panel-heading strong span').text(comma(subcost)+'원');
		});

		//한눈에 보기 비용 총합계 구하기
		var total = 0;
		$('#wallet-cost .panel-heading').each(function(index, item) {
			var amount = $(this).find('strong span').text().replace(/[^\d]+/g, '');
			total += parseInt(amount)
		});
		$('#total-sub').text(comma(total)+'원');

		//일별 카테고리별 비용합계 구하기
		$('#daily-cost .panel').each(function(index, items) {
			var subdaily = 0;
			$(this).find('tbody tr').each(function(index, item) {
				var cost = $(this).find('span').text().replace(/[^\d]+/g, '');
				subdaily += parseInt(cost);
			});
			
			$(this).find('.panel-heading strong span').text(comma(subdaily)+'원');
		});
		//날짜 탭 누를 때 날짜index 모달 input박스 담기
		$('a[href^="#menu"]').click(function(){
			var day = $(this).attr('href').replace('#menu', '');
			$('#modal-day').attr('value',day);
		});
		//일별 카테고리 구하고 모달 input박스에 담기
		$('button[id^="btn-plus-"]').click(function(){
			var category = $(this).attr('id').replace('btn-plus-', '');
			$('#modal-category').attr('value', category);
		});
		
		//modal 창 띄우는 이벤트 걸기
		$('[id^="btn-plus"]').click(function() {
			$('#plus-form').find('button:eq(0)').text('등록');
			$('#plus-form').attr('action','add.do');
			$('#wallet-modal').modal('show');
			
		});
		//modal 새 비용 추가 시 기존 쓰레기값 지우기
		$('#wallet-modal').on("hide.bs.modal", function(){
			$("[name=pno]").val('');
			$("[name=dayIndex]").val('');			
			$("[name=title]").val('');
			$("[name=money]").val('');
			$("[name=memo]").val('');		
		});
		//수정 modal 창 띄우는 이벤트 걸기
		$('button[id^="modify"').click(function(){
			var key = $(this).attr('id').replace('modify','');
			
			$.ajax({
				type: 'GET',
				url: "getmodal.do?keyno="+key,
				dataType: 'json',
				success: function(result){
					var wallet = result;
					
					$("[name=pno]").val(wallet.planNo);
					$("[name=dayIndex]").val(wallet.daily);
					$("[name=category]").val(wallet.category);
					$("[name=title]").val(wallet.title);
					$("[name=money]").val(wallet.money);
					$("[name=memo]").val(wallet.memo);
					$("[name=walletkey]").val(wallet.walletKey);	
					
					$('#plus-form').find('button:eq(0)').text('수정');
					$('#plus-form').attr('action','modify.do?keyno='+wallet.walletKey);
				}
			})
			$('#wallet-modal').modal('show');
			return false;
		});
		

		//차트 보여주기 이벤트

		window.onload = function() {
			var hotel = document.getElementById("hotel-sub-cost").innerHTML.replace(/[^\d]+/g, '');
			var trans = document.getElementById("trans-sub-cost").innerHTML.replace(/[^\d]+/g, '');
			var food = document.getElementById("food-sub-cost").innerHTML.replace(/[^\d]+/g, '');
			var shop = document.getElementById("shop-sub-cost").innerHTML.replace(/[^\d]+/g, '');
			var tour = document.getElementById("tour-sub-cost").innerHTML.replace(/[^\d]+/g, '');
			var etc = document.getElementById("etc-sub-cost").innerHTML.replace(/[^\d]+/g, '');

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
</html>