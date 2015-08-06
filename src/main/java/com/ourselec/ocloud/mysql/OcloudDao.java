package com.ourselec.ocloud.mysql;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.JdbcTemplate;

import com.ourselec.ocloud.util.GridData;
import com.ourselec.ocloud.util.GridJson;

public class OcloudDao {

	private	JdbcTemplate jdbcTemplate;

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}
	/**
	 * 权限：admin
	 * 查询所有申请厂商的用户
	 * @param where
	 * @return
	 */
	
	public List<Map<String, Object>> findByAudit_status(String where
			) {
		String sql = "select o.*,u.user_name from Vendor_info o inner join usr u on o.user_id= u.user_id   " + where
				;
		List<Map<String, Object>> l = jdbcTemplate.queryForList(sql);
		return l;
	}
	
	public Map<String, Object> findSucModel_id(String model_id){
		String sql ="SELECT DISTINCT o.`name`,o.alias,o.lng,o.lat,o.`comment` ,o.model_id FROM device o WHERE o.model_id= "+"'"+model_id+"'";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql);
		
		if (list.size()==0) {
			return null;
		}
		
		return list.get(0);
	}
	public Integer countDeviceByModel_idAll(String model_id){
		String sql ="SELECT count(*) FROM device o WHERE o.model_id= "+"'"+model_id+"'";
		Integer num = jdbcTemplate.queryForInt(sql);
		
		return num;
	}
	public Integer countDeviceByModel_id(String model_id,Integer range_id){
		List<Object> params = new ArrayList<Object>();
		params.add(model_id);
		params.add(range_id);
		String sql ="SELECT count(*) FROM device o WHERE o.model_id=? and o.range_id= ?";
		Integer num = jdbcTemplate.queryForInt(sql,params.toArray());
		
		return num;
	}

	public void findByMidRid(String where, List<Object> params,
			GridData<Map<String, Object>> data, String order) {
			String sql ="SELECT * FROM device o "+where +order;
			System.out.println(params.toArray());
			String countsql="select count(*) from device o "+where;
			int total = jdbcTemplate.queryForInt(countsql,params.toArray());
			params.add(data.getpageSize() * data.getpageNumber());
			params.add(data.getpageSize());
			List<Map<String, Object>> list = jdbcTemplate.queryForList(sql,params.toArray());
			data.settotal(total);
			data.setRows(list);
	}
	
	public void findByMidRidTest(String where, List<Object> params,
			GridJson<String> data, String order) {
			String sql ="SELECT * FROM device o "+where +order;
			String countsql="select count(*) from device o "+where;
			int total = jdbcTemplate.queryForInt(countsql,params.toArray());
			
			List<Map<String, Object>> list = jdbcTemplate.queryForList(sql,params.toArray());
			data.setRows(list.toString());
			data.setTotal(total);
	}
	
	/**
	 * 获取 设备原型
	 */
	public List<Map<String, Object>>findDevicePrototype(String user_id){
		//SELECT * FROM device d  INNER JOIN device_model m on d.device_id = m.source_id  WHERE d.user_id='25147830'
			String where="WHERE d.user_id="+user_id;
		String orderby = " ORDER BY d.created_at desc";
		String sql = "SELECT * FROM device d  INNER JOIN device_model m on d.device_id = m.source_id   ";
		
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql+where+orderby);
		if (list.size()==0) {
			return null;
		}
		
		return list;
	}
	
	
}
