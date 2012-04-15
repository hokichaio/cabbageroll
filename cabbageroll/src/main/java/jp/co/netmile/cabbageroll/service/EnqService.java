package jp.co.netmile.cabbageroll.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import jp.co.netmile.cabbageroll.dto.AnswerForm;
import jp.co.netmile.cabbageroll.dto.Choice;
import jp.co.netmile.cabbageroll.dto.Enq;
import jp.co.netmile.cabbageroll.dto.Multimedia;
import jp.co.netmile.cabbageroll.dto.Question;
import jp.co.netmile.cabbageroll.dto.TestK;

import org.bson.BSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

@Service
public class EnqService {
	
	@Autowired
	private MongoOperations mongoOperations;
	
	private List<Enq> enqPool;
	
	public List<TestK> find() {
		return mongoOperations.findAll(TestK.class, "helo");
	}
	
	
	public void testSave() {
		
		Choice c1 = new Choice();
		c1.setMessage("選択肢1");
		String[] s2 = {"2"};
		Choice c2 = new Choice();
		c2.setMessage("選択肢2");
		
		List<Choice> choices = new ArrayList<Choice>();
		choices.add(c1);
		choices.add(c2);
		
		Multimedia m = new Multimedia();
		m.setType(0);
		m.setUri("http://hoki.syuon.com/images/me.bmp");
		
		Question q = new Question();
		q.setChoices(choices);
		q.setDescription("some description here");
		q.setMultimedia(m);
		q.setTitle("the very first ENQ...");
		
		List<Question> qs = new ArrayList<Question>();
		qs.add(q);
		
		Enq enq = new Enq();
		enq.setEndDate(new Date());
		enq.setOwner("1");
		enq.setQuestions(qs);
		enq.setType(1);
		
//		mongoOperations.save(enq);
		mongoOperations.insert(enq);
		mongoOperations.insert(enq);
	}
	
	public void testUpdate() {
	
		Enq enq = enqPool.get(0);
		
		Multimedia m = new Multimedia();
		m.setType(0);
		m.setUri("http://hoki.syuon.com/images/me.bmp");
		
		Question q = enq.getQuestions().get(0);
		q.setMultimedia(m);
		List<Question> qs = new ArrayList<Question>();
		qs.add(q);
		enq.setQuestions(qs);
		
		Update update = new Update();
		update.set("enq", enq);
//		update.push("questions", value)
//		update.set("subject", article.getSubject()).set("active", article.getActive());
	
	}
	
	public void registAnswer(AnswerForm answerForm, String pid) {
		Query query = Query.query(Criteria.where("_id").is(answerForm.getEnqId()).andOperator(Criteria.where("questions.choices.answers").nin(pid)));
		Update update = new Update();
		update.addToSet("questions."+ answerForm.getqNo() +".choices." + answerForm.getcNo() + ".answers", pid);
		mongoOperations.updateFirst(query, update, Enq.class);
	}
	
	public Enq getEnqRandomly() {
		return enqPool.get(0);
	}
	
	public Enq getEnqById(String enqId) {
		Query query = Query.query(Criteria.where("_id").is(enqId));
		return mongoOperations.findOne(query, Enq.class);
	}
	
	public Enq getAvailableEnqById(String enqId) {
		Query query = Query.query(Criteria.where("_id").is(enqId));
		return mongoOperations.findOne(query, Enq.class);
	}
	
	@PostConstruct
	public void initPool() {
		this.enqPool = mongoOperations.findAll(Enq.class);
	}
}
