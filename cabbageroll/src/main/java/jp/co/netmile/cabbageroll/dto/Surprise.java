package jp.co.netmile.cabbageroll.dto;

import java.util.ArrayList;
import java.util.List;

public class Surprise {

	private Gift gift;
	
	private String id;
	
	private String receiverAddress;
	
	private List<People> receiverList = new ArrayList<People>();
	
	private List<People> senderList = new ArrayList<People>();
	
	private Integer tempPayment;
	
	private String tempMessage;
	
	private String tempMessageToSponsor;
	
	private boolean noAddress;
	
	private boolean noSponsor;
	
	private Integer statusId;

	public Gift getGift() {
		return gift;
	}

	public void setGift(Gift gift) {
		this.gift = gift;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getReceiverAddress() {
		return receiverAddress;
	}

	public void setReceiverAddress(String receiverAddress) {
		this.receiverAddress = receiverAddress;
	}

	public List<People> getReceiverList() {
		return receiverList;
	}

	public void setReceiverList(List<People> receiverList) {
		this.receiverList = receiverList;
	}

	public List<People> getSenderList() {
		return senderList;
	}

	public void setSenderList(List<People> senderList) {
		this.senderList = senderList;
	}

	public Integer getTempPayment() {
		return tempPayment;
	}

	public void setTempPayment(Integer tempPayment) {
		this.tempPayment = tempPayment;
	}

	public boolean isNoAddress() {
		return noAddress;
	}

	public void setNoAddress(boolean noAddress) {
		this.noAddress = noAddress;
	}

	public boolean isNoSponsor() {
		return noSponsor;
	}

	public void setNoSponsor(boolean noSponsor) {
		this.noSponsor = noSponsor;
	}
	
	public Integer getStatusId() {
		return statusId;
	}

	public void setStatusId(Integer statusId) {
		this.statusId = statusId;
	}
	
	public String getTempMessageToSponsor() {
		return tempMessageToSponsor;
	}

	public void setTempMessageToSponsor(String tempMessageToSponsor) {
		this.tempMessageToSponsor = tempMessageToSponsor;
	}

	public Integer getRemainingBill() {
		Integer remainingBill;
		if(this.gift != null) {
			remainingBill = gift.getPrice();
		} else {
			return null;
		}
		for(People payer : senderList) {
			remainingBill -= payer.getPayment();
		}
		return remainingBill;
	}
	
	public void addSender(People ppl) {
		senderList.add(ppl);
	}
	
	public String getPromoterId() {
		for(People ppl : senderList) {
			if(ppl.isPromoter()) return ppl.getId();
		}
		return null;
	}
	
	public String getPromoterName() {
		for(People ppl : senderList) {
			if(ppl.isPromoter()) return ppl.getName();
		}
		return null;
	}
	
	public void refreshList() {
		List<People> refreshedSender = new ArrayList<People>();
		for(People ppl : senderList) {
			if(ppl.getId() != null) {
				refreshedSender.add(ppl);
			}
		}
		this.senderList = refreshedSender;
		List<People> refreshedReceiver = new ArrayList<People>();
		for(People ppl : receiverList) {
			if(ppl.getId() != null) {
				refreshedReceiver.add(ppl);
			}
		}
		this.receiverList = refreshedReceiver;
	}
	
	public void setNoAddressByInt(int i) {
		noAddress = (i == 1);
	}
	
	public void setNoSponsorByInt(int i) {
		noSponsor = (i == 1);
	}
	
	public int getNoAddressAsInt() {
		return noAddress ? 1:0;
	}
	
	public int getNoSponsorAsInt() {
		return noSponsor ? 1:0;
	}
	
	public boolean isUserInList(String userId) {
		for(People ppl : senderList) {
			if(ppl.getId().equals(userId)) {
				return true;
			} 
		}
		return false;
	}

	public String getTempMessage() {
		return tempMessage;
	}

	public void setTempMessage(String tempMessage) {
		this.tempMessage = tempMessage;
	}
	
	public boolean isPaid() {
		int price = this.gift.getPrice();
		int paid = 0;
		for(People ppl : senderList) {
			paid += ppl.getPayment();
		}
		return (price-paid==0);
	}
	
}
