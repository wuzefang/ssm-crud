package com.wzf.crud.bean;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Email;

public class Employee {
	private Integer empId;

	@Pattern(regexp="^([\\u4e00-\\u9fa5]{2,4})|([A-Za-z0-9_]{4,16})|([a-zA-Z0-9_\\u4e00-\\u9fa5]{3,16})$",
			message="用户名格式异常，清输入4-16位字母,数字,汉字,下划线！")
	private String empName;

	private String gender;
	@Email(message="邮箱格式不正确！")
	private String email;

	private Integer dId;

	private Department dept;

	public Employee() {
		super();
	}

	public Employee(Integer empId, String empName, String gender, String email, Integer dId) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.gender = gender;
		this.email = email;
		this.dId = dId;
	}

	@Override
	public String toString() {
		return "Employee [empId=" + empId + ", empName=" + empName + ", gender=" + gender + ", email=" + email
				+ ", dId=" + dId + ", dept=" + dept + "]";
	}

	public Department getDept() {
		return dept;
	}

	public void setDept(Department dept) {
		this.dept = dept;
	}

	public Integer getEmpId() {
		return empId;
	}

	public void setEmpId(Integer empId) {
		this.empId = empId;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName == null ? null : empName.trim();
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender == null ? null : gender.trim();
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email == null ? null : email.trim();
	}

	public Integer getdId() {
		return dId;
	}

	public void setdId(Integer dId) {
		this.dId = dId;
	}
}