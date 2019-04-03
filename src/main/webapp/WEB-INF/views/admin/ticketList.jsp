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
	.pagination a {
	    color: black;
	    float: left;
	    padding: 8px 16px;
	    text-decoration: none;
	    transition: background-color .3s;
	    border-radius: 10px;
	}
	.pagination a.active {
	    background-color: #a0522d;
	    color: white;
	    border-radius: 10px;
	}
	.pagination a:hover:not(.active) {
		background-color: #black;
	    border-radius: 10px;
	}
</style>
</head>
<body>
<jsp:include page="../include/header.jsp" />
<div class="container" style="width: 60%; min-height: 740px;">
	<div class="row">
		<nav class="col-sm-3" id="myScrollspy">
			<!-- 왼쪽 메뉴바 -->
			<jsp:include page="menu.jsp" />
		</nav>
		<div class="col-sm-9">
			<!-- 오른쪽 티켓 리스트 -->
			<h1>
				<strong>티켓관리</strong>
				<img src="/resources/images/logo/peanutbw.png" width="40px">
				<img src="/resources/images/logo/peanutbw.png" width="40px">
				<img src="/resources/images/logo/peanutbw.png" width="40px">
				<span class="pull-right form-inline">
					<form method="post" id="search-form" class="form-inline">
						<input type="text" class="form-control" name="keyword" />
						<button class="btn btn-xs btn-default form-control" id="search-btn">검색</button>
					</form>
				</span>
			</h1>
			
			<table class="table table-hover">
				<colgroup>
					<col width="*%">
					<col width="18%">
					<col width="16%">
					<col width="16%">
					<col width="18%">
					<col width="10%">
				</colgroup>
				
				<thead>
					<tr>
						<th>티켓명</th>
						<th>가격</th>
						<th>할인율</th>
						<th>만료일</th>
						<th></th>
					</tr>
				</thead>
				<tbody style="font-size: small;" id="ticket-list">
				</tbody>
			</table>
		</div>
		<span class="pull-right"><a class="btn btn-default" href="addTicket.do">티켓등록</a></span>
		<div id="pagination" class="text-center">
		</div>
		
		<!-- Modal -->
		<div id="myModal" class="modal fade" role="dialog">
		  <div class="modal-dialog modal-lg">
		
		    <!-- Modal content-->
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		        <h4 class="modal-title">티켓 수정</h4>
		      </div>
		      <div class="modal-body">
		        <form method="post" id="update-form" action="updateTicket.do" enctype="multipart/form-data">
		        	<div class="row">
			        	<div class="col-sm-4 form-group">
			        		<input type="file" id="imgInp" name="images" accept="image/*"><span><small style="color: red">이미지 파일만 등록 해주세요.(10Mb제한)</small></span>
	  						<img id="blah" width="100%" src="/resources/images/review/noimage.jpg" alt="your image" />
			        		<input type="hidden" id="ticket-no" name="no">
			        	</div>
			        	<div class="col-sm-8 form-group">
			        		<table class="table table-bordered">
			        			<colgroup>
			        				<col width="25%">
			        				<col width="75%">
			        			</colgroup>
			        			<thead>
			        				<tr>
			        					<th>티켓명</th>
			        					<td><input type="text" class="form-control" id="ticket-name" name="name" value="부산아쿠아리움 입장권"></td>
			        				</tr>
			        				<tr>
			        					<th>가격</th>
			        					<td><input type="number" class="form-control" id="ticket-price" name="price" value="20000"></td>
			        				</tr>
			        				<tr>
			        					<th>카테고리</th>
			        					<td>
			        						<select class="form-control" id="ticket-category" name="category">
			        							<option value="WATER_PARK">워터파크</option>
			        							<option value="TEMA_PARK">테마파크</option>
			        							<option value="SPA">스파</option>
			        							<option value="AQUARIUM">아쿠아리움</option>
			        						</select>
			        					</td>
			        				</tr>
			        				<tr>
			        					<th>할인율</th>
			        					<td><input class="form-control" type="number"  id="ticket-discountRate" max="100" name="discountRate"></td>
			        				</tr>
			        				<tr>
			        					<th>판매종료일</th>
			        					<td><input class="form-control" type="date"  id="ticket-sellingEnd" name="sellingEnd"></td>
			        				</tr>
			        				<tr>
			        					<th>도시</th>
			        					<td><input class="form-control" type="text" id="ticket-locationCity" name="locationCity"></td>
			        				</tr>
			        			</thead>
			        		</table>
							<button style="width: 100%;" class="btn btn-default btn-sx form-control">수정</button> <hr />
							<a type="button" style="width: 100%;" class="btn btn-default btn-sx form-control" data-dismiss="modal">취소</a>
			        	</div>
		        	</div>
		        </form>
		      </div>
		    </div>
		  </div>
		</div>
	</div>
</div>
<jsp:include page="../include/miniUser.jsp" />
<jsp:include page="../include/footer.jsp" />
<script type="text/javascript">
	var keyword = null;
