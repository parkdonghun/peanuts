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
  	th { text-align: center;}
  	p.pageTitle {font-size: 3em; color: #c68c53; font-weight: bolder; margin-top: -20px; margin-bottom: -5px;}
  	.noticeBox p {font-size: 13px; color: #737373; font-weight: bolder; margin: 10px;}  
	#PlazaPagination .pagination a {color: #737373;} 
  </style>
</head>
<body>
<jsp:include page="../include/header.jsp">
	<jsp:param value="plaza" name="header"/>
</jsp:include>
<div class="container" style="width: 60%; margin-top: 40px;">
	<div class="col-sm-8">
		<p class="pageTitle" id="locationTop">광장게시판</p>
		<div class="noticeBox" style="height: 180px; padding: 10px; border: 2px solid #c68c53; border-radius: 7px; ">
			<p style="color: #666666;"><img src="../resources/images/logo/peanutbw.png" style="width: 20px; height: 20px;">
				 땅콩플래너 광장은 여행의 정보와 이야기를 자유롭게 공유하는 공간입니다.</p>
			<p style="color: #666666;"><img src="../resources/images/logo/peanutbw.png" style="width: 20px; height: 20px;">
				 게시글 작성 및 댓글 작성, 신고기능은 로그인한 회원만 작성 가능합니다.</p>
			<p style="color: #666666;"><img src="../resources/images/logo/peanutbw.png" style="width: 20px; height: 20px;">
				 여행 고수인 왕땅콩님들에게 여행의 도움을 받아보세요.</p>
			<p style="color: #666666;"><img src="../resources/images/logo/peanutbw.png" style="width: 20px; height: 20px;">
				 마음에 드는 글에는  <span class="glyphicon glyphicon-thumbs-up"></span> (추천)을 할 수 있습니다.</p>
			<p style="color: #666666;"><img src="../resources/images/logo/peanutbw.png" style="width: 20px; height: 20px;">
				 게시글 작성시 땅콩+3개! 댓글 작성시 땅콩+1개! <span style="color: #c68c53;">증정</span></p>
		</div>
		<div class="row" style="margin-right: 30px; margin-bottom: 5px; margin-top: 15px;">
			<form id="search-form" class="form-group form-inline" action="allplaza.do" method="post">
				<div class="form-group pull-right">
					<input type="hidden" name="currentPageNo" value="1"/>
					<select id="option" style="height: 25px;">
					    <option value='content' selected>내 용</option>
					    <option value='userId'>아이디</option>
					</select>
					<input type="text" class="form-control" id="keyword" style="width: 200px; height: 25px;" />
					<button id="searchbtn" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-search"></span></button>
				</div>
			</form>
		</div>
		<div class="row">
			<c:choose>
				<c:when test="${empty LOGIN_USER }">
				</c:when>
				<c:otherwise>
					<form action="addplaza.do" class="form-inline" method="post" id="add-board">
						<input type="hidden" name="id" value="${LOGIN_USER.id }"/>
						<div class="form-group">											
							<img width="60px;" src="../resources/images/profile/${LOGIN_USER.profile }">						
						</div>
						<div class="form-group">
							<textarea id="" name="content" style="width: 580px; resize:none;" rows="4"></textarea>
						</div>
						<button id="add-boardBtn" class="btn btn-default btn-sm" style="margin-top: 50px;">등록</button>
					</form>
				</c:otherwise>
			</c:choose>	
		</div>
		<div class="row" id="plaza">			
		</div>
		<div id="PlazaPagination">
						
		</div>
	</div>
	<div class="col-sm-4">
		<div class="row Ad" style="margin: 10px; margin-top: 0px; width: 370px; height: 370px;">
			<a href="https://www.chf.or.kr/c1/sub5.jsp?brdType=R&bbIdx=105526" target="black">
				<img src="/resources/images/advertising/jongno_jongnogu370.jpg" />
			</a>
		</div>
		<h3 style="margin-top: 20px; color: #996633;"><strong>광장 인기 게시글 TOP5</strong></h3>
		<p id="bestplaza" ></p>			
		<hr />
		<h3 style="margin-top: 30px; color: #996633;"><strong>최근 등록 댓글 TOP5</strong></h3>
		<p id="newplaza"></p>
	</div>
	
</div>
	<!-- 각 유저 미니 모달 -->
	<jsp:include page="../include/miniUser.jsp" />
<jsp:include page="../include/footer.jsp" />	
</body>
<script type="text/javascript">
$(function(){
	$('#add-board').on('click', '#add-boardBtn', function(){
		var content = $('#add-board').find('textarea[name=content]').val();
		if(content == ''){
			alert('내용을 입력하세요.');
			return false;
		}
		form.submit();
	});
	
});
	//날짜 패턴 지정
	function date2str(x, y) {	// x는 데이터, y는 패턴
	    var z = {
	        M: x.getMonth() + 1,
	        d: x.getDate(),
	        h: x.getHours(),
	        m: x.getMinutes(),
	        s: x.getSeconds()
	    };
	    y = y.replace(/(M+|d+|h+|m+|s+)/g, function(v) {
	        return ((v.length > 1 ? "0" : "") + eval('z.' + v.slice(-1))).slice(-2)
	    });

	    return y.replace(/(y+)/g, function(v) {
	        return x.getFullYear().toString().slice(-v.length)
	    });
	}
	
	//작성날짜 표현
	function datef(time){

		var w = 604800;
		var d = 86400;
		var h = 3600;
		var m = 60;
		
		var currentTime = new Date().getTime(); //현재시간(초)
		var gap = (currentTime - time) / 1000;
		if(gap > w){
			return date2str(new Date(time), 'yyyy년 M월 d일');
		}
		if(gap > d){
			return Math.round(gap/d)+"일전";
		}
		if(gap > h){
			return Math.round(gap/h)+"시간전";
		}
		if(gap >= m){
			return Math.round(gap/m)+"분전";
		}
		if(gap < m){
			if(gap < 0){
				return "1초전";
			}
			return Math.round(gap)+"초전";
		}
	}

	
	function getPlazaList(event, j, no){
		if ('${param.like}' == 'cancel'){
			alert('좋아요 취소');
		}
		if ('${param.reply}' == 'report'){
			alert('신고 접수 되었습니다');
		}

			
		var currentPageNo = j;
		var allplaza = $('#allplaza').val();
		var option = $('#option').val();
		var keyword = $('#keyword').val();
		var currentNo = no;
		
		$.ajax({
			type: 'GET',
			url: '/board/allplaza.do',
			dataType: 'json',
			data: {currentPageNo:(currentPageNo || 1), option:option, keyword:keyword, currentNo: (no || 0)},
			success: function(result){
				var $pagenation = $('#PlazaPagination');
				//최신댓글 top5
				var newp = result.newRe;
				$('#newplaza').empty();
				$.each(newp, function(n, items){
					var date = datef(items.createDate);
					var row = "";
					row += '<div class="row" style="margin: 10px;"><div class="col-sm-2">';
					row += '<img class="img-circle" width="40px;" height="40px;" src="../resources/images/profile/'+items.profile+'"></div>';
					row += '<div class="col-sm-10" style="font-size: 13px;">';
					row += '<a href="#" id="miniUser-'+items.userId+'"><strong style="color: #996633;">'+items.userId+'</strong></a> <a href="#" onclick="getplaza('+items.boardNo+')">'+items.contents+'</a><span style="color: gray; font-size: 12px;">..'+date+'</span>';
					row += '</div></div>';
					$('#newplaza').append(row);	
				}); 
				//인기글 top5
				var best = result.best;
				$('#bestplaza').empty();
				$.each(best, function(j, items){
					var date = datef(items.createDate);
					var row = "";
					row += '<div class="row" style="margin: 10px;"><div class="col-sm-2">';
					row += '<img class="img-circle" width="40px;" height="40px;" src="../resources/images/profile/'+items.profile+'"></div>';
					row += '<div class="col-sm-10" style="font-size: 13px;">';
					row += '<a href="#" id="miniUser-'+items.id+'"><strong style="color: #996633;">'+items.id+'</strong></a> <span class="badge" style="background-color: #996633;">'+items.likes+'</span> <a href="#" onclick="getplaza('+items.no+')">'+items.content+'</a><span style="color: gray; font-size: 12px;">..'+date+'</span>';
					row += '</div>'; 
				
					$('#bestplaza').append(row);
				});
				//게시판 전체글
				var list = result.list;
				$('#plaza').empty();
				$.each(list, function(i, item){
					var date = datef(item.createDate);
					var row = "";
					row += '<div class="row"><hr width="650px;" style="border-color: #e6ccb3; margin-left: 60px; margin-top: 3px;"/><div class="col-sm-2" style="padding-right: 10px; text-align:right;">';
					row += '<img class="img-circle" width="50px;" height="50px;" src="../resources/images/profile/'+item.profile+'"></div>';
					row += '<div class="col-sm-9">';
					row += '<div class="row">';
					row += '<a href="#" id="miniUser-'+item.id+'"><strong style="font-size: 17px; color: #996633;">'+item.id+'</strong></a>';
					row += '<a href="addlike.do?no='+item.no+'" class="btn btn-default btn-xs" type="button">';
					row += '<span class="glyphicon glyphicon-thumbs-up"></span></a><span class="badge" style="background-color: #996633;">'+item.likes+'</span>'; //좋아요 개수
					row += '<a href="listdel.do?no='+item.no+'" class="btn btn-default btn-xs pull-right" id="listdel-'+item.no+'">삭제</a>';
					row += '<button class="btn btn-default btn-xs pull-right" id="listmodi-'+item.no+'">수정</button></div>';
					row += '<div class="row" id="modidiv-"'+item.no+'>';
					row += '<h5 id="replylist-'+item.no+'">'+item.content+'<span style="color: gray; font-size: 12px;">..'+date+'</span></h5>';
					row += '<form id="modiform-'+item.no+'" class="form-group" action="listModi.do?no='+item.no+'" method="post" style="margin-top: 3px;">';
					row += '<textarea  name="content" style="width: 500px;" rows="3">'+item.content+'</textarea>';
					row += '<button class="btn btn-default btn-xs" style="margin-left: 5px;">저장</button></form>';
					if ('${LOGIN_USER.id}'){
						row += '<form class="form-group" id="add-reBoard-'+item.no+'" action="addRe.do" method="post" style="margin-top: 10px;">'
						row += '<input type="hidden" name="boardNo" value="'+item.no+'" />';
						row += '<input type="text" name="contents" style="width: 530px; height: 28px;" placeholder="Write a Comment.." /></form>';
					}
					row += '</div></div></div>'
					$('#plaza').append(row);
					$('[id^="modiform-"]').hide();
					
					
					if ('${LOGIN_USER.id}' != item.id){
						$('#listdel-'+item.no).hide();
						$('#listmodi-'+item.no).hide();
					} else{
						$('a[href="addlike.do?no='+item.no+'"]').click(function(){
							alert('본인이 작성한 글에는 추천을 할 수 없습니다.');
							return false;
						});
					}
					if (!'${LOGIN_USER.id}'){
						$('a[href="addlike.do?no='+item.no+'"]').click(function(){
							alert('로그인 후 사용가능한 기능입니다.');
							return false;
						});
					}
					
					//댓글 ajax
					$.ajax({	
						type: 'GET',
						url: '/board/reply.do',
						data: {no:item.no }, 
						dataType: 'json',
						success: function(re){
								$.each(re, function(i, item){
									var date = datef(item.createDate);
									var rows = '';
									rows += '<div id="reply" class="row" style="margin-top: 10px; margin-left: 10px;">';
									rows += '<img class="img-circle" width="35px;" height="35px;" src="../resources/images/profile/'+item.profile+'">';
									rows += '<a href="#" id="miniUser-'+item.userId+'"><span style="font-size: 14px; color: #996633;"> '+item.userId+'</span></a>';
									if(item.status == "REPORT"){
										rows += '<span id="relist-'+item.repNo+'" style="font-size: 13px; color: gray;"> 땅콩플래너에 신고 접수된 댓글입니다.</span>';
									} else if(item.status == "NORMAL") {
										rows += '<span id="relist-'+item.repNo+'" style="font-size: 13px;"> '+item.contents;
										rows += '<span style="color: gray; font-size: 12px;">..'+date+'</span></span>';
										if('${LOGIN_USER.id}' && '${LOGIN_USER.id}' != item.userId){
											rows += '<a href="report.do?no='+item.repNo+'" style="color: #cc3300; font-size: 11px;"> 신고</a>';
										}
										rows += '<button class="btn btn-default btn-xs" id ="remodib-'+item.repNo+'"><span class="glyphicon glyphicon-pencil"></span></button>';
										rows += ' <a href="redel.do?reno='+item.repNo+'" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-remove"></span></a>';
									}
									rows += '<form id="remodiform-'+item.repNo+'" class="form-group" action="reModi.do?reno='+item.repNo+'" method="post" style="margin-left: 40px;">'
									rows += '<input type="hidden" name="boardNo" value="" />';
									rows += '<input type="text" name="contents" style="width: 480px; height: 28px;" value="'+item.contents+'"></input></form>';
									rows += '</div>';						
									$('#modiform-' + item.boardNo).after(rows);
									$('[id^="remodiform-"]').hide();
									
									$('button[id^="remodib-'+item.repNo+'"]').click(function(){
										var reno = $(this).attr('id').replace('remodib-','');
										
										$('[id^="remodib-"]').hide();
										$('#relist-'+reno).hide();
										$('#remodiform-'+reno).show();
									});
									if ('${LOGIN_USER.id}' != item.userId){
										$('#remodib-'+item.repNo).hide();
										$('a[href^="redel.do?reno='+item.repNo+'"]').hide();
									}
								})	
						}
					});
				})
				$('form[id^="add-reBoard"]').find('input[name=contents]').keydown(function(e){
					var co = $(this).val();
					if(e.keyCode==13 && co == ''){
						alert("댓글 내용을 입력하세요");
						return false;
					}
				});
				
				
				//게시글 수정
				$('button[id^="listmodi-"]').click(function(){
					var no = $(this).attr('id').replace('listmodi-','');
					$('#replylist-'+no).hide();
					$('[id^="listmodi-"]').hide();
					$('#modiform-'+no).show();
				});
				
				$('#PlazaPagination').find('li').on('click',function(){
					$('#PlazaPagination').find('li').removeClass('active').find('a').css('background-color','#dfbf9f');
					$(this).addClass('active').find('a').css('background-color','#ac7339').css('border-color','').css('color','white');
				});
				
				
				//pagination
				var nav = 5; //페이지 단추 개수
				var totalCnt = result.totalCnt;
	            var totalPageNo = Math.ceil(totalCnt/10);
	            var totalBlocks = Math.ceil(totalPageNo/nav);
	            var currentBlock = Math.ceil(currentPageNo/nav);
	            var beginPage = ((currentBlock-1)*nav)+1;
	            var endPage = currentBlock*nav;
	            var previousPage = Math.floor((currentPageNo-1)/5)*5;
				var	nextPage = Math.ceil(currentPageNo/5)*5+1;
				
				var pagination = "<nav style='text-align: center;'>";
				 	pagination += "<ul class='pagination'>";
					if(currentBlock != 1){
					    pagination += "<li><a href='#' onclick='getPlazaList(event,"+previousPage+")' aria-label='Previous'>";
					    pagination += "<span aria-hidden='true'>&laquo;</span></a></li>";
					}
					if(currentBlock == totalBlocks) {
						beginPage = ((totalBlocks-1)*nav)+1;
						endPage = totalPageNo;
					}
					for (var i=beginPage; i<=endPage; i++) {
					   if (currentPageNo == i){
					      pagination += '<li class="active"><a style="background-color: #ac7339; border-color: #ac7339; color:white;">'+i+'</a></li>';
					   } else {
					      pagination += '<li><a onclick="getPlazaList(event,'+i+')">'+i+'</a></li>';
					   }
					}
					if(currentBlock != totalBlocks){
					    pagination += '<li><a onclick="getPlazaList(event,'+nextPage+')" aria-label="Next">';
					    pagination += '<span aria-hidden="true">&raquo;</span></a></li>';
					}
					pagination += '</ul></nav>';
					$pagenation.empty();
					$pagenation.append(pagination);
					
				
			}
			
		});
	} 

	
	$('#search-form').submit(function(event) {
		getPlazaList(event,1);
		return false;
	});
	
	getPlazaList(event, 1);
	
	function getplaza(pno){
		$('#PlazaPagination').hide();
		getPlazaList(event, 1, pno);
		return false;
	}

</script>
</html>