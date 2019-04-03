<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>admin :: userManagement</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}
</style>
</head>
<body style="overflow-x: hidden;">
<jsp:include page="../include/header.jsp" />
<div class="container" style="width: 60%; min-height: 740px;">
	<div class="row">
		<nav class="col-sm-3" id="myScrollspy">
			<!-- 왼쪽 메뉴바 -->
			<jsp:include page="menu.jsp" />
		</nav>
		<div class="col-sm-9">
			<!-- 오른쪽 유저 리스트 -->
			<h1>
				<strong>회원관리</strong>
				<img src="/resources/images/logo/peanutbw.png" width="40px">
				<img src="/resources/images/logo/peanutbw.png" width="40px">
				<img src="/resources/images/logo/peanutbw.png" width="40px">
				
				<span class="pull-right form-inline">
					<form action="searchUser.do" method="post" id="search-form" class="form-inline">
						<input type="text" class="form-control" name="keyword" />
						<button class="btn btn-xs btn-default form-control" id="search-btn">검색</button>
					</form>
				</span>
			</h1>
			
			<p style="color: #800000; font-size: small;">땅콩 갯수 더블클릭 후 원하는 숫자를 입력하면 입력한 숫자만큼 땅콩이 더해집니다</p>
			
			<table class="table table-hover">
				<colgroup>
					<col width="*%">
					<col width="13%">
					<col width="13%">
					<col width="15%">
					<col width="18%">
					<col width="12%">
					<col width="10%">
				</colgroup>
				
				<thead>
					<tr>
						<th>이름</th>
						<th>아이디</th>
						<th>가입일</th>
						<th>신고당한횟수</th>
						<th>땅콩갯수</th>
						<th>상태</th>
						<th></th>
					</tr>
				</thead>
				<tbody style="font-size: small;" id="plan-list">
					<c:forEach var="user" items="${users }">
						<tr>
							<td>${user.name}</td>
							<td><a href="#" id="miniUser-${user.id }">${user.id}</a></td>
							<td>${user.createDateToString }</td>
							<td>${user.repoReplyCnt }</td>
							<td>
								<span id="peanuts-${user.id}-num">${user.peanuts }</span>
								<span id="peanuts-${user.id}-form" style="display: none;" class="form-inline">
									<input type="number" name="plusNum" id="plusNum-${user.id}" class="form-control" style="width: 45px; height: 30px;">
									<button class="btn btn-xs btn-default" id="peanuts-c-btn-${user.id}" style="margin-left: 5px;">취소</button>
								</span>
							</td>
							<c:if test="${user.status eq 'IN' }">
								<td style="color:#39ac39; "><strong>정상</strong></td>
							</c:if>
							<c:if test="${user.status eq 'OUT' }">
								<td style="color:#a9a9a9; "><strong>탈퇴</strong></td>
							</c:if>
							<c:if test="${user.status eq 'REOUT' }">
								<td style="color:#800000; "><strong>강퇴</strong></td>
							</c:if>
							<c:if test="${user.status eq 'ADMIN' }">
								<td style="color:#ff4500; "><strong>관리자</strong></td>
							</c:if>
							<td class="dropdown">
					    		<a class="dropdown-toggle btn btn-sm btn-default" data-toggle="dropdown" href="#">상태 업데이트<span class="caret"></span></a>
								<ul class="dropdown-menu">
					          		<li><a href="updateUserStatusById.do?status=IN&userId=${user.id }&currentPageNo=${page.currentPageNo }&currentBlock=${page.currentBlock}">정상</a></li>
					          		<li><a href="updateUserStatusById.do?status=OUT&userId=${user.id }&currentPageNo=${page.currentPageNo }&currentBlock=${page.currentBlock}">탈퇴</a></li>
					          		<li><a href="updateUserStatusById.do?status=REOUT&userId=${user.id }&currentPageNo=${page.currentPageNo }&currentBlock=${page.currentBlock}">강퇴</a></li>
					          		<li><a href="updateUserStatusById.do?status=ADMIN&userId=${user.id }&currentPageNo=${page.currentPageNo }&currentBlock=${page.currentBlock}">관리자</a></li>
					      		</ul>
							</td>
						</tr>
						<input type="hidden" name="currentPageNo" value="${page.currentPageNo }" />
						<input type="hidden" name="currentBlock" value="${page.currentBlock }" />
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div id="pagination">
			<jsp:include page="../include/pagination.jsp">
				<jsp:param value="${page }" name="page"/>
				<jsp:param value="/admin/userList.do" name="url"/>
			</jsp:include>
		</div>
	</div>
</div>

<!-- modal -->
<div class="modal fade" id="detail-modal" role="dialog">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">회원정보</h4>
			</div>
			<div class="modal-body" id="insert-contents"></div>
		</div>
	</div>
