<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="miniUser-container">
	<!-- Modal -->
	<div class="modal fade" id="miniUserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-sm">
	    <div class="modal-content">
	      <div class="modal-header" style="background-color: #c68c53; color: #ffffff; height: 308px; text-align: center;">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <div class="row" style="margin:0px; margin-top: 10px;">
	        	<img id="miniUserProfile" width="230px;" height="230px;" style="border-radius: 50%; margin-right: -10px;" />
	        </div>
	        <h4 class="modal-title" id="miniUserId" style="margin-top: 5px;"></h4>
	       <p style="margin-top: -3px; font-size: 12px; opacity: 0.8;"><span>가입일</span> <span id="miniUserCD"></span></p>
	      </div>
	      <div class="modal-body-1" style="display:block; padding: 10px; text-align: center;">
	    	<div class="btn-group">
			  <button type="button" class="btn btn-default" id="miniMyPage" style="font-size: 12px;">마이페이지</button>
			  <button type="button" class="btn btn-default" id="miniMsg" style="font-size: 12px;">쪽지보내기</button>
			</div>
	      </div>
	      <div class="modal-body-2" style="display:none; padding: 10px;">
			<form method="POST" id="mini-sendMsg-form">
				<div style="text-align: right; font-size: 12px; margin-bottom: 3px;">
					<span>남은 글자수 | </span><span id="miniMsgRange">650</span>
					<button class="btn btn-xs btn-success">보내기</button>
				</div>
				<div style="background-color: #c68c53; color: #ffffff; font-size: 12px; padding: 7px;">
					※ 간단한 쪽지를 보내보세요!
				</div>
				<div class="form-group">
					<input type="hidden" class="form-control" name="receiver" id="miniReceiver"/>
					<textarea rows="5" maxlength="649" class="form-control" name="contents" style="resize: none;"></textarea>
				</div>
			</form>
	      </div>
	    </div>
	  </div>
	</div>
	
	<input type="hidden" value="${LOGIN_USER.id }" id="currLoginUserId" />
	
	<!-- 미로그인 시, 출력 모달 -->
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
<script>
$(function() {

	//공용변수
	var userId;
	var userStatus;
	var currLoginUserId = $('#currLoginUserId').val();
	
	//유저아이디를 클릭했을 때
	$('body').on('click', '[id^=miniUser-]', function(event) {
		if(currLoginUserId == '' || currLoginUserId == null) {
			$('#neLogin').modal('show');	
			return false;
		} 		
		userId = $(this).attr('id').replace('miniUser-', '').trim();
		$.ajax({
			type: 'GET',
			url: '/getMiniUser.do',
			data: {id: userId},
			dataType: 'json',
			success: function(result) {
				$('#miniUserId').text(result.id);
				$('#miniUserCD').text(result.createDateToString);
				$('#miniUserProfile').attr('src', '/resources/images/profile/'+result.profile);
				$('#miniReceiver').val(result.id);
				userStatus = result.status;
			}
		});
		$('#miniUserModal').modal('show');
	});
	
	//해당 유저의 마이페이지 가기
	$('.miniUser-container').on('click', '#miniMyPage', function() {
		if(userStatus == 'IN' || userStatus == 'ADMIN') {
			location.href = "/user/mypage.do?id=" + userId;
		} else {
			alert('탈퇴한 유저입니다.');
			return false;
		}
	});

	//해당 유저에게 메세지 보내기
	$('.miniUser-container').on('click', '#miniMsg', function() {
		if(userStatus == 'IN') {
			$('.miniUser-container').find('.modal-body-2').toggle();
		} else {
			alert('탈퇴한 유저입니다.');
			return false;
		}
	});
	
	//해당 유저에게 보내는 메세지 글자수 카운트
    $('#miniUserModal textarea[name=contents]').keyup(function (){
        //메시지 내용길이
    	var content = $(this).val();
        //메시지 내용길이 카운트하기
		var counter = 650 - content.length
        if(counter <= 0) {
        	counter = 0;
        }
        if(counter == 0) {
        	$('#miniMsgRange').css('color', 'red');	
        }
		$('#miniMsgRange').text(counter);
    });	
	
	//쪽지 발송
	$('.miniUser-container').on('submit', '#mini-sendMsg-form', function(event) {
		event.preventDefault();
		var receiver = $('#mini-sendMsg-form').find('input[name=receiver]').val();
		var contents = $('#mini-sendMsg-form').find('textarea[name=contents]').val();
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
				$('#miniUserModal textarea[name=contents]').val('');
				$('.miniUser-container').find('.modal-body-2').css('display', 'none');				
			}
		});
	});
	
	//모달 닫을 때, 메세지창 비우기
	$('#miniUserModal').on('hide.bs.modal',function(){
		$('#miniUserModal textarea[name=contents]').val('');
		$('.miniUser-container').find('.modal-body-2').css('display', 'none');
	});		
})
</script>