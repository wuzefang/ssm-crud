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

<!-- 员工修改 -->
	<div class="modal fade" id="empUpdateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" >员工修改</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal">
	       <!-- empName 添加 -->
			  <div class="form-group">
			    <label  class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
					<p class="form-control-static" id="empName_update_static"></p>		    
			    </div>
			  </div>
			<!-- email 添加 -->
			  <div class="form-group">
			    <label  class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" name ="email" id="email_update_input" placeholder="email@qq.com">
			      <span  class="help-block"></span>
			    </div>
			  </div>
			  <!-- 性别设置 -->
			 <div class="form-group">
			    <label  class="col-sm-2 control-label">gender</label>
			    <div class="col-sm-10">
			      <label class="radio-inline">
  					<input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
				  </label>
				  <label class="radio-inline">
  					<input type="radio" name="gender" id="gender2_update_input" value="F"> 女
				  </label>
			    </div>
			  </div>
			  <!-- 部门选择 -->
			  <div class="form-group">
			    <label  class="col-sm-2 control-label">deptName</label>
			    <div class="col-sm-4">
			      <select class="form-control" name="dId">	 </select>
			    </div>
			  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_update_btn">修改</button>
	      </div>
	    </div>
	  </div>
	</div>

<!-- 员工添加 -->
	<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal">
	       <!-- empName 添加 -->
			  <div class="form-group">
			    <label  class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" name = "empName" id="empName_add_input" placeholder="empName">
			      <span  class="help-block"></span>
			    </div>
			  </div>
			<!-- email 添加 -->
			  <div class="form-group">
			    <label  class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" name ="email" id="email_add_input" placeholder="email@qq.com">
			      <span  class="help-block"></span>
			    </div>
			  </div>
			  <!-- 性别设置 -->
			 <div class="form-group">
			    <label  class="col-sm-2 control-label">gender</label>
			    <div class="col-sm-10">
			      <label class="radio-inline">
  					<input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
				  </label>
				  <label class="radio-inline">
  					<input type="radio" name="gender" id="gender2_add_input" value="F"> 女
				  </label>
			    </div>
			  </div>
			  <!-- 部门选择 -->
			  <div class="form-group">
			    <label  class="col-sm-2 control-label">deptName</label>
			    <div class="col-sm-4">
			      <select class="form-control" name="dId">	 </select>
			    </div>
			  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
	      </div>
	    </div>
	  </div>
	</div>

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
				<button class="btn btn-primary" id = "emp_add_model_btn">新增</button>
				<button class="btn btn-danger" id = "emp_delAll_model_btn">删除</button>
			</div>
		</dir>
		<!-- 表格数据 -->
		<dir class="row">
			<div class="col-md-12">
				<table class="table table-hover"  id="emps_table"> 
					<thead>
						<tr>
							<th >
								<input type="checkbox" id="check_all"/>
							</th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					
					</tbody>
				</table>

			</div>
		</dir>
		<!-- 分页栏 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info_data">
				
			</div>
			<!-- 分页条 -->
			<div class="col-md-6" id="page_nav_data">
				
			</div>
		</div>

	</div>
	<script type="text/javascript">
		//定义全局变量保存总记录数
		var totalRecord,currentPage;
	
		// 1、发送ajax请求，获取到页面数据
		$(function(){
			to_page(1);
		});
		//将页面跳转和渲染抽取出成一个方法
		function to_page(pageNum){
			$.ajax({
				url:"${PATH}/emps",
				data:"pageNum="+pageNum,
				type:"get",
				success:function(result){
					console.log(result)
					//1、解析查询员工的结果集的表格
					build_emps_table(result);
					//2、解析分页信息的表格
					build_page_info(result);
					//3、解析分页条的表格
					build_page_nav(result);
				}
			});
		}
		function build_emps_table(result){
			//构建之前先清空数据
			$("#emps_table tbody").empty();
			
			var emps = result.extend.pageInfo.list;
			$.each(emps,function(index,item){
				//alert(item.empName);
				//选择按钮,把  id 和员工名 添加进去 ，方便删除时获取
				var checkBoxTd =$("<td></td>").append($("<input type='checkbox'class='check_item'/>")
						.attr("item_empName",item.empName)
						.attr("item_empId",item.empId))
						;
				//构建员工数据
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var empGenderTd = $("<td></td>").append(item.gender == "M" ? "男":"女");
				var empEmailTd = $("<td></td>").append(item.email);
				var empDeptTd = $("<td></td>").append(item.dept.deptName);
				//构建按钮 
				//编辑按钮
				var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
							.append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
							.append("编辑");
				editBtn.attr("edit_id",item.empId);  //为了方便编辑时，可以获取到快速当前员工的id，传到后台进行查询
				//删除按钮
				var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm del_btn")
							.append($("<span></span>").addClass("glyphicon glyphicon-trash"))
							.append("删除");
				delBtn.attr("del_id",item.empId).attr("del_name",item.empName);  //为了删除时，方便获取
				//合并按钮到一个td中
				var optTd = $("<td></td>").append(editBtn).append("  ").append(delBtn);
				$("<tr></tr>").append(checkBoxTd)
							  .append(empIdTd)
							  .append(empNameTd)
							  .append(empGenderTd)
							  .append(empEmailTd)
							  .append(empDeptTd)
							  .append(optTd)
							  .appendTo("#emps_table tbody")
			});
		}
		//分页信息数据
		function build_page_info(result){
			$("#page_info_data").empty();
			currentPage = result.extend.pageInfo.pageNum;
			var pagesNumber = result.extend.pageInfo.pages;
			totalRecord = result.extend.pageInfo.total;
			$("#page_info_data").append("当前  "+currentPage+"页,总 "+pagesNumber+"页 ,总"+totalRecord+" 条记录");
			
		}
		//分页条导航信息数据
		function build_page_nav(result){
			//page_nav_data
			$("#page_nav_data").empty();
			//构建整个分页条的 ul标签，并引用bootstrap
			var ul = $("<ul></ul>").addClass("pagination");
			//首页
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页"));
			
			//上一页
			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
			if(result.extend.pageInfo.hasPreviousPage){
				prePageLi.click(function(){
					to_page(result.extend.pageInfo.prePage);
				});
				firstPageLi.click(function(){
					to_page(1);
				});
			}
			//判断是上否有上一页
			if(!result.extend.pageInfo.hasPreviousPage){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}
			
			//下一页
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
			//末页
			//判断是否有下一页
			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页"));
			if(!result.extend.pageInfo.hasNextPage){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}
			if(result.extend.pageInfo.hasNextPage){
				nextPageLi.click(function(){
					to_page(result.extend.pageInfo.nextPage);
				});
				lastPageLi.click(function(){
					to_page(result.extend.pageInfo.pages);
				});
			}
			
			//1、添加顺序 首页 --- 前一页 ---页码范围 --- 下一页 --末页
			ul.append(firstPageLi).append(prePageLi);
			//连续显示的页码号
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				//便利的item就是 页码号  1 2 3 4 5
				var numLi =$("<li></li>").append($("<a></a>").append(item));
				//给便利的每个数字添加click事件
				numLi.click(function(){
					to_page(item);
				});
				if(result.extend.pageInfo.pageNum == item){
					numLi.addClass("active");
				}
				//2、遍历时 把获取到的页码号也添加进去
				ul.append(numLi);
			});
			//3、最后添加下一页和末页
			ul.append(nextPageLi).append(lastPageLi);
			var navEle = $("<nav></nav>").append(ul).addClass()
			navEle.appendTo("#page_nav_data");
		}
		function remove_form_style(ele){
			$(ele)[0].reset(); //清空表单内容
			$(ele).find("*").removeClass("has-error has-success")//清空之前验证结果的样式
			$(ele).find(".help-block").text("");
		}
		//查询出部门信息
		function getDepts(ele){
			$.ajax({
				url:"${PATH}/depts",
				type:"GET",
				success:function(result){
					//console.log(result);
					//遍历之前先清空下拉框
					$(ele).empty();
					//遍历查询的结果
					/**
					{"code":100,"msg":"请求成功！",
						"extend":{"depts":[{"deptId":1,"deptName":"研发部"},
						                   {"deptId":2,"deptName":"测试部"},
						                   {"deptId":3,"deptName":"实施部"}]}}
					*/
					$.each(result.extend.depts,function(){
						var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
						optionEle.appendTo(ele);
					});
				}
				
			});
		};
		//点击新增按钮，弹出模态框
		$("#emp_add_model_btn").click(function(){
			//在发送ajax请求之前，先重置掉所form表单中所有的信息,使用DOM对象的reset()
			//$("#empAddModel form")[0].reset();
			remove_form_style("#empAddModel form");
			//弹框之前，发送ajax请求，查出部门信息，显示在下拉列表中
			getDepts("#empAddModel select");
			//弹出模态框
			$("#empAddModel").modal({
				backdrop:"static"
			});
			
		});
		//校验结果显示
		function validate_msg(ele,status,msg){
			//显示前先清空信息
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			
			if("success" == status){
				$(ele).parent().addClass("has-success");
			}else if("error" == status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
	   //前端数据校验
		function validate_add_form(){
			//获取前端的empName的值
			var empNameVal = $("#empName_add_input").val();
			//获取前端email的值
			var emailVal = $("#email_add_input").val();
			//设置正则
			var empNameReg = /^([\u4e00-\u9fa5]{2,4})|([A-Za-z0-9_]{4,16})|([a-zA-Z0-9_\u4e00-\u9fa5]{3,16})$/;
			var emailReg = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
			
			if(!empNameReg.test(empNameVal)){
				//alert("户名注册必须为, 4-16位字母,数字,汉字,下划线！");
				validate_msg("#empName_add_input","error","户名注册必须为, 4-16位字母,数字,汉字,下划线！")
				return false;
			}else{
				validate_msg("#empName_add_input","success","")
			}
			
			if(!emailReg.test(emailVal)){
				//alert("邮箱格式不正确！");
				validate_msg("#email_add_input","error","邮箱格式不正确！")
				return false;
			}else{
				validate_msg("#email_add_input","success","")
			}
			return true;
		}
	   	//后端校验 ，用户名是否重复,用户名输入框发生改变后发送ajax请求进行数据查询和校验
		$("#empName_add_input").change(function(){
			var empName = this.value;
			//发送ajax
			$.ajax({
				url:"${PATH}/checkEmpName",
				type:"GET",
				data:"empName="+empName,
				success:function(result){
					if(result.code == 100){
						validate_msg("#empName_add_input","success",result.extend.vali_msg);
						//不可用时给保存按钮增加一个 ajax-vali属性 值为success
						$("#emp_save_btn").attr("ajax-vali","success");
					}else{
						validate_msg("#empName_add_input","error",result.extend.vali_msg);
						//不可用时给保存按钮增加一个 ajax-vali属性 值为error
						$("#emp_save_btn").attr("ajax-vali","error");
					}
				}
			});
		});
	   
		$("#emp_save_btn").click(function(){
			//在保存提交数据之前，先使用前端jQuery进行前端校验
			 if(!validate_add_form()){
				return false;
			} 
			//前端校验完以后，提交之前，进行后端校验结果判断:获取到当前按钮对象的 ajax-vali 对象的属性
			if($(this).attr("ajax-vali") == "error"){
				return false;
			}
			//1、将模态框中的信息以ajax请求方法，发送到服务器进行保存
			//$("#empAddModel form").serialize(),
			$.ajax({
				url:"${PATH}/emp",
				type:"POST",
				// jQuery 提供的快捷获取表单信息的方法
				data:$("#empAddModel form").serialize(),  
				success:function(result){
					//alert(result.msg);
					
					//1、判断后端校验后传过来的结果
					if(result.code == 100){
						//1、关闭表单框
						$("#empAddModel").modal("hide");
						//2、来到最后一页来查看插入的数据
						to_page(totalRecord + 1);
					}else{
						//console.log(result);
						//有哪个字段就显示哪个字段的信息
						if("undefined" != result.extend.errorFields.empName){
							validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
						}
						if("undefined" != result.extend.errorFields.email){
							validate_msg("#email_add_input","error",result.extend.errorFields.email);
						}
						
					}
					
				}
			});
		});
		//edit_btn  这个按钮是在click绑定事件之后才生成的，所以直接绑定是无效的
		/* $(".edit_btn").click(function(){
			
		}); */
		//解决方法：使用on()来将 后加载 的数据也进行事件绑定
		$(document).on("click",".edit_btn",function(){
			//alert("1111");
			//1、查出部门信息，并显示员工信息
			getDepts("#empUpdateModel select");
			//2、查出部门员工信息，并显示部门列表
			getEmp($(this).attr("edit_id"));
			//3、把员工id传递给模态框的更新按钮
			$("#emp_update_btn").attr("edit_id",$(this).attr("edit_id"));
			//4、弹出模态框
			$("#empUpdateModel").modal({
				backdrop:"static"
			});
		});
		// 获取员工方法
		function getEmp(id){
			$.ajax({
				url:"${PATH}/emp/"+id,
				type:"GET",
				success:function(result){
					//console.log(result);
					var empData = result.extend.emp;
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModel input[name=gender]").val([empData.gender]);
					$("#empUpdateModel select").val([empData.dId]);
				}
			});
		}
		//点击更新，更新员工信息
		$("#emp_update_btn").click(function(){
			//验证邮箱是否合法
			//获取前端email的值
			var emailVal = $("#email_update_input").val();
			//设置正则
			var emailReg = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
			
			if(!emailReg.test(emailVal)){
				//alert("邮箱格式不正确！");
				validate_msg("#email_update_input","error","邮箱格式不正确！")
				return false;
			}else{
				validate_msg("#email_update_input","success","")
			}
			
			// 发送ajax请求，保存更新的员工信息
			 $.ajax({
				url:"${PATH}/emp/"+$(this).attr("edit_id"),
				type:"PUT",
				data:$("#empUpdateModel form").serialize(),
				success:function(result){
					//alert(result.msg)
					//1、关闭模态框
					$("#empUpdateModel").modal("hide");
					//2、回到修改的那一页
					to_page(currentPage);
				}
			}); 
		});
		// 单个删除 ：：点击删除按钮，绑定事件
		$(document).on("click",".del_btn",function(){
			var empName = $(this).attr("del_name");
			var empId = $(this).attr("del_id");
			//alert($(this).attr("del_name"));
			if(confirm("确认删除【"+empName+"】")){
				//确认，发送ajax请求
				$.ajax({
					url:"${PATH}/emp/"+empId,
					type:"DELETE",
					success:function(result){
						//alert(result.msg);
						// 回到本页码
						to_page(currentPage);
					}
				});
			}
		});
		
		//完成全选，全不选
		$("#check_all").click(function(){
			//attr()获取自定义属性的值，prop能获取dom原生的属性值
			//alert($(this).prop("checked"))
			//将所有的check_item的checked属性全部复制成和check_all一样的
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		//给每个单选框也添加click事件，同样，.check_item也是后加载进页面的，使用on()
		$(document).on("click",".check_item",function(){
			//判断当前已选择的单选框，是否和单选框个数相同
			var flag = $(".check_item:checked").length == $(".check_item").length;
			//当全填满就是 true，没填满就是false
			//所以直接赋值即可
			$("#check_all").prop("checked",flag);
		});
		
		//全局删除按钮绑定事件
		$("#emp_delAll_model_btn").click(function(){
			//遍历所有的.check_item:checked
			var empNames = "";
			var empIdStr = "";
			$.each($(".check_item:checked"),function(){
				
				empNames += " [" +$(this).attr("item_empname")+"] ";
				empIdStr +=  $(this).attr("item_empid") + "-";
				
			});
			//alert(empIdStr)
			//去除最后一个多余的  -
			empIdStr = empIdStr.substring(0, empIdStr.length -1);
			if(confirm("确认删除"+empNames+"吗")){
				//发送ajax请求删除
				$.ajax({
					url:"${PATH}/emp/"+empIdStr,
					type:"DELETE",
					success:function(result){
						//alert(result.msg);
						to_page(currentPage);
					}
					
				});
			}
		});
	</script>
</body>
</html>