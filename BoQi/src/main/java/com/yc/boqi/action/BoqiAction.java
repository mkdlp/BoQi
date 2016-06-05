
package com.yc.boqi.action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.yc.boqi.entity.Address;
import com.yc.boqi.entity.IndexProductBean;
import com.yc.boqi.entity.UserInfo;
import com.yc.boqi.service.AddressService;
import com.yc.boqi.service.ProductinfoService;
import com.yc.boqi.util.AllSessions;

@Controller
public class BoqiAction implements ServletRequestAware,SessionAware{
	@Autowired
	private AddressService addressService;
	@Autowired
	private ProductinfoService productinfoService;
	private List<Address> adds;
	private HttpServletRequest request;
	private Map<String, Object> session;
	//��ҳ����ת
	public String index(){
		List<IndexProductBean> indexProductBeans = productinfoService.findIndexDogPro();
		if (indexProductBeans != null) {
			session.put("indexProductBeans", indexProductBeans);
			System.out.println("��ѯ���˹�����Ϣ��������" + indexProductBeans);
			index2();
			index3();
			return "index";
		}
		System.out.println("��ѯʧ�ܣ�");
		index2();
		return "failure";
	}
	public String index2(){
		List<IndexProductBean> indexProductBeans2 = productinfoService.findIndexCatPro();
		if (indexProductBeans2 != null) {
			session.put("indexProductBeans2", indexProductBeans2);
			System.out.println("��ѯ����è����Ϣ��������" + indexProductBeans2);
			return "index";
		}
		System.out.println("��ѯʧ�ܣ�");
		return "failure";
	}
	
	public String index3(){
		List<IndexProductBean> indexProductBeans3 = productinfoService.findIndexsmallPro();
		if (indexProductBeans3 != null) {
			session.put("indexProductBeans3", indexProductBeans3);
			System.out.println("��ѯ����С�����Ϣ��������" + indexProductBeans3);
			return "index";
		}
		System.out.println("��ѯʧ�ܣ�");
		return "failure";
		
	}
	//��ת�������̳�ҳ��
	public String shoppingindex(){
		return "shoppingindex";
	}
	//��ת�������ﳵ
	public String shopcar(){
		return "shopcar";
	}
	
	public String paymoney(){
		//��ȡ��ַ��Ϣ
		UserInfo user = (UserInfo) request.getSession().getAttribute(AllSessions.LOGIN_USER);
		System.out.println("�û�Id:"+user.getUsid());
		adds = addressService.findByUsid(user.getUsid());
		request.getSession().setAttribute(AllSessions.ADDRESSBYUSID, adds);
		return "paymoney";
	}
	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
	}
	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}
}