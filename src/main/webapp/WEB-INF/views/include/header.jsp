<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	#header-top li a {font-size: 11px; color: #808080;}
	#header .container-fluid a {font-size: 13px; color: #ffffff;}
	#header nav.navbar a:hover {background-color: #c68c53;}
	#header nav.navbar a:active {background-color: #c68c53;}
	#header nav.navbar a:focus {background-color: #c68c53;}
	#header nav.navbar li.active {background-color: #c68c53;}
	#header ul.dropdown-menu a:hover {color: #ffffff;}
	#header-searchbox input[type=text] {
	    float: right;
	    padding: 6px;
	    border: none;
	    margin-top: 5px;
	    margin-right: 0px;
	    font-size: 17px;
	}
	#header-searchbox span {
	    float: right;
	    padding-top: 8px;
	    padding-bottom: 2px;
	    border: none;
	    margin-top: 4px;
	    margin-right: 0px;
	    margin-left: 0px;
	    font-size: 18px;
	    text-align: center;
	    vertical-align: middle;
	}
	#globalSearchBox {
		z-index: 1;
		position: absolute;
		top: 105px;
		right: 0px;
		display: none;
		width: 430px;
		padding: 10px;	
		
		border: 4px solid #ac7339;
		background-color: #ffffff;
		font-weight: bolder;
		font-size: 12px;
		color: #ac7339; 
	}
	#globalSearchBox select {font-size: 12px; font-weight: normal;}
	#globalSearchBox option {font-size: 12px; font-weight: normal;}
	#globalSearchBox button {font-size: 12px; font-weight: normal;}
	#globalSearchBox input {font-size: 12px; font-weight: normal;}
	#globalSearchBox .slidecontainer {width: 80%;}
	#globalSearchBox .thisSlider {
	    -webkit-appearance: none;
	    width: 100%;
	    height: 25px;
	    background: #d3d3d3;
	    outline: none;
	    opacity: 0.7;
	    -webkit-transition: .2s;
	    transition: opacity .2s;
	}
	#globalSearchBox .thisSlider:hover {
	    opacity: 1;
	}
	#globalSearchBox .thisSlider::-webkit-slider-thumb {
	    -webkit-appearance: none;
	    appearance: none;
	    width: 25px;
	    height: 25px;
	    background: #e69900;
	    cursor: pointer;
	}
	#globalSearchBox .thisSlider::-moz-range-thumb {
	    width: 25px;
	    height: 25px;
	    background: #e69900;
	    cursor: pointer;
	}	
	#globalSearchBox .searchTerm {
	    padding: 4px 0 0 0 !important;
	}
	#globalSearchBox #range-1b {margin-top: -25px;}
	#globalSearchBox .termBtn {
		display: inline-block;
		border: 1px solid #cccccc;
		border-radius: 50%;
		width: 50px;
		height: 50px;
		font-size: 13px;
		color: #666666;
		text-align: center;
		padding-top: 15px;
		padding-bottom: 10px;
	}
	#globalSearchBox .termBtn:hover {background-color: #c68c53; color: #ffffff;}
	.selectedTerm {background-color: #c68c53; color: #ffffff;}
	#globalSearchBox input: {background-color: #ffffff;}
	#globalSearchBox input:-webkit-autofill {
	    -webkit-box-shadow: inset 0 0 0px 9999px white;
	}	
