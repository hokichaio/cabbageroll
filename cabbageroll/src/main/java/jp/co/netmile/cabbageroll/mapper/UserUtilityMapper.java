package jp.co.netmile.cabbageroll.mapper;

public interface UserUtilityMapper {
	
	public void increseSequence();
	
	public String getSequenceId();
	
	public String getUserIdByProviderUserId(String pid);
	
	public String getUserFacebookIdByUserId(String userId);

}
