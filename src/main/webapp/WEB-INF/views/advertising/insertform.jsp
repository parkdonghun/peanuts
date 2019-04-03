<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>form</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
// 등록버튼 정상작동되게 하기
$(function() {
		
	$('#select-form').submit(function() {
		// 빈칸으로 등록버튼 누르면 경고창
		var category = $('select[name="category"]').val();
		var id = $('input[name="id"]').val();
		var name = $('input[name="name"]').val();
		var pwd = $('input[name="pwd"]').val();
		var tel = $('input[name="tel"]').val();
		var manager = $('input[name="manager"]').val();
		var email = $('input[name="email"]').val();
		var serial = $('input[name="serial"]').val();
		var pwd2 = $('input[name="pwd2"]').val();
	
		if (category == '') {
			alert("업종을 선택하세요.");
			return false;
		}
		
		if (id == '') {
			alert("사업자 아이디를 입력하세요.");
			return false;
		}
		
		if (name == '') {
			alert("업체명을 입력하세요.");
			return false;
		}
		
		if (pwd == '') {
			alert("비밀번호를 입력하세요.");
			return false;
		}
		
		if (tel == '') {
			alert("전화번호를 입력하세요.");
			return false;
		}
		
		if (manager == '') {
			alert("담당자를 입력하세요.");
			return false;
		}
		
		if (email == '') {
			alert("이메일을 입력하세요.");
			return false;
		}
		
		if (serial == '') {
			alert("사업자번호를 입력하세요.");
			return false;
		}
		
		if (pwd != pwd2) {
			alert("비밀번호가 일치하지않습니다.");
			return false;
		}
		
		return true;
		
	})
	
	$('input[name="id"]').keyup(function(){
		$('#form-submit').attr("disabled", true);
		$('input[name=id-check]').addClass('btn-danger');
		$('input[name=id-check]').removeClass('btn-default');
	})
	
	$('input[name="id-check"]').click(function() {
		var id = $('input[name="id"]').val();
		
		$.ajax({
			type: "GET",
			url: "/advertising/checkId.do",
			dataType: "JSON",
			data: {id : id},
			success: function(item) {
				if (item != null) {
					alert("해당 아이디는 사용 가능합니다.");
					$('#form-submit').attr("disabled", false);
					$('input[name=id-check]').removeClass('btn-danger');
					$('input[name=id-check]').addClass('btn-default');
				} else {
					alert("해당 아이디가 존재 합니다.");
					$('#form-submit').attr("disabled", true);
				}	
			}
		})
	})
	
	// 비밀번호 체크
	$('#pwd-field').on('keyup', function() {
		var pwd = $('input[name=pwd]').val()
		var pwdcheck = $('input[name=pwd2]').val();
		
		if (pwd != '') {
			if(pwd==pwdcheck) {
				$('#check-pwd2').css('display', 'none');
			} else {
				$('#check-pwd2').css('display', '');
			}
		}
	})
})
</script>
</head>
<body style="overflow-x: hidden;">
<jsp:include page="../include/header.jsp" />
<div class="container" style="width: 60%; min-height: 740px;">
<br><br>
	<div class="row">
		<form id="select-form" class="form-horizontal" action="addAdvertising.do" method="post">
			<div class="form-group">
				<label class="col-sm-2 control-label">사업자 아이디</label>
				<div class="col-sm-3" id="register-form">
			      <select class="form-control" name="category">
						<option value="">::업종선택::</option>
						<option value="음식">음식</option>
						<option value="숙박">숙박</option>
						<option value="여행사">여행사</option>
						<option value="항공사">항공사</option>
						<option value="지자체">지자체</option>
						<option value="etc">etc</option>
					</select>
			    </div>
			    <div class="col-sm-4" id="id-field">
			      	<input type="text" class="form-control" name="id" placeholder="사업자 아이디를 입력하세요" maxlength="45">
			    </div>
				<div class="col-sm-2">
			    	<input type="button" class="btn btn-danger" name="id-check" value="중복체크">
			    </div>
			</div>
			<div class="form-group" id="name-field">
				<label class="col-sm-2 control-label">업체명</label>
				<div class="col-sm-9">
			    	<input type="text" class="form-control" name="name" placeholder="업체명을 입력하세요" maxlength="45">
			    </div>
			</div>
			<div class="form-group" id="pwd-field">
				<label class="col-sm-2 control-label">업체 비밀번호</label>
				<div class="col-sm-3">
					<input type="password" class="form-control" name="pwd" placeholder="비밀번호를 입력하세요" maxlength="45">
			    </div>
			    <label class="col-sm-3 control-label">비밀번호 체크</label>
				<div class="col-sm-3">
					<input type="password" class="form-control" name="pwd2" placeholder="비밀번호를 한번 더 입력하세요" maxlength="45">
				    <span id="check-pwd2" style="color: red; font-size: small; display: none;">비밀번호가 일치하지않습니다.</span>
			    </div>
			</div>
			<div class="form-group" id="tel-field">
				<label class="col-sm-2 control-label">업체 전화번호</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" name="tel" placeholder="업체 전화번호를 입력하세요" maxlength="15">
			    </div>
			</div>
			<div class="form-group" id="manager-field">
				<label class="col-sm-2 control-label">관리자 이름</label>
				<div class="col-sm-9">
			      <input type="text" class="form-control" name="manager" placeholder="관리자 이름을 입력하세요" maxlength="45">
			    </div>
			</div>
			<div class="form-group" id="email-field">
				<label class="col-sm-2 control-label">관리자 이메일 </label>
				<div class="col-sm-9">
			      <input type="email" class="form-control" name="email" placeholder="관리자 이메일을 입력하세요" maxlength="45">
			    </div>
			</div>
			<div class="form-group" id="serial-field">
				<label class="col-sm-2 control-label">사업자 번호 </label>
				<div class="col-sm-9">
			      <input type="text" class="form-control" name="serial" placeholder="사업자 번호 xxx-xx-xxxxx 양식으로 입력하세요" pattern="[0-9]{3}-[0-9]{2}-[0-9]{5}">
			    </div>
			</div>
			<div class="form-group">
				<div class="text-right col-sm-11">
					<button id="form-submit" class="btn btn-sm btn-warning" disabled>등록</button>
				</div>
			</div>
		</form>
	</div>
</div>
<jsp:include page="../include/footer.jsp" />
</body>
</html>