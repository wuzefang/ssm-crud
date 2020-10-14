package com.wzf.crud.test;

import java.util.List;
import java.util.UUID;

import javax.activation.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import com.wzf.crud.bean.Department;
import com.wzf.crud.bean.Employee;
import com.wzf.crud.bean.EmployeeExample;
import com.wzf.crud.dao.DepartmentMapper;
import com.wzf.crud.dao.EmployeeMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:applicationContext.xml" })
public class CRUDTest {

	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	ComboPooledDataSource dataSource;
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	SqlSession sqlSession;
	@Test
	public void crudTest() {
		System.out.println(departmentMapper);
		System.out.println(dataSource);
		// Department selectByPrimaryKey =
		// departmentMapper.selectByPrimaryKey(1);
		// System.out.println(selectByPrimaryKey);
		// departmentMapper.insertSelective(new Department(null, "测试部"));
		// departmentMapper.insertSelective(new Department(null, "实施部"));

//		employeeMapper.insertSelective(new Employee(null, "吴泽方", "M", "zfwu@iflytek.com", 1));
		
		//批量插入员工
//		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
//		for (int i = 0; i < 1000; i++) {
//			String uid = UUID.randomUUID().toString().substring(0, 5) + i;
//			mapper.insertSelective(new Employee(null, uid, "M", uid+"@qq.com", 1));
//		}
		//测试  ，EmployeMapper中 带部门的方法
		/**
		 *     List<Employee> selectByExampleWithDept(EmployeeExample example);
    		Employee selectByPrimaryKeyWithDept(Integer empId);
		 */
		List<Employee> selectByExampleWithDept = employeeMapper.selectByExampleWithDept(new EmployeeExample());
//		List<Employee> selectByExample = employeeMapper.selectByExample(new EmployeeExample());
		System.out.println(selectByExampleWithDept);
		
		Employee selectByPrimaryKeyWithDept = employeeMapper.selectByPrimaryKeyWithDept(100);
		System.out.println(selectByPrimaryKeyWithDept);
	}
}