$(function() {	
	getTicket(1);

	$('#search-form').submit(function(event){
		event.preventDefault();
		keyword = $('input[name="keyword"]').val();
		var pno = 1;
		getTicket(pno);
	})
})
function getTicket(pno) {
	var pno = pno;
	
	$.ajax({
		type:"GET",
		url:"/admin/getTicket.do",
		data:{keyword:keyword,pno:pno},
		success: function(result) {
			var tickets = result.tickets;
			var row = "";
			$.each(tickets,function(index,ticket) {
				row += '<tr>';
				row += '<td>'+ticket.name+'</td>';
				row += '<td>'+ticket.price+'</td>';
				row += '<td>'+ticket.discountRate+'</td>';
				row += '<td>'+formatDate(ticket.sellingEnd) +'</td>';
				row += '<td>';
				row += '<div>';
		    	row += '<a onclick="getTicketByNo('+ticket.no+')" class="btn btn-warning btn-xs"><span>수정</span></a>';
		    	row += '<a style="margin-left:5px;" onclick="deleteTicketByNo('+ticket.no+')" class="btn btn-danger btn-xs"><span>삭제</span></a>';
		    	row += '</div>'
				row += '</td>';
				row += '</tr>';
			})
			$('#ticket-list').empty();
			$('#ticket-list').append(row);
			
			var nav = 5;
			var totalCnt = result.totalCnt;
			var totalPageNo = Math.ceil(totalCnt/10);
			var totalBlocks = Math.ceil(totalPageNo/nav);
			var currentBlock = Math.ceil(pno/nav);
			var beginModalPage = ((currentBlock-1)*nav)+1;
			var endModalPage = currentBlock*nav;
			var previousPage = Math.floor((pno-1)/5)*5;
			var	nextPage = Math.ceil(pno/5)*5+1;
			
			var pagination = "<nav>";
			 	pagination += "<ul class='pagination'>";
				if(currentBlock != 1){
				    pagination += "<li><a style='border-radius: 10px; border-color: white;' href='#' onclick='getTicket("+previousPage+")' aria-label='Previous'>";
				    pagination += "<span aria-hidden='true'>&laquo;</span></a></li>";
				}
				if(currentBlock == totalBlocks) {
				   beginModalPage = ((totalBlocks-1)*nav)+1;
				   endModalPage = totalPageNo;
				}
				for (var i=beginModalPage; i<=endModalPage; i++) {
				   if (pno == i){
				      pagination += "<li><a style='border-radius: 10px; border-color: white;' class='active' href='#' onclick='getTicket("+i+")'>"+i+"</a></li>";
				   } else {
				      pagination += '<li><a style="border-radius: 10px; border-color: white;" href="#" onclick="getTicket('+i+')">'+i+'</a></li>';
				   }
				}
				if(currentBlock != totalBlocks){
				    pagination += "<li><a style='border-radius: 10px; border-color: white;' href='#' onclick='getTicket("+nextPage+")' aria-label='Next'>";
				    pagination += "<span aria-hidden='true'>&raquo;</span></a></li>";
				}
			pagination += "</ul></nav>";
			$('#pagination').empty();
			$('#pagination').append(pagination);
		}
	})
}


function formatDate(date) {
      var d = new Date(date),
      	month = '' + (d.getMonth() + 1),
          day = '' + d.getDate(),
          year = d.getFullYear();
      	hour = d.getHours();
      	minute = d.getMinutes();
      	second = d.getSeconds();

      if(month.length < 2){ 
      	month = '0' + month;
      }
      if(day.length < 2){
      	day = '0' + day;
      }
      if(hour.length < 2 ){
      	hour = '0' + hour;
      }
      if(minute.length  < 2) {
      	minute = '0' + minute;
      }
      if(second.length < 2) {
      	second = '0' + second;
      }
		var formattedDate = [year, month, day].join('-');
      return formattedDate;
  }
  
	function getTicketByNo(no) {
		$.ajax({
			type:"GET",
			url:"/admin/getTicketByNo.do",
			data:{ticketNo:no},
			success: function(result) {
				var ticket = result.ticket;
				$('#ticket-name').val(ticket.name);
				$('#ticket-price').val(ticket.price);
				$('#ticket-category').val(ticket.category);
				$('#ticket-discountRate').val(ticket.discountRate);
				$('#ticket-sellingEnd').val(formatDate(ticket.sellingEnd));
				$('#ticket-locationCity').val(ticket.locationCity);
				$('#ticket-no').val(ticket.no);
				$('#blah').attr('src', '/resources/images/ticket/'+ticket.images);
				$('#myModal').modal('show');
			}
		})
  }
  
  function readURL(input) {

	  if (input.files && input.files[0]) {
	    var reader = new FileReader();

	    reader.onload = function(e) {
	      $('#blah').attr('src', e.target.result);
	    }

	    reader.readAsDataURL(input.files[0]);
	  }
	}

	$("#imgInp").change(function() {
	  readURL(this);
	});
	
	$('#update-form').submit(function() {
		var name = $('#ticket-name').val();
		var price = $('#ticket-price').val();
		var category = $('#ticket-category').val();
		var discountRate = $('#ticket-discountRate').val();
		var sellingEnd = $('#ticket-sellingEnd').val();
		var locationCity = $('#ticket-locationCity').val();
		var img = $('#imgInp').val();
		
		if(name =='') {
			alert('티켓명을 입력해 주세요');
			return false;
		}
		if(price =='') {
			alert('가격을 입력해 주세요');
			return false;
		}
		if(category =='') {
			alert('카테고리를 선택해 주세요');
			return false;
		}
		if(sellingEnd =='') {
			alert('마감일을 입력해 주세요');
			return false;
		}
		if(discountRate =='') {
			alert('할인율을 입력해 주세요');
			return false;
		}
		if(locationCity =='') {
			alert('지역을 입력해 주세요');
			return false;
		}
	});
	
	function deleteTicketByNo(i) {
		$.ajax({
			type:"POST",
			url: "/ticket/deleteTicket.do",
			data: {ticketNo:i},
			success: function(result){
				var success = result.success;
				console.log(success);
				if(success) {
					getTicket(1);
					alert('티켓이 삭제되었습니다.');
				}
			}
		})
	}
  
</script>
</body>
</html>