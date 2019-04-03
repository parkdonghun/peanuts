<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.container {width: 60%;}
	.hidden {display: none;}
	.glyphicon {margin-top: 5px;}
	#top-title span {color: #666666;}
	#planner-setting {width: 70px; height: 30px; padding: 0px; font-size: 13px; color: #666666;}

	/* 기본상태 */	
	#top-table td {height: 60px; padding-top: 10px; border-bottom: 3px solid #ac7339;}
	#top-table span.glyphicon {font-size: 20px; color: #ac7339;}
	#top-table span.text {font-size: 12px; color: #ac7339; margin-top: 5px;}
	
	#top-table td.active {height: 60px; padding-top: 10px; background-color: #ac7339;}
	#top-table td:hover {background-color: #c68c53;}
 	#top-table a:link {text-decoration: none;}
	#top-table a:visited {text-decoration: none;}
	
</style>
<script>
$(function() {
	var randomNo = new Date().getTime()%2;
	var randomBanner = 'bannerAd-' + randomNo;
	$('[id='+randomBanner+']').show();
});
</script>
<div class="container">
	<!-- 배너광고 -->
	<div style="position: fixed; top: 135px; left: 180px; width: 160px; height: 600px; padding: 0px; margin: 0px; display: none;" id="bannerAd-0">
		<a href="http://shop.adidas.co.kr/PF020611.action?pn=SOLARBOOST&_OC_=Running_GDN_Pro_SOLAR_180605P&source=http://squid.nsmartad.com/&xdr=&utm_source=GDN&utm_medium=CPC&utm_campaign=FW18SOLAR&utm_content=Running_Y_2_180605_GDN" target="blank">
			<img src="/resources/images/advertising/adidasKor_adidas.jpg" />
		</a>
	</div>
	<div style="position: fixed; top: 135px; left: 180px; width: 160px; height: 600px; padding: 0px; margin: 0px; display: none;" id="bannerAd-1">
		<a href="http://tales.nexon.com/tales2/event/180614/SecondRun/update.aspx?utm_source=gdn&utm_medium=banner&utm_campaign=secondrun_0614&utm_content=pc_image_C" target="blank">
			<img src="/resources/images/advertising/nexonMng_talesweaver.jpg" />
		</a>
	</div>
	
	<div class="row" id="top-title" style="width: 95%; margin-right: auto; margin-left: auto;">
		<div class="row">
			<span style="display: none" id="pno">${pno }</span>
			<span id="plannerTitle" style="box-sizing: content-box; font-size: 25px; font-weight: bolder; color: #ac7339;"></span>
			<div id="modifyTitle" class="hidden form-inline" style="margin-bottom: 5px;">
				<input type="text" id="modifiedPlannerNm" class="form-control" maxlength="66" style="margin: 0px; width: 60%;"/>
				<button class="btn btn-sm btn-default" id="modifyBtn">수정</button>
				<button class="btn btn-sm btn-danger" id="cancelBtn">취소</button>
			</div>
		</div>
		<div class="row">
			<span class="glyphicon glyphicon-calendar"></span>&nbsp;<span id="plannerStart"></span>&nbsp;&nbsp;
			<span class="glyphicon glyphicon-user"></span>&nbsp;<span id="plannerMember"></span>people&nbsp;&nbsp;
			<span class="glyphicon glyphicon-comment"></span>&nbsp;<span id="plannerReply"></span>comments&nbsp;&nbsp;
			<span class="glyphicon glyphicon-heart-empty" id="likePlan" style="display: none; color: #666666;"></span>
			<span class="glyphicon glyphicon-heart" id="unlikePlan" style="display: none; color: #df2020; opacity: 0.7;"></span>
			<span id="plannerLikes"></span>likes&nbsp;&nbsp;	
			<ul class="nav navbar-nav">
				<li class="dropdown" id="modifyPlannerTop">
				</li>
<!-- 				<li class="dropdown">
		    		<a class="dropdown-toggle" data-toggle="dropdown" href="#" id="planner-setting"><span class="glyphicon glyphicon-cog"></span> 설정<span class="caret"></span></a>
						<ul class="dropdown-menu">
			          		<li><a href="#" id="modifyPlannerNm">플래너제목수정</a></li>
			          		<li><a href="#" id="deletePlanner">플래너삭제</a></li>
			      		</ul>
		     	</li> -->		
			</ul>
			<span class="pull-right">
				<img id="plannerUserProfile" width="30px;" height="30px;" style="border-radius: 50%; margin-top: -5px; margin-left: 10px;" class="pull-right"/>
				<span id="plannerUser" class="pull-right"  style="font-size: 15px; font-weight: bolder;"></span>
			</span>			
		</div>
	</div>
	<table class="text-center" id="top-table" width="100%" style="margin-top: -20px;">
		<colgroup>
			<col width="12%;">
			<col width="13%;">
			<col width="13%;">
			<col width="13%;">
			<col width="13%;">
			<col width="13%;">
			<col width="13%;">
		</colgroup>
		<tr>
			<td class="${param.top == 'home' ? 'active' : '' }"><a href="/planner/dashboard.do?pno=${param.pno }" id='mapDB'><span class="glyphicon glyphicon-home" ></span><br/><span class="text">HOME</span></a></td>
			<td class="${param.top == 'map' ? 'active' : '' }"><a href="/map/mapModule.do?pno=${param.pno }"><span class="glyphicon glyphicon-map-marker"></span><br/><span class="text">지도</span></a></td>
			<td class="${param.top == 'calendar' ? 'active' : '' }"><a href="/schedule/calendar.do?pno=${param.pno }"><span class="glyphicon glyphicon-calendar"></span><br/><span class="text">일정</span></a></td>
			<td class="${param.top == 'wallet' ? 'active' : '' }"><a href="/wallet/view.do?pno=${param.pno }"><span class="glyphicon glyphicon-piggy-bank"></span><br/><span class="text">가계부</span></a></td>
			<td class="${param.top == 'album' ? 'active' : '' }"><a href="/user/photoList.do?pno=${param.pno }"><span class="glyphicon glyphicon-picture"></span><br/><span class="text">앨범</span></a></td>
			<td class="${param.top == 'weather' ? 'active' : '' }"><a href="/weather/weather.do?pno=${param.pno }"><span class="glyphicon glyphicon-cloud"></span><br/><span class="text">날씨</span></a></td>
			<td class="${param.top == 'reply' ? 'active' : '' }"><a href="/reply/reply.do?pno=${param.pno }"><span class="glyphicon glyphicon-comment"></span><br/><span class="text">댓글</span></a></td>
		</tr>
	</table>
