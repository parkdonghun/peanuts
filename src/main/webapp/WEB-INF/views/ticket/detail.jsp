<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title></title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
	img[name=lastImg]{
		-webkit-filter: grayscale(100%);
		filter: gray;
	}
	.progress {margin: 0px; padding: 0px;}
	.progress-bar {margin: 0px; padding: 0px;}
	.noContents {font-size: 20px; color: #ccc; margin-top: 25px; margin-bottom: 10px; letter-spacing: -4px; font-weight: lighter; text-align: center;}
	.noContents-bg {font-size: 40px; color: #ccc; margin-top: -15px; margin-bottom: 10px; letter-spacing: -4px; font-weight: lighter; text-align: center;}	
	#ticketDetailTabs a:link {text-decoration: none; color: #666;}
	#ticketDetailTabs a:hover {text-decoration: underline; color: #ac7339;}
	#qtyProduct::-webkit-inner-spin-button, #qtyProduct::-webkit-outer-spin-button {opacity: 1;}
	
	.pagination a:link {color: #737373; text-decoration: none;}
	.pagination a:visited {color: #737373; text-decoration: none;}
    .pagination a.selected {background-color: #c68c53; color: #ffffff;}
	.pagination a:hover:not(.selected) {color: #c68c53;}		
	[id^=miniUser-]:hover {text-decoration: underline; color: #ac7339;}
</style>
</head>
<body style="overflow-x: hidden;">
<jsp:include page="../include/header.jsp">
	<jsp:param value="ticket" name="header"/>
</jsp:include>
<div class="container" style="width: 60%; margin-bottom: 200px;">
	<div class="row">
		<div class="col-md-7">
			<hr style="border: 2px solid #ac7339; margin-top: 3px; margin-bottom: 10px;">
			<div>
				<img src="/resources/images/ticket/${ticket.topImages[0] }" class="big-box" width="100%" />
			</div>
			<div class="text-center" style="margin: 10px;">
				<c:forEach items="${ticket.topImages }" var="image">
					<a href="/resources/images/ticket/${image }"><img src="/resources/images/ticket/${image }" class="small-box" width="62" height="63" /></a> 				
				</c:forEach>
			</div>
			<hr style="border: 2px solid #ac7339; margin-top: 10px; margin-bottom: 10px;">
	
			<div style="padding: 10px; width: 636.05px;">
				<ul class="nav nav-tabs" id="ticketDetailTabs">
					<li class="active"><a data-toggle="tab" href="#home">상품설명</a></li>
					<li><a data-toggle="tab" href="#menu1">상품리뷰</a></li>
					<li><a data-toggle="tab" href="#menu2">상품문의</a></li>
				</ul>
				<div class="tab-content">
					<div id="home" class="tab-pane fade in active">
					<c:forEach items="${ticket.mainImages }" var="image">
						<img src="/resources/images/ticket/${image }" width="100%">
					</c:forEach>
					</div>
					<div id="menu1" class="tab-pane fade">
						<div class="row" style="padding: 12px;">
							
							<!-- 상품평 상단 -->
							<div class="inline-block">
								<span style="font-size: 25px; color: #4d4d4d; font-weight: bold;">상품리뷰</span>
								<button type="button" class="btn btn-md btn-default pull-right" id="addReview">리뷰 등록</button>
							</div>
							
							<!-- 상품평 등록 모달  -->
							<div id="reviewModal" class="modal fade" role="dialog">
							  <div class="modal-dialog">
							    <!-- Modal content-->
							    <div class="modal-content">
							      <div class="modal-header">
							        <button type="button" class="close" data-dismiss="modal">&times;</button>
							        <h4 class="modal-title" id="review-title">상품평 등록</h4>
							      </div>
							      <div class="modal-body">
							        <form action="addReview.do" method="post" class="well" enctype="multipart/form-data" id="review-form">
							        	<div class="form-group">
							        		<label>평점</label>
							        		<input type="hidden" value="0" name="grade" id="review-grade">
							        		<input type="hidden" value="${ticket.info.no }" name="reviewNo" id="review-reviewNo">
							        		<input type="hidden" value="${ticket.info.no }" name="ticketNo" id="review-ticketNo">
							        		<p id="star-location">
							        			<span class="glyphicon glyphicon-star-empty" id="1Star"></span>
							        			<span class="glyphicon glyphicon-star-empty" id="2Star"></span>
							        			<span class="glyphicon glyphicon-star-empty" id="3Star"></span>
							        			<span class="glyphicon glyphicon-star-empty" id="4Star"></span>
							        			<span class="glyphicon glyphicon-star-empty" id="5Star"></span>
							        		</p>
							        	</div>
							        	<div class="form-group">
							        		<label>내용</label>
							        		<textarea rows="4" class="col-sm-12" style="resize:none;" name="contents" id="review-contents"></textarea>
							        	</div>
							        	<div class="form-group">
							        		<label>이미지 등록</label>
							        		<input type="file" id="imgInp" name="images" accept="image/*"><span><small style="color: red">이미지 파일만 등록 해주세요.(10Mb제한)</small></span>
		 										<img id="blah" width="100%" src="/resources/images/review/noimage.jpg" alt="your image" />
								        	<div class="pull-right" style="margin-top: 10px; margin-bottom:10px;">
								        		<button class="btn btn-default" id="review-form-btn">등록</button>
								        		<a type="button" class="btn btn-default" data-dismiss="modal">취소</a>
								        	</div>
							        	</div>
							        </form>
							      </div>
							    </div>
							  </div>
							</div>
							
							<!-- 상품평탭 -->
							<div class="row" style="margin-top: 15px;">
								<!-- 상품평 좌측   -->
								<div class="col-md-5" style="padding-left: 10px;">
									<!-- 평점 별표시  -->
									<div style="font-size: 25px; margin-top: 10px; margin-left: 0px; letter-spacing: -3px;">
										<c:forEach begin="1" end="${review.avg +((review.avg%1>0.5)?(1-(review.avg%1))%1:-(review.avg%1))}">
											<span style="color: #e69900" class="glyphicon glyphicon-star"></span>
										</c:forEach>
										<c:forEach begin="1" end="${5-(review.avg +((review.avg%1>0.5)?(1-(review.avg%1))%1:-(review.avg%1))) }">
											<span  style="color: #ccc;" class="glyphicon glyphicon-star"></span>
										</c:forEach>
										<span style="font-size: 16px; color: #4d4d4d; font-weight: lighter; opacity: 0.8; letter-spacing: 0px;">
											<c:if test="${review.avg  == null || review.avg  == 0}">(0점)</c:if>
											<c:if test="${review.avg != null && review.avg != 0 }">(<fmt:formatNumber value="${review.avg }" pattern="###.##" />점)</c:if>
										</span>
									</div>
									<p style="font-size: 15px; color: #4d4d4d; letter-spacing: -2px;"><strong>${review.sum }</strong>개의 상품평이 있습니다.</p>								
								</div>
								<!-- 상품평 가운데  -->
								<div class="col-md-1" style="font-size: 13px; color: #e69900; padding-right: 0px; margin-right: -30px;">
									<p style="height: 32px;">5점</p>
									<p style="height: 31px;">4점</p>
									<p style="height: 31px;">3점</p>
									<p style="height: 30px;">2점</p>
									<p style="height: 30px;">1점</p>
								</div>
								<!-- 상품평 우측 -->
								<%-- <fmt:formatNumber value="${review.ratio.ONE }" pattern="###.##" />% --%>
								<div class="col-md-6">
									<div class="progress">
										<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="${grades.FIVE }" aria-valuemin="0" aria-valuemax="100" style="width: ${review.ratio.FIVE }%;"></div>
									</div>
									<div class="progress">
										<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="${grades.FOUR }" aria-valuemin="0" aria-valuemax="100" style="width: ${review.ratio.FOUR }%;"></div>
									</div>
									<div class="progress ">
										<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="${grades.THREE }" aria-valuemin="0" aria-valuemax="100" style="width: ${review.ratio.THREE }%;"></div>
									</div>
									<div class="progress">
										<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="${grades.TWO }" aria-valuemin="0" aria-valuemax="100" style="width: ${review.ratio.TWO }%;"></div>
									</div>
									<div class="progress">
										<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="${grades.ONE }" aria-valuemin="0" aria-valuemax="100" style="width: ${review.ratio.ONE }%;"></div>
									</div>
								</div>
							</div>
						</div>
						
						<!-- 상품리뷰박스  -->
						<p style="font-size: 25px; color: #4d4d4d; font-weight: bold;">리뷰</p>
						<div id="review-box"></div>
						<div id="review-nav" class="text-center"></div>
						
					</div>
					
					<!-- 상품문의 -->
					<div id="menu2" class="tab-pane fade">
						<div style=" margin: 10px; padding-top: 10px; padding-bottom: 20px; height: 270px;">
							<form method="post" action="addQna.do" id="addQna-form">
								<p class="inline-block">
									<span style="font-size: 25px; color: #4d4d4d; font-weight: bold; letter-spacing: -2px;">상품에 대해 궁금한 점을 문의해주세요!</span>
									<button class="btn btn-default pull-right">문의등록</button>
								</p>
								<ul style="font-size: 12px; color: #666; padding-left: 3px;">
									<li>구매한 상품의 취소/반품은 구매내역에서 신청 가능합니다.</li>
									<li>상품문의 및 후기게시판을 통해 취소나 환불, 반품 등은 처리되지 않습니다.</li>
									<li>가격, 판매자, 교환/환불 및 배송 등 해당 삼품 자체와 관련 없는 문의는 받지 않습니다.</li>
									<li>상품과 관계없는 글, 양도, 광고성, 욕설, 도배 등의 글은 예고 없이 제한, 삭제등의 조치가 취해질 수 있습니다.</li>
									<li>공개 게시판이므로 전화번호, 메일 주소 등 고객님의 소중한 개인정보는 절대 남기지 말아주세요.</li>
								</ul>
								<input type="hidden" value="${ticket.info.no }" name="ticketNo">
								<textarea rows="4" style="resize:none;" class="form-control" name="questionContents" style="padding-left: 3px"></textarea>
							</form>
						</div>
						
						<!-- 상품문의란  -->
						<p style="font-size: 25px; color: #4d4d4d; font-weight: bold;">문의</p>
						<div style="margin-bottom: 10px;" id="qna-box"></div>

						<!-- 전체 문의 가져오기 -->
						<div class="text-center" id="qna-nav"></div>
						
						<!-- 문의 답변 모달 -->
						<div id="answer-modal" class="modal fade" role="dialog">
							  <div class="modal-dialog">
							    <!-- Modal content-->
							    <div class="modal-content">
							      <div class="modal-header">
							        <button type="button" class="close" data-dismiss="modal">&times;</button>
							        <h4 class="modal-title">문의 답변</h4>
							      </div>
							      <div class="modal-body">
							      	<form action="addQnaAnswer.do" method="post">
								        <table class="table">
								        	<colgroup>
								        		<col width="25%">
								        		<col width="*%">
								        	</colgroup>
								        	<thead>
								        		<tr>
								        			<th>문의자</th>
								        			<th>문의내용</th>
								        		</tr>
								        		<tr>
								        			<td id="qnaUser"></td>
								        			<td id="qnaContents"></td>
								        		</tr>
								        	</thead>
								        	<tbody>
								        		<tr>
								        			<th>답변내용</th>
								        			<th>
								        				<input type="hidden" id="qnaNo" name="qnaNo">
								        				<input type="hidden" value="${ticket.info.no }" name="ticketNo">
								        				<textarea style="width:100%; resize: none;" name="answerContents"></textarea>
								        			</th>
								        		</tr>
								        	</tbody>
								        </table>
								      	<button class="btn btn-info">등록</button>
								        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
							      	</form>
							      </div>
							      <div class="modal-footer">
							      </div>
							    </div>
							  </div>
							</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 우측 플로팅 상품정보  -->
		<div id="sidebox" style="width:28%; position:fixed; top:127px; right:15%;">
			<div style="background-color: #fff; padding: 20px; border: 1px solid #ccc; height: 170px;">
				<p style="font-size: 21px; color: #4d4d4d; font-weight: bolder; letter-spacing: -2px;">[${ticket.info.locationCity}] ${ticket.info.name }</p>
				<div style="font-size: 15px; margin-top: -5px;">
					<c:forEach begin="1" end="${review.avg +((review.avg%1>0.5)?(1-(review.avg%1))%1:-(review.avg%1))}">
						<span style="color: #e69900" class="glyphicon glyphicon-star"></span>
					</c:forEach>
					<c:forEach begin="1" end="${5-(review.avg +((review.avg%1>0.5)?(1-(review.avg%1))%1:-(review.avg%1))) }">
						<span  style="color: #ccc;" class="glyphicon glyphicon-star"></span>
					</c:forEach>
					<span style="font-size: 12px; color: #4d4d4d;">(${review.sum }개의 상품평)</span>
				</div>
				
				<p style="margin-top: 20px; color:#4d4d4d;">
					<del><fmt:formatNumber value="${ticket.info.price }" pattern="#,###" />원</del>
					 <span style="color: #ff3333; font-weight: bolder;">↓${ticket.info.discountRate }%</span>
				</p>
				<p id="dcPrice" style="font-size: 33px; font-weight: bolder; color: #996633; margin-top: -15px;">
					<fmt:formatNumber value="${ticket.info.price*((100 - ticket.info.discountRate)/100) }" pattern="#,###" />원
				</p>
			</div>

			<div style="background-color: #f2f2f2; height: 40px; border-right: 1px solid #ccc; border-left: 1px solid #ccc; padding: 10px; letter-spacing: -1px;">
	 			<strong>남은시간</strong> <span id="countdown"></span>
			</div>
		 	
		 	<div style="background-color: #fff; padding: 20px; padding-bottom: 10px; border: 1px solid #ccc; text-align: left;">	
		 		<p style="font-size: 13px; font-weight: bolder; color: #e60000;">※ 최대 5매까지 구매가능합니다. </p>
		 		<p class="inline-block">
			 		<input type="number" value="1" min="1" max="5" name="qty" id="qtyProduct" style="width: 60px; text-align: center;">
					<input type="hidden" name="title">
					<span style="color: #a0522d; font-weight: bolder; margin-left: 10px;" class="text-right">
						<span style="font-size: 12px; color: #4d4d4d;">총액</span>
						<span id="sumPrice"><fmt:formatNumber value="${ticket.info.price*((100 - ticket.info.discountRate)/100) }" pattern="#,###" /></span>
						원
					</span>
		 		</p>
				<p class="text-right" style="margin-top: 5px;">
					<a href="#header-box" class="btn btn-sm btn-default">위로</a>
					<button style="background-color: #e69900; color: #fff;" type="button" id="orderBtn" class="btn btn-sm">바로구매</button>
				</p>
			</div>
			
			<div style="margin-top: 5px;">
				<div id="review-fullImg-box" style="display:none; z-index: 1;" >
					<p style="text-align: center;"><img src="/resources/images/review/everr1.jpg" id="review-fullImg-src" height="320px;"/></p>
					<p style="height:30px; margin-top: -10px; text-align: left; padding-left: 10px; padding-top: 5px; background-color: #ac7339; color: #fff; font-size: 13px;">리뷰이미지 보기</p>
				</div>			
			</div>
			
		</div>
		
		<div id="myOrder" class="modal fade" role="dialog">
		  <div class="modal-dialog">
		    <!-- Modal content-->
		    <div class="modal-content">
		      <div class="modal-header" style="background-color:#ac7339; color: #fff;">
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		        <h4 class="modal-title">결제 정보</h4>
		      </div>
		      <div class="modal-body">
		        <table class="table">
		        	<thead>
		        		<tr>
		        			<th colspan="4" style="text-align: center; font-size: 15px; color: #666; border: 2px solid #e69900;">티켓 구매정보</th>
		        		</tr>
		        		<tr class="spacer" style="height: 20px;"></tr>
		        		<tr>
		        			<td style="font-size: 13px; color: #666; font-weight: bold;">티켓명</td>
		        			<td colspan="3" style="font-size: 14px; color: #ac7339; font-weight: bold;">${ticket.info.name }</td>
		        		</tr>
		        		<tr>
		        			<td style="font-size: 13px; color: #666; font-weight: bold;">가격<small>(1매기준)</small></td>
		        			<td id="orderPrice" style="font-size: 13px;"><fmt:formatNumber value="${ticket.info.price*((100 - ticket.info.discountRate)/100) }" pattern="#,###" />원</td>
		        			<td style="font-size: 13px; color: #666;" style="font-size: 12px; font-weight: bold;">수량</td>
		        			<td id="orderQty" style="font-size: 14px; color: #ac7339; font-weight: bold;"></td>
		        		</tr>
		        		<tr>
		        			<td style="font-size: 13px; color: #666; font-weight: bold;">총액</td>
		        			<td colspan="3" id="orderSumPrice" style="font-size: 14px; color: #ac7339; font-weight: bold;"></td>
		        		</tr>
		        	</thead>

		        	<tbody>
		        		<tr>
							<td style="font-size: 13px; color: #666; font-weight: bolder;">결제방식선택</td>
							<td colspan="3"  style="font-size: 13px; padding: 0px;">
								<span class="radio inline-block">
		        					<label><input type="radio" value="card" name="payment-method" id="payment-method-default" checked>카드결제</label>
		        					<label><input type="radio" value="bank" name="payment-method">무통장입금</label>
		        					<label><input type="radio" value="phone" name="payment-method">휴대폰결제</label>
		        				</span>
		        			</td>		        		
		        		</tr>
		        		<tr class="spacer" style="height: 20px;"></tr>
		        	</tbody>
		        	
		        	<!-- 카드결제  -->
		        	<tbody id="payment-card">
		        		<tr class="spacer" style="height: 20px;"></tr>
		        		<tr>
		        			<td style="font-size: 13px; color: #666; font-weight: bold;">카드사</td>
							<td>
								<select id="payment-card-com" class="form-control" style="width: 100px; font-size: 13px;">
									<option value="">:: 선택 ::</option>
									<option value="ss">삼성카드</option>
									<option value="sh">신한카드</option>
									<option value="ct">씨티카드</option>
									<option value="wr">우리카드</option>
									<option value="km">국민카드</option>
									<option value="rt">롯데카드</option>
									<option value="nh">NH농협카드</option>
								</select>
							</td>
							<td colspan="2" style="margin-left: -15px;">
								<span class="form-inline">
									<input size='6' id='numbersOnly' maxlength='4' type='text' class="form-control" style="width: 60px;"/>
									 - <input size='6' id='numbersOnly' maxlength='4' type='text' class="form-control" style="width: 60px;"/>
									 - <input size='6' id='numbersOnly' maxlength='4' type='text' class="form-control" style="width: 60px;"/>
									 - <input size='6' id='numbersOnly' maxlength='4' type='text' class="form-control" style="width: 60px;"/>
								</span>
							</td> 	        	
		        		</tr>
		        		<tr>
		        			<td style="font-size: 13px; color: #666; font-weight: bold;">비밀번호</td>
		        			<td colspan="3">
			        			<span class="form-inline">
				        			<input type="text" id="cardPwd" maxlength="2" class="form-control" style="width: 50px;"/>
				        			<label style="font-size: 13px; color: #666;">(앞 두자리)</label>
			        			</span>
		        			</td>
		        		</tr>
		        		<tr>
		        			<td style="font-size: 13px; color: #666; font-weight: bold;">월/년도</td>
		        			<td colspan="3">
			        			<span class="form-inline">
				        			<input type="text" id="cardMonth" maxlength="2" class="form-control" style="width: 50px;"/>
				        			 / <input type="text" id="cardYear" maxlength="2" class="form-control" style="width: 50px;" />
			        			</span>
		        			</td>
		        		</tr>
		        		<tr>
		        			<td style="font-size: 13px; color: #666; font-weight: bold;">CVC</td>
		        			<td colspan="3"><input type="text" id="cardCvc" maxlength="3" class="form-control" style="width: 50px;"/></td>
		        		</tr>
		        	</tbody>
		        	
		        	<!-- 무통장입금 -->
		        	<tbody id="payment-bank" style="display: none;">
		        		<tr class="spacer" style="height: 20px;"></tr>
		        		<tr>
		        			<td style="font-size: 13px; color: #666; font-weight: bold;">은행</td>
							<td>
								<select id="payment-bank-com" class="form-control" style="width: 100px; font-size: 13px;">
									<option value="">:: 선택 ::</option>
									<option value="ss">신한</option>
									<option value="km">국민</option>
									<option value="wr">우리</option>
									<option value="ko">기업</option>
									<option value="nh">농협</option>
								</select>
							</td>
							<td colspan="2" style="margin-left: -15px;">
								<span class="form-inline">
									<input size='6' id='bankNumber1' maxlength='4' type='text' class="form-control" style="width: 60px;" readonly="readonly"/>
									 - <input size='6' id='bankNumber2' maxlength='4' type='text' class="form-control" style="width: 60px;" readonly="readonly"/>
									 - <input size='6' id='bankNumber3' maxlength='4' type='text' class="form-control" style="width: 80px;" readonly="readonly"/>
								</span>
							</td> 	        	
		        		</tr>
		        		<tr>
		        			<td style="font-size: 13px; color: #666; font-weight: bold;">예금주</td>
		        			<td colspan="3" style="font-size: 13px;">땅콩티켓담당자</td>
		        		</tr>		        		
		        		<tr>
		        			<td style="font-size: 13px; color: #666; font-weight: bold;">입금기한일</td>
		        			<td colspan="3" style="font-size: 13px;" id="payment-bank-dead">익일 오후2시까지 입금바랍니다.</td>
		        		</tr>		        		
		        	</tbody>
		        	
		        	<!-- 휴대폰결제 -->
		        	<tbody id="payment-phone" style="display: none;">
		        		<tr class="spacer" style="height: 20px;"></tr>
		        		<tr>
		        			<td style="font-size: 13px; color: #666; font-weight: bold;">통신사</td>
							<td>
								<select id="payment-phone-com" class="form-control" style="width: 100px; font-size: 13px;">
									<option value="">:: 선택 ::</option>
									<option value="ss">SK</option>
									<option value="kt">KT</option>
									<option value="lg">U플러스</option>
								</select>
							</td>
							<td colspan="2" style="margin-left: -15px;">
								<span class="form-inline">
									<input size='6' id='phoneNumber1' maxlength='3' type='text' class="form-control" style="width: 60px;"/>
									 - <input size='6' id='phoneNumber2' maxlength='4' type='text' class="form-control" style="width: 60px;"/>
									 - <input size='6' id='phoneNumber3' maxlength='4' type='text' class="form-control" style="width: 60px;"/>
								</span>
							</td> 	        	
		        		</tr>
		        		<tr>
		        			<td colspan="4" style="font-size: 13px; color: #cc0000; font-weight: bold; text-align: center;">
		        				휴대폰 소액결제 건은 익월 요금에 청구됩니다.
		        			</td>
		        		</tr>		        		
		        	</tbody>
		        </table>
		      </div>
		      <div class="modal-footer">
		      	<form action="ticketOrder.do" method="post" id="tickeyOrder-form">
		      		<input type="hidden" name="ticketQty" value="1">
		      		<input type="hidden" name="ticketNo" value="${ticket.info.no }">
			        <button class="btn btn-default" id="addPayment">결제하기</button>
			        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
		      	</form>
		      </div>
		    </div>
		  </div>
		</div>		
		
		<div id="neLogin" class="modal fade" role="dialog">
		  <div class="modal-dialog modal-sm">
		    <!-- Modal content-->
		    <div class="modal-content">
		      <div class="modal-header" style="background-color: #ac7339; color: white;">
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		        <p class="modal-title" style="font-size: 14px; font-weight: bolder;">로그인후 이용 가능한 서비스 입니다.</p>
		      </div>
		      <div class="modal-body" style="text-align: center;">
		       <a href="/user/login.do" class="btn btn-default">로그인하러가기</a>
		      </div>
		    </div>
		  </div>
		</div>
			
	</div>
</div>
<jsp:include page="../include/miniUser.jsp"/>
<jsp:include page="../include/footer.jsp"/>
</body>
<script type="text/javascript">
	
	//티켓번호
	var ticketNo = ${ticket.info.no};
    //티켓 리뷰보기 실행
	getReview(event,ticketNo,1);
    //티켓 문의 보기 실행
	getQna(event,ticketNo,1);
    
    	
    
	$(function() {
	
	    $('#qna-box').on('click','[id^=openAnswerModal-]',function() {
	    	var qnaNo = $(this).attr('id').replace('openAnswerModal-','');
	    	$('#qnaNo').val(qnaNo);
	    	getQnaByNo(qnaNo)
	    	$('#answer-modal').modal('show');
	    })

		//문의 글 작성
		$('#addQna-form').submit(function(event) {
			var qnaContents = $(this).find('[name=questionContents]').val();
			if(qnaContents == '') {
				alert('문의내용을 입력해주세요.');
				return false;
			} 
			return true;
		});
		
		//유저아이디 hover
		$('#review-box').on('mouseenter', '[id^=miniUser-]', function() {
			$(this).attr('style', 'padding-top: 3px; font-size:12px; color: #ac7339;');
		});
		$('#review-box').on('mouseleave', '[id^=miniUser-]', function() {
			$(this).attr('style', 'padding-top: 3px; font-size:12px; color: #4d4d4d;');
		});
		
		//리뷰이미지 팝업
		$('#review-box').on('mouseenter', 'img[id^=reviewThumbnails-]', function() {
			var reviewImgName = $(this).attr('id').replace('reviewThumbnails-', '').trim();
			$('#review-fullImg-src').attr('src', '/resources/images/review/' + reviewImgName);
			$('#review-fullImg-box').show();
		});
		$('#review-box').on('mouseleave', 'img[id^=reviewThumbnails-]', function() {
			$('#review-fullImg-src').attr('src', '');
			$('#review-fullImg-box').hide();
		});
		
		//이미지 미리보기
		$("a .small-box").hover(function(event) {
			var img = $(this).attr("src");
			$(".big-box").attr("src" , img);
			return false;
		});
		$("a .small-box").click(function(event) {
			event.preventDefault();
		});
		
		//티켓리뷰 입력
		$('#review-form').on('click', 'span[id$=Star]', function(event) {
			var grade = parseInt($(this).attr('id').substring(0,1));
			$(':input[name=grade]').val(grade);
			
			var $p = $(this).parent();
			var row = "";
			
			$p.empty();
			for (var i=1; i <= grade; i++) {
				row += "<span class='glyphicon glyphicon-star' id='"+i+"Star'></span>";
			}
			for (var i = (grade+1); i <= 5; i++) {
				row += "<span class='glyphicon glyphicon-star-empty' id='"+i+"Star'></span>";
			}
			$p.html(row);
		});
		
		//구매 수량 변경 + 금액 자동 계산
		$('#qtyProduct').on('change', function(event) {
			var removeText = $('#dcPrice').text().split("원");
			var removeComma = removeText[0].split(",");
			var dcPrice = parseInt(removeComma[0] + removeComma[1]);
			var qty = parseInt($(this).val());
			$(':input[name=ticketQty]').val(qty);
			if(!qty) {
				qty = 0;
			}
			var sum = qty * dcPrice;
			num = sum + "";
			point = num.length % 3;
			len = num.length;
			str = num.substring(0, point);
			while(point < len) {
				if (str != "") {
					str += ",";
				}
				str += num.substring(point, point+3);
				point += 3;
			}
			$('#sumPrice').text(str);
			$('#payPrice').text(str);
		});
		
		//바로구매 버튼 클릭
		$('#orderBtn').on('click', function(event) {
			resetModal();
			if('${LOGIN_USER.id}' == ''){		
				$('#neLogin').modal('show');				
			} else {
				$("#myOrder").modal('show');
			}
			var qty = $('#qtyProduct').val();
			$('#orderQty').text(qty);
			var price = '${ticket.info.price*((100 - ticket.info.discountRate)/100) }' * qty;
			var sum = parseInt(price);
			num = sum + "";
			point = num.length % 3;
			len = num.length;
			str = num.substring(0, point);
			while(point < len) {
				if (str != "") {
					str += ",";
				}
				str += num.substring(point, point+3);
				point += 3;
			}
			$('#orderSumPrice').text(str+"원");
			$('#payPrice').text(str+"원");
		});
		
		//카드번호 입력받기
		$('#method').on('keyup','[id=numbersOnly]',function () {
		    var number = $(this).val().replace(/[^0-9]/g,'');
		    $(this).val(number);
		});
		
		//결제방식
		$('[name=payment-method]').change(function () {
			var payment = $('[name=payment-method]:checked').val();
			if(payment == 'card') {
				$('#payment-card').show();			
				$('#payment-bank').hide();			
				$('#payment-phone').hide();			
			} else if(payment == 'bank') {
				$('#payment-card').hide();			
				$('#payment-bank').show();			
				$('#payment-phone').hide();				
			} else if(payment == 'phone') {
				$('#payment-card').hide();			
				$('#payment-bank').hide();			
				$('#payment-phone').show();
			}
		});
		
		//은행에 맞는 무통장 입금번호 부여
		$('#payment-bank-com').change(function() {
			var selectedBank = $('#payment-bank-com').val();
			var bn1 = $('#bankNumber1');
			var bn2 = $('#bankNumber2');
			var bn3 = $('#bankNumber3');
			
			if(selectedBank == 'ss') {
				bn1.val('110');
				bn2.val('999');
				bn3.val('813843');
			} else if (selectedBank == 'km') {
				bn1.val('113');
				bn2.val('254');
				bn3.val('13581');				
			} else if (selectedBank == 'wr') {
				bn1.val('148');
				bn2.val('348');
				bn3.val('31513');				
			} else if (selectedBank == 'ko') {
				bn1.val('168');
				bn2.val('135');
				bn3.val('438454');				
			} else if (selectedBank == 'nh') {
				bn1.val('115');
				bn2.val('353');
				bn3.val('966521');				
			} else if (selectedBank == '') {
				bn1.val('');
				bn2.val('');
				bn3.val('');					
			}	
		})

		//(주문) 결제하기
		$('#addPayment').click(function(event) {
			event.preventDefault();	
			var paymentMethod = $('[name=payment-method]:checked').val();
			
			if(paymentMethod == 'card') {
				if($('select#payment-card-com').val() == '') {
					alert('카드사를 선택하세요.');
					return false;
				}			
				$(':input[id=numbersOnly]').each(function(index,item) {
					if(!$(item).val()) {
						alert('카드 번호를 입력하세요.');
						return false;
					}
				})
				if($('input#cardPwd').val() == '') {
					alert('카드 비밀번호를 입력하세요.');
					return false;
				}
				if($('input#cardMonth').val() == '') {
					alert('카드 기한월을 입력하세요.');
					return false;
				}
				if(parseInt($('input#cardMonth').val()) >= 12 ) {
					alert('카드 기한월을 올바르게 입력하세요.');
					return false;
				}
				if($('input#cardYear').val() == '') {
					alert('카드 기한연도를 입력하세요.');
					return false;
				}
				if($('input#cardCvc').val() == '') {
					alert('카드 보안번호(CVC)를 입력하세요.');
					return false;
				}				
			} else if(paymentMethod == 'bank') {
				if($('select#payment-bank-com').val() == '') {
					alert('은행을 선택하세요.');
					return false;
				}			
			} else if(paymentMethod == 'phone') {
				if($('select#payment-phone-com').val() == '') {
					alert('통신사를 선택하세요.');
					return false;
				}			
				if($('input[id=phoneNumber1]').val().length != 3) {
					alert('전화번호를 올바르게 입력하세요.');
					return false;						
				}
				if($('input[id=phoneNumber2]').val().length != 4) {
					alert('전화번호를 올바르게 입력하세요.');
					return false;						
				}
				if($('input[id=phoneNumber3]').val().length != 4) {
					alert('전화번호를 올바르게 입력하세요.');
					return false;					
				}
			}
			$('#tickeyOrder-form').submit();
		});
		
		//모달내용 지우기
		function resetModal() {
			$('[name=payment-method]').each(function(a, b) {
				$(b).prop('checked', false);
			})
			$('#payment-method-default').prop('checked', true);
			
			$('select#payment-card-com').val('');
			$(':input[id=numbersOnly]').each(function(index,item) {
				$(item).val('');
			})			
			$('input#cardPwd').val('');
			$('input#cardMonth').val('');
			$('input#cardYear').val('');
			$('input#cardCvc').val('');
			$('select#payment-bank-com').val('');
			$('select#payment-phone-com').val('');
			$('input[id=phoneNumber1]').val('');
			$('input[id=phoneNumber2]').val('');
			$('input[id=phoneNumber3]').val('');
		}
		
		//리뷰수정버튼 클릭
		$(function(){
			$('#menu1').on('click','[id^=updateReview]',function(event) {
				$('#review-title').text('상품평 수정');
				$('#review-form').attr('action','updateReview.do');
				$('#review-form-btn').text('수정');
				
				var reviewNo = $(this).attr('id').replace("updateReview-","");
				var ticketNo = $('#review-ticketNo').val();
				console.log(ticketNo);
				$reviewForm = $('#review-form');
				
				$.ajax({
					type: "GET",
					url: "/ticket/reviewDetail.do",
					data: {reviewNo:reviewNo},
					dataType: 'json',
					success: function(result) {
						var isSuccess = result.success;
						if(isSuccess) {
							var review = result.review;
							var grade = review.ticketGrade;
							var image = result.image;
							$('#review-grade').val(review.ticketGrade);
							$('#review-reviewNo').val(reviewNo);
							$('#star-location').empty();
							for(var i =1; i<= grade; i++) {
								$('#star-location').append("<span class='glyphicon glyphicon-star' id='1Star'></span>");
							}
							for(var i = 1; i<= (5-grade); i++) {
								$('#star-location').append("<span class='glyphicon glyphicon-star-empty' id='1Star'></span>");
							}
							$('#review-contents').text(review.reviewContents);
						if(image != null){
							$('#blah').attr('src', "/resources/images/review/"+image.IMAGENAME);						
						} else {
							$('#blah').attr('src', "/resources/images/review/noimage.jpg");
						}
						}
					}
				})
			});
		})
		
		//리뷰작성버튼 클릭
		$('#addReview').on('click',function(event) {
			if('${LOGIN_USER.id}' != ''){
				$('#reviewModal').modal('show');
			} else {
				$('#neLogin').modal('show');
			}
			$('#blah').attr('src', "/resources/images/review/noimage.jpg");
			$('#review-title').text('상품평 등록');
			$('#review-form').attr('action','addReview.do');
			$('#review-form-btn').text('등록');
			$('#star-location').empty();
			for(var i = 1; i<= 5; i++) {
				$('#star-location').append("<span class='glyphicon glyphicon-star-empty' id='1Star'></span>");
			}
			$('#review-contents').text("");
		});
		
		//리뷰에 이미지파일 업로드
		function readURL(input) {
			  if (input.files && input.files[0]) {
			    var reader = new FileReader();
			    reader.onload = function(e) {
			      $('#blah').attr('src', e.target.result);
			    }

			    reader.readAsDataURL(input.files[0]);
			  }
			}

			$("#imgInp").change(function() {
			  readURL(this);
			});
	});
	
	var end = new Date(${ticket.info.sellingEndTime });
    var _second = 1000;
    var _minute = _second * 60;
    var _hour = _minute * 60;
    var _day = _hour * 24;
    var timer;

    //티켓판매 남은시간 계산
    function showRemaining() {
        var now = new Date();
        var distance = end - now;
        if (distance < 0) {

            clearInterval(timer);
            document.getElementById('countdown').innerHTML = '판매종료!';

            return;
        }
        var days = Math.floor(distance / _day);
        var hours = Math.floor((distance % _day) / _hour);
        var minutes = Math.floor((distance % _hour) / _minute);
        var seconds = Math.floor((distance % _minute) / _second);

        document.getElementById('countdown').innerHTML = days + '일 ';
        document.getElementById('countdown').innerHTML += hours + '시간 ';
        document.getElementById('countdown').innerHTML += minutes + '분 ';
        document.getElementById('countdown').innerHTML += seconds + '초';
    }
    timer = setInterval(showRemaining, 1000);
    
    //티켓리뷰 가져오기
    function getReview(event,ticketNo,j) {
		$.ajax({
			type: "GET",
			url: "/review/allReview.do",
			data: {ticketNo:ticketNo,modalPageNo:j},
			dataType: 'json',
			success: function(result) {
				var review = result.list;
				var images = result.images;
				var totalCnt = parseInt(result.totalCnt);
				var row ="";
				var currentModalPageNo = j;
				if(totalCnt == 0) {
					row += "<div class='row' style='height: 200px; margin-left:30px;'>";
					row += "<p class='noContents'>등록된 상품평이 존재하지 않습니다.</p>";
					row += "<p class='noContents-bg'>:(</p>";
					row += "</div>";					
				} else {
					/* 정상작동  */
					$.each(review, function(index, list) {
						row += "<div class='row' style='border-bottom: 1px solid #ccc; padding-top: 20px; padding-bottom: 20px;'>";
						// 리뷰작성자 프로필사진
						row += "<div class='col-sm-1' style='padding: 0px;'>";
							row += "<img src='/resources/images/profile/"+list.USERPROFILE+"' class='img-circle' width='48px' height='48px;'>";
						row += "</div>";
						//리뷰작성자 아이디 및 별점 
						row += "<div class='col-sm-2' style='padding: 0px; padding-left:6px;'>";
							row += "<p style='padding-top: 3px; font-size:12px; color: #4d4d4d;' id='miniUser-"+list.USERID+"'>"+list.USERID+"</p>";
							row += "<p class='inline-block' style='margin-top: -10px;'>";
								for(var i=1; i<=list.TICKETGRADE; i++) {
									row += "<span style='color: #e69900;' class='glyphicon glyphicon-star'></span>"
								}
								for(var i=1; i<=(5-list.TICKETGRADE); i++) {
									row += "<span style='color: #ccc;' class='glyphicon glyphicon-star'></span>"
								}
							row += "</p>";
						row += "</div>";
						
						row += "<div class='col-sm-9'>";
						row += "<p style='inline-block'>";
						row += "<span style='font-size:13px; color: #4d4d4d;'>"+list.REVIEWCONTENTS+"</span>";
						row += "<span style='margin-left: 5px; color: #999999;'><small>"+formatDate(list.CREATEDATE)+"</small></span>";
						row += "</p>";
						$.each(images, function(index,image){
							if(image.NO == list.REVIEWNO) {
								row += "<img src='/resources/images/review/"+image.NAME+"' width='75px' height='75px;' id='reviewThumbnails-"+image.NAME+"' >"
							}
						})
						
						if(list.USERID == '${LOGIN_USER.id}'){			
							row += "<p class='pull-right'>";
							row += "<button class='btn btn-primary btn-xs' id='updateReview-"+list.REVIEWNO+"' data-toggle='modal' data-target='#reviewModal'>수정</button>";
							row += "<a href='deleteReview.do?ticketNo="+${ticket.info.no}+"&reviewNo="+list.REVIEWNO+"' class='btn btn-danger btn-xs' style='margin-left: 5px;'>삭제</a>";
							row += "</p>";
						} 
						row += "</div>";
						row += "</div>";
					})
				
					//리뷰가 있을 때에만 페이지네이션
					var nav = 5;
					if(totalCnt == 0) {
						totalCnt = 1;
					}
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
						    pagination += "<li><a href='#' onclick='getReview(event,"+ticketNo+","+previousPage+")' aria-label='Previous'>";
						    pagination += "<span aria-hidden='true'>&laquo;</span></a></li>";
						}
						if(currentBlock == totalBlocks) {
						   beginModalPage = ((totalBlocks-1)*nav)+1;
						   endModalPage = totalPageNo;
						}
						for (var i=beginModalPage; i<=endModalPage; i++) {
						   if (currentModalPageNo == i){
						      pagination += "<li class='selected'><a href='#'>"+i+"</a></li>";
						   } else {
						      pagination += '<li><a href="#" onclick="getReview(event,'+ticketNo+','+i+')">'+i+'</a></li>';
						   }
						}
						if(currentBlock != totalBlocks){
						    pagination += "<li><a href='#' onclick='getReview(event, "+ticketNo+", "+nextPage+")' aria-label='Next'>";
						    pagination += "<span aria-hidden='true'>&raquo;</span></a></li>";
						}
					pagination += "</ul></nav>";
					$('#review-nav').empty();
					$('#review-nav').append(pagination);
				
				}
				$('#review-box').empty();
				$('#review-box').append(row);
				
			}
		});
    }
    
    //티켓문의 가져오기
    function getQna(event,ticketNo,j) {
    	$.ajax({
    		type: "GET",
			url: "/qna/allQna.do",
			dataType: 'json',
			data:{ticketNo:ticketNo,pno:j},
			success: function(result) {
				var qnas = result.qnas;
				var totalCnt = result.totalCnt;
				var row = "";
				
				if( totalCnt == 0){					
					row += "<div class='row' style='height: 200px; margin-left:30px;'>";
					row += "<p class='noContents'>등록된 문의가 존재하지 않습니다.</p>";
					row += "<p class='noContents-bg'>:(</p>";
					row += "</div>";
					$('#qna-nav').empty();
				} else {
					row += "<div class='panel panel-group'>"
					$.each(qnas, function(index,qna){
						var qdate = formatDate(qna.QUESTIONDATE).substring(0,11);
						var adate = formatDate(qna.ANSWERDATE).substring(0,11);
						row += '<div class="panel panel-default" style="margin-top: 10px; margin-bottom: 10px;">'
						
						row += '<div class="panel-heading">';
						row += '<div class="inline-block">';
						row += '<span style="font-size: 13px; color: #666; font-weight: bolder;">질문</span>';
						if(qna.user.id == '${LOGIN_USER.id}'){
							row += '<span><a href="deleteQna.do?qnaNo='+qna.QNANO+'&ticketNo=${ticket.info.no}" class="btn btn-danger pull-right btn-xs">삭제</a></span>';
						} else if('${LOGIN_USER.status}' == 'ADMIN') {
							row += "<span class='pull-right'>";
							if(!qna.ANSWERCONTENTS) {
								row += '<button id="openAnswerModal-'+qna.QNANO+'" class="btn btn-warning btn-xs" style="margin-right: 5px;">답변</button>';													
							}
							row += '<a href="deleteQna.do?qnaNo='+qna.QNANO+'&ticketNo=${ticket.info.no}" class="btn btn-danger btn-xs">삭제</a>';
							row += "</span>";
						}
						row += '</div>';
						row += '</div>';
						
						//답변없는 문의의 경우
						if(!qna.ANSWERCONTENTS) {					
							row += '<div class="panel-body">'
							row += "<div class='row'>";
							
							// 문의작성자 프로필사진
							row += "<div class='col-sm-1' style='padding: 2px; margin-left: 10px;'>";
								row += "<img src='/resources/images/profile/"+qna.user.profile+"' class='img-circle' width='48px' height='48px;'>";
							row += "</div>";							
							
							//문의작성자 아이디 및 작성일 
							row += "<div class='col-sm-2' style='padding: 0px; padding-left:6px;'>";
							row += "<p style='padding-top: 3px; font-size:12px; color: #4d4d4d; margin-top: 5px;' id='miniUser-"+qna.user.id+"'>"+qna.user.id+"</p>";
							row += "<p style='color: #999999; font-size: 12px; margin-top: -10px;'>"+qdate+"</p>";
							row += "</div>";							
							
							row += '<div class="col-sm-9" style="margin-left: -20px;">';
							row += '<p style="font-size: 13px; color: #666;">'+qna.QUESTIONCONTENTS+'</p>'
							row += '</div>';
							
							row += '</div>';
							row += '</div>';
							row += '</div>';
						//답변완료된 문의의 경우
						} else {
							row += '<div class="panel-body">'
							row += "<div class='row'>";
						
							// 문의작성자 프로필사진
							row += "<div class='col-sm-1' style='padding: 2px; margin-left: 10px;'>";
								row += "<img src='/resources/images/profile/"+qna.user.profile+"' class='img-circle' width='48px' height='48px;'>";
							row += "</div>";							
							
							//문의작성자 아이디 및 작성일 
							row += "<div class='col-sm-2' style='padding: 0px; padding-left:6px;'>";
							row += "<p style='padding-top: 3px; font-size:12px; color: #4d4d4d; margin-top: 5px;' id='miniUser-"+qna.user.id+"'>"+qna.user.id+"</p>";
							row += "<p style='color: #999999; font-size: 12px; margin-top: -10px;'>"+qdate+"</p>";
							row += "</div>";							
							
							row += '<div class="col-sm-9" style="margin-left: -20px;">';
							row += '<p style="font-size: 12px; color: #666;">'+qna.QUESTIONCONTENTS+'</p>'
							row += '</div>';
							
							row += '</div>';
							row += '</div>';						
							
							// 관리자 답변
							row += '<div class="panel panel-warning">';
							
							row += '<div class="panel-heading">';
							row += '<div class="inline-block">';
							row += '<span style="font-size: 13px; color: #e69900; font-weight: bolder;">답변</span>';
							if('${LOGIN_USER.status}' == 'ADMIN') {
								row += '<span><a href="/qna/deleteQnaAnswer.do?qnaNo='+qna.QNANO+'&ticketNo=${ticket.info.no}" class="btn btn-danger pull-right btn-xs">삭제</a></span>';
							}
							row += '</div>';
							row += '</div>';
							
							row += '<div class="panel-body">'
							row += "<div class='row'>";
							
							// 관리자 프로필사진
							row += "<div class='col-sm-1' style='padding: 2px; margin-left: 10px;'>";
								row += "<img src='/resources/images/profile/peanutsAdmin.png' class='img-circle' width='48px' height='48px;'>";
							row += "</div>";							

							//관리자 아이디 및 작성일 
							row += "<div class='col-sm-2' style='padding: 0px; padding-left:6px;'>";
							row += "<p style='padding-top: 3px; font-size:12px; color: #4d4d4d; margin-top: 5px;'>땅콩매니저</p>";
							row += "<p style='color: #999999; font-size: 12px; margin-top: -10px;'>"+adate+"</p>";
							row += "</div>";							
							
							row += '<div class="col-sm-9" style="margin-left: -30px;">';
							row += '<p style="font-size: 12px; color: #666;">'+qna.ANSWERCONTENTS+'</p>'
							row += '</div>';
							
							row += '</div>';
							row += '</div>';							
							row += '</div>';							
							row += '</div>';							
						}
					})
					
					// 문의가 있을때만 페이지네이션
					var nav = 5;
					var currentModalPageNo = j;
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
						    pagination += "<li><a href='#' onclick='getQna(event,"+ticketNo+","+previousPage+")' aria-label='Previous'>";
						    pagination += "<span aria-hidden='true'>&laquo;</span></a></li>";
						}
						if(currentBlock == totalBlocks) {
						   beginModalPage = ((totalBlocks-1)*nav)+1;
						   endModalPage = totalPageNo;
						}
						for (var i=beginModalPage; i<=endModalPage; i++) {
						   if (currentModalPageNo == i){
						      pagination += "<li class='selected'><a href='#'>"+i+"</a></li>";
						   } else {
						      pagination += '<li><a href="#" onclick="getQna(event,'+ticketNo+','+i+')">'+i+'</a></li>';
						   }
						}
						if(currentBlock != totalBlocks){
						    pagination += "<li><a href='#' onclick='getQna(event, "+ticketNo+", "+nextPage+")' aria-label='Next'>";
						    pagination += "<span aria-hidden='true'>&raquo;</span></a></li>";
						}
					pagination += "</ul></nav>";
					$('#qna-nav').empty();
					$('#qna-nav').append(pagination);
				}
				$('#qna-box').empty();
				$('#qna-box').append(row);
			}
    	})
    }
    
    // 해당번호 문의 가져오기
    function getQnaByNo(i) {
    	$.ajax({
    		type: "GET",
			url: "/qna/getQna.do",
			dataType: 'json',
			data:{qnaNo:i},
			success: function(result) {
					
				$('#qnaUser').empty();
				$('#qnaUser').append(result.user.name);
				$('#qnaContents').empty();
				$('#qnaContents').append(result.QUESTIONCONTENTS);
    		}
    	})
    }
    
    //date 포맷팅
    function formatDate(date) {
        var d = new Date(date),
        	month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();
        	hour = d.getHours();
        	minute = d.getMinutes();
        	second = d.getSeconds();

        if(month.length < 2){ 
        	month = '0' + month;
        }
        if(day.length < 2){
        	day = '0' + day;
        }
        if(hour.length < 2 ){
        	hour = '0' + hour;
        }
        if(minute.length  < 2) {
        	minute = '0' + minute;
        }
        if(second.length < 2) {
        	second = '0' + second;
        }
		var formattedDate = [year, month, day].join('.')+ ' ' +[hour, month, second].join(':')
        return formattedDate;
    }
</script>
</html>