</style>
<div class="header-container" id="header-box">
	<div class="pull-center">
		<div id="header">
			<div style="height: 80px; margin-right: 20px;">
			    <ul class="nav navbar-nav navbar-right navbar-static-top" id="header-top">
			    	<c:choose>
			    		<c:when test="${empty LOGIN_USER && empty LOGIN_AD}">
							<li class="${param.header == 'register' ? 'active' : '' }"><a href="/user/formfilter.do"><span class="glyphicon glyphicon-user"></span> 회원가입</a></li>
						    <li class="${param.header == 'login' ? 'active' : '' }"><a href="/user/login.do"><span class="glyphicon glyphicon-log-in"></span> 로그인</a></li>
			    		</c:when>
			    		<c:when test="${not empty LOGIN_USER }">
							<li><a href="/user/mypage.do?id=${LOGIN_USER.id }"><span class="glyphicon glyphicon-user"></span> <strong>${LOGIN_USER.id }</strong>님 환영합니다!</a></li>
					    	<c:if test="${LOGIN_USER.status eq 'ADMIN'}">
						    	<li class="${param.header == 'admin' ? 'active' : '' }"><a href="/admin/main.do"> 관리자메뉴</a></li>
							</c:if>			    		
					    	<c:if test="${LOGIN_USER.status eq 'IN'}">
						    	<li class="${param.header == 'qna' ? 'active' : '' }"><a href="/adQna/qnaList.do"> 회원문의</a></li>
							</c:if>							
							<li><a href="/user/logout.do"><span class="glyphicon glyphicon-log-out"></span> 로그아웃</a></li>	    		
			    		</c:when>
			    		<c:when test="${not empty LOGIN_AD }">
				    		<li class="${param.header == 'advertising' ? 'active' : '' }"><a href="/advertising/getMyList.do"> 광고문의</a></li>
						    <li><a href="/user/logout.do"><span class="glyphicon glyphicon-log-out"></span> 로그아웃</a></li>	    		
			    		</c:when>
			    	</c:choose>
			    </ul>
			</div>
			<nav class="navbar" style="background-color: #ac7339; margin-top: -25px;">
			  <div class="container-fluid" style="padding-right: 5px;">
			    <div class="navbar-header">
			      <span class="navbar-brand">
			      	<img src="/resources/images/logo/peanuts.png" id="logoPeanuts" style="opacity: 1; width: auto; height: 100px; margin-top: -70px; margin-left: -20px;"/>
			      </span>
			    </div>
			    <div class="form-inline">
				    <ul class="nav navbar-nav navbar-static-top">
				      	<li class="${param.header == 'home' ? 'active' : '' }"><a href="/home.do"><strong>홈</strong></a></li>
				      	<c:if test="${not empty LOGIN_USER or not empty LOGIN_AD }">
							<li class="dropdown">
					    		<a class="dropdown-toggle" data-toggle="dropdown" href="#">플래너<span class="caret"></span></a>
								<ul class="dropdown-menu">
					          		<li class="${param.header == 'newPlanner' ? 'active' : '' }"><a href="/map/addPlanForm.do" style="color: #000000;">새 플래너</a></li>
					          		<li class="${param.header == 'mypage' ? 'active' : '' }"><a href="/user/mypage.do?id=${LOGIN_USER.id }" style="color: #000000;">내 플래너 리스트</a></li>
					      		</ul>
					     	</li>
				      	</c:if>
				      	<li class="${param.header == 'ticket' ? 'active' : '' }"><a href="/ticket/main.do">티켓</a></li>
				      	<li class="${param.header == 'plaza' ? 'active' : '' }"><a href="../board/plaza.do">광장게시판</a></li>
				      	<li class="${param.header == 'together' ? 'active' : '' }"><a href="/together/together.do">동행게시판</a></li>
				    </ul>
		      		<ul class="pull-right" style="margin-bottom: 0px;">
			      		<li class="form-inline" id="header-searchbox" style="list-style-type: none;">
			      			<span class="glyphicon glyphicon-option-vertical"  id="detail-search" style="width: 30px; height: 40px; background-color: #ffffff; color: #ac7339;"></span>
			      			<input type="text" style="border: none; width:240px; height: 40px; font-size: 12px; background-color: #ffffff; color: #ac7339;" placeholder=" 플래너/유저 검색"/> 
			      		</li>
		      		</ul>
			    </div>
			  </div>
			</nav>
			<div id="globalSearchBox">
				<form method="POST" action="/search/search.do" id="globalSearchForm">
					<div class="form-group">
						<span>플래너명</span><input type="text" id="searchTitle" name="searchTitle" class="form-control" maxlength="50"/>
					</div>
					<div class="form-group">
						<span>유저아이디</span><input type="text" id="searchId" name="searchId" class="form-control"/>
					</div>
					<div class="form-group">
						<span>여행지역</span>
						<p class="form-inline">
							<select name="cityname" class="form-control" style="width: 160px;">
								<option value="">:: 시/도 선택 ::</option>
								<option value="서울특별시">서울특별시</option>
								<option value="부산광역시">부산광역시</option>
								<option value="대구광역시">대구광역시</option>
								<option value="인천광역시">인천광역시</option>
								<option value="광주광역시">광주광역시</option>
								<option value="대전광역시">대전광역시</option>
								<option value="울산광역시">울산광역시</option>
								<option value="경기도_경기남부">경기도(경기남부)</option>
								<option value="경기도_경기북부">경기도(경기북부)</option>
								<option value="강원도">강원도</option>
								<option value="충청북도">충청북도</option>
								<option value="충청남도">충청남도</option>
								<option value="전라북도">전라북도</option>
								<option value="전라남도">전라남도</option>
								<option value="경상북도">경상북도</option>
								<option value="경상남도">경상남도</option>
								<option value="제주특별자치도">제주특별자치도</option>
								<option value="세종특별자치시">세종특별자치시</option>
							</select>
							<select name="locationId" class="form-control" style="width: 160px;">
								<option value="">:: 시/군/구 선택 ::</option>
							</select>	
							<button class="btn btn-warning" id="searchAddLC">추가▼</button>	
						</p>		
						<input type="text" id="searchLocations" name="searchLocations" class="form-control" placeholder="※ 리스트에서 선택추가해주세요"/>
					</div>
					<div class="form-group">
						<span>여행인원</span><span id="searchMemebers" style="font-weight: bolder;">0</span>명
						<p style="font-size: 11px; color: #666666;">※ 미정인 경우 0을 선택해주세요.</p>
						<input type="range" min="0" max="100" value="0" class="thisSlider" id="searchMBRange" name="searchMemebers">
					</div>
					<div class="form-group">
						<span>여행일수</span>
						<div class="inline-block">
							<span class="termBtn" id="searchT-1">당일</span>
							<span class="termBtn" id="searchT-2">2일</span>
							<span class="termBtn" id="searchT-7">7일</span>
							<span class="termBtn" id="searchT-14">14일</span>
							<span class="termBtn" id="searchT-30">30일</span>
							<span class="termBtn" id="freeTerm">입력</span>
							<input type="text" id="searchTerm" name="searchTerm" class="form-control" placeholder="※ 여행일수를 숫자로만 입력해주세요 ex) 20일→ 20"  style="display: none; margin-top: 5px;"/>
						</div>
					</div>
					<div class="form-group">
						<span>해시태그</span>
						<p class="form-inline">
							<select name="hastagList" class="form-control" style="width: 320px;">
								<option value="">:: 해시태그선택 ::</option>
								<option value="산">#산</option>
								<option value="강">#강</option>
								<option value="바다">#바다</option>
								<option value="봄">#봄</option>
								<option value="여름">#여름</option>
								<option value="가을">#가을</option>
								<option value="겨울">#겨울</option>
								<option value="가족">#가족</option>
								<option value="기념">#기념</option>
								<option value="기차">#기차</option>
								<option value="내일로">#내일로</option>
								<option value="덕질">#덕질</option>
								<option value="먹방">#먹방</option>
								<option value="방학">#방학</option>
								<option value="버스">#버스</option>
								<option value="배낭">#배낭</option>
								<option value="우정">#우정</option>
								<option value="이별">#이별</option>
								<option value="자유">#자유</option>
								<option value="졸업">#졸업</option>
								<option value="주말">#주말</option>
								<option value="즉흥">#즉흥</option>
								<option value="청춘">#청춘</option>
								<option value="첫">#첫</option>
								<option value="커플">#커플</option>
								<option value="테마">#테마</option>
								<option value="퇴사">#퇴사</option>
								<option value="홀로">#홀로</option>
								<option value="휴가">#휴가</option>
								<option value="힐링">#힐링</option>
							</select>
							<button class="btn btn-warning" id="searchAddHT">추가▼</button>	
						</p>
						<input type="text" id="searchHashtags" name="searchHashtags" class="form-control"  placeholder="※ 리스트에서 선택추가해주세요"/>
					</div>	
					<div class="form-group pull-right">
						<button class="btn btn-default" id="undoBtn">조건 초기화</button>
						<button class="btn" style="background-color: #ac7339; color: #ffffff;">검색</button>
					</div>				
				</form>
			</div>
		</div>
	</div>