</div>
<jsp:include page="../include/miniUser.jsp" />
<jsp:include page="../include/footer.jsp" />
</body>
<script>
$(function() {
	var currentPageNo = $('input[name=currentPageNo]').val();
	var currentBlock = $('input[name=currentBlock]').val();
	
	// 땅콩 갯수 조절하기
	$('#plan-list').on('dblclick', 'span[id^="peanuts-"]', function() {
		var i1 = $(this).attr("id");
		var i2 = i1.replace('peanuts-', '');
		var userId = i2.replace('-num', '');
		
		// 입력창 모두 닫음, 숫자 모두 보임, 누른숫자만 숨김, 누른 숫자의 입력폼을 킴
		$('span[id$="-form"]').css('display', 'none');
		$('span[id$="-num"]').css('display', '');
		$('#peanuts-'+userId+'-num').css('display', 'none');
		$('#peanuts-'+userId+'-form').css('display', '');
		
		// 땅콩 갯수를 입력하고 엔터키를 눌렀을 때
		$('#peanuts-'+userId+'-form').keypress(function(e) {
			if (e.keyCode == 13) {
				var num = $('#plusNum-'+userId).val();
				if (num == '' || num == '0') {
					return false;
				}
				var plusNum = parseInt(num);
				location.href="/admin/plusPeanuts.do?userId="+userId+"&plusNum="+plusNum+"&currentPageNo="+currentPageNo+"&currentBlock="+currentBlock;
			}
		})
	});
	
	// 취소버튼
	$('#plan-list').on('click', '#peanuts-c-btn', function() {
		$('span[id$="-form"]').css('display', 'none');
		$('span[id$="-num"]').css('display', '');
	});
	
	// 모달 띄우기
	$('td').on('click', 'a[id^="detail-"]', function(e) {
		e.preventDefault();
		var id = $(this).attr("id");
		var repNo = id.replace('detail-', '');
		
		$.ajax({
			type: "GET",
			url: "getRepoByRepNo.do",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "json",
			async: false,
			data: {repNo: parseInt(repNo)},
			success: function(reply) {
				var row = '<p>'+reply.contensWithEnter+'</p>';
				$('#insert-contents').empty().append(row);
			}
		});
		
		$('#detail-modal').modal();
	});
	
	$(".dropdown-toggle").dropdown();
	
	$('#search-btn').click(function(e) {
		e.preventDefault();
		
		var keyword = $('input[name=keyword]').val();
		if (keyword == null) {
			return false;
		}
		
		$.ajax({
			type: "GET",
			url: "searchUser.do",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			dataType: "json",
			async: false,
			data: {keyword: keyword},
			success: function(items) {
				var rows = '';
				$.each(items, function(index, item) {
					rows += '<tr>';
					rows += '<td>'+item.name+'</td>';
					rows += '<td>'+item.id+'</td>';
					
					var date = new Date(item.createDate);
					rows += '<td>'
					rows += date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate();
					rows += '</td>';
					rows += '<td>'+item.repoReplyCnt+'</td>';
					rows += '<td>';
					rows += '<span id="peanuts-'+item.id+'-num">'+item.peanuts+'</span>';
					rows += '<span id="peanuts-'+item.id+'-form" style="display: none;" class="form-inline">';
					rows += '<input type="number" name="plusNum" class="form-control" style="width: 45px; height: 30px;">';
					rows += '<button class="btn btn-xs btn-default" id="peanuts-c-btn" style="margin-left: 5px;">취소</button>';
					rows += '</span>';
					rows += '</td>';
					if (item.status == 'IN') {
						rows += '<td style="color:#39ac39; "><strong>정상</strong></td>';
					}
					if (item.status == 'OUT') {
						rows += '<td style="color:#a9a9a9; "><strong>탈퇴</strong></td>';
					}
					if (item.status == 'REOUT') {
						rows += '<td style="color:#800000; "><strong>강퇴</strong></td>';
					}
					if (item.status == 'ADMIN') {
						rows += '<td style="color:#ff4500; "><strong>관리자</strong></td>';
					}
					rows += '<td class="dropdown">';
					rows += '<a class="dropdown-toggle btn btn-sm btn-default" data-toggle="dropdown" href="#">상태 업데이트<span class="caret"></span></a>';
					rows += '<ul class="dropdown-menu">';
					rows += '<li><a href="updateUserStatusById.do?status=IN&userId='+item.id+'&currentPageNo=${page.currentPageNo }&currentBlock=${page.currentBlock}">정상</a></li>';
					rows += '<li><a href="updateUserStatusById.do?status=OUT&userId='+item.id+'&currentPageNo=${page.currentPageNo }&currentBlock=${page.currentBlock}">탈퇴</a></li>';
					rows += '<li><a href="updateUserStatusById.do?status=REOUT&userId='+item.id+'&currentPageNo=${page.currentPageNo }&currentBlock=${page.currentBlock}">강퇴</a></li>';
					rows += '<li><a href="updateUserStatusById.do?status=ADMIN&userId='+item.id+'&currentPageNo=${page.currentPageNo }&currentBlock=${page.currentBlock}">관리자</a></li>';
					rows += '</ul>';
					rows += '</td>';
					rows += '</tr>';
				});
			
				var cnt = items.length;
				if (cnt == 0) {
					$('#pagination').empty();
					$('#plan-list').empty().append('<tr><td colspan="5" class="pull-center">검색 결과가 존재하지 않습니다</td></tr>');
					
				} else if (cnt != 0) {
					$('#pagination').empty();
					$('#plan-list').empty().append(rows);
					if (cnt > 10) {
						$('#contents').css('overflow-y', 'scroll').css('height', '680px');
					}
				}
				
			}
		});
	});
})
</script>
</html>