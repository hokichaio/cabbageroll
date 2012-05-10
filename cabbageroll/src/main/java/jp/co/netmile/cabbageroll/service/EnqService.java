package jp.co.netmile.cabbageroll.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.ResourceBundle;

import javax.annotation.PostConstruct;

import jp.co.netmile.cabbageroll.dto.AnswerForm;
import jp.co.netmile.cabbageroll.dto.Choice;
import jp.co.netmile.cabbageroll.dto.ChoiceAsResult;
import jp.co.netmile.cabbageroll.dto.Enq;
import jp.co.netmile.cabbageroll.dto.Multimedia;
import jp.co.netmile.cabbageroll.dto.Question;
import jp.co.netmile.cabbageroll.dto.Result;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class EnqService {
	
	private static final int DAYS = Integer.parseInt(ResourceBundle.getBundle("k").getString("enq_exist_day"));
	
	private static final String FILE_DEST = ResourceBundle.getBundle("k").getString("file_dest");
	
	private static final int DAYS_IN_MILLISECOND = 1000*60*60*24*DAYS;
	
	@Autowired
	private MongoOperations mongoOperations;
	
	private List<Enq> enqPool;
	
	public List<Result> getResults(String enqId, String pid, List<String> frineds) {
		
		
		Enq enq = getEnqById(enqId);
		
		if(!isAnswered(enq,pid)) return null;
		
		List<Result> results = new ArrayList<Result>();
		
		for(Question q: enq.getQuestions()) {
			Result result = new Result();
			result.setEnqId(enqId);
			result.setDescription(q.getDescription());
			List<Choice> choices = q.getChoices();
			
			List<ChoiceAsResult> cResultList = new ArrayList<ChoiceAsResult>();
			for(Choice c : choices) {
				ChoiceAsResult cResult = new ChoiceAsResult(c);
				for(String aId : c.getAnswers()) {
					if(frineds.contains(aId)) cResult.addFriend(aId);
				}
				cResultList.add(cResult);
			}
			result.setChoices(cResultList);
			results.add(result);
		}
		
		
		return results;
		
	}
	
	public void createEnq(Enq enq) throws IllegalStateException, IOException {
		
		//Questions&Choicesの整理
//		List<Question> arrangedQuestions = new ArrayList<Question>();
//		for(Question q : enq.getQuestions()) {
//			if(q.getChoices() != null) {
//				arrangedQuestions.add(q);
//			}
//		}
//		enq.setQuestions(arrangedQuestions);
//		for(Question q : enq.getQuestions()) {
//			List<Choice> arrangedChoices = new ArrayList<Choice>();
//			for(Choice c : q.getChoices()) {
//				if(c.getMessage()!=null && !c.getMessage().isEmpty()) {
//					arrangedChoices.add(c);
//				}
//			}
//			q.setChoices(arrangedChoices);
//		}
		enq.arrangeData();
		
		//END_DATEの計算
		Calendar now = Calendar.getInstance();
		now.add(Calendar.MILLISECOND, DAYS_IN_MILLISECOND);
		enq.setEndDate(now.getTime());
		
		//画像を一時保存
		Map<Integer,MultipartFile> fileMap = null;
		for(int i= 0; i<=enq.getQuestions().size()-1; i++) {
			MultipartFile file = enq.getQuestions().get(i).getMultimedia().getFile();
			if(file != null && !file.isEmpty()) {
				fileMap = new HashMap<Integer,MultipartFile>();
				fileMap.put(i, file);
			} else {
				if(enq.getQuestions().get(i).getMultimedia().getType() == Multimedia.TYPE_YOUTUBE) {
					String uri = enq.getQuestions().get(i).getMultimedia().getUri();
					if(uri != null && !uri.isEmpty()) {
						uri = uri.split("v=")[1].split("&")[0];
						enq.getQuestions().get(i).getMultimedia().setUri(uri);
					}
				} 
			}
			enq.getQuestions().get(i).getMultimedia().setFile(null);
		}
		
		//Insert&Init
		mongoOperations.insert(enq);
		
		//画像のDESTを決める
		if(fileMap!=null) {
			for (Integer qno : fileMap.keySet()) {
				MultipartFile file = fileMap.get(qno);
				String subName = file.getOriginalFilename().split("\\.")[1];
				String fileName = enq.getOwner() + "_" + enq.getId() + "_" + qno + "." + subName;
				File dest = new File(FILE_DEST + fileName);
	        	file.transferTo(dest);
	        	
	        	Query query = Query.query(Criteria.where("_id").is(enq.getId()));
	        	Update update = new Update();
	        	update.set("questions."+ qno +".multimedia.uri", fileName);
	        	mongoOperations.updateFirst(query, update, Enq.class);
			}
		}
		
		initPool();
	}
	
	public void registAnswer(AnswerForm answerForm, String pid) {
		Enq enq = getEnqById(answerForm.getEnqId());
		if(enq.getQuestions().get(answerForm.getqNo()).getType().equals(Question.TYPE_SA)) {
			Query query = Query.query(Criteria.where("_id").is(answerForm.getEnqId()).andOperator(Criteria.where("questions." + answerForm.getqNo() + ".choices.answers").nin(pid)));
			Update update = new Update();
			update.addToSet("questions."+ answerForm.getqNo() +".choices." + answerForm.getcNo() + ".answers", pid);
			mongoOperations.updateFirst(query, update, Enq.class);
		}else if(enq.getQuestions().get(answerForm.getqNo()).getType().equals(Question.TYPE_MA)) {
			for(Integer cNo : answerForm.getcNos()) {
				Query query = Query.query(Criteria.where("_id").is(answerForm.getEnqId()).andOperator(Criteria.where("questions." + answerForm.getqNo() + ".choices." + answerForm.getcNo() + ".answers").nin(pid)));
				Update update = new Update();
				update.addToSet("questions."+ answerForm.getqNo() +".choices." + cNo + ".answers", pid);
				mongoOperations.updateFirst(query, update, Enq.class);
			}
		}
	}
	
	public Enq getEnqRandomly() {
		if(enqPool == null || enqPool.isEmpty()) return null;
		Random random = new Random();
		return enqPool.get(random.nextInt(enqPool.size()));
	}
	
	public List<Enq> getEnqsRandomly() {
		return enqPool;
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
	
	public List<Enq> getAvailableEnqs(String pid) {
		Query query = Query.query(Criteria.where("questions.choices.answers").nin(pid));
		return mongoOperations.find(query, Enq.class);
	}
	
	public List<Enq> getHistory(String pid) {
		Query query = Query.query(Criteria.where("questions.choices.answers").in(pid));
		return mongoOperations.find(query, Enq.class);
	}
	
	public List<Enq> getMyEnq(String pid) {
		Query query = Query.query(Criteria.where("owner").in(pid));
		return mongoOperations.find(query, Enq.class);
	}
	/**
	 * 次の未回答qnoを探す、すべて回答済みの場合はnull
	 * @param enq
	 * @return
	 */
	public Integer getQno(Enq enq, String pid) {
		
		Integer qNo = 0;
		for(int i=0; i<enq.getQuestions().size(); i++) {
			Question q = enq.getQuestions().get(i);
			for(Choice c : q.getChoices()) {
				if(c.getAnswers().contains(pid)) {
					qNo += 1;
					break;
				} 
			}
		}
		if(qNo >= enq.getQuestions().size()) {
			return null;
		}
		return qNo;
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
