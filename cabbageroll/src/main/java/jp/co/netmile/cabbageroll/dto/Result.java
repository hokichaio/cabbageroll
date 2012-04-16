package jp.co.netmile.cabbageroll.dto;

import java.util.List;

public class Result {
	
	private String title;
	
	private Integer type;
	
	private List<ChoiceAsResult> choices;
	
	private String enqId;
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public List<ChoiceAsResult> getChoices() {
		return choices;
	}

	public void setChoices(List<ChoiceAsResult> choices) {
		this.choices = choices;
	}

	public String getEnqId() {
		return enqId;
	}

	public void setEnqId(String enqId) {
		this.enqId = enqId;
	}
	
}
