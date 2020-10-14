package com.wzf.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wzf.crud.bean.Employee;
import com.wzf.crud.bean.EmployeeExample;
import com.wzf.crud.bean.EmployeeExample.Criteria;
import com.wzf.crud.dao.EmployeeMapper;

@Service
public class EmploeeSrvice {

	@Autowired
	EmployeeMapper employeeMapper;

	/**
	 * 
	 * 查询所有员工
	 * @return 返回所有员工的list集合
	 */
	public List<Employee> getAll() {
		
		List<Employee> selectByExampleWithDept = employeeMapper.selectByExampleWithDept(null);
		
		return selectByExampleWithDept;
	}

	/**
	 * 员工保存方法
	 * @param employee
	 */
	public void saveEmp(Employee employee) {	
		employeeMapper.insertSelective(employee);
	}

	/**
	 * 检验员工名是否可用
	 * countByExample =  0--->可用
	 * 反之不可用
	 * @param empName
	 * @return
	 */
	public Boolean checkEmpName(String empName) {
		EmployeeExample example = new EmployeeExample();
		Criteria createCriteria = example.createCriteria();
		createCriteria.andEmpNameEqualTo(empName);
		long countByExample = employeeMapper.countByExample(example );
		return countByExample == 0;
	}
	/**
	 * 根据id获取到员工的信息
	 * @param id
	 * @return
	 */
	public Employee getEmp(Integer id) {
		Employee employee = employeeMapper.selectByPrimaryKey(id);
		return employee;
	}
	/**
	 * 员工更新方法
	 * @param employee
	 */
	public void updateEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}
	
	/**
	 * 单个员工删除
	 * @param id
	 */
	public void deleEmpById(Integer id) {
		employeeMapper.deleteByPrimaryKey(id);
	}
	/**
	 * 批量员工删除
	 * @param del_ids
	 */
	public void deleBatch(List<Integer> del_ids) {
		//拼装条件
		EmployeeExample example = new EmployeeExample();
		Criteria createCriteria = example.createCriteria();
		Criteria andEmpIdIn = createCriteria.andEmpIdIn(del_ids);
		//调用批量删除
		employeeMapper.deleteByExample(example);
	}

}
