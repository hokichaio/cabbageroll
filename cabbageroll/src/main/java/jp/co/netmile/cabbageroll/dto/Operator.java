package jp.co.netmile.cabbageroll.dto;

public class Operator {
	
	public static final String SESSION_KEY_OPERATOR = "OP";
	
	private String id;
	
	private String name;
	
	private long loginTime;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public long getLoginTime() {
		return loginTime;
	}

	public void setLoginTime(long loginTime) {
		this.loginTime = loginTime;
	}

}
