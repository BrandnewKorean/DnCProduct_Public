package vo;

public class ProductImageVO {
	private String productcode;
	private String filename;
	private boolean ismain;
	
	public boolean getIsmain() {
		return ismain;
	}
	public void setIsmain(boolean ismain) {
		this.ismain = ismain;
	}
	public String getProductcode() {
		return productcode;
	}
	public void setProductcode(String productcode) {
		this.productcode = productcode;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	@Override
	public String toString() {
		return "ProductImageVO [productcode=" + productcode + ", filename=" + filename + ", ismain=" + ismain + "]";
	}
}
