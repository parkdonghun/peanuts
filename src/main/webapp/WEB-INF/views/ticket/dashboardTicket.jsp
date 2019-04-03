<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
function comma(str) {
  		str = String(str);
   	return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}
	getTicket();
function getTicket() {	
	$.ajax({
		type: "GET",
		url: "/ticket/dashboard.do",
		dataType: 'json',
		data:{},
		success: function(result) {
			$('#ticketTopList').empty();
			var $ticketTopList = $('#ticketTopList');
			
			$.each(result.list, function(n, items){
				var price = comma(items.price);
				var orderPrice = comma(items.price*((100-items.discountRate)/100));
				var row = '';
				
				row += '<li><div class="col-lg-2" style="margin-left: 15px;">';
				row += '<a href="/ticket/detail.do?ticketNo='+items.no+'">';
				row += '<img class="card-img-top img-rounded" style="opacity:0.9;" src="/resources/images/ticket/'+items.images+'" width="180px" height="200px"></a>';
				row += '<h5 class="card-title"><strong>'+items.name+'</h5>';
				row += '<h5><small><del class=>￦ '+price+'원</del></small> <span style="color: red;">↓'+items.discountRate+'%</span>';
				row += '<p><span>￦'+orderPrice+'</span>원<p></h5>';
				row += '</div></li>';	
				$ticketTopList.append(row);
			});
		}
	})
}
</script>
<div class="container">
	<div class="row text-center" style="margin-top: 20px;">
		<ul class="list-unstyled" id="ticketTopList">
			
		</ul>
	</div>
</div>