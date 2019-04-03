<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>photoList</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style type="text/css">
body {
  font-family: Arial;
  margin: 0;
}

* {
  box-sizing: border-box;
}

img {
  vertical-align: middle;
}

/* Position the image container (needed to position the left and right arrows) */
.container {
  position: relative;
}

/* Hide the images by default */
.mySlides {
  display: none;
}

/* Add a pointer when hovering over the thumbnail images */
.cursor {
  cursor: pointer;
}

/* Next & previous buttons */
.prev,
.next {
  cursor: pointer;
  position: absolute;
  top: 40%;
  width: auto;
  padding: 16px;
  margin-top: -50px;
  color: #8b4513;
  font-weight: bold;
  font-size: 20px;
  border-radius: 0 3px 3px 0;
  user-select: none;
  -webkit-user-select: none;
}

/* Position the "next button" to the right */
.next {
  right: 0;
  border-radius: 3px 0 0 3px;
}

/* On hover, add a black background color with a little bit see-through */
.prev:hover,
.next:hover {
  background-color: #8b4513;
  color: #fff8dc;
}

/* Number text (1/3 etc) */
.numbertext {
  color: #f2f2f2;
  font-size: 12px;
  padding: 8px 12px;
  position: absolute;
  top: 0;
}

/* Container for image text */
.caption-container {
  text-align: center;
  background-color: #222;
  padding: 2px 16px;
  color: white;
}

.row:after {
  content: "";
  display: table;
  clear: both;
}

/* Six columns side by side */
.column {
  float: left;
  width: 16.66%;
  padding: 10px;
}
.column img {
    margin-top: 12px;
    
}
.row:after {
    content: "";
    display: table;
    clear: both;
}

/* Add a transparency effect for thumnbail images */
.demo {
  opacity: 0.6;
}

.active,
.demo:hover {
  opacity: 1;
}
</style>
</head>
<body>
<jsp:include page="../include/header.jsp" />
<jsp:include page="../include/top.jsp">
	<jsp:param name="top" value="album"/>
	<jsp:param name="pno" value="${pno }"/>
</jsp:include>
<div class="container" style="width: 60%; min-height: 740px;">
	<div class="row">
		<h1>
			<c:if test="${isWriter}">
				<span class="pull-right form-inline" style="font-size: small;">
					<form action="/user/addPhoto.do" method="post" id="file-add-form" enctype="multipart/form-data" class="form-inline form-group" >
						<input type="file" class="form-control" name="photo" />
						<input type="hidden" name="pno" value="${pno }" />
						<button class="btn btn-xs btn-default form-control" id="add-btn">추가</button>
					</form>
				</span>
			</c:if>
			<br>
			<c:if test="${isWriter}">
				<span style="font-size: small; color: #800000;" class="pull-right">
					▶▶▶ 사진을 더블클릭하면 삭제됩니다 ◀◀◀
				</span>
			</c:if>
		</h1>
	</div>
	
	
	<c:forEach items="${photos}" var="photo">
		<div class="mySlides text-center" style="height: 450px; padding: auto;">
	    	<div class="numbertext">${photo.index} / ${size}</div>
	    	<img src="/resources/images/album/${photo.name}" style="max-width:960px; height: 450px;">
	  	</div>
  	</c:forEach>
    
  	<a class="prev" onclick="plusSlides(-1)">&lt;</a>
  	<a class="next" onclick="plusSlides(1)">&gt;</a>

  	<div class="caption-container">
    	<p id="caption" style="text-align: center;"></p>
  	</div>
	
	<div class="row" >
		<c:forEach items="${photos }" var="photo">
	    	<div class="column text-center" ondblclick="delPhoto('${photo.no}', '${photo.name}')">
      			<img class="demo cursor" src="/resources/images/album/${photo.name }" style="max-width:100%; max-height: 100px;" onclick="currentSlide(${photo.index})" alt="${photo.name }" />
	    	</div>
		</c:forEach>
	</div>
<input type="hidden" name="isWriter" value="${isWriter }" />
<script>
var slideIndex = 1;
showSlides(slideIndex);

function plusSlides(n) {
	showSlides(slideIndex += n);
}

function currentSlide(n) {
	showSlides(slideIndex = n);
}

function showSlides(n) {
	var i;
	var slides = document.getElementsByClassName("mySlides");
	var dots = document.getElementsByClassName("demo");
	var captionText = document.getElementById("caption");
	if (n > slides.length) {slideIndex = 1}
	if (n < 1) {slideIndex = slides.length}
	for (i = 0; i < slides.length; i++) {
	    slides[i].style.display = "none";
	}
	for (i = 0; i < dots.length; i++) {
	    dots[i].className = dots[i].className.replace(" active", "");
	}
	slides[slideIndex-1].style.display = "block";
	dots[slideIndex-1].className += " active";
	captionText.innerHTML = dots[slideIndex-1].alt;
}

var isWriter;

$(function() {
	$('#add-btn').click(function(e) {
		e.preventDefault();
		var photo = $('input[name=photo]').val()

		if (photo == "") {
			return false;
		}
		
		$('#file-add-form').submit();
	});
	
	isWriter = $('input[name=isWriter]').val();
})

function delPhoto(no, name) {
	if (isWriter == 'false') {
		return false;
	}
	var isOk = confirm('사진을 삭제하시겠습니까?');
	if (isOk == true) {
		location.href='/user/delPhoto.do?pno='+no+'&name='+name;
	}
}
</script>
</div>
<jsp:include page="../include/footer.jsp" />
</body>
</html>