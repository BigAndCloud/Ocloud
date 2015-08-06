package com.ourselec.ocloud.service;

import java.util.List;

import com.ourselec.ocloud.controller.dto.DeviceDTO;
import com.ourselec.ocloud.controller.dto.ModelDTO;
import com.ourselec.ocloud.controller.dto.PropertyDTO;
import com.ourselec.ocloud.domain.Device;
import com.ourselec.ocloud.domain.DeviceModel;
import com.ourselec.ocloud.domain.DeviceProperty;
import com.ourselec.ocloud.domain.PropertyChannel;
import com.ourselec.ocloud.domain.Vendor;
import com.ourselec.ocloud.util.BaiDuUtil;

public class AssembleDTO {

	
public static DeviceDTO assembleDeviceDTO(Device device){
		
		DeviceDTO dto = new DeviceDTO();
		try {
			dto = new DeviceDTO();
			dto.setId(device.getId());
			dto.setName(device.getName());
			dto.setAlias(device.getAlias());
			dto.setAlive_time(device.getAlive_time());
			dto.setTimezone(device.getTimezone());
			dto.setIs_activated(device.getIs_activated());
			dto.setComment(device.getComment());
			dto.setDevice_id(device.getDevice_id());
			dto.setModel_id(device.getModel_id());
			String site= BaiDuUtil.getCity(device.getLat().toString(),device.getLng().toString());

			List<DeviceProperty> propertys =DeviceProperty.findListByModel_id(device.getModel_id());
			Integer pros = 0; 
			if (propertys!=null) {
				pros=1;
				
			}
			System.out.println(pros);
			dto.setPros(pros);
			dto.setSite(site);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return dto;
	}
	



		public static ModelDTO assembleModelDTO(DeviceModel model,Device device) {

			ModelDTO dto = new ModelDTO();
			dto.setId(model.getId());
			dto.setAudit_status(model.getAudit_status());
			dto.setComment(model.getComment());
			dto.setCreated_at(model.getCreated_at());
			dto.setIs_enabled(model.getIs_enabled());
			dto.setModel_id(model.getModel_id());
			dto.setModel_name(model.getModel_name());
			dto.setText_encoding_id(model.getText_encoding_id());
			dto.setBinary_encoding_id(model.getBinary_encoding_id());
			DeviceDTO devicedto = AssembleDTO.assembleDeviceDTO(device);
			dto.setDevice(devicedto);
			dto.setProperty(DeviceProperty.findListByModel_id(model.getModel_id()));
			Vendor vendor = Vendor.findVendor(model.getVendor_id());
			dto.setVendor(vendor);
			return dto;
		}
		
		
		public static PropertyDTO assemblePropertyDTO(DeviceProperty property){
			PropertyDTO dto = new PropertyDTO();
			dto.setId(property.getId());
			dto.setAlias(property.getAlias());
			dto.setName(property.getName());
			dto.setDevice_model_id(property.getDevice_model_id());
			List<PropertyChannel> channels = PropertyChannel.findListByPropertyid(property.getId());
			Integer chans = 0;
			if (channels!=null) {
				chans=1;
			}
			dto.setChans(chans);
			dto.setChannellist(channels);
			dto.setCreated_at(property.getCreated_at());
			return dto;
		}
}
