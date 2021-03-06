<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<table id="watpro_info" data-options="fit:true"></table>
<div id="product_toolbar" style="width:100%,text-align:left">
	<a href="javascript:addWatProInfoButton()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a>
	<a href="javascript:uptWatProInfoButton()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">修改</a>
	<a href="javascript:rmvWatProInfoButton()" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">删除</a>
	<label style="margin-left:15px;">所属分类</label><select id="watFir_select" onChange="ftos()">
		<option value=-1>全部</option>
	</select>
	<label style="margin-left:15px;">二级分类</label><select id="watSec_select">
		<option value=-1>全部</option>
	</select>
	<label style="margin-left:15px;">品牌</label><select id="watBra_select">
		<option value=-1>全部</option>
	</select>
	<a href="javascript:findProByInfo()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
</div>
<script>
var uptProid;
var datagrid;
$(function(){
	
	var editRow=undefined;
	var op;
	var flag;
	

	var statusObj=[{sid:0,sname:'不可用'},{sid:1,sname:'可用'}];
	
	datagrid=$('#watpro_info').datagrid({
		url:'watProductServlet',
		queryParams:{op:"getPageWatProInfo"},
		fitColumns:true,
		striped:true,
		loadMsg:"数据加载中...",
		pagination:true,
		rownumbers:true,
		sortName:'proid',
		remoteSort:false,
		idField: 'proids',
		columns:[[
		    {field:'proids',title:'商品编号',width:100,align:'center',checkbox:true},
		    {field:'proid',title:'商品编号',width:200,align:'center'},
		    {field:'proname',title:'商品名称',width:200,align:'center',editor:{type:"text",options:{required:true}}},
		    {field:'nature',title:'商品规格',width:200,align:'center',editor:{type:"text",options:{required:true}}},
		    {field:'brandname',title:'品牌',width:200,align:'center',editor:{type:"text",options:{required:true}}},
		    {field:'tname',title:'所属分类',width:200,align:'center',editor:{type:"text",options:{required:true}}},
		    {field:'promarprice',title:'商品市场价',width:200,align:'center',editor:{type:"text",options:{required:true}}},
		    {field:'bqpri',title:'波奇价',width:200,align:'center',editor:{type:"text",options:{required:true}}},
		    {field:'prosales',title:'销量',width:200,align:'center',editor:{type:"text",options:{required:true}}},
		    {field:'inventory',title:'库存',width:200,align:'center',editor:{type:"text",options:{required:true}}},
		    {field:'status',title:'是否上架',width:200,align:'center',editor:{type:"text",options:{required:true}}},
		    {field:'op',title:'操作',width:100,align:'center',
				formatter:function(value,row,index){
					return "<a href='javascript:showProDetail("+row.proid+")'>详细<a/>";
					}
				}
		]],
		toolbar:"#product_toolbar"
	});
	
	$.post("watProductServlet",{op:"getSelectInfo"},function(data){
		//var statusObj=[{sid:0,sname:'不可用'},{sid:1,sname:'可用'}];
		var obj=$("#watPro_brname");
		var obj1=$("#watPro_tpname");
		var obj2=$("#watPro_status");
		var obj3=$("#uptwatPro_brname");
		var obj4=$("#uptwatPro_tpname");
		var obj5=$("#uptwatPro_status");
		var obj6=$("#watFir_select");
		var obj7=$("#watSec_select");
		var obj8=$("#watBra_select");
		
		var opt;
		$.each(data.brand,function(index,item){
			opt="<option value='"+item.brandid+"'>"+item.brandname+"</option>";
			obj.append($(opt));
			obj3.append($(opt));
			obj8.append($(opt));
		});
		$.each(data.type,function(index,item){
			opt="<option value='"+item.tid+"'>"+item.tname+"</option>";
			obj1.append($(opt));
			obj4.append($(opt));
			//obj7.append($(opt));
		});
		$.each(data.fir,function(index,item){
			opt="<option value='"+item.fid+"'>"+item.fname+"</option>";
			obj6.append($(opt));
		});
		for(var i=0;i<2;i++){
			var name;
			if(i==0){
				name="下架";
			}else{
				name="上架";
			}
			opt="<option value='"+i+"'>"+name+"</option>";
			obj2.append($(opt));
			obj5.append($(opt));
		}
		
	},"json");
});	

function ftos(){
	var changefid=$("#watFir_select").val();
	var obj=$("#watSec_select");
	var opt;
	obj.html("");
	if(changefid==-1){
		opt="<option value=-1>全部</option>";
		obj.append($(opt));
	}else{
		$.post("watProductServlet",{op:"changeWatSecInfo",fid:changefid},function(data){
			console.info(data);
			$.each(data.sec,function(index,item){
				opt="<option value='"+item.tid+"'>"+item.tname+"</option>";
				obj.append($(opt));
			});
		},"json");
	}
	
	
}
</script>

