package jp.co.netmile.cabbageroll.dto;

import java.util.List;

public class AnswerForm {
	
	private String enqId;
	
	private Integer qNo;
	
	private Integer cNo;
	
	private List<Integer> cNos;

	public String getEnqId() {
		return enqId;
	}

	public void setEnqId(String enqId) {
		this.enqId = enqId;
	}

	public Integer getqNo() {
		return qNo;
	}

	public void setqNo(Integer qNo) {
		this.qNo = qNo;
	}

	public Integer getcNo() {
		return cNo;
	}

	public void setcNo(Integer cNo) {
		this.cNo = cNo;
	}

	public List<Integer> getcNos() {
		return cNos;
	}

	public void setcNos(List<Integer> cNos) {
		this.cNos = cNos;
	}
	
}
