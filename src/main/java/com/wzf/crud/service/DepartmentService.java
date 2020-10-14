package com.wzf.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wzf.crud.bean.Department;
import com.wzf.crud.dao.DepartmentMapper;
@Service
public class DepartmentService {
	@Autowired
	DepartmentMapper departmentMapper;
	
	public List<Department> getDepts() {
		List<Department> selectByExample = departmentMapper.selectByExample(null);
		return selectByExample;
	}

}