<div id="watPro_add" class="easyui-dialog" title="添加狗狗商品"  data-options="fit:true,iconCls:'icon-add',resizeable:true,modal:true,closed:true" style="float:left;">
	<form action="" style="padding:20px;float:left;display:inline-block;">
		<label>商品名称:</label><input type=text name="name"id="watPro_name" class="myinput"><br /> <br /> 
		<label>商品规格:</label><input type=text name="nature"id="watPro_nature" class="myinput"><br /> <br /> 
		<label>品牌名称:</label><select name="brandid" id="watPro_brname"class="myinput"></select><br /> <br />
		<label>所属分类:</label><select name="tid" id="watPro_tpname"class="myinput"></select><br /> <br />
		<label>商品图片:</label><input type=file name="pic" id="watPro_pic" multiple="multiple" onchange="previewMultipleImage(this,'news_pic_show')"><br /> <br /> 
		<label>市场价:</label><input type=text name="marpri"id="watPro_marpri" class="myinput"><br /> <br /> 
		<label>波奇价:</label><input type=text name="bqpri"id="watPro_bqpri" class="myinput"><br /> <br /> 
		<label>商品销量:</label><input type=text name="sales"id="watPro_sales" class="myinput"><br /> <br /> 
		<label style="float:left;">商品介绍:</label><textarea maxlength="25" name="intro" id="watPro_intro" class="myinput" style="width:150px;height:50px;"></textarea><br /> <br /> 
		<label>商品库存:</label><input type=text name="inven"id="watPro_inven" class="myinput"><br /> <br /> 
		<label>商品状态:</label><select name="status" id="watPro_status"class="myinput"></select><br /> <br />  
		
		<a href="javascript:addWatProInfo()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a>
	</form>
	<div style="float:right;width:380px;margin-right:20px;">
		<fieldset id="news_pic_show">
			<legend>图片预览</legend>
		</fieldset>
	</div>
</div>


<div id="watPro_show" class="easyui-dialog" title="查看狗狗商品"  data-options="fit:true,iconCls:'icon-add',resizeable:true,modal:true,closed:true" style="float:left;">
	<form action="" style="padding:20px;float:left;display:inline-block;">
		<label>商品名称:</label><input type=text name="name" id="showwatPro_name" class="myinput" readonly="readonly"><br /> <br /> 
		<label>商品规格:</label><input type=text name="nature" id="showwatPro_nature" class="myinput" readonly="readonly"><br /> <br />
		<label>品牌名称:</label><input type=text name="brandid" id="showwatPro_brandid" class="myinput" readonly="readonly"><br /> <br />
		<label>所属分类:</label><input type=text name="tid" id="showwatPro_tid" class="myinput" readonly="readonly"><br /> <br />
		<label>适用宠物:</label><input type=text name="suitpet" id="showwatPro_suitpet" class="myinput" readonly="readonly"><br /> <br />
		<label>市场价:</label><input type=text name="marpri" id="showwatPro_marpri" class="myinput" readonly="readonly"><br /> <br />
		<label>波奇价:</label><input type=text name="bqpri" id="showwatPro_bqpri" class="myinput" readonly="readonly"><br /> <br /> 
		<label>商品销量:</label><input type=text name="sales" id="showwatPro_sales" class="myinput" readonly="readonly"><br /> <br />
		<label style="float:left;">商品介绍:</label><textarea maxlength="25" name="intro" id="showwatPro_intro" class="myinput" readonly="readonly" style="width:150px;height:50px;"></textarea><br /> <br /> 
		<label>商品库存:</label><input type=text name="inven" id="showwatPro_inven" class="myinput" readonly="readonly"><br /> <br /> 
		<label>商品状态:</label><input type=text name="status" id="showwatPro_status" class="myinput" readonly="readonly"><br /> <br />  
		
	</form>
	<div style="float:right; width:380px; margin-right:20px; margin-top:20px" id="news_pic_show_info">
	</div>
</div>


