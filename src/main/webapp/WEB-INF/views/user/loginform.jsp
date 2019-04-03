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
  <script>
  	$(function() {
  		$('#previousPage').click(function() {
  			history.back();
  		})
  	})
  </script>
</head>
<body>
	<jsp:include page="../include/header.jsp">
		<jsp:param value="login" name="header"/>
	</jsp:include>
	<div class="container" style="min-height: 740px;">
		<div class="row text-center" style="width: 100%; margin-top: 100px;">
			<img src="/resources/images/logo/logobw.png">
			
			<c:if test="${param.err eq 'fail' }">
				<div class="alert alert-danger col-md-offset-3 col-md-5">
					<strong>오류</strong> 아이디 혹은 비밀번호가 올바르지 않습니다.
				</div>
			</c:if>
			<c:if test="${param.err eq 'deny' }">
				<div class="alert alert-danger col-md-offset-3 col-md-5">
					<strong>오류</strong> 로그인이 필요한 서비스 입니다.
				</div>
			</c:if>
			<c:if test="${param.err eq 'outPutUser' }">
				<div class="alert alert-danger col-md-offset-3 col-md-5">
					<strong>오류</strong> 탈퇴처리된 회원입니다.
				</div>
			</c:if>
		
			<form class="text-center" action="login.do" method="post" style="width: 100%">
				<div style="margin-bottom: 10px;" class="col-md-offset-3 col-md-5">
					<label class="radio-inline">
						<input type="radio" name="status" value="user" checked="checked">일반사용자
					</label>
					<label class="radio-inline">
						<input type="radio" name="status" value="ad">사업자
					</label>
				</div>
				<div class="form-group text-center">
					<div class="input-group col-md-offset-3 col-md-5">
						<span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
						<input style="height: 45px;" type="text" class="form-control" name="id" id="form-id" placeholder="아이디를 입력해주세요" />
					</div>
				</div>
				<div class="form-group">
					<div class="input-group col-md-offset-3 col-md-5">
						<span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
						<input style="height: 45px;" type="password" class="form-control" name="pwd" id="form-pwd" placeholder="비밀번호를 입력해주세요" />
					</div>
				</div>
				<div class="text-center">
					<div class="input-group col-md-offset-3 col-md-5">
						<button style="width: 100%; height:45px; background-color: #0074e9; font-size: 17px; color: white; font-style: inherit;" class="btn btn-default">로그인</button><hr />
						<a style="width: 100%; height:45px; font-size: 17px; font-style: inherit;" id="previousPage" class="btn btn-default">취소</a>
					</div>
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="../include/footer.jsp" />
</body>
</html>