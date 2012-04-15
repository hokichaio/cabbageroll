package jp.co.netmile.cabbageroll.dto;

public class People {
	
	private String surpriseId;
	
	private int payment;
	
	private String id;
	
	private String name;
	
	private String message;
	
	private boolean isPromoter;

	public int getPayment() {
		return payment;
	}

	public void setPayment(int payment) {
		this.payment = payment;
	}

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

	public boolean isPromoter() {
		return isPromoter;
	}

	public void setPromoter(boolean promoter) {
		this.isPromoter = promoter;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
	public void setPromoterByInt(int i) {
		this.isPromoter = (i == 1);
	}
	
	public int getPromoterAsInt() {
		return isPromoter ? 1:0;
	}

	public String getSurpriseId() {
		return surpriseId;
	}

	public void setSurpriseId(String surpriseId) {
		this.surpriseId = surpriseId;
	}
	
}
