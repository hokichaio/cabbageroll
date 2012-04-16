package jp.co.netmile.cabbageroll.social;

import javax.servlet.http.HttpServletResponse;

import jp.co.netmile.cabbageroll.mapper.UserUtilityMapper;
import jp.co.netmile.cabbageroll.service.FacebookService;
import jp.co.netmile.cabbageroll.util.UserCookieGenerator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.social.connect.Connection;
import org.springframework.social.connect.web.SignInAdapter;
import org.springframework.web.context.request.NativeWebRequest;


public final class SignIn implements SignInAdapter {

private final UserCookieGenerator userCookieGenerator = new UserCookieGenerator();
	
	@Autowired
	private UserUtilityMapper userUtilityMapper;
	
	public String signIn(String userId, Connection<?> connection, NativeWebRequest request) {
		String pId = userUtilityMapper.getUserFacebookIdByUserId(userId);
		SecurityContext.setCurrentUser(new User(userId, pId));
		userCookieGenerator.addCookie(userCookieGenerator.USER_ID, userId, request.getNativeResponse(HttpServletResponse.class));
		userCookieGenerator.addCookie(userCookieGenerator.PROVIDER_ID, pId, request.getNativeResponse(HttpServletResponse.class));
		String rd = (String)request.getAttribute("rd", NativeWebRequest.SCOPE_SESSION);
		if(rd != null) {
			request.setAttribute("rd", null, NativeWebRequest.SCOPE_SESSION);
			return rd;
		}
		return "/";
	}
	

}