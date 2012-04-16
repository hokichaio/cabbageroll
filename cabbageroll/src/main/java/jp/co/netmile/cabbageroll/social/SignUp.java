package jp.co.netmile.cabbageroll.social;

import jp.co.netmile.cabbageroll.mapper.UserUtilityMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.connect.Connection;
import org.springframework.social.connect.ConnectionSignUp;

/**
 * {@link ConnectionSignUp}
 */
public class SignUp implements ConnectionSignUp {

	@Autowired
	private UserUtilityMapper userUtilityMapper;

//	private final AtomicLong userIdSequence = new AtomicLong();

//	public String execute(Connection<?> connection) {
//		return Long.toString(userIdSequence.incrementAndGet());
//	}
	public String execute(Connection<?> connection) {
		String pid = connection.getKey().getProviderUserId();
		String userId = userUtilityMapper.getUserIdByProviderUserId(pid);
		if(userId == null) {
			userUtilityMapper.increseSequence();
			return userUtilityMapper.getSequenceId();
		}
		else return userId;
	}
}