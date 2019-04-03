<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>dashboard</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel='stylesheet' href='/resources/fullcalendar/fullcalendar.css' />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src='/resources/fullcalendar/lib/moment.min.js'></script>
<script src='/resources/fullcalendar/fullcalendar.js'></script>
<script src='/resources/fullcalendar/locale/ko.js'></script>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<style type="text/css">
body {
  background: #e6e6e6;
  font-family: "Roboto", sans-serif;
  font-weight: 400;
}
#conference-timeline {
  position: relative;
  max-width: 920px;
  width: 100%;
  margin: 0 auto;
}
#conference-timeline .timeline-start,
#conference-timeline .timeline-end {
  display: table;
  font-family: "Roboto", sans-serif;
  font-size: 18px;
  font-weight: 900;
  text-transform: uppercase;
  background: #c68c53;
  padding: 15px 23px;
  color: #fff;
  max-width: 30%;
  width: 100%;
  text-align: center;
  margin: 0 auto;
}
#conference-timeline .conference-center-line {
  position: absolute;
  width: 3px;
  height: 100%;
  top: 0;
  left: 50%;
  background: #c68c53;
  z-index: -1;
}
#conference-timeline .conference-timeline-content {
  padding-top: 40px;
  padding-bottom: 40px;
}
.timeline-article {
  width: 1200px;
  /* height: 100%; */
  overflow: hidden;
  margin: 0 0 0 -90px;
}
.timeline-article .content-left-container {
  max-width: 60%;
  width: 600px;
  margin: 0px;
}
.timeline-article .content-right-container {
  max-width: 60%;
  width: 600px;
  margin: 0px;
}
.timeline-article .timeline-author {
  display: block;
  font-weight: 400;
  font-size: 14px;
  line-height: 24px;
  color: #242424;
  text-align: right;
}
.timeline-article .content-left {
  position: relative;
  width: 500px;
  border: 1px solid #ddd;
  background-color: #fff;
  box-shadow: 0 1px 3px rgba(0,0,0,.03);
  padding: 15px;
}
.timeline-article .content-right {
  position: relative;
  width: 500px;
  border: 1px solid #ddd;
  background-color: #fff;
  box-shadow: 0 1px 3px rgba(0,0,0,.03);
  padding: 15px;
}
.timeline-article p {
  margin: 0 0 0 0px;
  padding: 0;
  font-weight: 400;
  color: #242424;
  font-size: 14px;
  line-height: 24px;
  position: relative;
}
/*숫자*/
.timeline-article p span.article-number {
  /* position: absolute; */
  position: static;
  font-weight: 200;
  font-size: 44px;
  letter-spacing: -4px;
  top: 10px;
  left: -60px;
  color: #c68c53;
}
span.ticketTitle {
  /* position: absolute; */
  position: static;
  font-weight: 200;
  font-size: 44px;
  letter-spacing: -4px;
  top: 10px;
  left: -60px;
  color: #c68c53;
}
.timeline-article .content-left-container {
  float: left;
}
.timeline-article .content-right-container {
  float: right;
}
.timeline-article .content-left:before,
.timeline-article .content-right:before{
  position: absolute;
  top: 20px;
  font-size: 23px;
  font-family: "FontAwesome";
  color: #fff;
}
.timeline-article .content-left:before {
  content: "\f0da";
}
.timeline-article .content-right:before {
  content: "\f0d9";
}
.dashTicket-Box {
  border: 3px solid #c68c53;
  width: 1140px;
  height: auto;
  margin-top: 20px;
  margin-left: -110px;
  background-color: #fff; z-index: 1}
@media only screen and (max-width: 830px) {
  #conference-timeline .timeline-start,
  #conference-timeline .timeline-end {
    margin: 0;
  }
  #conference-timeline .conference-center-line {
    margin-left: 0;
    left: 50px;
  }
  .timeline-article .meta-date {
    margin-left: 0;
    left: 20px;
  }
  .timeline-article .content-left-container,
  .timeline-article .content-right-container {
    max-width: 100%;
    width: auto;
    float: none;
    margin-left: 110px;
    min-height: 53px;
  }
  .timeline-article .content-left-container {
    margin-bottom: 20px;
  }
  .timeline-article .content-left,
  .timeline-article .content-right {
    padding: 10px 25px;
    min-height: 65px;
  }
  .timeline-article .content-left:before {
    content: "\f0d9";
    right: auto;
    left: -8px;
  }
  .timeline-article .content-right:before {
    display: none;
  }
}
@media only screen and (max-width: 400px) {
  .timeline-article p {
    margin: 0;
  }
  .timeline-article p span.article-number {
    display: none;
  }
  
}
</style>
</head>
<body>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/top.jsp">
	<jsp:param name="top" value="home"/>
	<jsp:param name="pno" value="${pno }"/>
</jsp:include>
<section id="conference-timeline" style="width: 60%">
    <!--여행 시작일-->
    <%-- <div class="timeline-start">${startDate }</div> --%>
    
    <!--가운데 선-->
    <div class="conference-center-line"></div>
    
    <!--내용-->
    <div class="conference-timeline-content">
        <div class="timeline-article">
            <div class="content-left-container">
                <div class="content-left">
                   	<p><span class="article-number"><span style="color: #996633; margin-left: -5px;">01</span>지도</span></p>
                	<br>
                   	<img src="${mapImg}">
                    <br>
                    <c:if test="${status == 'N' && isWriter eq true }">
                    	<a href="/map/map.do?pno=${pno }" class="btn btn-sm" style="background-color: #ac7339; margin-top: 10px; color: #fff;">루트수정</a>
                    </c:if>
                </div>
            </div>
            <div class="content-right-container">
                <div class="content-right">
                	<p><span class="article-number"><span style="color: #996633; margin-left: -5px;">02</span>일정</span></p>
 					<jsp:include page="../schedule/dashCal.jsp">
						<jsp:param name="pno" value="${pno }"/>
					</jsp:include>                	
                </div>
            </div>
        </div>
        <div class="timeline-article">
            <div class="content-left-container">
                <div class="content-left">
                   	<p><span class="article-number"><span style="color: #996633; margin-left: -5px;">03</span>가계부</span></p>
                	<br>
                   	<p>
                   		<jsp:include page="../wallet/dashWallet.jsp">
                   			<jsp:param value="${pno }" name="pno"/>
                   		</jsp:include>
                   	</p>
                </div>
            </div>
            <div class="content-right-container">
                <div class="content-right">
                	<p><span class="article-number"><span style="color: #996633; margin-left: -5px;">04</span>날씨</span></p>
                	<br>
                    <p>
                    	<jsp:include page="../weather/dashWeather.jsp">
                   			<jsp:param value="${param.pno }" name="pno"/>
                   		</jsp:include>
                    </p>
                </div>
            </div>
        </div>

	    <!--여행 종료일-->
	    <div class="timeline-end" style="margin-top: 20px;">${endDate }</div>
	        
	    <div class="dashTicket-Box">
	        <div>
	            <div>
	               	<p><span class="ticketTitle"><span style="color: #996633; margin-left: 5px;">05</span>티켓</span><a style="margin-left: 15px; margin-bottom: 20px;" class="btn btn-success btn-xs" href="/ticket/main.do">티켓 구매 바로가기<span style="color: white" class="glyphicon glyphicon-shopping-cart"></span></a></p>
	               	<p>
	               		<jsp:include page="../ticket/dashboardTicket.jsp" />
	               	</p>
	            </div>
	        </div>
	    </div>
    
    </div>
</section>
<jsp:include page="../include/footer.jsp" />
</body>
</html>