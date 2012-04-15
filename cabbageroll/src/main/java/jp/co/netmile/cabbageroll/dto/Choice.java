package jp.co.netmile.cabbageroll.dto;

import java.util.ArrayList;
import java.util.List;

import org.springframework.data.annotation.Id;

public class Choice {

	private String message;
	
	private List<String> answers = new ArrayList<String>();
	
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public List<String> getAnswers() {
		return answers;
	}

	public void setAnswers(List<String> answers) {
		this.answers = answers;
	}
	
}
