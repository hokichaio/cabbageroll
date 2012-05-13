package jp.co.netmile.cabbageroll.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

@Service
public class OtherService {
	
	private static final String ANONYMOUS_USER = "anonymous";
	
	@Autowired
	private MongoOperations mongoOperations;
	
	public void report(String enqId, String pid) {
		
//		if(pid==null) pid = ANONYMOUS_USER;
//		Query query = Query.query(Criteria.where("enqId").is(enqId).andOperator(Criteria.where("questions." + answerForm.getqNo() + ".choices.answers").nin(pid)));
//		
	}
	
}
