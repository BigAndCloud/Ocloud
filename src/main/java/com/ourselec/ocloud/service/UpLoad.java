package com.ourselec.ocloud.service;

import java.io.File;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;



import com.ourselec.ocloud.domain.DeviceModel;

public class UpLoad extends HttpServlet {

/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

@SuppressWarnings("unchecked")
@Override
protected void service(HttpServletRequest req, HttpServletResponse resp)
                                            throws ServletException, IOException {
			req.setCharacterEncoding("utf-8");
			resp.setContentType("text/html;charset=utf-8");
			//为解析类提供配置信息
			DiskFileItemFactory factory = new DiskFileItemFactory();
			//创建解析类的实例
			ServletFileUpload sfu = new ServletFileUpload(factory);
			//开始解析
			sfu.setFileSizeMax(1024*400);
			//每个表单域中数据会封装到一个对应的FileItem对象上
//			String  company_name= req.getParameter("company_name").toString();
//			System.out.println("company_name==="+company_name);
			
			Map<String, Object> map = new LinkedHashMap<String, Object>();
		try {  
			List<FileItem> items = sfu.parseRequest(req);
			
			//区分表单域
			
			for (int i = 0; i < items.size(); i++) {
				FileItem item = items.get(i);
				//isFormField为true，表示这不是文件上传表单域
				
					if(item.isFormField()){
						
						String name = item.getString("UTF-8");
						String fileName = item.getFieldName();
						map.put(fileName, name);
					}else{
				//	ServletContext sctx = getServletContext();
					//获得存放文件的物理路径
					//upload下的某个文件夹 得到当前在线的用户 找到对应的文件夹
					
				//	String path = sctx.getRealPath("D:/workspace-sts-3.6.3.RELEASE/upload");
					String path="D:/workspace-sts-3.6.3.RELEASE/upload/";
					//获得文件名
					String fileName = item.getName();
					String name = item.getFieldName();
					
					
					
					//该方法在某些平台(操作系统),会返回路径+文件名
					fileName = fileName.substring(fileName.lastIndexOf("/")+1);
					map.put(name, path+fileName);
					File file = new File(path+"\\"+fileName);
					
				if(!file.exists()){
					item.write(file);
				//将上传图片的名字记录到数据库中
				//	boolean fale = DeviceModel.addModel(developer_id,vendor_id,model_name,model_id,null,text_encoding_id,binary_encoding_id,picture,comment);
					}
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			}
		DeviceModel model = new DeviceModel();
		model.addModel(map);
		
		resp.sendRedirect(req.getContextPath()+"/deviceModel/addModelsuccess");
	}
	
	
	
}
