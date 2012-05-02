package jp.co.netmile.cabbageroll.config;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESedeKeySpec;

import jp.co.netmile.cabbageroll.util.Encryptor;
import jp.co.netmile.cabbageroll.util.UserCookieGenerator;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class UtilConfig {

	@Value("${cipher.key}")
	private String cipherKey;

	public Encryptor encryptor() {
		Cipher encoder = null;
		Cipher decoder = null;
		try {
			SecretKey secretKey
			= SecretKeyFactory.getInstance("DESede").generateSecret(new DESedeKeySpec(cipherKey.getBytes()));
			encoder = Cipher.getInstance("DESede");
			encoder.init(Cipher.ENCRYPT_MODE, secretKey);
			decoder = Cipher.getInstance("DESede");
			decoder.init(Cipher.DECRYPT_MODE, secretKey);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return new Encryptor(encoder, decoder);
	}
	
	@Bean
	public UserCookieGenerator userCookieGenerator() {
		return new UserCookieGenerator(encryptor());
	}
}