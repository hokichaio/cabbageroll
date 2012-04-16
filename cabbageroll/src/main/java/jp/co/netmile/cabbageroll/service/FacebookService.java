package jp.co.netmile.cabbageroll.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.social.facebook.api.Facebook;
import org.springframework.stereotype.Service;


@Service
public class FacebookService {
	
	private final Facebook facebook;
	
	@Inject
	public FacebookService(Facebook facebook) {
		this.facebook = facebook;
	}
	
	public FacebookService() {
		this.facebook = null;
	}
	
	@Cacheable("friendsCache")
	public List<String> getFriends(String pId) {
		return facebook.friendOperations().getFriendIds();
	}
	
}
