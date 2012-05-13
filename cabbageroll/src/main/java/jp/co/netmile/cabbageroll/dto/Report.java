package jp.co.netmile.cabbageroll.dto;

import java.util.Date;

public class Report {
	
	private String enqId;
	
	private String reporter;
	
	private Date reportedTime;

	public String getEnqId() {
		return enqId;
	}

	public void setEnqId(String enqId) {
		this.enqId = enqId;
	}

	public String getReporter() {
		return reporter;
	}

	public void setReporter(String reporter) {
		this.reporter = reporter;
	}

	public Date getReportedTime() {
		return reportedTime;
	}

	public void setReportedTime(Date reportedTime) {
		this.reportedTime = reportedTime;
	}

}
