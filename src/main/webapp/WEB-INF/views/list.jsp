<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("PATH", request.getContextPath()); //获取到项目的服务器路径
%>


<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script type="text/javascript" src="${PATH }/static/js/jquery.min.js"></script>

<!-- Bootstrap -->
<link href="${PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="${PATH }/static/bootstrap-3.3.7-dist//js/bootstrap.min.js"></script>

</head>
<body>
	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题 -->
		<dir class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</dir>
		<!-- 按钮 -->
		<dir class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</dir>
		<!-- 表格数据 -->
		<dir class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<th>#</th>
						<th>empName</th>
						<th>gender</th>
						<th>email</th>
						<th>deptName</th>
						<th>操作</th>
					</tr>
					<c:forEach items="${pageInfo.list }" var="emp">
						<tr>
							<td>${emp.empId }</td>
							<td>${emp.empName }</td>
							<td>${emp.gender=="M"?"男":"女" }</td>
							<td>${emp.email }</td>
							<td>${emp.dept.deptName }</td>
							<td>
								<button class="btn btn-primary btn-sm">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
									编辑
								</button>
								<button class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									删除
								</button>
							</td>
						</tr>
					</c:forEach>

				</table>

			</div>
		</dir>
		<!-- 分页栏 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6">
				当前  ${pageInfo.pageNum } 页,总 ${pageInfo.pages } 页 ,总 ${pageInfo.total } 条记录
			</div>
			<!-- 分页条 -->
			<div class="col-md-6">
				<nav aria-label="Page navigation">
				<ul class="pagination">
					<%-- <c:if test="${pageInfo.pageNum != 1 }"> --%>
					<c:if test="${pageInfo.hasPreviousPage }">
						<li><a href="${PATH }/emps?pageNum=1">首页</a></li>
						<li><a href="${PATH }/emps?pageNum=${pageInfo.pageNum  - 1} " aria-label="Previous"> <span
							aria-hidden="true">&laquo;</span>
					</a></li>
					</c:if>
					
					<c:forEach items="${pageInfo.navigatepageNums }" var="pageNumber">
						<c:if test="${pageNumber == pageInfo.pageNum }">
							<li class="active"><a href="#">${pageNumber }</a></li>
						</c:if>
						<c:if test="${pageNumber != pageInfo.pageNum }">
							<li ><a href="${PATH }/emps?pageNum=${pageNumber }">${pageNumber }</a></li>
						</c:if>
						
					</c:forEach>
				
					
					<%-- <c:if test="${pageInfo.pageNum != pageInfo.pages }"> --%>
					<c:if test="${pageInfo.hasNextPage }">
						<li><a href="${PATH }/emps?pageNum=${pageInfo.pageNum + 1}" aria-label="Next"> <span
							aria-hidden="true">&raquo;</span>
						</a></li>
						<li><a href="${PATH }/emps?pageNum=${pageInfo.pages}">末页</a></li>
					</c:if>
				</ul>
				</nav>
			</div>
		</div>

	</div>

</body>
</html>