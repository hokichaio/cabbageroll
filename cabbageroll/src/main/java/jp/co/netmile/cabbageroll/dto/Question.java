package jp.co.netmile.cabbageroll.dto;

import java.util.List;

import org.springframework.data.mongodb.core.mapping.Document;

@Document
public class Question {
	
	private Multimedia multimedia;
	
	private String description;
	
	private List<Choice> choices;
	
	public Multimedia getMultimedia() {
		return multimedia;
	}

	public void setMultimedia(Multimedia multimedia) {
		this.multimedia = multimedia;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public List<Choice> getChoices() {
		return choices;
	}

	public void setChoices(List<Choice> choices) {
		this.choices = choices;
	}

}
