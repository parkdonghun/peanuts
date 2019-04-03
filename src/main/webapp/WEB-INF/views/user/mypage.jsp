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
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
    #messageModal a, #messageModal td, #messageModal th, #messageModal option {color: #808080; font-size: 13px;}
    #messageModal a:link {color: #808080;}
    #messageModal a:hover {color: #ac7339;}
    
    #messageModal .modal-header {background-color: #ac7339; color: #ffffff;}
	#left-menu li.selected {background-color: #c68c53; color: #ffffff;}
	#left-menu li:hover:not(.selected) {color: #ac7339;}  
	#newAlertBadge-2 {background-color: #ac7339; color: #ffffff;}
	
	.pagination a:link {color: #737373; text-decoration: none;}
	.pagination a:visited {color: #737373; text-decoration: none;}
   	.pagination a.selected {background-color: #c68c53; color: #ffffff;}
	.pagination a:hover:not(.selected) {color: #c68c53;}

	
	.dday {
		position: relative;
	    padding-top: 12px;
		width: 50px;
		height: 50px;
		background-color: #b33c00;
		color: white;
		text-align: center;
		border-radius: 30px;
		opacity: 0.6;
	}
	/* The switch - the box around the slider */
	#myplannerList .switch {
	  position: relative;
	  display: inline-block;
	  width: 40px;
	  height: 20px;
	}
	
	/* Hide default HTML checkbox */
	#myplannerList .switch input {display:none;}
	
	/* The slider */
	#myplannerList .slider {
	  position: absolute;
	  cursor: pointer;
	  top: 0;
	  left: 0;
	  right: 0;
	  bottom: 0;
	  background-color: #802b00;
	  -webkit-transition: .4s;
	  transition: .4s;
	}
	#myplannerList .slider:before {
	  position: absolute;
	  content: "";
	  height: 14px;
	  width: 14px;
	  left: 4px;
	  bottom: 4px;
	  background-color: white;
	  -webkit-transition: .4s;
	  transition: .4s;
	}
	
	#myplannerList input:checked + .slider {
	  background-color: #ccc;
	}
	
	#myplannerList input:focus + .slider {
	  box-shadow: 0 0 1px #ccc;
	}
	
	#myplannerList input:checked + .slider:before {
	  -webkit-transform: translateX(20px);
	  -ms-transform: translateX(20px);
	  transform: translateX(20px);
	}
	
	/* Rounded sliders */
	#myplannerList .slider.round {
	  border-radius: 20px;
	}
	
	#myplannerList .slider.round:before {
	  border-radius: 50%;
	}
	
	.plan-detail {position: relative; width: 237px; height: 300px; opacity:0.8; background-color: #996633; margin-bottom: -300px;}
	.plan-detail p {color: #ffffff; font-size: 12px; font-weight: lighter;}
	
	.pagination a {
	    color: black;
	    float: left;
	    padding: 8px 16px;
	    text-decoration: none;
	    transition: background-color .3s;
	}
	.pagination a.active {
	    background-color: #a0522d;
	    color: white;
	    border-radius: 10px;
	}
	.pagination a:hover:not(.active) {
		background-color: #ddd;
	    border-radius: 10px;
	}
	
</style>
<script type="text/javascript">
function datef(time){
	var dbtime = new Date(time);
	var currentTime = new Date().getTime();
	var d = 86400;
	
    var dday = Math.round(((dbtime - currentTime)/1000)/d);
	if(dday < 0){
		return "완료";
	}
	return "D-"+dday;
}
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


$(function(){
	
	getPlanner()
	
	$('#mypage-leftMenu .list-group-item').click(function(){
		$('#mypage-leftMenu .list-group-item').removeClass("active").css("background-color", "").css("border-color","");
		$(this).addClass("active").css("background-color", "#c68c53").css("border-color","#c68c53");
		
		type = $('.active').attr('id');
	});
	$('#myPlan').click(function() {
		getPlanner();		
	});
	$('#likePlan').click(function() {
		getPlanner();		
	});
	
	if ('${param.err}' == 'already'){
		alert('이미 등록된 관심플래너입니다.');
	}
	function getPlanner(planNo, openStatus){
		
		var type = $('.active').attr('id');
		var param = {type:type};
		if (planNo) {
			param.planNo = planNo;
			param.openStatus = openStatus;
		} else {
			param.planNo = 0;
			param.openStatus = "";
		}
		
		$.ajax({
			type: 'GET',
			url: '/user/planList.do?id=${param.id}',
			dataType: 'json',
			data: param,
			success: function(result){
				$('#myplannerList').empty();
				var $myplannerList = $('#myplannerList');
	
				var myplanList = result;
				$.each(myplanList, function(n, items){
					var Dday = datef(items.startDate);
					var tg = hashT(items.hashTag);
					
					var row ="";
					row += '<div class="col-sm-4 col-md-4"><div class="thumbnail" style="height: 360px;">';
					row += '<div>';
					row += '<div class="row plan-detail" id="plan-detail-'+items.no+'" style="display: none; margin-left:1px; padding:10px; padding-top:30px;">'
					row += '<p><strong>여행출발</strong></p>';
					row += '<p style="margin-top: -10px;">'+items.startMonth+'</p>';
					row += '<p><strong>여행지역</strong></p>';
					row += '<p id="plan-locations-'+items.no+'" style="margin-top: -10px;"></p>';
					row += '<p><strong>해시태그</strong></p>';				
					if(tg == ""){						
						row += '<p style="margin-top: -10px;">없음</p>';
					} else {						
						row += '<p style="margin-top: -10px;">'+tg+'</p>';
					}
					row += '</div>';
					if("${param.id}" == "${LOGIN_USER.id}"){		 
						if(items.planType == 'myPlan'){
							if(items.open == 'Y'){			
								row += '<label class="switch"><input type="checkbox" id="open-'+items.no+'"><span class="slider round" style="height: 20px;"></span></label>';
							} else if(items.open == 'N'){
								row += '<label class="switch"><input type="checkbox" id="open-'+items.no+'" checked="checked"><span class="slider round" style="height: 20px;"></span></label>';
							}
						}
						 if(items.planType == 'myPlan'){					
							row += '<a href="delPlanner.do?pno='+items.no+'"><span class="glyphicon glyphicon-remove pull-right" style="color: gray;"></span></a></div>'
						} else if(items.planType == 'likePlan'){
							row += '<a href="delLikePlanner.do?pno='+items.no+'"><span class="glyphicon glyphicon-remove pull-right" style="color: gray;"></span></a></div>'
						}
					}
					row += '<div id="plan-map-'+items.no+'"><div style="max-height:200px; overflow-y : hidden;">';
					row += '<a href="/planner/dashboard.do?pno='+items.no+'"><img style="width:242px; max-height:200px;" style="border: 2px solid #e4e4e4" src="'+items.mapImg+'"></a></div>';
					row += '<div class="dday" style="left:75%; top: -160px;">';
					row += '<p style="font-size: 17px;">'+Dday+'</p></div></div>';
					row += '<div>';
					row += '<ul class="list-unstyled">';
					row += '<li style="text-align: center; font-size:20px;"><a href="dashboard.do?pno='+items.no+'"><strong>'+items.title+'</strong></a></li>';
					row += '<li style="text-align: center; color: #595959;">'+items.startMonth+'</li>';
					row += '<li style="text-align: center"><a href="addPlanLike.do?id=${param.id}&pno='+items.no+'" class="btn btn-danger btn-xs" id="addlike-'+items.no+'">♡ <span class="badge">'+items.likeCnt+'</span></a></li>';
					row += '</ul></div></div></div>';
					
					if("${param.id}" != "${LOGIN_USER.id}" && items.open == 'Y'){
						$myplannerList.prepend(row);
						
					} else if("${param.id}" == "${LOGIN_USER.id}"){						
						$myplannerList.prepend(row);
						$('a[id^="addlike"]').attr("readonly","readonly").removeAttr("href");
					}
					
				});
				if("${param.id}" == "${LOGIN_USER.id}" && type == 'myPlan'){				
					var nrow = '';
					nrow += '<div class="col-sm-4 col-md-4"><div class="thumbnail" style="height: 360px; text-align: center;">';
					nrow += '<a href="/map/addPlanForm.do"><button class="btn btn-success btn-md" style="margin-top: 160px;"> + 여행 등록하기</button></a></div></div>'; 
					$myplannerList.append(nrow);
				}
			}	
		});	
	}
	
		$('#myplannerList').on('change', 'input[id^="open-"]', function(){
			var openStatus = ($(this).prop('checked') ? 'N' : 'Y');
		
			var planNo = $(this).attr('id').replace('open-','');
			getPlanner(planNo, openStatus);
		});

})



</script>
<body>
<jsp:include page="../include/header.jsp" />
<div class="container" style="width: 60%; min-height: 740px;">
	<div class="row">
		<div class="col-sm-3">
			<div class="well" style="text-align: center">
				<img src="../resources/images/profile/${userInfo.profile }" class="img-circle center-block" width="200px;" height="200px;">
				<h3><strong>${userInfo.id }</strong></h3>
				<c:choose>
					<c:when test="${not empty LOGIN_USER.id}">
						<c:if test="${param.id eq LOGIN_USER.id }">	
							<h5 style="color: gray;">
								<img src="../resources/images/logo/peanutbw.png" style="width: 20px; height: 20px;"> <strong>${userInfo.peanuts }</strong>
							</h5>
							<div class="btn-group" role="group">				
								<button id="profile-img" class="btn btn-warning btn-sm">사진 변경</button>
								<button id="modify-user" class="btn btn-warning btn-sm">정보 수정</button>
							</div>
						</c:if>
					</c:when>
				</c:choose>
			</div>
			<div>
				<div class="list-group" id="mypage-leftMenu">
					<a href="#" class="list-group-item active" style="background-color:#c68c53; border-color: #c68c53;" id="myPlan">
						<span class="glyphicon glyphicon-th"></span> 나의 플래너 
						<span class="badge" style="background-color : white; color: #c68c53;">${planCnt }</span></a>
					<a href="#" class="list-group-item" id="likePlan">
						<span class="glyphicon glyphicon-heart"></span> 관심 플래너 
						<span class="badge" style="background-color : white; color: #c68c53;">${likePlanCnt }</span></a>
					<c:choose>
						<c:when test="${not empty LOGIN_USER.id}">
							<c:if test="${param.id eq LOGIN_USER.id }">							
								<a href="#" class="list-group-item" id="btn-msgBox"><span class="glyphicon glyphicon-envelope"></span> 쪽지함
									<span class="badge" style="background-color : white; color: #c68c53;" id="newAlertBadge-1"></span></a>
								<a href="#" class="list-group-item" onclick="getOrderList(1,new Date(), getLastMonth(24))">
									<span class="glyphicon glyphicon-shopping-cart"></span> 주문내역</a>
							</c:if>							
						</c:when>
					</c:choose>
				</div>
			</div>
		</div>
		<div class="col-sm-9" id="myplannerList">
		
		</div>
	</div>
	
	<!-- Modal -->
	<div id="profile-modal" class="modal fade" role="dialog">
		<div class="modal-dialog modal-sm">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header"
					style="background-color: #ac7339; color: white;">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">프로필 사진 변경</h4>
				</div>
				<div class="modal-body">
					<form class="form-group" id="plus-form" action="imgModify.do" method="post" enctype="multipart/form-data">
						<div class="form-group">
							<div style="position: relative; overflow: hidden;">
					    		<img id="img-preview" width="150px" height="150px" class="img-circle center-block" 
					    			src="../resources/images/profile/${userInfo.profile }">
					    	</div>
						</div>
						<div class="form-group">
							<input id="imgInp" type="file" name="profile">
						</div>
						<div align="right">
							<button class="btn btn-primary btn-sm" id="btn-profile">등록</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="msg-container">
		<div class="modal fade" id="messageModal" role="dialog">
			<div class="modal-dialog modal-lg">
	
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">메시지함</h4>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-sm-3">
								<div class="panel panel-default">
									<ul class="list-group" id="left-menu">
										<li class="list-group-item" id="recievedMsg">받은메시지함 <span class="badge" id="newAlertBadge-2"></span></li>
										<li class="list-group-item" id="sentMsg">보낸 메시지함</li>
										<li class="list-group-item" id="delMsg">삭제 메시지함</li>
										<li class="list-group-item" id="newMsg">새 메시지</li>
									</ul>
								</div>
								<img src="/resources/images/logo/peanuts.png" width="190px;"/>
							</div>
							<div class="col-sm-9" id="right-menu">
								<!-- ajax를 사용해서 변경될위치, 모달 오픈시에는 받은메시지함이 default -->
								<!-- 각 메시지함마다 페이징 필요 선택삭제, 전체 삭제(비우기) 그리고 1페이지로 돌아오기 
	               			    	* 선택정렬 : 전체메시지, 즐겨찾기 메시지 : 읽은 메시지 : 안읽음 메시지-->
								<div id="recievedBox" style="display: none;" >
									<table class="table">
										<colgroup>
											<col width="10%">
											<col width="7%">
											<col width="*">
											<col width="23%">
										</colgroup>
										<thead>
											<tr>
												<td colspan="3" class="text-left">
													<button class="btn btn-xs btn-danger" id="all-select">전체선택</button>
													<button class="btn btn-xs btn-default" id="del-selected">선택삭제</button>
												</td>
												<td class="text-right">
													<!-- criteria 사용 : where절용 -->
													<select name="listBy" class="btn btn-xs">
														<option value="all" selected>모든메시지</option>
														<option value="mark">즐겨찾기</option>
														<option value="unread">안읽은메시지</option>
														<option value="read">읽은메시지</option>
													</select>
												</td>
											</tr>
											<tr>
												<th></th>
												<th>발신</th>
												<th>내용</th>
												<th>수신일</th>
											</tr>	
										</thead>
										<tbody></tbody>
										<tfoot></tfoot>
									</table>
								</div>
								<div id="sentBox" style="display: none">
									<table class="table">
										<colgroup>
											<col width="15%">
											<col width="7%">
											<col width="*">
											<col width="23%">
										</colgroup>	
										<thead>
											<tr>
												<td colspan="4" class="text-left">
													<button class="btn btn-xs btn-danger" id="all-select">전체선택</button>
													<button class="btn btn-xs btn-default" id="can-selected">선택발송취소</button>
													<span class="pull-right" style="font-weight: bolder;">
														※ 상대방이 읽지않은 경우에만, 발송취소 가능합니다.
													</span>												
												</td>
											</tr>									
											<tr>
												<th></th>
												<th>수신</th>
												<th>내용</th>
												<th>발신일</th>
											</tr>
										</thead>							
										<tbody></tbody>
										<tfoot></tfoot>
									</table>
								</div>
								<div id="delBox" style="display: none">
									<table class="table">
										<colgroup>
											<col width="10%">
											<col width="7%">
											<col width="*">
											<col width="23%">
										</colgroup>
										<thead>
											<tr>
												<th colspan="4">
													<button class="btn btn-xs btn-success" id="all-select">전체선택</button>
													<button class="btn btn-xs btn-default" id="rec-selected">선택복구</button>
													<span class="pull-right" style="color: #e60000; font-weight: bolder;">
														※ 삭제일 기준 30일 이후 완전삭제 됩니다.
													</span>
												</th>
											</tr>
											<tr>
												<th></th>
												<th>발신</th>
												<th>내용</th>
												<th>삭제일</th>
											</tr>										
										</thead>
										<tbody></tbody>
										<tfoot></tfoot>
									</table>							
								</div>
								<div id="newBox" style="display: none">
									<form method="POST" action="sendMessage.do" id="sendMsg-form">
										<div class="form-group">
											<input type="text" class="form-control" name="receiver" placeholder="받는 사용자 닉네임"/>
											<p style="font-size: 12px;">※ 동시 발송 : 닉네임을 |(SHIFT+\키)로 구분</p>
										</div>
										<div style="text-align: right; font-size: 12px; margin-bottom: 3px;">
											<span>남은 글자수 | </span><span id="textRange">650</span>
											<button class="btn btn-xs btn-success">보내기</button>
										</div>
										<div style="background-color: #c68c53; color: #ffffff; font-size: 12px; padding: 7px;"> ※ 개인정보 기입 금지, 개인정보를 요구하는 경우 관리자에게 문의해주세요!</div>
										<div class="form-group">
											<textarea rows="10" maxlength="649" class="form-control" name="contents" style="resize: none;"></textarea>
										</div>
									</form>
								</div>
								
								<!-- 메시지 내용 클릭시, 표시될 디테일 페이지 -->
								<div id="detailBox" style="display: none">
									<table class="table">
										<colgroup>
											<col width="10%">
											<col width="20%">
											<col width="*">
										</colgroup>
										<thead>
											<tr>
												<th rowspan="2"><img width="50px;" height="50px;" id="sorcPic" style="border-radius: 50%; margin-top: -5px; margin-left: 5px;"/></th>
												<th id="sorc"></th>
												<td id="sorcUserId"></td>
											</tr>
											<tr>
												<th>보낸날짜</th>
												<td id="sorcAnswer"></td>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td colspan="3">
													<div class="form-control"  id="sorcContents" style="overflow-y: scroll; height: 250px; " ></div>
												</td>
											</tr>
										</tbody>
										<tfoot>
											<tr>
												<td colspan="3" class="text-right">
													<button id="toList" class="btn btn-xs btn-default" style="background-color: #c68c53; color: #ffffff;">
														<span class="glyphicon glyphicon-list"></span>목록으로
													</button>
												</td>
											</tr>
										</tfoot>
									</table>
								</div>
								
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Modal -->
	<div id="confirmPassword-modal" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	    <!-- Modal content-->
	    <div class="modal-content">
	      <div class="modal-header" style="background-color: #ac7339; color: white;">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">비밀번호 확인</h4>
	      </div>
	      <div class="modal-body">
        	<input type="password" id="inputPassword">
	        <button class="btn btn-default" id="confirmPassword">확인</button>
	        <button class="btn btn-default" id="cfp-modal-close">취소</button>
	      </div>
	    </div>
	  </div>
	</div>
	<div id="updateUser-modal" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	    <!-- Modal content-->
	    <div class="modal-content">
	      <div class="modal-header" style="background-color: #ac7339; color: white;">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">회원정보 수정</h4>
	      </div>
	      <div class="modal-body">
	        <form class="well" action="updateUser.do" method="post" id="updateUser-form">
				<div class="form-group col-md-12 wrapper">
					<div class="input-group">
						<span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
						<input type="password" class="form-control" name="pwd" id="form-pwd" placeholder="변경할 비밀번호를 입력하거나 현재 사용중인 비밀번호를 입력해주세요." />
					</div>
						<span id="check-pwd1" style="color: red" class="help-block text-left">비밀번호를 입력해주세요.</span>
				</div>
				<div class="form-group col-md-12 wrapper">
					<div class="input-group">
						<span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
						<input type="password" class="form-control col-md-3" id="form-pwdcheck" placeholder="변경할 비밀번호를 다시 입력해주세요" />
					</div>
						<span id="check-pwd2" style="color: red" class="help-block text-left">비밀번호가 일치하지않습니다.</span>
				</div>
				<div class="form-group col-md-12 wrapper">
					<div class="input-group">
						<span class="input-group-addon"><span class="glyphicon glyphicon-envelope"></span></span>
						<input type="email" class="form-control" name="email"  id="form-email" placeholder="변경할 이메일 주소를 입력해주세요" />
					</div>
						<span id="check-email" style="color: red" class="help-block text-left">이메일을 입력해주세요.</span>
				</div>
				<div class="form-group col-md-12 wrapper">
					<div class="input-group">
						<span class="input-group-addon"><span class="glyphicon glyphicon-phone"></span></span>
						<input type="tel" class="form-control" name="tel"  id="form-phone" placeholder="휴대폰 번호를 입력해주세요" />
					</div>
						<span id="check-tel" style="color: red" class="help-block text-left">휴대폰 번호를 입력해주세요.</span>
				</div>
				<div class="text-center">
					<a href="outPut.do" class="btn btn-warning btn-lg">탈퇴</a>
					<button class="btn btn-warning btn-lg">수정</button>
					<button type="button" class="btn btn-warning btn-lg" data-dismiss="modal">취소</button>
				</div>
	        </form>
	      </div>
	    </div>
	  </div>
	</div>
	<div id="ne-password" class="modal fade" role="dialog">
	  <div class="modal-dialog">
	    <!-- Modal content-->
	    <div class="modal-content">
	      <div class="modal-header" style="background-color: #ac7339; color: white;">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">비밀번호 불일치</h4>
	      </div>
	      <div class="modal-body">
	       <h4>비밀번호가 올바르지 않습니다.</h4>
	       <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
</div>
<jsp:include page="../include/footer.jsp" />
</body>
<script type="text/javascript">
$(function(){
	
	//모달 창 띄우기
	$('#profile-img').click(function(){
		$('#profile-modal').modal('show');
	});
	$('#btn-msgBox').click(function() {
		$('#messageModal').modal('show');
	})
	$('#modify-user').click(function() {
		$('#confirmPassword-modal').modal('show');
		$('#inputPassword').val('');
	})
	//모달 창 닫기
	$('.closeModal').click(function() {
		$('#confirmPassword-modal').modal('hide');
		$('#updateUser-modal').modal('show');
		$('#ne-password').modal('show');
	})
	$('#cfp-modal-close').click(function() {
		$('#confirmPassword-modal').modal('hide');
		$('#inputPassword').val('');
	})
	//프로필사진 변경 미리보기
	function readURL(input) {
		  if (input.files && input.files[0]) {
		    var reader = new FileReader();

		    reader.onload = function(e) {
		      $('#img-preview').attr('src', e.target.result);
		    }

		    reader.readAsDataURL(input.files[0]);
		  }
	}
	$("#imgInp").change(function() {
		readURL(this);
	});
	
	//modal 기존 쓰레기값 지우기
	$('#profile-modal').on("hide.bs.modal", function(){
		$("[name=file-img]").val('');
		$('#img-preview').attr('src', '../resources/images/profile/DEFAULT_PROFILE.JPG');
	});
	
	//공용변수
	var totalMsg;		//전체 메시지 수
	var totalPageNo;	//전체 페이지수 (컨텐츠수 / 10)
	var totalBlocks;	//전체 블록수 (페이지수/nav 반올림)
	var currentBlock;	//현재 블록
	var start;
	var end;
	var beginPage;	//시작 페이지
	var endPage;	//끝 페이지
	var currentModalPageNo = 1;
	var nav = 5;	
	
	var listBy;
	var section;
	var $rbox = $('#recievedBox');
	var $sbox = $('#sentBox');
	var $dbox = $('#delBox');
	var $nbox = $('#newBox');
	var $dtbox = $('#detailBox');
	
    $('textarea[name=contents]').keyup(function (){
        //메시지 내용길이
    	var content = $(this).val();
        //메시지 내용길이 카운트하기
		var counter = 650 - content.length
        if(counter <= 0) {
        	counter = 0;
        }
        if(counter == 0) {
        	$('#textRange').css('color', 'red');	
        }
		$('#textRange').text(counter);
    });
      
	//사용자가 읽지않은 메시지 갯수 (메시지 읽을때마다 실행해야함)
	//기존의 읽음여부에 상관없이 매번 실행해서 확인해야함
	function newAlertBadge() {
		$.ajax({
				type: 'GET',
				url: 'getMessages.do',
				data: {keyword: 'unread'},
				dateType: 'json',
				success: function(result) {
					$('span[id^=newAlertBadge]').text(result.length);
				}
		});
	}
	newAlertBadge();
	
	//Modal 꺼질때마다 api 리스트 표시되는 modal body 지우기
	$('#messageModal').on('hide.bs.modal',function(){
		currentModalPageNo = 1;
		$('input[name=receiver]').val('');
		$('span#textRange').val('650');
		$('textarea[name=contents]').val('');
		
		$('#left-menu li').removeClass('selected')
		$('select[name=listBy]').val('all');
		$('div[id$="Box"]').css('display', 'none');
		$rbox.find('tbody').empty();
		$rbox.find('tfoot').empty();
		$sbox.find('tbody').empty();
		$sbox.find('tfoot').empty();
		$dbox.find('tbody').empty();
		$dbox.find('tfoot').empty();
		$dtbox.hide();
	});		
	
	//left-menu selected 시키고, right-menu show시키기
	$('#left-menu li').on('click', function() {
		//우측 모든 화면 가리기
        $('div[id$="Box"]').css('display', 'none');
        $dtbox.hide();

		//각 섹션별 페이지번호 초기화
		currentModalPageNo = 1;
		
		//작성중이던 메시지가 있을 경우 초기화
		$('input[name=receiver]').val('');
		$('span#textRange').val('650');
		$('textarea[name=contents]').val('');		
		
		//수신메시지함 정렬방식 초기화
		$('select[name=listBy]').val('all');
		
		//left-menu selected 클래스 지정
		$('#left-menu li').removeClass('selected');
        $(this).addClass('selected');

        //좌측 섹션값 가져오기
        var msgId = $(this).attr('id').replace('Msg', '').trim();
        section = msgId;
        //보여줄 우측섹션 값담기
		if(msgId == 'recieved'){
			recievedBox();
		}
		if(msgId == 'sent'){
			sentBox();
		}
		if(msgId == 'del'){
			delBox();
		}
		//선택한 섹션화면 보여주기
		$('div[id="'+msgId+'Box"]').css('display', 'block');
	});
	
	$('select[name=listBy]').change(function() {
		currentModalPageNo = 1;
		recievedBox();
	});
	
	//수신 메시지함 ajax
	function recievedBox() {
		listBy = $('select[name=listBy]').val();
		$.ajax({
			type: 'GET',
			url: '/user/getMessages.do',
			data: {keyword: listBy},
			dataType: 'json',
			success: function(result) {
				$rbox.find('tbody').empty();
				$rbox.find('tfoot').empty();
				start = (currentModalPageNo-1)*10;
				end = (currentModalPageNo*10);
				
				var rows;
				if(result.length != 0) {
					totalMsg = result.length;
					totalPageNo = Math.ceil(totalMsg/10);
					if(currentModalPageNo == totalPageNo){
						end = result.length
					}
					
					for(var i=start; i<end; i++){
 						rows += "<tr>";
						rows += "<td><input type='checkbox' id='check-"+result[i].msgKey+"' />";
						if(result[i].mark == 'Y') {
							rows += "<span class='glyphicon glyphicon-star' style='margin-left: 5px; color: #e6b800;' id='mark-"+result[i].msgKey+"'></span></td>";
						} else {
							rows += "<span class='glyphicon glyphicon-star' style='margin-left: 5px; color: #bfbfbf;' id='mark-"+result[i].msgKey+"'></span></td>";
						}
						rows += "<td><a href='mypage.do?id="+result[i].userId+"'>"+result[i].userId+"</a></td>";
						if(result[i].status == 'N') {
							rows += "<td><a href='#' id='detail-"+result[i].msgKey+"' style='color: #ac7339;'>■ "+result[i].contentsWithDots+"</a></td>";
						} else {
							rows += "<td><a href='#' id='detail-"+result[i].msgKey+"'>"+result[i].contentsWithDots+"</a></td>";
						}
						rows += "<td>"+result[i].createDateToStringWithTime+"</td>";
						rows += "</tr>";	
					}
				} else {
					totalMsg = 1;
					totalPageNo = Math.ceil(totalMsg/10);					
					rows += '<tr><td colspan="4" class="text-center">수신메시지가 존재하지 않습니다.</td></tr>';
				}
				$rbox.find('tbody').append(rows);
				
				totalBlocks = Math.ceil(totalPageNo/nav);
				currentBlock = Math.ceil(currentModalPageNo/nav);
				beginPage = ((currentBlock-1)*nav)+1;
				endPage = currentBlock*nav;		
				 
				pagination = "<tr><td colspan='4' style='text-align: center;'><nav>";
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
					if (currentModalPageNo == i){
						pagination += "<li><a href='#' class='selected'>"+i+"</a></li>";
					} else {
						pagination += "<li><a href='#'>"+i+"</a></li>";
					}
				}
				if(currentBlock != totalBlocks){
				    pagination += "<li><a href='#' aria-label='Next'>";
				    pagination += "<span aria-hidden='true'>&raquo;</span></a></li>";
				}
			    pagination += "</ul></nav></td></tr>";
			    $rbox.find('tfoot').append(pagination);				
			}
		});
	}
	
	//rbox pagination 클릭한경우
	$rbox.find('tfoot').on('click', 'a', function(){
		currentModalPageNo = $(this).text();
		recievedBox();
		return false;
	});		
	$rbox.find('tfoot').on('click', 'a[aria-label="Previous"]', function(){
		currentBlock = currentBlock == 1 ? currentBlock : currentBlock-1;
		currentModalPageNo = ((currentBlock-1)*nav)+1;	
		recievedBox();
		return false;
	});		
	$rbox.find('tfoot').on('click', 'a[aria-label="Next"]', function(){
		currentBlock = currentBlock+1;
		currentModalPageNo = ((currentBlock-1)*nav)+1;		
		recievedBox();
		return false;
	});		
	
	//발신 메시지함 ajax
	function sentBox() {
		$.ajax({
			type: 'GET',
			url: '/user/getSentMessages.do',
			dataType: 'json',
			success: function(result) {
				$sbox.find('tbody').empty();
				$sbox.find('tfoot').empty();
				start = (currentModalPageNo-1)*10;
				end = (currentModalPageNo*10);
				
				var rows;
				if(result.length != 0) {
					totalMsg = result.length;
					totalPageNo = Math.ceil(totalMsg/10);
					if(currentModalPageNo == totalPageNo){
						end = result.length
					}
					
					for(var i=start; i<end; i++) {
						rows += "<tr>";
						//읽은여부에 따른 버튼 표시
						if(result[i].status == 'Y') {
							rows += "<td style='color: #39ac39; font-size: 12px; padding-left: 27px;'><strong>읽음</strong></td>";
						} 
						if(result[i].status == 'N') {	
							rows += "<td style='padding-left: 33px;'><input type='checkbox' id='check-"+result[i].msgKey+"'/></td>";
						}
						rows += "<td><a href='mypage.do?id="+result[i].receiver+"'>"+result[i].receiver+"</a></td>";
						rows += "<td><a href='#' id='detail-"+result[i].msgKey+"'>"+result[i].contentsWithDots+"</a></td>";
						//읽은 여부에 따른 읽은시각 표시
						if(result[i].status == 'Y') {
							rows += "<td style='color: #39ac39;'><strong>"+result[i].readDateToStringWithTime+"</strong></td>";
						}
						if(result[i].status == 'N') {	
							rows += "<td>"+result[i].createDateToStringWithTime+"</td>";
						}
						rows += "</tr>";	
					}
				} else {
					totalMsg = 1;
					totalPageNo = Math.ceil(totalMsg/10);						
					rows += "<tr><td colspan='4' class='text-center'>발신메시지가 존재하지 않습니다.</tr>";
				}
				$sbox.find('tbody').append(rows);
				
				totalBlocks = Math.ceil(totalPageNo/nav);
				currentBlock = Math.ceil(currentModalPageNo/nav);
				beginPage = ((currentBlock-1)*nav)+1;
				endPage = currentBlock*nav;		
				 
				pagination = "<tr><td colspan='4' style='text-align: center;'><nav>";
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
					if (currentModalPageNo == i){
						pagination += "<li><a href='#' class='selected'>"+i+"</a></li>";
					} else {
						pagination += "<li><a href='#'>"+i+"</a></li>";
					}
				}
				if(currentBlock != totalBlocks){
				    pagination += "<li><a href='#' aria-label='Next'>";
				    pagination += "<span aria-hidden='true'>&raquo;</span></a></li>";
				}
			    pagination += "</ul></nav></td></tr>";
			    $sbox.find('tfoot').append(pagination);				
			}
		});
	}	
	
	//sbox pagination 클릭한경우
	$sbox.find('tfoot').on('click', 'a', function(){
		currentModalPageNo = $(this).text();
		sentBox();
		return false;
	});		
	$sbox.find('tfoot').on('click', 'a[aria-label="Previous"]', function(){
		currentBlock = currentBlock == 1 ? currentBlock : currentBlock-1;
		currentModalPageNo = ((currentBlock-1)*nav)+1;	
		sentBox();
		return false;
	});		
	$sbox.find('tfoot').on('click', 'a[aria-label="Next"]', function(){
		currentBlock = currentBlock+1;
		currentModalPageNo = ((currentBlock-1)*nav)+1;		
		sentBox();
		return false;
	});		

	//삭제 메시지함 ajax
	function delBox() {
		$.ajax({
			type: 'GET',
			url: '/user/getdelMessages.do',
			dataType: 'json',
			success: function(result) {
				$dbox.find('tbody').empty();
				$dbox.find('tfoot').empty();
				start = (currentModalPageNo-1)*10;
				end = (currentModalPageNo*10);
				
				var rows;
				if(result.length != 0) {
					totalMsg = result.length;
					totalPageNo = Math.ceil(totalMsg/10);
					if(currentModalPageNo == totalPageNo){
						end = result.length
					}
					
					for(var i=start; i<end; i++) {
						rows += "<tr>";
						rows += "<td><input type='checkbox' id='check-"+result[i].msgKey+"' />";
						if(result[i].mark == 'Y') {
							rows += "<span class='glyphicon glyphicon-star' style='margin-left: 5px; color: #e6b800;' id='mark-"+result[i].msgKey+"'></span></td>";
						} else {
							rows += "<span class='glyphicon glyphicon-star' style='margin-left: 5px; color: #bfbfbf;' id='mark-"+result[i].msgKey+"'></span></td>";
						}
						rows += "<td><a href='mypage.do?id="+result[i].userId+"'>"+result[i].userId+"</a></td>";
						if(result[i].readDate == null) {
							rows += "<td><a href='#' id='detail-"+result[i].msgKey+"' style='color: #ac7339;'>■ "+result[i].contentsWithDots+"</a></td>";
						} else {
							rows += "<td><a href='#' id='detail-"+result[i].msgKey+"'>"+result[i].contentsWithDots+"</a></td>";
						}
						rows += "<td>"+result[i].delDateToStringWithTime+"</td>";
						rows += "</tr>";	
					}
				} else {
					totalMsg = 1;
					totalPageNo = Math.ceil(totalMsg/10);						
					rows += "<tr><td colspan='4' class='text-center'>삭제메시지가 존재하지 않습니다.</tr>";
				}
				$dbox.find('tbody').append(rows);
				
				totalBlocks = Math.ceil(totalPageNo/nav);
				currentBlock = Math.ceil(currentModalPageNo/nav);
				beginPage = ((currentBlock-1)*nav)+1;
				endPage = currentBlock*nav;		
				 
				pagination = "<tr><td colspan='4' style='text-align: center;'><nav>";
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
					if (currentModalPageNo == i){
						pagination += "<li><a href='#' class='selected'>"+i+"</a></li>";
					} else {
						pagination += "<li><a href='#'>"+i+"</a></li>";
					}
				}
				if(currentBlock != totalBlocks){
				    pagination += "<li><a href='#' aria-label='Next'>";
				    pagination += "<span aria-hidden='true'>&raquo;</span></a></li>";
				}
			    pagination += "</ul></nav></td></tr>";
			    $dbox.find('tfoot').append(pagination);				
			}
		});
	}
	
	//dbox pagination 클릭한경우
	$dbox.find('tfoot').on('click', 'a', function(){
		currentModalPageNo = $(this).text();
		delBox();
		return false;
	});		
	$dbox.find('tfoot').on('click', 'a[aria-label="Previous"]', function(){
		currentBlock = currentBlock == 1 ? currentBlock : currentBlock-1;
		currentModalPageNo = ((currentBlock-1)*nav)+1;	
		delBox();
		return false;
	});		
	$dbox.find('tfoot').on('click', 'a[aria-label="Next"]', function(){
		currentBlock = currentBlock+1;
		currentModalPageNo = ((currentBlock-1)*nav)+1;		
		delBox();
		return false;
	});		
	
	//신규 메시지 발송
	$('#sendMsg-form').submit(function(event) {
		event.preventDefault();
		
		var receiver = $('input[name=receiver]').val();
		var contents = $('textarea[name=contents]').val();
		if(receiver == '') {
			alert('수신 닉네임을 입력하세요.');
			return false;
		}
		if(contents == '') {
			alert('메세지 내용을 입력하세요.');
			return false;
		}
		
		$.ajax({
			type: 'POST',
			url: '/user/sendMessage.do',
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			data: {receiver: receiver, contents: contents},
			complete: function() {
				//보낸메세지함 첫 페이지로
				currentModalPageNo = 1;
				currentBlock = 1;
				section = 'sent';
				$('#left-menu li').removeClass('selected');
		        $('#left-menu li#sentMsg').addClass('selected');				
				sentBox();
		        $('div[id$="Box"]').css('display', 'none');
				$('div[id=sentBox]').css('display', 'block');		
				
			}
		});
	});	
	
	//메세지 상세 내용보기
	$('.msg-container').on('click', 'a[id^=detail-]', function() {
		$('div[id$="Box"]').css('display', 'none');
		var msgKey = $(this).attr('id').replace('detail-', '').trim();

		var keyword;
		if(section == 'recieved' || section == 'del') {
			keyword = {category: 'rd', key: msgKey};
			$('#sorc').text("발신");
		}
		if(section == 'sent') {
			keyword = {category: 's', key: msgKey}
			$('#sorc').text("수신");
		}
		var messageDetail;
		$.ajax({
			type: 'GET',
			url: '/user/getMessageDetail.do',
			data: keyword,
			dataType: 'json',
			async: false,
			success: function(result) {
				$('#sorcPic').attr('src', '/resources/images/profile/'+result.profile);
				$('#sorcUserId').text(result.id);
				$('#sorcAnswer').text(result.createDateToString);
				$('#sorcContents').html(result.contentsWithBr);
				$dtbox.css('display','block');
				newAlertBadge();
			}
		});	
	})
	
	//해당 메시지함 리스트 첫 페이지로 가기
	function toListFirstPage() {
        $('div[id$="Box"]').css('display', 'none');
		$('select[name=listBy]').val(listBy);
        //보여줄 우측섹션 값담기
		if(section == 'recieved'){
			recievedBox();
		}
		if(section == 'sent'){
			sentBox();
		}
		if(section == 'del'){
			delBox();
		}
		currentModalPageNo = 1;
		currentBlock = 1;
		//선택한 섹션화면 보여주기
		$('div[id="'+section+'Box"]').css('display', 'block');		
	}
	
	//목록으로
	function toList() {
        $('div[id$="Box"]').css('display', 'none');
		$('select[name=listBy]').val(listBy);
        //보여줄 우측섹션 값담기
		if(section == 'recieved'){
			recievedBox();
		}
		if(section == 'sent'){
			sentBox();
		}
		if(section == 'del'){
			delBox();
		}
		if(section == 'new'){
			section = 'sent'
			sentBox();
		}
		//선택한 섹션화면 보여주기
		$('div[id="'+section+'Box"]').css('display', 'block');	
	}
	
	//원래있던 목록으로 가기버튼
	$('#toList').click(function() {
		toList();		
	})
	
	//즐겨찾기등록, 해지
	$('.msg-container').on('click', '[id^=mark-]', function() {
		var id = $(this).attr('id').replace('mark-', '').trim();
		$.ajax({
			type: 'GET',
			url: '/user/markMessage.do',
			data: {key: id},
			dataType: 'json',
			complete: function(){
				toList();
			}
		});
	});
	
	//어떤 리스트에서라도 전체선택
	$('.msg-container').on('click', '#all-select', function() {
		var rows = $(this).parents('table').find('tbody input[id^=check-]');
		$.each(rows, function(index, row) {
			$(row).attr('checked',true);
		})
	})
	
	//수신메시지함에서 선택삭제
	$('.msg-container').on('click', '#del-selected', function() {
		var rows = $rbox.find('tbody input[id^=check-]:checked');
		var ids = [];
		$.each(rows, function(index, row) {
			ids.push($(row).attr('id').replace('check-','').trim());
		});
		$.ajaxSettings.traditional = true;
		$.ajax({
			type: 'POST',
			url: '/user/delMessage.do',
			data: JSON.stringify(ids),
			contentType:'application/json',
			complete: function() {
				newAlertBadge();
				toList();
			}
		});		
	})

	//발신메시지함에서 선택발송취소
	$('.msg-container').on('click', '#can-selected', function() {
		var rows = $sbox.find('tbody input[id^=check-]:checked');
		var ids = [];
		$.each(rows, function(index, row) {
			ids.push($(row).attr('id').replace('check-','').trim());
		});
		$.ajaxSettings.traditional = true;
		$.ajax({
			type: 'POST',
			url: 'cancelSendMessage.do',
			data: JSON.stringify(ids),
			contentType:'application/json',
			complete: function() {
				newAlertBadge();
				toList();
			}
		});		
	})

	//삭제메시지함에서 선택삭제복구
	$('.msg-container').on('click', '#rec-selected', function() {
		var rows = $dbox.find('tbody input[id^=check-]:checked');
		var ids = [];
		$.each(rows, function(index, row) {
			ids.push($(row).attr('id').replace('check-','').trim());
		});
		$.ajaxSettings.traditional = true;
		$.ajax({
			type: 'POST',
			url: '/user/recoveryMessage.do',
			data: JSON.stringify(ids),
			contentType:'application/json',
			complete: function() {
				newAlertBadge();
				toList();
			}
		});		
	})
	
	$('#confirmPassword').click(function() {
		var inputPassword = $('#inputPassword').val();
		var userPassword = '${LOGIN_USER.pwd}';
		if(inputPassword == userPassword) {
			$('#form-email').val('${LOGIN_USER.email}')
			$('#form-phone').val('${LOGIN_USER.tel}')
			$('#updateUser-modal').modal('show');
		} else {
			$('#ne-password').modal('show');
		}
	})
	
});

	  function getCommaNumber(number) {
		  	var sum = number;
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
			return str;
	  }
	
	  function getOrderList(pno, startDate, endDate) {
			var row = "";
			row += '<div class="row">';
			row += '<form style="background-color:white;">';
			row += '<div style="margin: 10px">';
			row += '<div class="noticeBox" style="height: 130px; padding: 10px; border: 2px solid #c68c53; border-radius: 7px; margin-bottom:30px;">';
			row += '<p style="color: #666666;"><img src="../resources/images/logo/peanutbw.png" style="width: 20px; height: 20px;">';
			row += ' 조회할 날짜를 선택해주세요.</p>';
			row += '<p style="color: #666666;"><img src="../resources/images/logo/peanutbw.png" style="width: 20px; height: 20px;">';
			row += ' 상품의 교환 신청은 고객센터로 문의하여 주세요..</p>';
			row += '<p">';
			row += '<div class="form-group form-inline">'
			row += '<a class="btn btn-default btn-sm" style="margin-left: 15px" onclick="insertDate(new Date(), new Date())">오늘</a>';
			row += '<a class="btn btn-default btn-sm" style="margin-left: 3px" onclick="lastWeek()">1주일</a>';
			row += '<a class="btn btn-default btn-sm" style="margin-left: 3px" onclick="lastMonth(1)">1개월</a>';
			row += '<a class="btn btn-default btn-sm" style="margin-left: 3px" onclick="lastMonth(3)">3개월</a>';
			row += '<a class="btn btn-default btn-sm" style="margin-left: 3px; margin-right: 15px;" onclick="lastMonth(12)">1년</a>';
			row += '<input type="date" class="form-control" id="endDate" value=""> - '
			row += '<input type="date" class="form-control" id="startDate" value="">'
			row += '<a style="margin-left:10px;" class="btn btn-warning btn-sm" onclick="lookUp()">조회</a>'
			row += '</div>';
			row += '</p>';
			row += '<div style="margin-top: 10px;">';
			row += '</div>';
			row += '</div>';
			row += '</div>';
			row += '<table class="table" style="font-size:14px;">';
			row += '<thead>';
			row += '<tr>';
			row += '<th>주문번호</th>';
			row += '<th>주문한 티켓</th>';
			row += '<th>수량</th>';
			row += '<th>가격</th>';
			row += '<th>주문일</th>';
			row += '<th>비고</th>';
			row += '</tr>';
			row += '</thead>';
			row += '<tbody id="list-box">';
	$.ajax({
		type: "POST",
		url: "/ticket/orderList.do",
		data: {startDate:formatDate(startDate), endDate:formatDate(endDate), pno:pno},
		success: function(result) {
			var list = result.list;
			if(result.success) {
				$.each(list, function(index, item) {
	  				row += "<tr>";
	  				row += "<td>"+item.RN+"</td>";
	  				row += "<td><a style='text-decoration:none' href='/ticket/detail.do?ticketNo="+item.TICKETNO+"'><span style='color:black;'>"+item.TICKETNAME+"</span></a></td>";
	  				row += "<td>"+item.ORDERQTY+"</td>";
	  				row += "<td>"+getCommaNumber((item.TICKETPRICE*((100-item.DISCOUNTRATE)/100))*item.ORDERQTY)+"원</td>";
	  				row += "<td>"+formatDate(item.ORDERDATE)+"</td>";
	  				row += "<td><span><a class='btn btn-danger btn-xs' onclick='orderCancel("+item.ORDERNO+")'>취소</a></span></td>";
	  				row += "</tr>";  					
				}) 
				row += '</tbody>';
				row += '</table>';
				row += '</form>';
				row += '</div>';
			  	
			  	var nav = 5;
				var totalCnt = result.totalCnt;
				var totalPageNo = Math.ceil(totalCnt/10);
				var totalBlocks = Math.ceil(totalPageNo/nav);
				var currentBlock = Math.ceil(pno/nav);
				var beginModalPage = ((currentBlock-1)*nav)+1;
				var endModalPage = currentBlock*nav;
				var previousPage = Math.floor((pno-1)/5)*5;
				var	nextPage = Math.ceil(pno/5)*5+1;
					
				row += "<div class='text-center'>";
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
					   if (pno == i){
					      pagination += "<li><a class='active' href='#'>"+i+"</a></li>";
					   } else {
					      pagination += '<li><a href="#" onclick="getPage('+i+')">'+i+'</a></li>';
					   }
					}
					if(currentBlock != totalBlocks){
					    pagination += "<li><a href='#' onclick='getPage("+i+")' aria-label='Next'>";
					    pagination += "<span aria-hidden='true'>&raquo;</span></a></li>";
					}
				pagination += "</ul></nav>";
				row += pagination;
				row += "</div>";
			  	
				$("#myplannerList").empty();
				$("#myplannerList").append(row);
				insertDate(startDate, endDate);
			} else {
				row += "<tr><td colspan='5'><span class='col-sm-offset-5'>해당기간의 주문내역이 존재하지 않습니다.</span></td></tr></tbody></table></form></div>";
				$("#myplannerList").empty();
				$("#myplannerList").append(row);
				insertDate(startDate, endDate);
			}
		}
		
		
	})
}

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
		var formattedDate = [year, month, day].join('-');
      return formattedDate;
  }
  
  function insertDate(startDate, endDate) {
  	$("#startDate").val(formatDate(startDate));
  	$("#endDate").val(formatDate(endDate));
  }

  /* 오늘로부터 1주일전 날짜 반환 */
  function lastWeek() {
    var d = new Date();
    var dayOfMonth = d.getDate();
    d.setDate(dayOfMonth - 7);
    insertDate(new Date(), d);
  }

  /* 오늘로부터 n개월전 날짜 반환 */
  function lastMonth(n) {
    var d = new Date();
    var monthOfYear = d.getMonth();
    d.setMonth(monthOfYear - n);
    insertDate(new Date(), d);
  }
  function getLastMonth(n) {
      var d = new Date();
      var monthOfYear = d.getMonth();
      d.setMonth(monthOfYear - n);
     return d;
    }
  
  function lookUp() {
  	var startDate = $("#startDate").val();
  	var endDate = $("#endDate").val();
  	getOrderList(1,startDate, endDate);
  }
  function getPage(i) {
  	var startDate = $("#startDate").val();
  	var endDate = $("#endDate").val();
  	getOrderList(i,startDate, endDate);
  }
  function orderCancel(i) {
  	$.ajax({
  		type: "GET",
			url: "/ticket/orderCancel.do",
			data: {orderNo:i},
			success: function(result) {
				var startDate = $("#startDate").val();
		    	var endDate = $("#endDate").val();
		    	getOrderList(1,startDate, endDate);
			}
  	})
  }
  $(function() {
	  $('[id^=check]').hide();
		
		$('#updateUser-form').submit(function(event) {
			var pwd = $('#form-pwd').val();
			var pwdcheck = $('#form-pwdcheck').val();
			var email = $('#form-email').val();
			var phone = $('#form-phone').val();
			
			if(pwd == '') {
				$('#check-pwd1').show();
				return false;
			}
			if(pwd != pwdcheck) {
				$('#check-pwd2').show();
				return false;
			}
			if(email == '') {
				$('#check-email').show();
				return false;
			}
			if(phone == '') {
				$('#check-tel').show();
				return false;
			}
			
			return true;
		})
		
		$('#form-pwdcheck').on('keyup', function() {
  			var pwd = $('#form-pwd').val();
  			var pwdcheck = $('#form-pwdcheck').val();
  			
  			if(pwd==pwdcheck) {
  				$('#check-pwd2').hide();
  			} else {
  				$('#check-pwd2').show();
  			}
  		})
  		var currPlanNo = "";
  		$('#myplannerList').on('mouseenter','div[id^=plan-map-]',function() {
			currPlanNo =  $(this).attr('id').replace('plan-map-', '').trim();
			$('div[id^=plan-detail-').slideUp('fast');
			$('div[id=plan-detail-'+currPlanNo+']').slideDown('fast');
			var locationBox = $('#plan-locations-'+currPlanNo);
			$.ajax({
				type: 'GET',
				url: '/search/resultLocation.do',
				data: {pno: currPlanNo},
				async: false,
				dataType: 'json',
				success: function(result) {
					var rows = "";
					if(result.length == 0) {
						rows += "없 음";
					} else {
						$.each(result, function(index, item) {
							rows += item;
							rows += " ";
						})
					}
					locationBox.empty();
					locationBox.append(rows);
				}
			}); 
		});
		$('#myplannerList').on('mouseout','div[id^=plan-detail-]',function() {
			$('div[id^=plan-detail-').slideUp('fast');		
		})
		
		$('#myplannerList').on('click','div[id^=plan-detail-]',function(){
			location.href = "/planner/dashboard.do?pno=" + currPlanNo;
		})
  })
</script>
</html>