<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>qnaList</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
	a:link, a:visited {
		color: #000000;
	}
	a:hover {
		color: #ac7339;
	}
	.noticeBox p {
		font-size: 13px;
		color: #737373;
		font-weight: bolder;
		margin: 10px;
	}
</style>
</head>
<body>
<jsp:include page="../include/header.jsp" />
<div class="container" style="width: 60%; min-height: 740px;">
	<div class="row">
		<div class="col-sm-1"></div>
		<div class="col-sm-10">
			<div class="row">
				<div class="col-sm-2">
					<h1><strong>QnA</strong></h1>
				</div>
				<div class="noticeBox col-sm-9">
					<p><img src="/resources/images/logo/peanutbw.png" width="20px;" /> 땅콩플래너 동행게시판을 통해서 즐거운 여행의 파트너를 만나보세요!</p>
					<p><img src="/resources/images/logo/peanutbw.png" width="20px;" /> 게시글 작성은 로그인한 회원만 가능합니다.</p>
				</div>
				<div class="col-sm-1">
				</div>
			</div>
			<c:if test="${!(LOGIN_USER.status eq 'ADMIN') }">
				<a href="qnaForm.do" class="btn btn-default pull-right btn-sm">새 글 작성</a>
			</c:if>
			<br>
			<br>
			<table class="table table-hover">
				<colgroup>
					<col width="10%">
					<col width="*">
					<col width="15%">
					<col width="15%">
					<col width="10%">
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>답변상태</th>
					</tr>
				</thead>
				<tbody style="font-size: small;">
				<c:forEach var="board" items="${boards }">
					<c:if test="${LOGIN_USER.id eq board.userId || LOGIN_USER.status eq 'ADMIN'}">
						<tr>
							<td>${board.no }</td>
							<td>
								<a href="qnaDetail.do?no=${board.no }&currentPageNo=${page.currentPageNo }&currentBlock=${page.currentBlock}">
									${board.title }
									<c:if test="${board.isSameDate}">
										 <span style="background-color: #b22222;" class="badge"> New</span>
									</c:if>
								</a>
							</td>
							<td>${board.userId }</td>
							<td><fmt:formatDate value="${board.createDate }" pattern="yyyy-MM-dd" /></td>
							<td>
							<c:if test="${board.hasReply eq true }">
								<button class="btn btn-xs btn-info">완료</button>
							</c:if>
							<c:if test="${board.hasReply eq false }">
								<button class="btn btn-xs btn-warning">대기</button>
							</c:if>
							</td>
						</tr>
					</c:if>
				</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<jsp:include page="../include/pagination.jsp">
		<jsp:param value="${page }" name="page"/>
		<jsp:param value="/adQna/qnaList.do" name="url"/>
	</jsp:include>
</div>
<jsp:include page="../include/footer.jsp" />
</body>
</html>