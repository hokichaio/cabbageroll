package jp.co.netmile.cabbageroll.dto;

import java.util.List;

public class Result {
	
	private String description;
	
	private Integer type;
	
	private List<ChoiceAsResult> choices;
	
	private String enqId;
	
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
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
