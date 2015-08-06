package com.ourselec.ocloud.domain.power;

import javax.persistence.Column;

import org.springframework.roo.addon.jpa.identifier.RooIdentifier;
import org.springframework.roo.addon.json.RooJson;
@RooIdentifier
@RooJson
public class TresourceRolesCompositePK {
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5530866967681233566L;

	@Column(name = "RESID")
	private Integer resId;
	
	@Column(name = "ROLEID")
	private Integer roleId;
}