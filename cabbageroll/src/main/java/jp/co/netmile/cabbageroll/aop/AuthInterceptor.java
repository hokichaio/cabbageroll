package jp.co.netmile.cabbageroll.aop;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.connect.UsersConnectionRepository;
import org.springframework.social.facebook.api.Facebook;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.view.RedirectView;

import jp.co.netmile.cabbageroll.social.SecurityContext;
import jp.co.netmile.cabbageroll.util.UserCookieGenerator;

/**
 * Before a request is handled:
 * 1. sets the current User in the {@link SecurityContext} from a cookie, if present and the user is still connected to Facebook.
 * 2. requires that the user sign-in if he or she hasn't already.
 * @author Keith Donald
 */
final public class AuthInterceptor extends HandlerInterceptorAdapter {

	private final UsersConnectionRepository connectionRepository;
	
	public AuthInterceptor(UsersConnectionRepository connectionRepository) {
		this.connectionRepository = connectionRepository;
	}
	
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
//		rememberUser(request, response);
//		if(requestForResources(request)) {
//			return true;
//		}
//		if(handleSignOut(request, response)) {
//			return true;
//		}
//		if(SecurityContext.userSignedIn() || requestForSignIn(request)) {
//			return true;
//		} else {
//			return requireSignIn(request, response);
//		}
		if (request.getServletPath().startsWith("/signout")) {
//			connectionRepository.createConnectionRepository(SecurityContext.getCurrentUser().getId()).removeConnections("facebook");
//			userCookieGenerator.removeCookie(response);
			new RedirectView("/", true).render(null, request, response);
		}
		return true;
	}
	
//	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
//		SecurityContext.remove();
//	}

	// internal helpers

//	private void rememberUser(HttpServletRequest request, HttpServletResponse response) {
//		String userId = userCookieGenerator.readCookieValue(userCookieGenerator.USER_ID, request);
//		String pId = userCookieGenerator.readCookieValue(userCookieGenerator.PROVIDER_ID, request);
//		if (userId == null) {
//			return;
//		}
//		if (!userNotFound(userId)) {
//			userCookieGenerator.removeCookie(response);
//			return;
//		}
//		SecurityContext.setCurrentUser(new User(userId, pId));
//	}

//	private void handleSignOut(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		if (SecurityContext.userSignedIn() && request.getServletPath().startsWith("/signout")) {
//			connectionRepository.createConnectionRepository(SecurityContext.getCurrentUser().getId()).removeConnections("facebook");
//			userCookieGenerator.removeCookie(response);
//			SecurityContext.remove();
//		}
//	}
	
//	private boolean handleSignOut(HttpServletRequest request, HttpServletResponse response) throws Exception {
//		if (SecurityContext.userSignedIn() && request.getServletPath().startsWith("/signout")) {
//			connectionRepository.createConnectionRepository(SecurityContext.getCurrentUser().getId()).removeConnections("facebook");
//			userCookieGenerator.removeCookie(response);
//			SecurityContext.remove();
//			new RedirectView("/", true).render(null, request, response);
//			return true;
//		}
//		return false;
//	}
	
	private boolean requestForResources(HttpServletRequest request) {
		return request.getServletPath().startsWith("/resources");
	}
		
	private boolean requestForSignIn(HttpServletRequest request) {
		return request.getServletPath().startsWith("/signin");
	}
	
	private boolean requireSignIn(HttpServletRequest request, HttpServletResponse response) throws Exception {
		new RedirectView("/signin", true).render(null, request, response);
		return false;
	}

	private boolean userNotFound(String userId) {
		// doesn't bother checking a local user database: simply checks if the userId is connected to Facebook
		return connectionRepository.createConnectionRepository(userId).findPrimaryConnection(Facebook.class) != null;
	}
	
}