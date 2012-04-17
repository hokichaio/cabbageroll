package jp.co.netmile.cabbageroll.dto;

import org.springframework.web.multipart.MultipartFile;

public class Multimedia {
	
	public static final int TYPE_NO_MEDIA = 0;

	public static final int TYPE_UPLOAD = 1; 
	
	public static final int TYPE_YOUTUBE = 2;
	
	public static final int TYPE_URL = 3; 
	
	private Integer type = TYPE_NO_MEDIA;
	
	private String uri;
	
	private MultipartFile file;

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getUri() {
		return uri;
	}

	public void setUri(String uri) {
		this.uri = uri;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}
	
}
