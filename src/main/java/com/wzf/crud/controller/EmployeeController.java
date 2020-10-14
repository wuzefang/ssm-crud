package com.wzf.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wzf.crud.bean.Employee;
import com.wzf.crud.bean.Msg;
import com.wzf.crud.service.EmploeeSrvice;

/**
 * 处理员工的CRUD请求
 * 
 * @author wuzf
 *
 */
@Controller
public class EmployeeController {
	@Autowired
	EmploeeSrvice emplyoyeeService;
	
	/**
	 * 单个，批量 二合一
	 * 批量删除  1-2-3
	 * 单个删除 1
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	public Msg deletEmp(@PathVariable("ids")String ids){
		if(ids.contains("-")){
			List<Integer> del_ids = new ArrayList<>();
			//1、先进行切割
			String[] str_ids = ids.split("-");
			for (String str : str_ids) {
				del_ids.add(Integer.parseInt(str));
			}
			emplyoyeeService.deleBatch(del_ids);
		}else{
			//如果只有一个参数直接转换成int类型，进行删除
			int id = Integer.parseInt(ids);
			emplyoyeeService.deleEmpById(id);
		}
		
		return  Msg.success();
	}
	/**
	 * 保存更新的员工信息
	 * @param employee
	 * @return
	 */
	@RequestMapping(value="/emp/{empId}" ,method =RequestMethod.PUT)
	@ResponseBody
	public Msg saveEmp(Employee employee){
		emplyoyeeService.updateEmp(employee);
		return  Msg.success();
	}
	
	/**
	 * 根据员工的id 获取指定的员工，并返回给前端页面
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/emp/{id}" ,method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id){
		Employee employee = emplyoyeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	
	/**
	 * 查询前端传过来的员工名是否可用
	 * @param empName
	 * @return
	 */
	@RequestMapping("/checkEmpName")
	@ResponseBody
	public Msg checkEmpName(@RequestParam("empName") String empName){
		String regx = "^([\u4e00-\u9fa5]{2,4})|([A-Za-z0-9_]{4,16})|([a-zA-Z0-9_\u4e00-\u9fa5]{3,16})$";
		boolean matches = empName.matches(regx);
		if(!matches){
			return Msg.fail().add("vali_msg", "用户名格式异常，清输入4-16位字母,数字,汉字,下划线！");
		}
		//当正则验证失败时才会查数据库
		Boolean b = emplyoyeeService.checkEmpName(empName);
		if(b){
			return Msg.success().add("vali_msg", "用户名可用！");
		}else{
			return Msg.fail().add("vali_msg", "用户名已存在！");
		}
	}

	/**
	 * 新增员工，在新增时，进行后端JSR303校验
	 * @param employee
	 * @return
	 */
	@RequestMapping(value = "/emp", method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp( @Valid Employee employee,BindingResult result) {
		Map<String,Object> map = new HashMap<>();
		if (result.hasErrors()){
			//校验失败，返回失败，在模态框中显示校验失败的错误信息
			List<FieldError> fieldErrors = result.getFieldErrors();
			for(FieldError fieldError :fieldErrors){
				System.out.println("错误字段名："+fieldError.getField());
				System.out.println("错误信息："+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else{
			emplyoyeeService.saveEmp(employee);
			return Msg.success();
		}
		
	}

	/**
	 * 查询员工数据（分页查询） 此时的查询结果 只能给B端浏览器使用，过多依赖平台
	 * 
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody // 直接将数据以json字符串的形式返回给页面
	public Msg getEmpsWithJson(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum) {
		// 3、使用PageHelper进行分页查询
		PageHelper.startPage(pageNum, 5); // 本句代码紧跟的查询就是一个分页查询
		// 1、此时查询的结果是全部的结果集，没分页
		List<Employee> emps = emplyoyeeService.getAll(); // 此时的查询就是一个分页查询
		// 4、将查询的结果，封装到PageInfo中，然后将pageInfo返回给前端 页面
		PageInfo pageInfo = new PageInfo(emps, 5); // 此时的 5 表示为 每次分5页

		// return pageInfo; // 此时直接返回PageInfo不包含页面的响应状态码和状态信息等
		return Msg.success().add("pageInfo", pageInfo);
	}

	/**
	 * 查询员工数据（分页查询） 此时的查询结果 只能给B端浏览器使用，过多依赖平台
	 * 
	 * @return
	 */
	// @RequestMapping("/emps")
	// 2、获取请求参数的页码，不传参数时，默认为 1
	public String getEmps(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum, Model model) {
		// 3、使用PageHelper进行分页查询
		PageHelper.startPage(pageNum, 5); // 本句代码紧跟的查询就是一个分页查询
		// 1、此时查询的结果是全部的结果集，没分页
		List<Employee> emps = emplyoyeeService.getAll(); // 此时的查询就是一个分页查询
		// 4、将查询的结果，封装到PageInfo中，然后将pageInfo返回给前端 页面
		PageInfo pageInfo = new PageInfo(emps, 5); // 此时的 5 表示为 每次分5页
		// 5、返回pageInfo给请求域中
		model.addAttribute("pageInfo", pageInfo);

		return "list";
	}
}
