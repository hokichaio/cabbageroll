package jp.co.netmile.cabbageroll.exception;

public class AdminAuthException extends Exception {

	private static final long serialVersionUID = -7547144485019946483L;

	public AdminAuthException(String arg0, Throwable arg1){
		super(arg0, arg1);
	}
	
	public AdminAuthException(String arg0){
		super(arg0);
	}
	
	public AdminAuthException(Throwable arg0){
		super(arg0);
	}
	
}