</div>

<input type="hidden" name="a" />

<script>
$(function() {
	var pno = $('#pno').text();
	var orgPlannerNm;
	
	//탭 액티브시키기
	active();
	function active() {
		$('#top-table td.active').find('span.glyphicon').css('color', '#ffffff');
		$('#top-table td.active').find('span.text').css('color', '#ffffff');
	}
	
	//플래너 정보 담기
	$.ajax({
		type: 'GET',
		url: '/planner.do',
		data: {pno: pno},
		dataType: 'json',
		async: false,
		success: function(result) {
			var planner = result.planner;
			var user = result.user;
			var loginUser = result.loginUser;
			var hasLiked = result.hasLiked;
			var likes = result.likes;
			var reply = result.reply;
			$('#plannerTitle').text(planner.title);
			$('#plannerUserProfile').attr('src', '/resources/images/profile/'+user.profile);
			$('#plannerUser').text(user.id);
			$('#plannerStart').text(planner.startMonth);
			$('#plannerMember').text(planner.member);
			$('#plannerLikes').text(likes);
			$('#plannerReply').text(reply);
			$('input[name=a]').val(user.createDateToString);
			
			if(user.id == loginUser) {
				var rows = '';	
				rows += '<a class="dropdown-toggle" data-toggle="dropdown" href="#" id="planner-setting"><span class="glyphicon glyphicon-cog"></span> 설정<span class="caret"></span></a>';
				rows += '<ul class="dropdown-menu">';
				rows += '<li><a href="#" id="modifyPlannerNm">플래너제목수정</a></li>';
				rows += '<li><a href="#" id="deletePlanner">플래너삭제</a></li>'
				rows += '</ul>';
				$('#modifyPlannerTop').append(rows);
			}
			if(hasLiked == 0) {
				$('#unlikePlan').hide();
				$('#likePlan').show();
			} else {
				$('#likePlan').hide();
				$('#unlikePlan').show();
			}
		}
		
	});
	
	//플래너 탭 마우스 이벤트
	$('#top-table td').mouseenter(function(){
		$(this).find('span.glyphicon').css('color', '#ffffff');
		$(this).find('span.text').css('color', '#ffffff');
		active();
	});
	$('#top-table td').mouseleave(function(){
		$(this).find('span.glyphicon').css('color', '#ac7339');
		$(this).find('span.text').css('color', '#ac7339');
		active();
	});
	
	//플래너 이름 변경
	$('#modifyPlannerNm').on('click', function() {
		orgPlannerNm = $('#plannerTitle').text();
		$('input#modifiedPlannerNm').attr('placeholder', orgPlannerNm);
		$('#plannerTitle').addClass('hidden');
		$('#modifyTitle').removeClass('hidden');
	});
	$('#modifyBtn').on('click', function() {
		var modifiedPlannerNm = $('#modifiedPlannerNm').val();
		if(modifiedPlannerNm == '') {
			alert('플래너 제목을 입력하세요');
			return false;
		}
		$.ajax({
			type: 'POST',
			url: '../modifyPNm.do',
			data: {name: modifiedPlannerNm, pno: pno},
			dataType: 'json',
			success: function(result){
				$('#plannerTitle').text(result.title);
				$('#plannerTitle').removeClass('hidden');
				$('#modifyTitle').addClass('hidden');
			}
		});
	});
	$('#cancelBtn').on('click', function() {
		$('#plannerTitle').text(orgPlannerNm);
		$('input#modifiedPlannerNm').val("");
		$('input#modifiedPlannerNm').attr('placeholder', orgPlannerNm);
		$('#plannerTitle').removeClass('hidden');
		$('#modifyTitle').addClass('hidden');		
	});
	$('#deletePlanner').on('click', function() {
	    if (confirm('플래너를 삭제하시겠습니까?')) {
			alert('플래너가 삭제되었습니다.');
			location.href="../delPlanner.do?pno="+pno;
	    } else {
	    	alert('플래너 삭제가 취소되었습니다.');
	    }
	});
	
	//플래너 좋아요하기
	$('#likePlan').click(function() {
		$.ajax({
			type: 'GET',
			url: '/likePlanner.do',
			data: {pno: pno},
			complete: function() {
				var currLikes = parseInt($('#plannerLikes').text());
				$('#plannerLikes').text(currLikes+1);
				$('#likePlan').hide();
				$('#unlikePlan').show();
			}
		}) 
	})
	
	//플래너 좋아요취소하기
	$('#unlikePlan').click(function() {
		$.ajax({
			type: 'GET',
			url: '/unlikePlanner.do',
			data: {pno: pno},
			complete: function() {
				var currLikes = parseInt($('#plannerLikes').text());
				$('#plannerLikes').text(currLikes-1);				
				$('#unlikePlan').hide();
				$('#likePlan').show();
			}
		}) 
	})
	
});
</script>
