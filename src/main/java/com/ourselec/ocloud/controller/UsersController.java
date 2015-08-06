package com.ourselec.ocloud.controller;





import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ourselec.ocloud.domain.Users;
import com.ourselec.ocloud.util.StringUtil;


@RequestMapping("/users")
@Controller
public class UsersController {
	
	Logger logger = Logger.getLogger(Users.class);
	
	@RequestMapping("/register")
	
	public ModelAndView addJsp(ModelAndView view){
		view.setViewName("/users/register");
		return view;
	}
	
	@RequestMapping("/addUser")
	public ModelAndView addUser(ModelAndView view
			,@RequestParam(value="username",required= false)String username
			,@RequestParam(value="passwd",required= false)String passwd
			){
		logger.info("/users/addUser");
		String errormsg = "suesses";
			
			if (StringUtil.isEmpty(username)||StringUtil.isEmpty(passwd)) {
				errormsg= "用户名OR密码不能为空";
				view.addObject("errormsg", errormsg);
				view.setViewName("users/register");
			}
			if (Users.findByusername(username)!=null) {
				errormsg = "这个邮箱已经被使用";
				view.addObject("errormsg", errormsg);
				view.setViewName("/users/register");
			}
			boolean 	 fale =  Users.AddUsers(username, passwd);
			 if (!fale) {
				errormsg = "添加失败";
				view.addObject("errormsg", errormsg);
				view.setViewName("users/register");
				return view;
			}
			
		logger.info("users/addUser");
		view.addObject("username", username);
		view.addObject("password", passwd);
		view.addObject("errormsg", errormsg);
		view.setViewName("users/regSuccess");
		return view;
		
		
	}
	
	public ModelAndView searchUsers(ModelAndView view){
		/**
		 * StringBuilder builder = new StringBuilder(" where");
			List<Object> params = new ArrayList<Object>();
			builder.append(" 1=1 and");
			try {
			
			if (!StringUtil.isEmpty(username)) {
				builder.append(" o.username = ? and");
				params.add(username);
				view.addObject("username", username);
			}
			if (!StringUtil.isEmpty(passwd)) {
				String salt = UUID.randomUUID().toString();
				params.add(salt);
				builder.append(" o.salt = ? and");
				String endpasswd= PaySign.EncoderByMd5(passwd, salt);
				builder.append(" o.passwd = ? and");
				params.add(endpasswd);
			}
			builder.append("o.createdAt = ? and");
			params.add(new Date());
			
			builder.append("o.userid = ? and");
			params.add(RandomNumberGenerator.generateNumber2());
			
			
			
			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}catch (Exception e) {
				e.printStackTrace();
			}
			if (builder.toString().endsWith("and")) {
				builder.delete(builder.length() - 3, builder.length());
			}
			if (builder.toString().endsWith("where")) {
				builder.delete(builder.length() - 5, builder.length());
			}
		 */
		
		return view;
	}
}
