package jp.co.netmile.cabbageroll.aop;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import jp.co.netmile.cabbageroll.dto.Operator;
import jp.co.netmile.cabbageroll.exception.AdminAuthException;

import org.apache.log4j.Logger;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@Configurable
@Aspect
public class AdminInterceptor {
	
	private static final long SESSION_TIME_MS = 1000*60*30;
	
	private static final Logger log = Logger.getLogger(AdminInterceptor.class.getName());

	@Before("execution(public * jp.co.netmile.cabbageroll.controller.backend..*(..)) && !execution(public * jp.co.netmile.cabbageroll.controller.backend.BackendController.login(..)) && !execution(public * jp.co.netmile.cabbageroll.controller.backend.BackendController.welcome(..))")
	public void interceptor() throws AdminAuthException {
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = request.getSession(false);
		if(session != null) {
			Operator operator = (Operator)session.getAttribute(Operator.SESSION_KEY_OPERATOR);
			long diff = System.currentTimeMillis() - operator.getLoginTime();
			if(diff <= SESSION_TIME_MS) {
				return;
			}
		}
		
		throw new AdminAuthException("Session Timeout");
	}
	
}
