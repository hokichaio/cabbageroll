package jp.co.netmile.cabbageroll.dto;

import java.util.ArrayList;
import java.util.List;

public class ChoiceAsResult extends Choice {

	private List<String> friends = new ArrayList<String>();

	public ChoiceAsResult(Choice c) {
		super.setAnswers(c.getAnswers());
		super.setMessage(c.getMessage());
	}
	
	public List<String> getFriends() {
		return friends;
	}

	public void addFriend(String friend) {
		this.friends.add(friend);
	}
	
}
