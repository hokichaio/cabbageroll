package jp.co.netmile.cabbageroll.social;

import jp.co.netmile.cabbageroll.mapper.UserUtilityMapper;
import jp.co.netmile.cabbageroll.service.FacebookService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.social.connect.Connection;
import org.springframework.social.connect.ConnectionSignUp;

/**
 * {@link ConnectionSignUp}
 */
public class SignUp implements ConnectionSignUp {

	@Autowired
	private UserUtilityMapper userUtilityMapper;
	
	@Autowired
	private FacebookService facebookService;

//	private final AtomicLong userIdSequence = new AtomicLong();

//	public String execute(Connection<?> connection) {
//		return Long.toString(userIdSequence.incrementAndGet());
//	}
	public String execute(Connection<?> connection) {
		String pid = connection.getKey().getProviderUserId();
		String userId = userUtilityMapper.getUserIdByProviderUserId(pid);
		if(userId == null) {
			userUtilityMapper.increseSequence();
			userId = userUtilityMapper.getSequenceId();
			saveUserInfo(userId);
			return userId;
		}
		else return userId;
	}
	
	@Async
	private void saveUserInfo(String userId) {
		try {
			Thread.sleep(5000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		facebookService.saveUserInfo(userId);
	}
}