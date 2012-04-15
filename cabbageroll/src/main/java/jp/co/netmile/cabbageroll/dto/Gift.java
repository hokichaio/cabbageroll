package jp.co.netmile.cabbageroll.dto;

public class Gift {
	
	public static final int CATEGORY_ID_SWEETS = 1;
	public static final int CATEGORY_ID_BOOK = 2;
	public static final int CATEGORY_ID_GROCERY = 3;
	
	private String id;
	
	private String name;
	
	private String description;
	
	private Integer price;

	private Integer categoryId;

	public String getId() {
		return id;
	}


	public void setId(String id) {
		if(id != null && id.isEmpty()) id=null;
		this.id = id;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	public Integer getPrice() {
		return price;
	}


	public void setPrice(Integer price) {
		this.price = price;
	}


	public Integer getCategoryId() {
		return categoryId;
	}


	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}

	public boolean isEmpty() {
		boolean isIdEmpty = (this.id==null || this.id.isEmpty());
		boolean isCategoryIdEmpty = (this.categoryId==null);
		return(isIdEmpty && isCategoryIdEmpty);
	}
	
}
