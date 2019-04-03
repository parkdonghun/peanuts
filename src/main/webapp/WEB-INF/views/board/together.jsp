<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<!DOCTYPE html>
<html lang="ko">
<head>
<title>together board</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<style type="text/css">
	body {overflow-x: hidden;}
	#together-box p.pageTitle {font-size: 3em; color: #c68c53; font-weight: bolder; margin-top: -20px; margin-bottom: -5px;}
	#together-box .noticeBox p {font-size: 13px; color: #737373; font-weight: bolder; margin: 10px;}
	
	#together-box select[name=searchBy] {font-size: 12px;}
	#getMyJoins {background-color: #c68c53; color: #ffffff;}
	#togetherModal tbody td {text-align: center;}
	#togetherModal tbody td a:link {color: #666666; text-decoration: none;}
	#togetherModal tbody td a:visited {color: #666666; text-decoration: none;}
	#togetherModal tbody td a:hover {color: #ac7339; text-decoration: underline;}
	
	#together-box table th, table td {padding: 3px;}
	#together-box .listHead th {text-align: center; font-size: 12px; color: #737373;}
	#together-box .listTop a:visited {color: #666666; text-decoration: underline;}
	#together-box .listTop a:hover {color: #ac7339; text-decoration: underline;}
	#together-box .listTop td {text-align: center; font-size: 12px; color: #737373;}
	#together-box .listMiddle td {text-align: center; font-size: 12px; color: #737373;}
	#together-box .listMiddle a:link {color: #666666; text-decoration: none;}
	#together-box .listMiddle a:visited {color: #666666; text-decoration: underline;}
	#together-box .listMiddle a:hover {color: #ac7339; text-decoration: underline;}
	#together-box td a:link {color: #666666; text-decoration: none;}
	#together-box td a:hover {color: #ac7339; text-decoration: underline;}
	#together-box td[id^=title-]:hover {color: #ac7339; text-decoration: underline;}
	.detailReply [id^=miniUser-]:hover {color: #ac7339; text-decoration: underline;}
	
	#together-box .pagination a:link {color: #737373; text-decoration: none;}
	#together-box .pagination a:visited {color: #737373; text-decoration: none;}
   	#together-box .pagination a.active {background-color: #c68c53; color: #ffffff;}
	#together-box .pagination a:hover:not(.active) {color: #c68c53;}	
	
	.detailHead th, .detailHead span {text-align: left; font-size: 12px; color: #737373;}
	.detailLoginReply th, .detailLoginReply span {text-align: left; font-size: 12px; color: #737373;}
	
	.topJoinList a:link {font-size: 13px; color: #666666; text-decoration: none;}
	.topJoinList a:visited {color: #666666;}
	.topJoinList a:hover {color: #ac7339; text-decoration: underline;}
	.topLikeList a:link {font-size: 13px; color: #666666; text-decoration: none;}
	.topLikeList a:visited {color: #666666;}
	.topLikeList a:hover {color: #ac7339; text-decoration: underline;}
	
	#togetherModal th {color: #808080; font-size: 12px; text-align: center;}
</style>
<body>
<jsp:include page="../include/header.jsp">
	<jsp:param name="header" value="together"/>
</jsp:include>
<br/>
<div class="container" style="width: 60%; min-height: 740px;" id="together-box">
	<div class="row">
		<div class="col-sm-8" id="leftSection">
			<p class="pageTitle" id="locationTop">동행게시판</p>
			<div class="row noticeBox" style="border: 2px solid #c68c53; border-radius: 7px;">
				<p><img src="/resources/images/logo/peanutbw.png" width="20px;" /> 땅콩플래너 동행게시판을 통해서 즐거운 여행의 파트너를 만나보세요!</p>
				<p><img src="/resources/images/logo/peanutbw.png" width="20px;" /> 함께하고 싶은 회원의 게시글에 <span style="color: #c68c53;">참여버튼</span>을 눌러보세요!</p>
				<p><img src="/resources/images/logo/peanutbw.png" width="20px;" /> 게시글 작성은 로그인한 회원만 가능합니다.</p>
				<p><img src="/resources/images/logo/peanutbw.png" width="20px;" /> 게시글 작성시 땅콩+3개! 댓글 작성시 땅콩+1개! <span style="color: #c68c53;">증정</span></p>
			</div>
			
			<div class="row searchBox" style="margin-top: 20px; margin-bottom: 20px;">
				<div class="col-sm-5 pull-left">
					<span class="form-inline" id="newBtns" style="display: block;">
						<button class="btn btn-sm btn-default" id="newBoardBtn">새 글</button>
						<button class="btn btn-sm" id="getMyJoins">나의 동행참여</button>
					</span>
					<button class="btn btn-sm btn-warning" id="toListBtn" style="display: none;">목록으로</button>
					<span class="form-inline" id="addBtns" style="display: none;">
						<button class="btn btn-sm btn-success" id="addNewBoardBtn">등록</button>
						<button class="btn btn-sm btn-default" id="cancelNewBoardBtn">취소</button>
					</span>
					<span class="form-inline" id="modifyBtns" style="display: none;">
						<button class="btn btn-sm btn-warning" id="modifyBoardBtn">수정</button>
						<button class="btn btn-sm btn-default" id="delBoardBtn">취소</button>
					</span>
				</div>
				<div class="col-sm-7 form-inline text-right">
					<select class="form-control" name="searchBy">
						<option value="all">::검색기준::</option>
						<option value="writer">작성자</option>
						<option value="title">제목</option>
						<option value="contents">내용</option>
						<option value="board">제목+내용</option>
					</select>
					<input class="form-control" type="text" width="200px;" name="keyword" />
					<button class="btn btn-sm btn-default" id='searchBtn'>검색</button>
				</div>
			</div>
			
			<div class="row listBox">
				<table class="table" width="100%;">
					<colgroup>
						<col width="7%">
						<col width="*">
						<col width="15%">
						<col width="15%">
						<col width="7%">
						<col width="7%">
					</colgroup>
					<thead>
						<tr class="listHead">
							<th>번호</th>
							<th style="text-align: left;">최근 일주일 인기글 ⓘ</th>
							<th>작성자</th>
							<th>날짜</th>
							<th>조회</th>
							<th><span class="glyphicon glyphicon-thumbs-up"></span></th>
						</tr>
					</thead>
					<tbody class="listTop">
						<c:choose>
							<c:when test="${not empty topTogethers }">
								<c:forEach var="together" items="${topTogethers }">
									<tr>
										<td><img src="/resources/images/logo/peanutbw.png" width="15px;" style="opacity: 0.8;"/></td>
										<td style="text-align: left; font-size: 13px; color: #ac7339; font-weight: bolder;" id='title-${together.no }'>${together.titleWithDots }</td>
										<td><a href="#" id="miniUser-${together.userId }">${together.userId }</a> </td>
										<td><fmt:formatDate value="${together.createDate }" pattern="MM.dd hh:mm"/></td>
										<td>${together.view }</td>
										<td>${together.likes }</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="6">게시글이 존재하지않습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
					<tbody class="listMiddle"></tbody>
					<tfoot class="listBottom"></tfoot>
				</table>			
			</div>
			
			<div class="row detailBox" style="display: none; margin-top: -10px;">
				<table class="table" width="100%">
					<colgroup>
						<col width="10%">
						<col width="*">
					</colgroup>
					<!-- 해당 게시글 정보 -->
					<thead class="detailHead">
						<tr>
							<th colspan="2" style="font-size: 14px; color: #000000; text-align: left; font-weight: bolder;" id="detailTitle"></th>
						</tr>
						<tr>
							<th colspan="2">
								<span id="detailWriter"></span> 
								| <span id="detailCD"></span> 
								| 조회 <span id="detailViews"></span> 
								| <span class="glyphicon glyphicon-thumbs-up"></span> <span id="detailLikes"></span>
								<span id="user-modify" style="float:right; display: none; margin-top: -3px; margin-left: 2px;"><button class="btn btn-xs btn-warning">수정</button></span>
								<span id="user-delete" style="float:right; display: none; margin-top: -3px; margin-left: 2px;"><button class="btn btn-xs btn-danger">삭제</button></span>
								<span id="user-like" style="float:right; display: none; margin-top: -3px; margin-left: 2px;"><button class="btn btn-xs btn-default" style="color: #996633;">좋아요!</button></span>
								<span id="user-unlike" style="float:right; display: none; margin-top: -3px; margin-left: 2px;"><button class="btn btn-xs btn-default" style="color: #b30000;">좋아요취소</button></span>
							</th>
						</tr>
					</thead>
					<!-- 해당 게시글내용 -->
					<tbody>
						<tr><td colspan="2" class="detailMiddle" style="font-size: 13px; height: 200px;"></td></tr>
						<tr>
							<td colspan="2">
								<span class="badge badge-lg badge-default" id="joinCnt" style="margin-bottom: -10px; margin-left: -5px;"></span>	
								<button class="btn btn-lg btn-warning" id="addJoin" style="display: none;">동행참여 <span class="glyphicon glyphicon-ok-circle"></span></button>
						 		<button class="btn btn-lg btn-danger" id="cancelJoin" style="display: none;">동행취소 <span class="glyphicon glyphicon-remove-circle"></span></button>
						 	</td>
						</tr>
					</tbody>
					<!-- 로그인 유저 댓글 작성란 -->
					<tbody class="detailLoginReply">
						<tr>
							<th colspan="2" >
								<span class="glyphicon glyphicon-thumbs-up"></span> <span id="detailLikes"></span>
								<span id="user-like" style="float:right; display: none; margin-top: -3px;"><button class="btn btn-xs btn-default" style="color: #996633;">좋아요!</button></span>	
								<span id="user-unlike" style="float:right; display: none; margin-top: -3px;"><button class="btn btn-xs btn-default" style="color: #b30000;">좋아요취소</button></span>
								| <span class="glyphicon glyphicon-comment"></span> <span id="replyCnt"></span>
							</th>
						</tr>
						<tr>
							<th style="padding-top: 16px;">
								<img src="/resources/images/profile/${LOGIN_USER.profile }" width="70px;" height="70px;" id="login-profile"/>
							</th>
							<th>
								<textarea class="form-control" rows="3" id="replyContents" style="resize: none; font-size: 12px; font-weight: lighter;"></textarea>
								<div id="addReply" style="background-color: #e6e6e6; text-align: center; font-size: 12px; height: 30px; margin-top: -2px; padding-top: 5px;">확인</div>
							</th>
						</tr>
					</tbody>
					<!-- 해당 게시글에 달린 댓글 목록 -->
					<tbody class="detailReply"></tbody>
				</table>				
			</div>
			
			<div class="row newBoardBox" style="display: none; margin-top: -10px;">
				<form width="100%" method="POST" action="/together/addNewBoard.do" id="newBoard-form">
					<div class="form-group">
						<input type="hidden" name="no" value="0"/>
						<c:choose>
							<c:when test="${not empty LOGIN_USER }">
								<input type="hidden" name="userId" value="${LOGIN_USER.id }" />
							</c:when>
						</c:choose>
						<input type="text" name="title" class="form-control" placeholder="제목 (ex 지역명/날짜/제목 ... )" />
					</div>
					<div class="form-group">
						<p style="font-size: 13px; color: #3a2812; margin-top: -5px; margin-left: 10px;">
							<strong>개인정보</strong>를 언급하거나 요청하지마세요! <br/>
							동행 참여수가 높거나, 좋아요수가 많을 경우 게시판 랭킹에 표시될 수 있습니다!				
						</p>
					</div>
					<div class="form-group" style="text-align: right; font-size: 12px; margin-bottom: 3px; margin-top: -20px;">
						<span>남은 글자수 | </span><span id="textRange">650</span>
					</div>					
					<div class="form-group">
						<textarea rows="15" class="form-control" name="contents" maxlength="649" style="resize: none;"></textarea>				
					</div>
				</form>			
			</div>			
			
			
		</div>
		<div class="col-sm-4" id="rightSection">
			<div class="row RankBox" style="display: block;">
				<div class="row Ad" style="margin: 10px; width: 370px; height: 370px;">
					<a href="http://www.cng.go.kr/main.web" target="blank">
						<img src="/resources/images/advertising/changnyung_changnyung370370.jpg" />
					</a>
				</div>
				
				<h2 style="margin-left: 0px; padding: 10px; color: #996633; letter-spacing: -4px;">
					최근3개월 <strong>참여</strong> TOP5
				</h2>
				<div class="row topJoinList" style="margin-left: 5px;"></div>
				
				<h2 style="margin-left: 0px; padding: 10px; color: #996633; letter-spacing: -4px;">
					최근3개월 <strong>좋아요</strong> TOP5
				</h2>
				<div class="row topLikeList" style="margin-left: 5px;"></div>
			</div>
			
			<div class="row JoinerBox" style="display: none;">
				<h2 style="margin-left: 0px; padding: 10px; color: #996633; letter-spacing: -4px;">
					동행 <strong>참여자</strong> 리스트(<span id='joinerCnt'></span>명)
				</h2>
				<h5 style="margin-top: -20px; margin-left: 0px; padding: 10px; color: #130d06; letter-spacing: -2px;">
					※ 참여자에게 쪽지를 보내서 함께 계획을 세워보세요!
				</h5>
				<div class="row" id="joinerList" style="margin-left: 15px;"></div>
			</div>
		</div>	
	</div>
	
	<!-- Modal -->
	<div class="modal fade" id="togetherModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header" style="background-color: #c68c53; color: #ffffff;">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">나의 동행참여 리스트</h4>
	      </div>
	      <div class="modal-body">
			<table class="table">
				<colgroup>
					<col width="7%">
					<col width="10%">
					<col width="*">
					<col width="10%">
					<col width="20%">
				</colgroup>
				<thead>
					<tr>
						<td colspan="5" class="text-left">
							<button class="btn btn-xs btn-danger" id="all-select">전체선택</button>
							<button class="btn btn-xs btn-default" id="cancel-selected">선택취소</button>
						</td>
					</tr>
					<tr>
						<th></th>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>신청일</th>
					</tr>	
				</thead>
				<tbody></tbody>
			</table>			
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>	

	<!-- 각 유저 미니 모달 -->
	<jsp:include page="../include/miniUser.jsp" />

	<!-- 로그인 유저 / 관리자 확인용 -->
	<c:choose>
		<c:when test="${not empty LOGIN_USER }">
			<input type="hidden" id="loginId" value="${LOGIN_USER.id }" />
			<input type="hidden" id="loginStatus" value="${LOGIN_USER.status }" />
		</c:when>
	</c:choose>
	
</div>
<jsp:include page="../include/footer.jsp" />	
</body>
<script>
$(function() {	
	
	//공용변수
	var loginId = $('#loginId').val();
	var loginStatus = $('#loginStatus').val();
	var searchBy = 'all';
	var keyword = '';
	var repCnt;
	var bno;
	var repNo;

	var totalCnt;			//전체 게시글 수
	var totalPageNo;		//전체 페이지수 (컨텐츠수 / 20)
	var totalBlocks;		//전체 블록수 (페이지수/nav 반올림)
	var currentBlock = 1;	//현재 블록
	var start;
	var end;
	var beginPage;			//시작 페이지
	var endPage;			//끝 페이지
	var currentPageNo = 1;
	var nav = 5;

	var $listBox = $('.listBox');    				
	var $list = $('.listMiddle');
	var $paging = $('.listBottom');
	var $rankBox = $('.RankBox');
	var $joinList = $('.topJoinList');
	var $likeList = $('.topLikeList');
	var $detailBox = $('.detailBox');
	var $detailReply = $('.detailReply');
	var $joinerBox = $('.JoinerBox');
	var $joinerCnt = $('#joinerCnt');
	var $joinerList = $('#joinerList');
	var $newBoardBox = $('.newBoardBox');
	
	//게시글 작성 변수
	var $bTitle = $newBoardBox.find('input[name=title]');
	var $bContents = $newBoardBox.find('textarea[name=contents]');

	//모달 열기
	$('#getMyJoins').on('click', function() {
		if(loginId == '' || loginId == null) {
			$('#neLogin').modal('show');	
			return false;
		} 
		$.ajax({
			type: 'GET',
			url: '/together/getMyTogethers.do',
			dataType: 'json',
			success: function(result) {
				var rows;
				if(result.length == 0) {
					rows += "<tr><td colspan='5' class='text-center' style='font-size: 12px; padding-top: 20px; color: #666666;'>신청내역이 존재하지 않습니다.</td></tr>";
				} else {
					$.each(result, function(index, together) {
 						rows += "<tr>";
						rows += "<td><input type='checkbox' id='check-"+together.boardNo+"' /></td>";
						rows += "<td style='font-size: 12px; color: #666666;'>"+together.boardNo+"</td>";
						rows += "<td style='font-size: 12px; color: #666666;' id='title-"+together.boardNo+"'><a href='#'>"+together.titleWithDots+"</a></td>";
						rows += "<td style='font-size: 12px; color: #666666;'><a href='#'>"+together.userId+"</a></td>";
						rows += "<td style='font-size: 12px; color: #666666;'>"+together.createDateToString+"</td>";
						rows += "</tr>";						
					});
				}
			$('#togetherModal').find('tbody').append(rows);
			}
		});
		$('#togetherModal').modal('show');
	});
	
	//모달 닫기 - 닫으면 동행게시판 첫 페이지로
	$('#togetherModal').on('hide.bs.modal',function(){
		$('#togetherModal').find('tbody').empty();
		currentPageNo = 1;
		currentBlock = 1;
		toList();
	});		
	
	//어떤 리스트에서라도 전체선택
	$('#together-box').on('click', '#all-select', function() {
		var rows = $(this).parents('table').find('tbody input[id^=check-]');
		$.each(rows, function(index, row) {
			$(row).attr('checked',true);
		})
	})	

	//모달에서 선택한 동행글들 전체 참여취소
	$('#together-box').on('click', '#cancel-selected', function() {
		var all = $('#togetherModal').find('tbody input[id^=check-]');
		var rows = $('#togetherModal').find('tbody input[id^=check-]:checked');
		var ids = [];
		$.each(rows, function(index, row) {
			ids.push($(row).attr('id').replace('check-','').trim());
		});
		$.ajaxSettings.traditional = true;
		$.ajax({
			type: 'POST',
			url: '/together/cancelSelectedTogethers.do',
			data: JSON.stringify(ids),
			contentType:'application/json',
			async: false,
			complete: function() {
				$.each(rows, function(index, row) {
					$(row).parents('tr').hide();
				})
			}
		});	
		if(all.length == rows.length) {
			var rows = "<tr><td colspan='5' class='text-center' style='font-size: 12px; padding-top: 20px; color: #666666;'>신청내역이 존재하지 않습니다.</td></tr>";
			$('#togetherModal').find('tbody').append(rows);
		}
	})
	
	//글 글자수 세기
    $('#together-box').on('keyup','textarea[name=contents]', function (){
        //메시지 내용길이
    	var content = $(this).val();
        //메시지 내용길이 카운트하기
		var counter = 650 - content.length
        if(counter <= 1) {
        	counter = 0;
        }
        if(counter == 0) {
        	$('#textRange').css('color', 'red');	
        }
		$('#textRange').text(counter);
    });	
	
	//게시글 목록 표시
	getAllTogethers();	
	function getAllTogethers() {
		$.ajax({
			type: 'GET',
			url: '/together/getAllTogethers.do',
			data: {by: searchBy, key: keyword},
			dataType: 'json',
			async: false,
			success: function(result) {
				$list.empty();
				$paging.empty();
 				start = (currentPageNo-1)*20;
				end = (currentPageNo*20);
				
				var rows;
				if(result.length != 0) {
					totalCnt = result.length;
					totalPageNo = Math.ceil(totalCnt/20);
					if(currentPageNo == totalPageNo){
						end = result.length
					}
					
					for(var i=start; i<end; i++){
						rows += "<tr>";
						rows += "<td>"+result[i].no+"</td>";
						rows += "<td style='text-align: left; font-size: 13px;' id='title-"+result[i].no+"'>"+result[i].titleWithDots+"</td>";
						rows += "<td><a href='#' id='miniUser-"+result[i].userId+"'>"+result[i].userId+"</a></td>";
						rows += "<td>"+result[i].createDateToString+"</td>";
						rows += "<td>"+result[i].view+"</td>";
						rows += "<td>"+result[i].likes+"</td>";
						rows += "</tr>";
					}
				} else {
					totalCnt = 1;
					totalPageNo = Math.ceil(totalCnt/20);					
					rows += '<tr><td colspan="6" class="text-center">게시글이 존재하지 않습니다.</td></tr>';
				}
				$list.append(rows);				
				
				//pagination
				totalBlocks = Math.ceil(totalPageNo/nav);
				beginPage = ((currentBlock-1)*nav)+1;
				endPage = currentBlock*nav;		
				 
				pagination = "<tr><td colspan='6' style='text-align: center;'><nav>";
			    pagination += "<ul class='pagination'>";
				if(currentBlock != 1){
				    pagination += "<li><a href='#' aria-label='Previous'>";
				    pagination += "<span aria-hidden='true'>&laquo;</span></a></li>";
				}
				if(currentBlock == totalBlocks) {
					beginPage = ((totalBlocks-1)*nav)+1;
					endPage = totalPageNo;
				}
				for (var i=beginPage; i<=endPage; i++) {
					if (currentPageNo == i){
						pagination += "<li><a href='#' class='active'>"+i+"</a></li>";
					} else {
						pagination += "<li><a href='#'>"+i+"</a></li>";
					}
				}
				if(currentBlock != totalBlocks){
				    pagination += "<li><a href='#' aria-label='Next'>";
				    pagination += "<span aria-hidden='true'>&raquo;</span></a></li>";
				}
			    pagination += "</ul></nav></td></tr>";
			    $paging.append(pagination);	
			}
		});
	}
	
	//$paging pagination 클릭한경우
	$paging.on('click', 'a', function(){
		currentPageNo = $(this).text();
		getAllTogethers();
		location.href='#locationTop';
		return false;
	});		
	$paging.on('click', 'a[aria-label="Previous"]', function(){
		currentBlock = currentBlock - 1;
		currentPageNo = beginPage - 1;	
		getAllTogethers();
		location.href='#locationTop';
		return false;
	});		
	$paging.on('click', 'a[aria-label="Next"]', function(){
		currentBlock = currentBlock + 1;
		currentPageNo = endPage + 1;		
		getAllTogethers();
		location.href='#locationTop';
		return false;
	});		
	
	//검색 버튼을 클릭한 경우
	$('#together-box #searchBtn').click(function() {
 		var search1 = $('select[name=searchBy]').val();
		var search2 = $('input[name=keyword]').val();
		
		if(search1 == 'all') {
			alert('검색기준을 선택하세요');
			return false;
		}
		if(search2 == '') {
			alert('검색어를 입력하세요');
			return false;
		}
		currentModalPageNo = 1;
		searchBy = search1;
		keyword = search2;
		getAllTogethers();		
	})
	
	//오른쪽 메뉴 중간 : 참여수 탑5 게시글
	getTopJoin();
	function getTopJoin() {
		$.ajax({
			type: 'GET',
			url: '/together/getTopJoin.do',
			dataType: 'json',
			success: function(result) {
				$joinList.empty();
				var rows = "";
				if(result.length != 0) {
					$.each(result, function(index, board) {
						rows += "<div class='row' style='margin-bottom: 10px;'>";
						rows += "<div class='col-sm-2'><img src='/resources/images/profile/"+board.profile+"' width='50px;' height='50px;'/></div>"
						rows += "<div class='col-sm-10'>";
						rows += "<p style='margin-top: 3px; margin-bottom: 3px;'><label class='label label-warning'>참여해요! ("+board.together+")</label></p>";
						rows += "<a href='#' style='color: #ac7339;' id='miniUser-"+board.userId+"'><strong>"+board.userId+" </strong></a>";
						rows += "<a href='#' id='title-"+board.no+"'>"+board.titleWithDots+"</a> <span style='color: #999999;'><small>"+board.createDateToString+"</small></span>";
						rows += "</div>";
						rows += "</div>";
					})
				} else {
					rows += '<div class="row text-center" style="margin-top: 10px; color: #999999;"><small>게시글이 존재하지 않습니다.</small></div>';
				}
				$joinList.append(rows);				
			}
		});
	}
	
	//오른쪽 메뉴 하단 : 좋아요수 탑 5 게시글
	getTopLikes();
	function getTopLikes() {
		$.ajax({
			type: 'GET',
			url: '/together/getTopLikes.do',
			async: false,
			dataType: 'json',
			success: function(result) {
				$likeList.empty();
				var rows = "";
				if(result.length != 0) {
					$.each(result, function(index, board) {
						rows += "<div class='row' style='margin-bottom: 10px;'>";
						rows += "<div class='col-sm-2'><img src='/resources/images/profile/"+board.profile+"' width='50px;' height='50px;'/></div>"
						rows += "<div class='col-sm-10'>";
						rows += "<p style='margin-top: 3px; margin-bottom: 3px;'><label class='label label-warning'>좋아요! ("+board.likes+")</label></p>";
						rows += "<a href='#' style='color: #ac7339;' id='miniUser-"+board.userId+"'><strong>"+board.userId+" </strong></a>";
						rows += "<a href='#' id='title-"+board.no+"'>"+board.titleWithDots+"</a> <span style='color: #999999;'><small>"+board.createDateToString+"</small></span>";
						rows += "</div>";
						rows += "</div>";
					})
				} else {
					rows += '<tr><td colspan="6" class="text-center">게시글이 존재하지 않습니다.</td></tr>';
				}
				$likeList.append(rows);				
			}
		});
	}
	
	//목록으로
	$('#together-box').on('click', '#toListBtn', function() {
		toList();
	});
	function toList() {
		getAllTogethers();

		//목록에서는 새글작성 버튼만 보이기
		$('#addBtns').css('display', 'none');
		$('#modifyBtns').css('display', 'none');
		$('#toListBtn').css('display', 'none');
		$('#newBtns').css('display', 'block');		
		
		//목록에서는 리스트 박스만 보이기
		$detailBox.css('display', 'none');        
		$newBoardBox.css('display', 'none');        
		$listBox.css('display', 'block');    
		
		//중도작성인 댓글창 비우기
		$('#replyContents').val('');
		//해당 게시글의 참여자목록 비우기
		$joinerList.empty();

		//우측 랭킹박스 보이기, 참여자목록 가리기
		$rankBox.css('display', 'block');
		$joinerBox.css('display', 'none');
		
		//동행버튼 다시 활성화
		$('#addJoin').attr('disabled', false);
		$('#cancelJoin').attr('disabled', false);		
	}

	//게시글 상세내용(제목 클릭시)
	$('#together-box').on('click', '[id^=title-]', function() {
		if(loginId == '' || loginId == null) {
			$('#neLogin').modal('show');	
			return false;
		} 		
		bno = $(this).attr('id').replace('title-', '').trim();
		$('#togetherModal').find('tbody').empty();
		$('#togetherModal').modal('hide');
		getBoardDetail();
		location.href='#locationTop';
	});
	function getBoardDetail() {
		$.ajax({
			type: 'GET',
			url: '/together/getBoardDetail.do',
			data: {no: bno},
			async: false,
			dataType: 'json',
			success: function(result) {
				var hasJoined = result.hasJoined;
				var hasLiked = result.hasLiked;
				var detail = result.boardDetail;
				var replyCnt = result.replyCnt;
				var writer = detail.userId;
				
				//목록버튼 보이기
				$('#newBtns').css('display', 'none');
				$('#toListBtn').css('display', 'block');
				
				//동행버튼 보이기
				if(hasJoined == 0) {
					$('#cancelJoin').css('display', 'none');
					$('#addJoin').css('display', 'block');
				} else {
					$('#addJoin').css('display', 'none');
					$('#cancelJoin').css('display', 'block');
				}
				
				$('span#user-unlike').css('display', 'none');
				$('span#user-like').css('display', 'none');
				//좋아요버튼 보이기
				if(loginId != writer && loginStatus != 'ADMIN') {
					if(hasLiked == 0) {
						$('span#user-unlike').css('display', 'none');
						$('span#user-like').css('display', 'block');
					} else {
						$('span#user-like').css('display', 'none');
						$('span#user-unlike').css('display', 'block');
					}
				}
				
				//작성자거나 관리자면, 보여주기
				$('#user-modify').css('display', 'none');
				$('#user-delete').css('display', 'none');
				if(loginId == writer || loginStatus == 'ADMIN') {
					$('#user-modify').css('display', 'block');
					$('#user-delete').css('display', 'block');
				}
				
				//게시글내용 보이기
				var miniId = 'detailWriter miniUser-' + detail.userId;
				$listBox.css('display', 'none');    				
				$newBoardBox.css('display', 'none');    				
				$detailBox.css('display', 'block');
				$('#detailTitle').text(detail.title);
				$('#detailWriter').text(detail.userId);
				$('#detailWriter').attr('id', miniId);
				$('#detailCD').text(detail.createDateToString);
				$('#detailViews').text(detail.view);	
				$('[id^=detailLikes]').text(detail.likes);
				$('.detailMiddle').html(detail.contentsWithBr);
				$('#joinCnt').text(detail.together);
				$('#replyCnt').text('('+replyCnt+')');
				
				//댓글 가져오기
				$('#replyContents').text('');
				getAllReplys();				
			
				// 작성자가 본인의 글을 선택한 경우 오른쪽 페이지에는 신청 목록 띄우기
				if(loginId == writer || loginStatus == 'ADMIN') {
					$.ajax({
						type: 'GET',
						url: '/together/getAllJoiner.do',
						data: {no: bno},
						dataType: 'json',
						success: function(result) {
							var rows = "";
							if(result.length == 0) {
								$joinerCnt.text('0');
								rows += '<div class="row text-center" style="margin-top: 10px; color: #999999;">동행 참여자가 존재하지 않습니다.</div>';
							} else {
								$joinerCnt.text(result.length);
								$.each(result, function(index, joiner) {
									rows += "<div class='row' style='margin-bottom: 10px;' id='miniUser-"+joiner.userId+"'>";
									rows += "<div class='col-sm-2'><img src='/resources/images/profile/"+joiner.profile+"' width='50px;' height='50px;' style='border-radius: 50%;'/></div>"
									rows += "<div class='col-sm-10' style='padding-top: auto; padding-bottom: auto;'>";
									rows += "<a href='#' style='color: #ac7339;'><strong>"+joiner.userId+" </strong></a><br/>";
									rows += "<span style='color: #000000;'><small>신청일</small> </span>";
									rows += "<span style='color: #999999;'><small>"+joiner.createDateToString+" </small></span>";
									rows += "</div>";
									rows += "</div>";								
								});
							}
						$joinerList.append(rows);
						}
					});	
					
					$('#addJoin').attr('disabled', true);
					$('#cancelJoin').attr('disabled', true);
					$joinerBox.css('display', 'block');
					$rankBox.css('display', 'none');
				}
			}
		});
	}
	
	//해당 게시글의 댓글 가져오기
	function getAllReplys() {
		$detailReply.empty();
		$.ajax({
			type: 'GET',
			url: '/together/getAllReplys.do',
			data: {no: bno},
			dataType: 'json',
			success: function(result) {
				var rows = "";
				if(result.length == 0) {
					repCnt = 0;
					rows += '<tr><td colspan="6" class="text-center" style="font-size: 12px; padding-top: 20px;">댓글이 존재하지 않습니다.</td></tr>';
				} else {
					repCnt = result.length;
					$.each(result, function(index, reply) {
						rows += "<tr id='rep-"+reply.repNo+"'>";
						rows += "<th style='padding: 20px;'>";
						rows += "<img src='/resources/images/profile/"+reply.profile+"' width=50px; height=50px;/>";
						rows += "</th>";
						rows += "<th>";
						rows += "<span class='row' style='font-size: 12px;'><span id='miniUser-"+reply.userId+"'>"+reply.userId+"</span> <small style='color: #a6a6a6; margin-right: 10px;'>"+reply.createDateToString+"</small></span>";
						if(reply.status == 'REPORT') {
							rows += "<span class='row' style='font-size: 12px; display: block; font-weight: lighter; margin: 0px; color: #b30000;'> 신고된 댓글 입니다. </span>";
						} else {
							rows += "<span class='row' id='repContents' style='font-size: 12px; display: block; font-weight: lighter; margin: 0px;'>"+reply.contents+"</span>";
							rows += "<span class='row' id='orgContents' style='display: none;'><textarea class='form-control' rows='3' style='font-size: 12px; resize: none; font-weight: lighter; width: 95%; margin-left: 10px;'>"+reply.contents+"</textarea></span>";
							rows += "<span class='row' id='reportedContents' style='font-size: 12px; display: none; font-weight: lighter; margin: 0px; color: #b30000;'> 신고된 댓글 입니다. </span>";
						}
						if(loginId == reply.userId || loginStatus == 'ADMIN') {
							rows += "<span class='pull-right form-inline' id='modifyBox' style='display: block; margin-top: 10px;'>";
							rows += "<button class='btn btn-xs btn-default' id='modifyRep' style='margin-right: 5px;'>수정</button>";
							rows += "<button class='btn btn-xs btn-danger' id='delRep'>삭제</button>";
							rows += "</span>";
							rows += "<span class='pull-right form-inline' id='modifyAddBox' style='display: none; margin-top: 10px;'>";
							rows += "<button class='btn btn-xs btn-warning' id='modifyRepAdd' style='margin-right: 5px;'>등록</button>";
							rows += "<button class='btn btn-xs btn-default' id='modifyRepCancel'>취소</button>";
							rows += "</span>";
						} else {
							rows += "<span class='pull-right' style='margin-top: 10px;'>";
							if(reply.status == 'NORMAL') {
								rows += "<button class='btn btn-xs btn-danger' id='reportRep'>신고</button>";
							} else {
								rows += "<button class='btn btn-xs btn-danger' disabled>신고</button>";
							}
							rows += "</span>";
						}
						rows += "</th>";
						rows += "</tr>";
					})	
				}
				$detailReply.append(rows);
			}
		});		
	}
	
	//해당 글 좋아요하기
	$('#together-box').on('click', '#user-like', function() {
		$.ajax({
			type: 'POST',
			url: '/together/likeBoard.do',
			data: {no: bno},
			complete: function() {
				var currLikes = parseInt($('[id^=detailLikes]').first().text());
				$('[id^=detailLikes]').text(currLikes+1);
				$('span#user-like').css('display', 'none');
				$('span#user-unlike').css('display', 'block');
			}
		});
	})

	//해당 글 좋아요 취소하기
	$('#together-box').on('click', '#user-unlike', function() {
		$.ajax({
			type: 'POST',
			url: '/together/unlikeBoard.do',
			data: {no: bno},
			complete: function() {
				var currLikes = parseInt($('[id^=detailLikes]').first().text());
				$('[id^=detailLikes]').text(currLikes-1);
				$('span#user-like').css('display', 'block');
				$('span#user-unlike').css('display', 'none');
			}
		});
	})
	
	//해당 글 동행 참여하기
	$('#together-box').on('click', '#addJoin', function() {
		$.ajax({
			type: 'POST',
			url: '/together/addJoin.do',
			data: {no: bno},
			complete: function() {
				var currJoin = parseInt($('#joinCnt').text());
				$('#joinCnt').text(currJoin+1);
				$('#addJoin').css('display', 'none');
				$('#cancelJoin').css('display', 'block');	
			}
		});
	});

	//해당 글 동행 참여 취소하기
	$('#together-box').on('click', '#cancelJoin', function() {
		$.ajax({
			type: 'POST',
			url: '/together/cancelJoin.do',
			data: {no: bno},
			complete: function() {
				var currJoin = parseInt($('#joinCnt').text());
				$('#joinCnt').text(currJoin-1);
				$('#addJoin').css('display', 'block');
				$('#cancelJoin').css('display', 'none');	
			}
		});
	});

	//새글 작성 버튼 클릭
	$('#newBoardBtn').on('click', function() {
		if(loginId == '' || loginId == null) {
			$('#neLogin').modal('show');	
			return false;
		} 
		//새글 등록, 취소 버튼만 보이기
		$('#newBtns').css('display', 'none');
		$('#toListBtn').css('display', 'none');
		$('#modifyBtns').css('display', 'none');		
		$('#addBtns').css('display', 'block');
		
		//새글 작성 페이지만 보이기
		$detailBox.css('display', 'none');        
		$listBox.css('display', 'none');		
		$newBoardBox.css('display', 'block');
	});
	
	//글 작성 등록
	$('#together-box').on('click', '#addNewBoardBtn', function() {
		var title = $bTitle.val();
		var contents = $bContents.val();	
		var form = $('#newBoard-form');
		
		if(title == '') {
			alert('제목을 입력하세요.');
			return false;
		}
		if(contents == '') {
			alert('내용을 입력하세요.');
			return false;
		}
		form.submit();
	});	

	//글 작성 중 취소
	$('#together-box').on('click', '#cancelNewBoardBtn', function() {
		$bTitle.val('');
		$bContents.val('');	
		$('#textRange').text('650');
		toList();
	});
	
	//글 수정 버튼 클릭
	$('#together-box .detailHead').on('click', '#user-modify', function() {
		//글 수정, 취소 버튼만 보이기
		$('#newBtns').css('display', 'none');
		$('#toListBtn').css('display', 'none');
		$('#addBtns').css('display', 'none');
		$('#modifyBtns').css('display', 'block');		
		
		$.ajax({
			type: 'GET',
			url: '/together/getBoard.do',
			data: {no: bno},
			dataType: 'json',
			asynce: false,
			success: function(result) {
				console.log(result);
				$bTitle.val(result.title);
				$bContents.val(result.contents);	
			}
		});
		
		//글 작성 페이지만 보이기
		$detailBox.css('display', 'none');        
		$listBox.css('display', 'none');		
		$newBoardBox.css('display', 'block');
	});
	
	//글 수정된 내용 등록
	$('#together-box').on('click', '#modifyBoardBtn', function() {
		var title = $bTitle.val();
		var contents = $bContents.val();	
		var form = $('#newBoard-form');
		if(title == '') {
			alert('제목을 입력하세요.');
			return false;
		}
		if(contents == '') {
			alert('내용을 입력하세요.');
			return false;
		}
		$newBoardBox.find('input[name=no]').val(bno);
		form.submit();		
	});
	
	//글 수정 중 취소	
	$('#together-box').on('click', '#delBoardBtn', function() {
		$bTitle.val('');
		$bContents.val('');	
		$('#textRange').text('650');
		toList();		
	});
	
	//글 삭제 버튼 클릭
	$('.detailHead').on('click', '#user-delete', function() {
		console.log(bno);
		if(confirm('정말 게시글을 삭제하시겠습니까?')) {
			location.href="/together/delBoard.do?no="+bno;
		}
	});
	
	//댓글 작성시 땅콩 +1
	$('#together-box').on('click', 'div#addReply', function() {
		var contents = $('#replyContents').val();
		if(contents == '') {
			alert('댓글을 입력하세요.');
			return false;
		} 
		$.ajax({
			type: 'POST',
			url: '/together/addReply.do',
			data: {no: bno, contents: contents},
			dataType: 'json',
			success: function(reply) {
				if(repCnt == 0) {
					$detailReply.empty();
				}
				var rows = "<tr id='rep-"+reply.repNo+"'>";
				rows += "<th style='padding: 20px;'>";
				rows += "<img src='/resources/images/profile/"+reply.profile+"' width=50px; height=50px;/>";
				rows += "</th>";
				rows += "<th>";
				rows += "<span class='row' style='font-size: 12px;' id='miniUser-"+reply.userId+"'>"+reply.userId+" <small style='color: #a6a6a6; margin-right: 10px;'>"+reply.createDateToString+"</small></span>";
				if(reply.status == 'REPORT') {
					rows += "<span class='row' style='font-size: 12px; display: block; font-weight: lighter; margin: 0px; color: #b30000;'> 신고된 댓글 입니다. </span>";
				} else {
					rows += "<span class='row' id='repContents' style='font-size: 12px; display: block; font-weight: lighter; margin: 0px;'>"+reply.contents+"</span>";
					rows += "<span class='row' id='orgContents' style='display: none;'><textarea class='form-control' rows='3' style='font-size: 12px; font-weight: lighter; width: 95%; margin-left: 10px;'>"+reply.contents+"</textarea></span>";
					rows += "<span class='row' id='reportedContents' style='font-size: 12px; display: none; font-weight: lighter; margin: 0px; color: #b30000;'> 신고된 댓글 입니다. </span>";
				}
				if(loginId == reply.userId || loginStatus == 'ADMIN') {
					rows += "<span class='pull-right form-inline' id='modifyBox' style='display: block; margin-top: 10px;'>";
					rows += "<button class='btn btn-xs btn-default' id='modifyRep' style='margin-right: 5px;'>수정</button>";
					rows += "<button class='btn btn-xs btn-danger' id='delRep'>삭제</button>";
					rows += "</span>";
					rows += "<span class='pull-right form-inline' id='modifyAddBox' style='display: none; margin-top: 10px;'>";
					rows += "<button class='btn btn-xs btn-warning' id='modifyRepAdd' style='margin-right: 5px;'>등록</button>";
					rows += "<button class='btn btn-xs btn-default' id='modifyRepCancel'>취소</button>";
					rows += "</span>";
				} else {
					rows += "<span class='pull-right' style='margin-top: 10px;'>";
					if(reply.status == 'NORMAL') {
						rows += "<button class='btn btn-xs btn-danger' id='reportRep'>신고</button>";
					} else {
						rows += "<button class='btn btn-xs btn-danger' disabled>신고</button>";
					}
					rows += "</span>";
				}
				rows += "</th>";
				rows += "</tr>";			
				$detailReply.append(rows);
			}
		});
		$('#replyContents').val('');
	});
	
	//댓글 수정
	$('.detailReply').on('click', '#modifyRep', function() {
		var $tr = $(this).parents('tr')
		repNo = $(this).parents('tr').attr('id').replace('rep-','').trim();
		$('span#repContents').css('display', 'block');	// 나머지 댓글 span 다 보이기
		$('span#orgContents').css('display', 'none');	// 해당 댓글입력 textarea 다 가리기
		$('span#modifyBox').css('display', 'block'); 	// 나머지 댓글 수정버튼 다 보이기
		$('span#modifyAddBox').css('display', 'none'); 	// 나머지 댓글 등록버튼 다 가리기
		
		$tr.find('#repContents').css('display', 'none');	// 해당 댓글 span 가리기
		$tr.find('#orgContents').css('display', 'block');	// 해당 댓글입력 textarea 보이게
		$tr.find('#modifyBox').css('display', 'none'); 		// 해당 댓글 수정버튼 가리기
		$tr.find('#modifyAddBox').css('display', 'block');	// 해당 댓글 등록버튼 보이기
	});
		
	//수정된 댓글 등록
	$('.detailReply').on('click', '#modifyRepAdd', function() {
		var $tr = $(this).parents('tr');
		var modifiedRep = $tr.find('#orgContents').find('textarea').val();
		if(modifiedRep == '') {
			alert('댓글을 입력하세요.');
			return false;
		}
		$.ajax({
			type: 'POST',
			url: '/together/modifyReply.do',
			data: {no: repNo, contents: modifiedRep},
			dataType: 'json',
			success: function(result) {
				console.log(result);
				$tr.find('#repContents').text(result.contents);
				$tr.find('#orgContents').find('textarea').text(result.contents);
				$('span#repContents').css('display', 'block');	// 나머지 댓글 span 다 보이기
				$('span#orgContents').css('display', 'none');	// 해당 댓글입력 textarea 다 가리기
				$('span#modifyBox').css('display', 'block'); 	// 나머지 댓글 수정버튼 다 보이기
				$('span#modifyAddBox').css('display', 'none'); 	// 나머지 댓글 등록버튼 다 가리기					
			}
		});
	});
		
	//댓글 수정 도중 취소 버튼
	$('.detailReply').on('click', '#modifyRepCancel', function() {
		var $tr = $(this).parents('tr');
		//댓글 원상복구
		var recovery = $tr.find('#repContents').text();
		$tr.find('#orgContents').find('textarea').val(recovery);
		$('span#repContents').css('display', 'block');	// 나머지 댓글 span 다 보이기
		$('span#orgContents').css('display', 'none');	// 해당 댓글입력 textarea 다 가리기
		$('span#modifyBox').css('display', 'block'); 	// 나머지 댓글 수정버튼 다 보이기
		$('span#modifyAddBox').css('display', 'none'); 	// 나머지 댓글 등록버튼 다 가리기		
	});
	
	//댓글 삭제
	$('.detailReply').on('click', '#delRep', function() {
		var $tr = $(this).parents('tr');
		repNo = $tr.attr('id').replace('rep-','').trim();
		$.ajax({
			type: 'POST',
			url: '/together/delReply.do',
			data: {no: repNo},
			complete: function() {
				$tr.hide();
			}
		});
	});
	
	//댓글 신고
	$('.detailReply').on('click', '#reportRep', function() {
		var $tr = $(this).parents('tr');
		repNo = $tr.attr('id').replace('rep-','').trim();
		$.ajax({
			type: 'POST',
			url: '/together/reportReply.do',
			data: {no: repNo},
			complete: function() {
				$tr.find('#reportRep').attr('disabled', true);
				$tr.find('#reportedContents').css('display', 'block');	// 신고댓글 표시
				$tr.find('#repContents').css('display', 'none');	// 해당 댓글 span 가리기
				$tr.find('#orgContents').css('display', 'none');	// 해당 댓글입력 textarea 가리기
			}
		});
	});
	
})
</script>
</html>