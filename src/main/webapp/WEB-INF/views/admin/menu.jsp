<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">
/* body {
    position: relative;
} */
ul.nav-pills {
	/* position: relative; */
    top: 140px;
    /* position: fixed; */
}
/* div.col-sm-9 div {
    height: 250px;
    font-size: 28px;
} */
a:link, a:visited {
	color: #000000;
}
/* width */
::-webkit-scrollbar {
    width: 10px;
}

/* Track */
::-webkit-scrollbar-track {
    background: #f1f1f1; 
}
 
/* Handle */
::-webkit-scrollbar-thumb {
    background: #888; 
}

/* Handle on hover */
::-webkit-scrollbar-thumb:hover {
    background: #555; 
}
</style>
<ul class="nav nav-pills nav-stacked" style="overflow-y: scroll; height:680px;">
	<li><a href="/admin/userList.do">회원관리</a></li>
	<li><a href="/advertising/getAdList.do">업체관리</a></li>
	<li><a href="/admin/repoList.do">신고댓글</a></li>
	<li><a href="/admin/planList.do">플래너 관리</a></li>
	<li class="dropdown">
		<a class="dropdown-toggle" data-toggle="dropdown" href="#">게시판 관리<span class="caret"></span></a>
		<ul class="dropdown-menu">
			<li><a href="/admin/qnaList.do">QNA</a></li>
			<li><a href="/admin/plazaList.do">광장게시판</a></li>
			<li><a href="/admin/togetherList.do">동행게시판</a></li>
			<li><a href="/admin/ticketList.do">티켓게시판</a></li>
			<li><a href="/advertising/getAllAdBoards.do">광고게시판</a></li>
		</ul>
	</li>
	<hr/>
	<li><a href="#a">총 여행일수</a></li>
	<li><a href="#b">월별 여행일</a></li>
	<li><a href="#c">가장 많이 방문한 도시</a></li>
	<li><a href="#d">가장 오래 머문 도시(전체)</a></li>
	<li><a href="#e">가장 오래 머문 도시(평균)</a></li>
	<li><a href="#"></a></li>
	<hr/>
	<li><a href="/admin/main.do"> ◀◀◀ 메인 메뉴로</a></li>
	<li><a href="/home.do"> ◀◀◀ 홈으로</a></li>
</ul>