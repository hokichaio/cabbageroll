/*
 * Copyright 2011 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package jp.co.netmile.cabbageroll.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.util.CookieGenerator;

public final class UserCookieGenerator {
	
	private static Encryptor encryptor;

	private static final CookieGenerator userCookieGenerator = new CookieGenerator();
	
	public static final String USER_ID = "cabbageroll";
	
	public static final String PROVIDER_ID = "p";
	
	private static final int ONE_WEEK = 7 * 24 * 60 * 60; // for 1 week
	
	public UserCookieGenerator(Encryptor encryptor) {
		UserCookieGenerator.encryptor = encryptor;
	}
	
	public static void addCookie(String key, String value, HttpServletResponse response) {
		userCookieGenerator.setCookieMaxAge(ONE_WEEK);
		userCookieGenerator.setCookieName(key);
		userCookieGenerator.addCookie(response, value);
	}
	
	public static void removeCookie(HttpServletResponse response) {
		userCookieGenerator.setCookieName(USER_ID);
		userCookieGenerator.addCookie(response, "");
		userCookieGenerator.setCookieName(PROVIDER_ID);
		userCookieGenerator.addCookie(response, "");
	}
	
	public static String readCookieValue(String key, HttpServletRequest request) {
		userCookieGenerator.setCookieName(key);
		Cookie[] cookies = request.getCookies();
		if (cookies == null) {
			return null;
		}
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals(userCookieGenerator.getCookieName())) {
				return cookie.getValue();
			}
		}
		return null;
	}
	
	public static String getDecryptedValue(String key, HttpServletRequest request) {
		String encrypted = readCookieValue(key,request);
		System.out.print(encryptor);
		return encryptor.decrypt(encrypted);
	}
	
	public static void addEncryptedCookie(String key, String value, HttpServletResponse response) {
		addCookie(key,encryptor.encrypt(value),response);
	}

}