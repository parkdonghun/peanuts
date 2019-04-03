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
	body {overflow-x: hidden;}
	.blurb a {
				color: #595959;
				font-family: Fantasy;
				font-size: 14px;
				text-decoration: none;
			}
	.blurb a:hover {text-decoration: none; color: #993300;}
	.under-caption {width: 200px; height: 40px; background-color: rgb(0,0,0,0.2); border: 2px solid #fff; margin-right: auto; margin-left: auto; font-size: 15px; letter-spacing: 5px; padding-top: 6px;}
	.carousel-caption a:link {color: #fff; text-decoration: none;}
	.carousel-caption a:visited {color: #fff; text-decoration: none;}
  </style>
</head>
<script type="text/javascript">
$(function(){
	
	$('#tagTooltip').ready(function(){
	    $('[data-toggle="tooltip"]').tooltip(); 
	});
	
	var locationType = 'seoul';
	$('#locationType').find('li').on('click',function(){
		
		$('#locationType').find('li').removeClass('active').find('a').css('background-color','#dfbf9f');
		$(this).addClass('active').find('a').css('background-color','#ac7339');
		locationType = $('#locationType').find('.active').attr('id');
		getTikcketList(locationType);
	});
	
	getPlanList();
	getTikcketList(locationType);
	function hashT(tags){
		if(tags != null){
			var tag = tags.split(',');
			var strTag = '';
			for (var i in tag){
				strTag += '#'+tag[i];
			}
			return strTag;
		} else {
			return '';
		}	
	}
	
	function getPlanList(){
		
		
		
		var $planTopList = $('#planTopList');
		
		//인기 플래너 top4 출력
		$.ajax({
			type: 'GET',
			url: 'planlist.do',
			dataType: 'json',
			success: function(result){
				$.each(result.topList, function(n, items){
					var tg = hashT(items.hashTag);
					
					var row = '';
					row += '<div class="col-lg-2"><div class="card" style="text-align: center;">';
					if(!"${LOGIN_USER.id}"){
						row += '<a data-toggle="tooltip" id="tagTooltip" title="'+tg+'" href="user/login.do">';
					} else {
						row += '<a data-toggle="tooltip" id="tagTooltip" title="'+tg+'" href="planner/dashboard.do?pno='+items.no+'">';	
					}
					row += '<img class="card-img-top img-rounded" style="opacity:0.7;" src="'+items.mapImg+'"></a>';
					row += '<div class="card-body">';	
					row += '<h5 class="card-title"><strong style="color: #666666;">'+items.title+'</strong></h5>';
					//row += '<p style="font-size: 12px; color:#802b00;">'+tg+'</p>';
					row += '<h6>2018년 5월 '+items.userId+' <img src="resources/images/profile/'+items.profile.profile+'" class="img-Circle" width="30px;" height="30px;"></h6>';		
					row += '</div></div></div>';
					
					$planTopList.prepend(row); 
				});
			}
		});
	}
});
	// 인기 티켓 top6 출력	
	function getTikcketList(locationType){
		// 천단위 콤마 찍기
		function comma(str) {
	   		str = String(str);
	    	return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
		}

		$.ajax({
			type: 'GET',
			url: 'ticketlist.do',
			dataType: 'json',
			data: {value: locationType},
			success: function(result){
				$('#ticketTopList').empty();
				var $ticketTopList = $('#ticketTopList');
				
				$.each(result, function(n, items){
					var price = comma(items.price);
					var orderPrice = comma(items.price*((100-items.discountRate)/100));
					var row = '';
					
					row += '<li><div class="col-lg-2" style="margin-left: 15px; text-align:center;">';
					row += '<a href="ticket/detail.do?ticketNo='+items.no+'">';
					row += '<img class="card-img-top img-rounded" style="opacity:0.9;" src="resources/images/ticket/'+items.images+'" width="180px" height="200px"></a>';
					row += '<h5 class="card-title"><strong style="color: #595959;">'+items.name+'</h5>';
					row += '<h5><small><del class=>￦ '+price+'원</del></small> <span style="color: red;">↓'+items.discountRate+'%</span>';
					row += '<p><span>￦'+orderPrice+'</span>원<p></h5>';
					row += '</div></li>';	
					$ticketTopList.append(row);
				});
			}
		});
	}
	function changImg(i) {
		var no = i;
		$('img[id^="blurb-img"]').css('display','none');
		$('#blurb-img'+no).css('display','inline');
	}
	if('${param.fail}' == 'login'){
		alert("로그인 후 사용가능한 기능입니다.");
	}
</script>
<body>
<jsp:include page="include/header.jsp" />
<div class="container" style="width: 100%; position: relative; margin-top: -20px; overflow-x: hidden;">
		<div class="row">
		<!-- 상단 슬라이드 이미지 -->
			<div id="myCarousel" class="carousel slide" data-ride="carousel">

				<!--페이지-->
				<ol class="carousel-indicators">
					<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
					<li data-target="#myCarousel" data-slide-to="1"></li>
					<li data-target="#myCarousel" data-slide-to="2"></li>
				</ol>
				<!--페이지-->

				<div class="carousel-inner">
					<!--슬라이드1-->
					<div class="item active">
						<img src="resources/images/maincsstop3.jpg" style="width: 100%; height: 500px;">
						<div class="conatiner">
							<div class="carousel-caption" style="  margin-bottom: 220px;">
								<p style="font-size: 85px; letter-spacing: -10px;"><span style="font-weight: bolder;">땅콩플래너</span><span style="font-weight: lighter">에서</span></p>
								<h2 style="font-size: 25px; color: #fff; margin-top: -15px; letter-spacing: 25px; font-weight: initial;">새로운여행을시작해보세요</h2><br />
								<div class="under-caption"><a href="map/addPlanForm.do">플래너시작</a></div>
							</div>
						</div>
					</div>
					<!--슬라이드2-->
					<div class="item">
						<a href="https://post.naver.com/bic_fest" target="blank">
							<img class="img" src="/resources/images/advertising/busan.jpg" style="width: 100%; height: 500px;">
						</a>
					</div>
					<!--슬라이드3-->
					<div class="item">
						<a href="https://www.youtube.com/watch?v=zUMSL5_B1a4" target="blank">
							<img src="/resources/images/advertising/incheon_incheon1900.jpg" style="width: 100%; height: 500px;">
						</a>
					</div>
				
				</div>

				<!--이전, 다음 버튼-->
				<a class="left carousel-control" href="#myCarousel" data-slide="prev">
					<span class="glyphicon glyphicon-chevron-left"></span></a> 
				<a class="right carousel-control" href="#myCarousel" data-slide="next">
					<span class="glyphicon glyphicon-chevron-right"></span></a>
			</div>
		</div>
		<div class="container" style="width: 60%; margin-top: 30px;">
			<div class="row col-lg-12">
				<h3 style="color: #996633; font-family: Fantasy;"><img src="resources/images/logo/peanutbw.png" width="30px" height="30px"/> <strong>인기 플래너</strong></h3>
				<hr />
			</div>
			<div class="row text-center" id="planTopList">
				
				<!-- 축제정보 -->
				<div class="col-lg-4">
					<div class="row text-center">
						<a href="http://korea.lottetour.com/tour/plan-view.asp?kr_pj_seq=347&v_goods_type=prd">
						<img src="resources/images/advertising/LOTTE.JPG" height="250px;" width="300px;" /></a>
						<p style="Font-Family: Fantasy; font-size: 28px; font-weight: bolder; color: #336600;"> BEST OF BEST
							<span style="Font-Family: initial; font-size: 15px; font-weight: bolder; color: #800000;"> No팁!No옵션!</span>
							<span style="Font-Family: initial; font-size: 12px; font-weight: bolder; color: #999999;">롯데관광</span>
						</p>
						
					</div>			
				</div>
			</div>
			<div class="row pull-center;" style="margin-top: 20px; padding: 30px;">
				<div class="row">
					<h3 style="color: #996633; font-family: Fantasy;"><img src="resources/images/logo/peanutbw.png" width="30px" height="30px" /> <strong>BEST 인기상품</strong>
					<a class="btn btn-success btn-xs" href="ticket/main.do">티켓 구매 바로가기<span class="glyphicon glyphicon-shopping-cart"></span></a></h3>	
				</div>
				<div class="row">
					<ul class="nav nav-pills nav-justified" id="locationType">
					  <li class="active" id="seoul"><a style="border-radius: 0px; background-color: #ac7339; color: #ffffff;">서울/경기/인천</a></li>
					  <li id="kangwon"><a style="border-radius: 0px; background-color: #dfbf9f; color: #ffffff;">강원</a></li>
					  <li id="chungcheong"><a style="border-radius: 0px; background-color: #dfbf9f; color: #ffffff;">충청/전라</a></li>
					  <li id="kyeongsang"><a style="border-radius: 0px; background-color: #dfbf9f; color: #ffffff;">경상/부산</a></li>
					  <li id="jeju"><a style="border-radius: 0px; background-color: #dfbf9f; color: #ffffff;">제주</a></li>
					</ul>
				</div>
				<div class="row text-center" style="margin-top: 20px;">
					<ul class="list-unstyled text-center" id="ticketTopList">
						
					</ul>
				</div>
			</div>		
		</div>	
		<div class="container" style="width: 100%; background-color: #f9f2ec;">	
			<div class="row center-block" style="width:60%; height: 400px; margin-top: 30px;">
				<div class="row col-xs-8">
					<div class="row" style="margin-top: 25px; margin-left: 20px; height: 300px;">
						<div class="col-xs-3">
							<p style="Font-Family: Fantasy; font-size: 45px; color: #595959;"><strong>SPECIAL  THEME</strong></p>
							<p class="blurb"><a onclick="changImg(1)"><strong>가족 쉼여행!</strong> <span class="glyphicon glyphicon-chevron-right"></span></a><hr style="border-color: #595959; margin: 0px;"/></p>
							<p class="blurb"><a onclick="changImg(2)"><strong>지자체 지원여행</strong> <span class="glyphicon glyphicon-chevron-right"></span></a><hr style="border-color: #595959; margin: 0px;"/></p>	
							<p class="blurb"><a onclick="changImg(3)"><strong>보령 머드 축제</strong> <span class="glyphicon glyphicon-chevron-right"></span></a><hr style="border-color: #595959; margin: 0px;"/></p>	
						</div>
						<div class="col-xs-9">
							<a href="http://www.toursketch.co.kr/exshow.php?exno=88">
							<img class="img-Rounded Corners" id="blurb-img1" src="resources/images/advertising/family.JPG" width="500px;" height="100%" style="display: inline;"></a>
							<a href="http://www.toursketch.co.kr/exshow.php?exno=76">
							<img class="img-Rounded Corners" id="blurb-img2" src="resources/images/advertising/alcah.JPG" width="500px;" height="100%" style="display: none;" ></a>
							<a href="http://www.toursketch.co.kr/exshow.php?exno=95">
							<img class="img-Rounded Corners" id="blurb-img3" src="resources/images/advertising/mudf.JPG" width="500px;" height="100%" style="display: none;"></a>
						</div>
						
					</div>
				</div>
				<div class="row col-xs-4" style="margin-left: 20px; margin-top: 20px; background-color: white; height: 320px;">
					<div class="row" style="margin-top: 10px; margin-left: 10px; margin-right: 10px; height: 300px;">
						<div class="row">
							<div style="margin-left: 15px;">
								<span style="Font-Family: Fantasy; font-size: 30px; font-weight: bolder; color: #2e5cb8;"> Hello! </span>
								 <span style="Font-Family: Fantasy; font-weight: 900; font-size: 18px; color: #0066cc"> August SUMMER Festival!
								 	<img src="resources/images/풍선.png" style="height: 50px; width: 50px;" />
								 </span>
								<img src="resources/images/강원헤더2.JPG" style="width: 318.5px; height: 55px;">
							</div>
						</div>
						<div class="embed-responsive embed-responsive-16by9">
							<iframe class="embed-responsive-item" src="https://www.youtube.com/embed/WBH8uP_2mlA"></iframe>
						</div>
					</div>
				</div>
			</div>
		</div>
	
</div>
<jsp:include page="include/footer.jsp" />
</body>
</html>