<div id="watPro_upt" class="easyui-dialog" title="更改狗狗商品"  data-options="fit:true,iconCls:'icon-add',resizeable:true,modal:true,closed:true" style="float:left;">
	<form action="" style="padding:20px;float:left;display:inline-block;">
		<label>商品名称:</label><input type=text name="name"id="uptwatPro_name" class="myinput"><br /> <br /> 
		<label>商品规格:</label><input type=text name="nature"id="uptwatPro_nature" class="myinput"><br /> <br /> 
		<label>品牌名称:</label><select name="brandid" id="uptwatPro_brname"class="myinput"></select><br /> <br />
		<label>所属分类:</label><select name="tid" id="uptwatPro_tpname"class="myinput"></select><br /> <br />
		<label>商品图片:</label><input type=file name="pic" id="uptwatPro_pic" multiple="multiple" onchange="previewMultipleImage(this,'uptpro_pic_show')"><br /> <br /> 
		<label>市场价:</label><input type=text name="marpri"id="uptwatPro_marpri" class="myinput"><br /> <br /> 
		<label>波奇价:</label><input type=text name="bqpri"id="uptwatPro_bqpri" class="myinput"><br /> <br /> 
		<label>商品销量:</label><input type=text name="sales"id="uptwatPro_sales" class="myinput"><br /> <br /> 
		<label style="float:left;">商品介绍:</label><textarea maxlength="25" name="intro" id="uptwatPro_intro" class="myinput" style="width:150px;height:50px;"></textarea><br /> <br /> 
		<label>商品库存:</label><input type=text name="inven"id="uptwatPro_inven" class="myinput"><br /> <br /> 
		<label>商品状态:</label><select name="status" id="uptwatPro_status"class="myinput"></select><br /> <br />  
		
		<a href="javascript:uptWatProInfo()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">修改</a>
	</form>
	<div style="float:right;width:380px;margin-right:20px;">
		<fieldset id="uptpro_pic_show">
			<legend>图片预览</legend>
		</fieldset>
	</div>
</div>
<script>
function findProByInfo(){
	var fid=$("#watFir_select").val();
	var tid=$("#watSec_select").val();
	var brandid=$("#watBra_select").val();
	var type="水族";
	
	$('#watpro_info').datagrid({
		url:'watProductServlet',
		queryParams:{op:"findProByInfo",fid:fid,tid:tid,brandid:brandid,type:type}
	});	
}
function addWatProInfoButton(){
	$("#watPro_add").dialog("open");
}
function addWatProInfo(){
	
	var proname=$("#watPro_name").val();
	var nature=$("#watPro_nature").val();
	var brandid=$("#watPro_brname").val();
	var tid=$("#watPro_tpname").val();
	var promarprice=$("#watPro_marpri").val();
	var bqpri=$("#watPro_bqpri").val();
	var prosales=$("#watPro_sales").val();
	var prointro=$("#watPro_intro").val();
	var inventory=$("#watPro_inven").val();
	var status=$("#watPro_status").val();
	
	$.ajaxFileUpload({
		url:"watProductServlet?op=addWatProInfo",
		secureuri:false,
		fileElementId:"watPro_pic",
		dataType:"json",
		data:{
			proname:proname,
			nature:nature,
			brandid:brandid,
			tid:tid,
			promarprice:promarprice,
			bqpri:bqpri,
			prosales:prosales,
			prointro:prointro,
			inventory:inventory,
			status:status
		},
		success:function(data,status){
			if(parseInt($.trim(data))==1){
				$.messager.show({title:'成功提示',msg:'新闻信息添加成功....',timeout:2000,showType:'slide'});
				$("#watPro_add").dialog("close");
				$("#watpro_info").datagrid("reload");
				
				$("#watPro_name").val("");
				$("#watPro_nature").val("");
				$("#watPro_pic").val("");
				$("#watPro_marpri").val("");
				$("#watPro_bqpri").val("");
				$("#watPro_sales").val("");
				$("#watPro_intro").val("");
				$("#watPro_inven").val("");
				$("#news_pic_show").html("");
				
			}else{
				$.messager.alert("失败提示","商品信息添加失败....","error");
			}
		},
		error:function(data,status,e){
			$.messager.alert("错误提示","商品信息添加有误....\n"+e,"error");
		}
	});
}

function showProDetail(proid){
	$("#watPro_show").dialog("open");
	
	$.post("watProductServlet",{op:"findProByProid",proid:proid},function(data){
		var pro=data.pro;
		var bra=data.bra;
		var sm=data.sm;
		$("#showwatPro_name").val(pro[0].proname);
		$("#showwatPro_nature").val(pro[0].nature);
		$("#showwatPro_brandid").val(bra[0].brandname);
		$("#showwatPro_tid").val(sm[0].tname);
		$("#showwatPro_suitpet").val(pro[0].suitpet);
		$("#showwatPro_marpri").val(pro[0].promarprice);
		$("#showwatPro_bqpri").val(pro[0].bqpri);
		$("#showwatPro_sales").val(pro[0].prosales);
		$("#showwatPro_intro").val(pro[0].prointro);
		$("#showwatPro_inven").val(pro[0].inventory);
		$("#showwatPro_status").val(pro[0].status);
		var str="";
		
		var pics=pro[0].pictrue.split(",");
		for(var i=0;i<pics.length;i++){
			str+="<img src='"+pics[i]+"' width='100px' height='100px'/>"
		}
		$("#news_pic_show_info").html($(str));
	},"json");
}

