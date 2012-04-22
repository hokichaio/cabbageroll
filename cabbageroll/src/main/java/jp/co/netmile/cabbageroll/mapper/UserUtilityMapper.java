package jp.co.netmile.cabbageroll.mapper;

import java.util.List;

import jp.co.netmile.cabbageroll.dto.UserConnection;

public interface UserUtilityMapper {
	
	public void increseSequence();
	
	public String getSequenceId();
	
	public String getUserIdByProviderUserId(String pid);
	
	public String getUserFacebookIdByUserId(String userId);
	
	public List<UserConnection> getUsers();

}
