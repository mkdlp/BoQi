package com.yc.boqi.action;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ModelDriven;
import com.yc.boqi.entity.JasonObject;
import com.yc.boqi.entity.Pet;
import com.yc.boqi.service.PetService;

@Controller("baikeAction")
public class BaikeAction implements SessionAware,ModelDriven<Pet>{
	
	private JasonObject<Pet> jasonObject;
	private Pet pet;
	
	private Map<String,Object> session;
	@Autowired
	private PetService petService;
	
	
	//ͼƬ�ϴ�   xxx xxxFileName xxxContentType
	private File[] pictrues;//�ϴ��ļ�
	private String[] pictruesFileName;//�ϴ��ļ���
	private String[] pictruesContentType;//�ϴ��ļ�����
	


	public String findDogPet(){
		String page=ServletActionContext.getRequest().getParameter("page");
		String rows=ServletActionContext.getRequest().getParameter("rows");
		jasonObject=new JasonObject<Pet>();
		jasonObject.setRows(petService.findPetByFamily(Integer.valueOf(page),Integer.valueOf(rows),"��"));
		return "DogPet";
	}
	
	public String addDogPet(){
		jasonObject=new JasonObject<Pet>();
		jasonObject.setResult(petService.addPet(pet,pictrues,pictruesFileName,pictruesContentType));
		return "addDog";
	}
	
	public String finDogByid(){
		String petid=ServletActionContext.getRequest().getParameter("petid");
		jasonObject=new JasonObject<Pet>();
		jasonObject.setData(petService.findPetByid(Integer.valueOf(petid)));
		return "IdDog";
		
	}
	
	public String updateDogInfo(){
		jasonObject=new JasonObject<Pet>();
		int result=petService.updatePet(pet,pictrues,pictruesFileName,pictruesContentType);
		System.out.println(result);
		jasonObject.setResult(result);
		return "uptDog";
	}
	public String deleteDogInfo(){
		String petids=ServletActionContext.getRequest().getParameter("petids");
		System.out.println(petids);
		jasonObject=new JasonObject<Pet>();
		jasonObject.setResult(petService.deletePet(petids));
		return "dltDog";
	}

	public JasonObject<Pet> getJasonObject() {
		return jasonObject;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session=session;
	}

	@Override
	public Pet getModel() {
		this.pet=new Pet();
		return pet;
	}
	public File[] getPictrues() {
		return pictrues;
	}

	public void setPictrues(File[] pictrues) {
		this.pictrues = pictrues;
	}

	public String[] getPictruesFileName() {
		return pictruesFileName;
	}

	public void setPictruesFileName(String[] pictruesFileName) {
		this.pictruesFileName = pictruesFileName;
	}

	public String[] getPictruesContentType() {
		return pictruesContentType;
	}

	public void setPictruesContentType(String[] pictruesContentType) {
		this.pictruesContentType = pictruesContentType;
	}
}
