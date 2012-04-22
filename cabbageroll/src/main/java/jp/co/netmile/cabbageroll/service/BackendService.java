package jp.co.netmile.cabbageroll.service;

import java.util.List;

import jp.co.netmile.cabbageroll.dto.UserConnection;
import jp.co.netmile.cabbageroll.dto.facebook.Profile;
import jp.co.netmile.cabbageroll.mapper.UserUtilityMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

@Service
public class BackendService {
	
	@Autowired
	private UserUtilityMapper userUtilityMapper;
	
	@Autowired
	private MongoOperations mongoOperations;

	public List<UserConnection> getUsers() {
		return userUtilityMapper.getUsers();
	}
	
	public Profile getUserProfile(String pid) {
		Query query = Query.query(Criteria.where("_id").is(pid));
		return mongoOperations.findOne(query, Profile.class, "facebookProfile");
	}
	
	
}
