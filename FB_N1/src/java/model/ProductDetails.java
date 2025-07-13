package model;

public class ProductDetails {
    private int productDetailsId;
    private int productId;
    private String color;
    private String size;
    private String material;
    private Double weight;
    private String origin;
    private String warranty;
    private String moreInfo;

    public ProductDetails() {}

    public ProductDetails(int productDetailsId, int productId, String color, String size, String material, Double weight, String origin, String warranty, String moreInfo) {
        this.productDetailsId = productDetailsId;
        this.productId = productId;
        this.color = color;
        this.size = size;
        this.material = material;
        this.weight = weight;
        this.origin = origin;
        this.warranty = warranty;
        this.moreInfo = moreInfo;
    }

    // Getters and setters
    public int getProductDetailsId() { return productDetailsId; }
    public void setProductDetailsId(int productDetailsId) { this.productDetailsId = productDetailsId; }
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }
    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }
    public String getSize() { return size; }
    public void setSize(String size) { this.size = size; }
    public String getMaterial() { return material; }
    public void setMaterial(String material) { this.material = material; }
    public Double getWeight() { return weight; }
    public void setWeight(Double weight) { this.weight = weight; }
    public String getOrigin() { return origin; }
    public void setOrigin(String origin) { this.origin = origin; }
    public String getWarranty() { return warranty; }
    public void setWarranty(String warranty) { this.warranty = warranty; }
    public String getMoreInfo() { return moreInfo; }
    public void setMoreInfo(String moreInfo) { this.moreInfo = moreInfo; }
} 