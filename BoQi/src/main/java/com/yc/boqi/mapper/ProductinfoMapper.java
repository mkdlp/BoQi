package com.yc.boqi.mapper;

import java.util.List;
import java.util.Map;

import com.yc.boqi.entity.Productinfo;
import com.yc.boqi.entity.Top8ProductinfoBean;

public interface ProductinfoMapper {
	//��ȡ�̳���ҳ�����������ǰ8����Ʒ
	public List<Top8ProductinfoBean> findTop8OfProductByLei();
	//��ȡ������Ʒ��̨��ʾ�б�
	public List<Productinfo> findTypePro(Map<String, Object> type);
	//��ȡһ��������Ʒ������
	public int ProTotal(String type);
	/**
	 * �����Ʒ
	 * @param productinfo����Ʒ��
	 * @return
	 */
	public boolean addProduct(Productinfo productinfo);
	public List<Productinfo> searchPro(Map<String,Object> map);
	
}
