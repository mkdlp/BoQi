
package com.yc.boqi.action;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.springframework.stereotype.Controller;

@Controller
public class BoqiAction{
	//��ҳ����ת
	public String index(){
		return "index";
	}
	//��ת�������̳�ҳ��
	public String shoppingindex(){
		
		return "shoppingindex";
	}
	
}