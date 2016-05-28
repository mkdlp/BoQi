package com.yc.boqi.service;

import java.util.List;
import java.util.Map;

import com.yc.boqi.entity.UserInfo;

public interface UserService {
	//��ҳ��ѯ�û�
	List<UserInfo> getPageUsers(Map<String,Object> map);
	//��ȡ�û�����
	int getUserTotal();
	//����yonghuid��ȡ�û���Ϣ
	UserInfo getUserByUsid(int usid);
	//ɸѡ��ѯ
	List<UserInfo> findUserByInfo(Map<String,Object> map);
}
