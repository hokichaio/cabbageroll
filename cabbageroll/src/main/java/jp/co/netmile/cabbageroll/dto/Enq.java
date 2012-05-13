package jp.co.netmile.cabbageroll.dto;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
public class Enq {
	
//	public static final int TYPE_SQ = 1;
//	
//	public static final int TYPE_MQ = 2;
	
	@Id
	private String id;
	
//	private Integer type;
	
	private String title;
	
	private List<Question> questions;
	
	private String owner;
	
	private Date endDate;
	
	private boolean isAdvertise;
	
	private boolean isDiagnose;
	
	private List<Rule> rules;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public List<Question> getQuestions() {
		return questions;
	}

	public void setQuestions(List<Question> questions) {
		this.questions = questions;
	}

	public String getOwner() {
		return owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
	public boolean isAdvertise() {
		return isAdvertise;
	}

	public void setAdvertise(boolean isAdvertise) {
		this.isAdvertise = isAdvertise;
	}

	public boolean isDiagnose() {
		return isDiagnose;
	}

	public void setDiagnose(boolean isDiagnose) {
		this.isDiagnose = isDiagnose;
	}

	public List<Rule> getRules() {
		return rules;
	}

	public void setRules(List<Rule> rules) {
		this.rules = rules;
	}

	public void arrangeData() {
		List<Question> arrangedQuestions = new ArrayList<Question>();
		for(Question q : questions) {
			if(q.getChoices() != null) {
				arrangedQuestions.add(q);
			}
		}
		this.questions = arrangedQuestions;
		for(Question q : questions) {
			List<Choice> arrangedChoices = new ArrayList<Choice>();
			for(Choice c : q.getChoices()) {
				if(c.getMessage()!=null && !c.getMessage().isEmpty()) {
					arrangedChoices.add(c);
				}
			}
			q.setChoices(arrangedChoices);
		}
	}
	
	public boolean checkShowResult(Enq enq, String pid) {
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
