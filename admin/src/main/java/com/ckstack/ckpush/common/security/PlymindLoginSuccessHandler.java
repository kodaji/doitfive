package com.ckstack.ckpush.common.security;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.web.util.UrlPathHelper;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Created by kodaji on 2016. 1. 22..
 */
public class PlymindLoginSuccessHandler implements AuthenticationSuccessHandler {
    private final static Logger LOG = LoggerFactory.getLogger(PlymindLoginSuccessHandler.class);

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
        CkUserDetails userDetails = (CkUserDetails) authentication.getPrincipal();

        UrlPathHelper urlPathHelper = new UrlPathHelper();
        String redirectPage = urlPathHelper.getContextPath(request) + "/user/myadvice/progress_list";
        //String redirectHash = WebUtils.findParameterValue(request, "redirecthash");

        //if(redirectHash != null && !StringUtils.trim(redirectHash).equals("")) redirectPage += "#"+redirectHash;

        //사용자 페이지에 상담사 아이디로 로그인 시 관리자페이지로 이동 처리  - by kas0610
        List<GrantedAuthority> authorities = (List<GrantedAuthority>) userDetails.getAuthorities();
        for(GrantedAuthority grantedAuthority : authorities){
            if(grantedAuthority.getAuthority().equals("ROLE_ADVISOR")) {
                redirectPage = urlPathHelper.getContextPath(request) + "/admin";
            }
        }

        LOG.info("success login. user_id["+userDetails.getUser_id()+"], member_srl["+
                userDetails.getMember_srl()+"] redirect to page["+redirectPage+"]");

        response.sendRedirect(redirectPage);

    }
}
