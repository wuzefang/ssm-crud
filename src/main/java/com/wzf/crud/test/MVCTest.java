package com.wzf.crud.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;
import com.wzf.crud.bean.Employee;

/**
 * 使用Spring测试模块，模拟web请求功能，测试crud的正确性
 * 
 * @author wuzf
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = { "classpath:applicationContext.xml","classpath:springmvc.xml"})
public class MVCTest {
	//虚拟mvc请求，获取到结果
	MockMvc mockMvc;
	//传入Springmvc的ioc
	@Autowired
	WebApplicationContext context;
	
	@Before
	public void initMockMvc(){
		mockMvc= MockMvcBuilders.webAppContextSetup(context).build();
	}
	@Test
	public void testPage() throws Exception{
		// 模拟请求，并获取返回值
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pageNum", "25")).andReturn();
		//请求成功后，请求域中会有pageInfo,取出pageInfo进行验证
		MockHttpServletRequest request = result.getRequest();
		PageInfo page = (PageInfo) request.getAttribute("pageInfo");
		System.out.println("当前页码：" + page.getPageNum());
		System.out.println("总页码:"+page.getPages());
		System.out.println("总记录数："+ page.getTotal());
		int[] nums = page.getNavigatepageNums();
		for (int i : nums){
			System.out.println("   "+ i );
		}
		List<Employee> list = page.getList();
		for (Employee e : list){
			System.out.println("ID:"+e.getEmpId() + "====>Name" +e.getEmpName());
		}
	}
}
