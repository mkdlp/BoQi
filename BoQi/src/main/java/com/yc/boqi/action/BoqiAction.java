
package com.yc.boqi.action;

import org.springframework.stereotype.Controller;

@Controller
public class BoqiAction {
	//��ҳ����ת
	public String index(){
		return "index";
	}
	//��ת�������̳�ҳ��
	public String shoppingindex(){
		//����ת֮ǰ���Ȱ�Ҫ��ȡ�����ݴ浽session��
		
		return "shoppingindex";
	}
	
}