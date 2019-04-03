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
</head>
<body>
	<jsp:include page="../include/header.jsp">
		<jsp:param value="register" name="header"/>
	</jsp:include>
	<div class="container" style="min-height: 740px;">
		<div class="col-sm-12">
			<img src="/resources/images/greeting.jpg" width="100%"/>
		</div>
		<div class="col-sm-6 text-center">
			<a class="btn btn-primary" href="/user/form.do">
				개인회원 가입하기
			</a>
		</div>
		<div class="col-sm-6 text-center">
			<a class="btn btn-primary" href="/advertising/addAdvertisingForm.do">
				사업자회원 가입하기
			</a>
		</div>
	</div>
	<jsp:include page="../include/footer.jsp"/>
</body>
</html>