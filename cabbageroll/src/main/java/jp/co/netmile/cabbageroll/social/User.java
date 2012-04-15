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
package jp.co.netmile.cabbageroll.social;

/**
 * Simple little User model. 
 * Just stores the user's id for simplicity.
 * @author Keith Donald
 */
public final class User {
	
	private final String id;
	
	private final String pId;
	
	public User(String id, String pId) {
		this.id = id;
		this.pId = pId;
	}
	
	public String getId() {
		return id;
	}
	
	
	public String getpId() {
		return pId;
	}
	
}