</div>
<script>
$(function() {
	
	//공용변수
	var searchLocations = "";	
	var searchHashtags = "";	
	
	//상세검색창 나타나기1
	$('#header').on('click', '#header-searchbox', function() {
		$('#globalSearchBox').slideToggle();
	})
	
	//상세검색창 나타나기2
	$('#header').on('click', '#detail-search', function() {
		$('#globalSearchBox').slideToggle();
	});
	
	//조건 초기화 버튼 클릭
	$('#header').on('click', '#undoBtn', function(event) {
		event.preventDefault();
		searchLocations = "";
		searchHashtags = "";		
		$('#globalSearchBox').find('#searchTitle').val('');	
		$('#globalSearchBox').find('#searchId').val('');	
		$('#globalSearchBox').find('select[name=cityname]').val('');	
		$('#globalSearchBox').find('input#searchLocations').val('');	
		$('#globalSearchBox').find('span#searchMemebers').text('0');	
		$('#globalSearchBox').find('input#searchMBRange').val('0');	
		$('#globalSearchBox').find('input#searchTerm').val('');	
		$('#globalSearchBox').find('[id^=searchT-]').removeClass('selectedTerm');
		$('#globalSearchBox').find('select[name=hastagList]').val('');	
		$('#globalSearchBox').find('input#searchHashtags').val('');	
		$('#globalSearchBox').slideUp();
		$('#globalSearchBox').slideDown();
	})
	
	//지역선택	
	$('#header select[name="cityname"]').change(function() {
		$.ajax({
			type: "POST",
			url: "/map/getLocation.do",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "json",
			data: {city: $(this).val()},
			async: false,
			success: function(result) {
				var rows = '<option value="">선택하세요</option>';
				$.each(result, function(index, location) {
					rows += '<option value="'+location.name+'">'+location.name+'</option>';
				});
				$('#header select[name="locationId"]').empty().append(rows);
			}
		});
	});	
	
	//지역 다중 선택
	$('#header').on('click', 'button#searchAddLC', function(event) {
		event.preventDefault();
		var currLC = $('#header select[name=locationId]').val();
		if($('#header input#searchLocations').val() == "") {
			searchLocations = "";
		}
		if(searchLocations == "" && currLC != "") {
			searchLocations = searchLocations + currLC;
		} else if(searchLocations != "" && currLC != "") {
			searchLocations = searchLocations + ',' + currLC;
		} 
		$('#header input#searchLocations').val(searchLocations);
	});
	
	//검색 멤버수 설정
	//슬라이더 이동할때마다 멤버수 표시하기
	$('#header #searchMBRange').on('input', function() {
		var members = $(this).val();
		var output = $('#searchMemebers');
		output.text(this.value);
	});

	//여행일자 선택
	//주어진 보기에서 선택시, 입력폼 가리고 클래스 주기
	$('#header').on('click', '[id^=searchT-]', function() {
		$('#header').find('[id^=searchT-]').removeClass('selectedTerm');
		$(this).addClass('selectedTerm');
		$('#header #searchTerm').val('');
		$('#header #searchTerm').hide();
		var selectedTerm = $(this).attr('id').replace('searchT-', '').trim();
		$('#header #searchTerm').val(selectedTerm);
	});
	
	//여행일자 자유입력시, 입력폼 보여주기
	$('#header').on('click', 'span#freeTerm', function() {
		$('#header').find('[id^=searchT-]').removeClass('selectedTerm');
		$('#header #searchTerm').val('');
		$('#header #searchTerm').toggle();
	});
	
	//해시태그 다중 선택
	$('#header').on('click', 'button#searchAddHT', function(event) {
		event.preventDefault();
		var currHT = $('#header select[name=hastagList]').val();
		if($('#header input#searchHashtags').val() == "") {
			searchHashtags = "";
		}
		if(searchHashtags == "" && currHT != "") {
			searchHashtags = searchHashtags + currHT;
		} else if(searchHashtags != "" && currHT != "") {
			searchHashtags = searchHashtags + ',' + currHT;
		} 
		$('#header input#searchHashtags').val(searchHashtags);
	});
	
});
</script>