function uptWatProInfoButton(){
	
	var  rows=datagrid.datagrid("getChecked")[0];
	
	if(rows==undefined){
		$.messager.show({
			title:"温馨提示",
			msg:"请选择您要修改的数据...",
			timeout:2000,
			showType:'slide'
		});
	}else{
		var proid=rows.proid;
		uptProid=proid;
		$("#watPro_upt").dialog("open");
		$.post("watProductServlet",{op:"findProByProid",proid:proid},function(data){
			var pro=data.pro;
			var bra=data.bra;
			var sm=data.sm;
			$("#uptwatPro_name").val(pro[0].proname);
			$("#uptwatPro_nature").val(pro[0].nature);
			$("#uptwatPro_brname option").map(function(){
				var temp=$(this).text();
				if(temp==bra[0].brandname){
					$(this).attr("selected",true);
				}
			});
			$("#uptwatPro_tpname option").map(function(){
				var temp=$(this).text();
				if(temp==sm[0].tname){
					$(this).attr("selected",true);
				}
			});
			$("#uptwatPro_marpri").val(pro[0].promarprice);
			$("#uptwatPro_bqpri").val(pro[0].bqpri);
			$("#uptwatPro_sales").val(pro[0].prosales);
			$("#uptwatPro_intro").val(pro[0].prointro);
			$("#uptwatPro_inven").val(pro[0].inventory);
			$("#uptwatPro_status option").map(function(){
				var temp=$(this).val();
				if(temp==pro[0].status){
					$(this).attr("selected",true);
				}
			});
			var str="";
			
			var pics=pro[0].pictrue.split(",");
			for(var i=0;i<pics.length;i++){
				str+="<img src='"+pics[i]+"' width='100px' height='100px'/>"
			}
			$("#news_pic_show_info").html($(str));
		},"json");
	}	
}
function rmvWatProInfoButton(){
	var rows=datagrid.datagrid("getChecked");
	if(rows.length<=0){   //
		$.messager.show({
			title:"友情提示",
			msg:"请选择要删除的数据...",
			timeout:2000,
			showType:'slide'
		});
	}else{
		$.messager.confirm('信息确认','您确定要删除选中的数据吗？',function(r){
			if(r){
				var proids="";
				for(var i=0;i<rows.length-1;i++){
					proids+=rows[i].proid+",";
				}
				proids+=rows[i].proid;
						
				//将要删除aid发送到服务器
				$.post("watProductServlet",{op:"delProInfo",proids:proids},function(data){
					if(data==1){   //删除成功
						$.messager.show({
							title:"删除提示",
							msg:"新闻信息删除成功...",
							timeout:2000,
							showType:'slide'
						});
						datagrid.datagrid("reload");  //重新加载数据一次
					}else{
						$.messager.alert('失败提示','商品信息删除失败...','error');
					}
				});
			}
		});
	}
			
}


function uptWatProInfo(){
	var proname=$("#uptwatPro_name").val();
	var nature=$("#uptwatPro_nature").val();
	var brandid=$("#uptwatPro_brname").val();
	var tid=$("#uptwatPro_tpname").val();
	var suitpet=$("#uptwatPro_suitpet").val();
	var promarprice=$("#uptwatPro_marpri").val();
	var bqpri=$("#uptwatPro_bqpri").val();
	var prosales=$("#uptwatPro_sales").val();
	var prointro=$("#uptwatPro_intro").val();
	var inventory=$("#uptwatPro_inven").val();
	var status=$("#uptwatPro_status").val();
	
	$.ajaxFileUpload({
		url:"watProductServlet?op=uptWatProInfo",
		secureuri:false,
		fileElementId:"uptwatPro_pic",
		dataType:"json",
		data:{
			proid:uptProid,
			proname:proname,
			nature:nature,
			brandid:brandid,
			tid:tid,
			suitpet:suitpet,
			promarprice:promarprice,
			bqpri:bqpri,
			prosales:prosales,
			prointro:prointro,
			inventory:inventory,
			status:status
		},
		success:function(data,status){
			if(parseInt($.trim(data))==1){
				$.messager.show({title:'成功提示',msg:'商品信息修改成功....',timeout:2000,showType:'slide'});
				$("#watPro_upt").dialog("close");
				$("#watpro_info").datagrid("reload");
				
				$("#uptwatPro_name").val("");
				$("#uptwatPro_nature").val("");
				$("#uptwatPro_pic").val("");
				$("#uptwatPro_marpri").val("");
				$("#uptwatPro_bqpri").val("");
				$("#uptwatPro_sales").val("");
				$("#uptwatPro_intro").val("");
				$("#uptwatPro_inven").val("");
				$("#uptpro_pic_show").html("");
				
			}else{
				$.messager.alert("失败提示","商品信息修改失败....","error");
			}
		},
		error:function(data,status,e){
			$.messager.alert("错误提示","商品信息修改有误....\n"+e,"error");
		}
	});
}



</script>