package com.ourselec.ocloud.domain;
import org.springframework.roo.addon.javabean.RooJavaBean;

import org.springframework.roo.addon.tostring.RooToString;
import javax.validation.constraints.NotNull;

@RooJavaBean
@RooToString
/*@RooJpaActiveRecord*/
public class Timer {

    /**
     */
    @NotNull
    private String message;
}
