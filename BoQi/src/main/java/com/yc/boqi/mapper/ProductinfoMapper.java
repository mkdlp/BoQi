package com.yc.boqi.mapper;

import java.util.List;

import com.yc.boqi.entity.Top8ProductinfoBean;

public interface ProductinfoMapper {
	//��ȡ�̳���ҳ�����������ǰ8����Ʒ
	public List<Top8ProductinfoBean> findTop8OfProductByLei();

}
