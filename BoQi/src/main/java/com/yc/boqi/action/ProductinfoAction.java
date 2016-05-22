package com.yc.boqi.action;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.yc.boqi.entity.Top8ProductinfoBean;
import com.yc.boqi.mapper.ProductinfoMapper;
@Controller
public class ProductinfoAction {
	@Autowired
	private ProductinfoMapper productinfoMapper;
	private List<Top8ProductinfoBean> productinfos;

	public List<Top8ProductinfoBean> getProductinfos() {
		return productinfos;
	}

	//��ȡÿ�����͵�ǰ8����Ʒ
	public String GetTop8(){
		System.out.println("������");
		productinfos = productinfoMapper.findTop8OfProductByLei();
		System.out.println("���ݣ�"+productinfos);
		return "GetTop8";
	}
}