package com.yc.boqi.mapper;

import java.util.List;
import java.util.Map;

import com.yc.boqi.entity.IndexProductBean;
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
	/**
	 * ��ѯһ����Ʒ��������Ϣ
	 * @param orderid����Ʒid
	 * @return
	 */
	public Productinfo findAproduct(int proid);
	// index.jspҳ����Ʒ�Ĺ����ֲ�ѯ��Ϣ
	List<IndexProductBean> findIndexDogPro();

	// index.jspҳ����Ʒ��è���ֲ�ѯ��Ϣ
	List<IndexProductBean> findIndexCatPro();

	// index.jspҳ����Ʒ��С�貿�ֲ�ѯ��Ϣ
	List<IndexProductBean> findIndexsmallPro();
	//�Ѷ���״̬��ΪʧЧ
	public void updateGoodsNum(Map<String, Object> so);
	//��ȡ��Ʒ������
	public List<Productinfo> findNatureByName(String[] names);
	//������Ʒ������Ʒ���Բ�ѯ��Ʒ
	public List<Productinfo> findPriceByNaNa(Map<String, Object> so);
}
