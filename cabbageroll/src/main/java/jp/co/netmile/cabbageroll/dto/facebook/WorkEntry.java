package jp.co.netmile.cabbageroll.dto.facebook;

public class WorkEntry {

	private Reference employer;

	private String startDate;

	private String endDate;

	public Reference getEmployer() {
		return employer;
	}

	public void setEmployer(Reference employer) {
		this.employer = employer;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	
}
