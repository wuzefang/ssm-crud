package com.wzf.crud.bean;

import java.util.HashMap;
import java.util.Map;

public class Msg {

	//请求返回状态码 100-正常，200-异常
	private int code;
	//请求响应状态信息
	private String msg;
	//请求返回给浏览器的数据
	private Map<String,Object> extend = new HashMap<>();
	
	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Map<String, Object> getExtend() {
		return extend;
	}

	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}

	public static Msg success(){
		Msg result = new Msg();
		result.setCode(100);
		result.setMsg("请求成功！");
		return result;
	}
	
	public static Msg fail(){
		Msg result = new Msg();
		result.setCode(200);
		result.setMsg("请求异常！");
		return result;
	}
	
	public	Msg add(String key ,Object value){
		this.getExtend().put(key, value);
		return this;
	}
}
