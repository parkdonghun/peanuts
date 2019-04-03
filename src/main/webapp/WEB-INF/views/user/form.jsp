<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title></title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script type="text/javascript">
  	$(function() {
  		$('#previousPage').click(function() {
  			history.back();
  		})
  		
  		$('[id^=check]').hide();
  		
  		$('#register-form').submit(function(event) {
  			var name = $('#form-name').val();
  			var pwd = $('#form-pwd').val();
  			var id = $('#form-id').val();
  			var pwdcheck = $('#form-pwdcheck').val();
  			var email = $('#form-email').val();
  			var phone = $('#form-phone').val();
  			var idOverlap = $('#overlap-id').val();
  			
  			if(name == '') {
  				$('#check-name').show();
  				return false;
  			}
  			if(id == '') {
  				$('#check-id').show();
  				$('#check-existId').hide();
				$('#check-nonExistId').hide();	
  				return false;
  			}
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
  		$('#idCheck').click(function() {
  			
  			var id = $('#form-id').val();
  			if (id == '') {
  				$('#check-id').show();
				$('#check-existId').hide();
				$('#check-nonExistId').hide();						
  				return false;
  			}
  			$.ajax({
  				type: "GET",
				url: "/user/checkUser.do",
				dataType: 'json',
				data:{userId:id},
				success: function(result) {
					var isExist = result;
					if(isExist) {
		  				$('#check-id').hide();
						$('#check-existId').show();
						$('#check-nonExistId').hide();
					} else {
		  				$('#check-id').hide();
						$('#check-existId').hide();
						$('#check-nonExistId').show();
						$('#btn-register').attr('disabled',false);
					}
				}
  			})
  		})
  	})
  </script>
  <style type="text/css">
  .wrapper {
  	min-height: 50px;
  	padding-bottom: 10px;
  }
  .form-group {
  	margin-left: 150px;
  }
  </style>
</head>
<body>
	<jsp:include page="../include/header.jsp">
		<jsp:param value="register" name="header"/>
	</jsp:include>
<div class="container" style="min-height: 740px;">
	<div class="row text-center" style="width: 100%; margin-top: 100px;">
		<form class="well" id="register-form" method="post" action="register.do" enctype="multipart/form-data">
			<div class="form-group col-md-12 wrapper">
				<div class="input-group col-md-5">
					<span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
					<input type="text" class="form-control" name="name" id="form-name" placeholder="이름" aria-describedby="helpBlock"/>
				</div>
				<span id="check-name" style="color: red" class="help-block text-left">이름을 입력해주세요.</span>
			</div>
			<div class="form-group col-md-12 wrapper">
				<div class="input-group col-md-5">
					<span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
					<input type="text" class="form-control" name="id" id="form-id" placeholder="아이디" />
					<a class="btn btn-primary input-group-addon" id="idCheck">중복확인</a>
				</div>
				<span id="check-id" style="color: red" class="help-block text-left">아이디를 입력해주세요.</span>
				<span id="check-existId" style="color: red" class="help-block text-left">이미 존재하는 아이디 입니다.</span>
				<span id="check-nonExistId" style="color: blue" class="help-block text-left">사용가능한 아이디 입니다.</span>
				<div class="col-md-2">
				</div>
			</div>
			<div class="form-group col-md-12 wrapper">
				<div class="input-group col-md-5">
					<span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
					<input type="password" class="form-control" name="pwd" id="form-pwd" placeholder="비밀번호" />
				</div>
				<span id="check-pwd1" style="color: red" class="help-block text-left">비밀번호를 입력해주세요.</span>
			</div>
			<div class="form-group col-md-12 wrapper">
				<div class="input-group col-md-5">
					<span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
					<input type="password" class="form-control col-md-3" id="form-pwdcheck" placeholder="비밀번호 재입력" />
				</div>
				<span id="check-pwd2" style="color: red" class="help-block text-left">비밀번호가 일치하지않습니다.</span>
			</div>
			<div class="form-group col-md-12 wrapper">
				<div class="input-group col-md-5">
					<span class="input-group-addon"><span class="glyphicon glyphicon-envelope"></span></span>
					<input type="email" class="form-control" name="email"  id="form-email" placeholder="이메일" />
				</div>
				<span id="check-email" style="color: red" class="help-block text-left">이메일을 입력해주세요.</span>
			</div>
			<div class="form-group col-md-12 wrapper">
				<div class="input-group col-md-5">
					<span class="input-group-addon"><span class="glyphicon glyphicon-phone"></span></span>
					<input type="tel" class="form-control" name="phone"  id="form-phone" placeholder="휴대폰 번호" />
				</div>
				<span id="check-tel" style="color: red" class="help-block text-left">휴대폰 번호를 입력해주세요.</span>
			</div>
			<div class="form-group col-md-12 wrapper">
				<div class="input-group col-md-5">
					<span class="input-group-addon"><span>프로필 사진을 등록해주세요.</span></span>
					<input type="file" name="profile" id="form-profile">
				</div>
			</div>
			
			<div class="text-center">
				<button class="btn btn-primary btn-lg" disabled="disabled" id="btn-register">회원가입</button>
				<a class="btn btn-info btn-lg" id="previousPage">취소</a>
			</div>
		</form>
	</div>
</div>
	<%@include file="../include/footer.jsp" %>
</body>
</html>