<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.pagination a {
	    color: black;
	    float: left;
	    padding: 8px 16px;
	    text-decoration: none;
	    transition: background-color .3s;
	}
	.pagination a.active {
	    background-color: #a0522d;
	    color: white;
	    border-radius: 10px;
	}
	.pagination a:hover:not(.active) {
		background-color: #ddd;
	    border-radius: 10px;
	}
</style>

<c:if test="${page.totalCnt == 0 }">
	<a href="#" class="active">1</a>
</c:if>
<div class="row text-center" id="pagination">
	<div class="pagination">
		<c:if test="${page.currentBlock != 1 }">
			<a href="${url }?currentPageNo=${page.beginPage - 1}&currentBlock=${page.currentBlock - 1}">&laquo;</a>
		</c:if>
		<c:forEach var="pageNo" step="1" begin="${page.beginPage }" end="${page.endPage }">
			<c:choose>
				<c:when test="${page.currentPageNo == pageNo }">
					<a href="#" class="active">${pageNo }</a>
				</c:when>
				<c:otherwise>
					<a href="${url }?currentPageNo=${pageNo }&currentBlock=${page.currentBlock}">${pageNo }</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${page.currentBlock != page.totalBlocks }">
			<a href="${url }?currentPageNo=${page.endPage + 1}&currentBlock=${page.currentBlock + 1}">&raquo;</a>
		</c:if>
	</div>
</div>