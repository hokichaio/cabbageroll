package jp.co.netmile.cabbageroll.service;

import java.util.List;

import javax.inject.Inject;

import jp.co.netmile.cabbageroll.dto.User;
import jp.co.netmile.cabbageroll.dto.facebook.EducationEntry;
import jp.co.netmile.cabbageroll.dto.facebook.Profile;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.social.connect.Connection;
import org.springframework.social.connect.ConnectionRepository;
import org.springframework.social.connect.UsersConnectionRepository;
import org.springframework.social.facebook.api.Facebook;
import org.springframework.social.facebook.api.FacebookProfile;
import org.springframework.stereotype.Service;


@Service
public class FacebookService {
	
	@Inject
	UsersConnectionRepository usersConnectionRepository;
	
	@Autowired
	private MongoOperations mongoOperations;
	
//	private final Facebook facebook;
//	
//	@Inject
//	public FacebookService(Facebook facebook) {
//		this.facebook = facebook;
//	}
	
//	public FacebookService() {
//		this.facebook = null;
//	}
	
	@Cacheable("friendsCache")
	public List<String> getFriends(String userId) {
		
		ConnectionRepository connectionRepository = usersConnectionRepository.createConnectionRepository(userId);
		if (connectionRepository.findPrimaryConnection(Facebook.class) != null) {
			Facebook facebook = connectionRepository.getPrimaryConnection(Facebook.class).getApi();
			return facebook.friendOperations().getFriendIds();
		} 
		return null;
		
	}
	
	public void saveUserInfo(String userId) {
		
		ConnectionRepository connectionRepository = usersConnectionRepository.createConnectionRepository(userId);
		if (connectionRepository.findPrimaryConnection(Facebook.class) != null) {
			Facebook facebook = connectionRepository.getPrimaryConnection(Facebook.class).getApi();
			mongoOperations.save(facebook.userOperations().getUserProfile());
		}
	}
	
}
