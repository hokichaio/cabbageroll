package jp.co.netmile.cabbageroll.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import javax.mail.internet.MimeUtility;

public class HashManager {
	
	private static final String KEY = "studiok";
	
	public static String encrypt(String input) {
		
		SecretKeySpec keySpec = new SecretKeySpec(KEY.getBytes(), "Blowfish");
		try {
			Cipher cipher = Cipher.getInstance("Blowfish");
			cipher.init(Cipher.ENCRYPT_MODE, keySpec);
			byte[] encrypted = cipher.doFinal(input.getBytes());
			ByteArrayOutputStream forEncode = new ByteArrayOutputStream();
		    OutputStream toBase64 = MimeUtility.encode(forEncode, "base64");
		    toBase64.write(encrypted);	
		    toBase64.close();
		    return forEncode.toString("iso-8859-1");
		} catch(Exception e) {
			return null;
		} 
		
	}
	
	public static String decrypt(String input) {
		
		SecretKeySpec keySpec = new SecretKeySpec(KEY.getBytes(), "Blowfish");
		try {
			InputStream fromBase64 = MimeUtility.decode(new ByteArrayInputStream(input.getBytes()), "base64");
		    byte[] buf = new byte[1024];
		    ByteArrayOutputStream toByteArray = new ByteArrayOutputStream();
		    for (int len = -1;(len = fromBase64.read(buf)) != -1;)
		    	toByteArray.write(buf, 0, len);
		    Cipher cipher = Cipher.getInstance("Blowfish");
			cipher.init(Cipher.DECRYPT_MODE, keySpec);
			return new String(cipher.doFinal(toByteArray.toByteArray()));
		} catch(Exception e) {
			return null;
		}
		
	}
	

}
