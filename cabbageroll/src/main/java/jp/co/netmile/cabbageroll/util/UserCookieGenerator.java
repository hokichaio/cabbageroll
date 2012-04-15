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

/**
 * Utility class for managing the quick_start user cookie that remembers the signed-in user.
 * @author Keith Donald
 */
public final class UserCookieGenerator {

	private final CookieGenerator userCookieGenerator = new CookieGenerator();
	
	public final String USER_ID = "cabbageroll";
	
	public final String PROVIDER_ID = "p";

//	public UserCookieGenerator() {
//		userCookieGenerator.setCookieName("cabbageroll");
//	}

	public void addCookie(String key, String value, HttpServletResponse response) {
		userCookieGenerator.setCookieName(key);
		userCookieGenerator.addCookie(response, value);
	}
	
	public void removeCookie(HttpServletResponse response) {
		userCookieGenerator.setCookieName(USER_ID);
		userCookieGenerator.addCookie(response, "");
		userCookieGenerator.setCookieName(PROVIDER_ID);
		userCookieGenerator.addCookie(response, "");
	}
	
	public String readCookieValue(String key, HttpServletRequest request) {
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
	
//	public void setCookieName(String name) {
//		userCookieGenerator.setCookieName(name);
//	}

}