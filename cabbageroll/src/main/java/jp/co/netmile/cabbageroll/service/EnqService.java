package jp.co.netmile.cabbageroll.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.ResourceBundle;

import javax.annotation.PostConstruct;

import jp.co.netmile.cabbageroll.dto.AnswerForm;
import jp.co.netmile.cabbageroll.dto.Choice;
import jp.co.netmile.cabbageroll.dto.ChoiceAsResult;
import jp.co.netmile.cabbageroll.dto.Enq;
import jp.co.netmile.cabbageroll.dto.Question;
import jp.co.netmile.cabbageroll.dto.Result;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

@Service
public class EnqService {
	
	private static final int DAYS = Integer.parseInt(ResourceBundle.getBundle("k").getString("enq_exist_day"));
	
	private static final int DAYS_IN_MILLISECOND = 1000*60*60*24*DAYS;
	
	@Autowired
	private MongoOperations mongoOperations;
	
	private List<Enq> enqPool;
	
	public Result getResult(String enqId, String pid, List<String> frineds) {
		
		Result result = new Result();
		Enq enq = getEnqById(enqId);
		
		if(!isAnswered(enq,pid)) return null;
		
		result.setEnqId(enqId);
		if(enq.getType().equals(Enq.TYPE_SQ)) {
			result.setType(enq.getType());
			result.setTitle(enq.getTitle());
			List<Choice> choices = enq.getQuestions().get(0).getChoices();
			
			List<ChoiceAsResult> cResultList = new ArrayList<ChoiceAsResult>();
			
			for(Choice c : choices) {
				ChoiceAsResult cResult = new ChoiceAsResult(c);
				for(String aId : c.getAnswers()) {
					if(frineds.contains(aId)) cResult.addFriend(aId);
				}
				cResultList.add(cResult);
			}
			result.setChoices(cResultList);
		}
		
		return result;
		
	}
	
	public void createEnq(Enq enq) {
		List<Question> arrangedQuestions = new ArrayList<Question>();
		for(Question q : enq.getQuestions()) {
			if(q.getChoices() != null) {
				arrangedQuestions.add(q);
			}
		}
		enq.setQuestions(arrangedQuestions);
		
		for(Question q : enq.getQuestions()) {
			List<Choice> arrangedChoices = new ArrayList<Choice>();
			for(Choice c : q.getChoices()) {
				if(c.getMessage()!=null && !c.getMessage().isEmpty()) {
					arrangedChoices.add(c);
				}
			}
			q.setChoices(arrangedChoices);
		}
		
		Calendar now = Calendar.getInstance();
		now.add(Calendar.MILLISECOND, DAYS_IN_MILLISECOND);
		enq.setEndDate(now.getTime());
		mongoOperations.insert(enq);
		initPool();
	}
	
	public void registAnswer(AnswerForm answerForm, String pid) {
		Query query = Query.query(Criteria.where("_id").is(answerForm.getEnqId()).andOperator(Criteria.where("questions.choices.answers").nin(pid)));
		Update update = new Update();
		update.addToSet("questions."+ answerForm.getqNo() +".choices." + answerForm.getcNo() + ".answers", pid);
		mongoOperations.updateFirst(query, update, Enq.class);
	}
	
	public Enq getEnqRandomly() {
		Random random = new Random();
		return enqPool.get(random.nextInt(enqPool.size()));
	}
	
	public Enq getEnqById(String enqId) {
		Query query = Query.query(Criteria.where("_id").is(enqId));
		return mongoOperations.findOne(query, Enq.class);
	}
	
	public Enq getAvailableEnq(String pid) {
		Query query = Query.query(Criteria.where("questions.choices.answers").nin(pid));
		List<Enq> enqs = mongoOperations.find(query, Enq.class);
		if(enqs == null || enqs.isEmpty()) return null;
		Random random = new Random();
		return enqs.get(random.nextInt(enqs.size()));
	}
	
	public List<Enq> getHistory(String pid) {
		Query query = Query.query(Criteria.where("questions.choices.answers").in(pid));
		return mongoOperations.find(query, Enq.class);
	}
	
	@PostConstruct
	public void initPool() {
		this.enqPool = mongoOperations.findAll(Enq.class);
	}
	
	private boolean isAnswered(Enq enq, String pid) {
		boolean isAnswered = false;
		if(enq.getEndDate().after(new Date())) {
			for(Question q : enq.getQuestions()) {
				for(Choice c : q.getChoices()) {
					if(c.getAnswers().contains(pid)) {
						isAnswered = true;
						break;
					}
				}
				if(isAnswered) break;
			}
		} else {
			isAnswered = true;
		}
		return isAnswered;
	}
	
	
}
