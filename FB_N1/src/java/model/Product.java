/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;



public class Product {
    private int productId;
    private int productCateId;
    private String productName;
    private double productPrice;
    private String productImage;
    private String productDescription;
    private String productStatus;
    private CateProduct CateProduct;

    public Product() {
    }

    public Product(int productId, int productCateId, String productName, double productPrice, String productImage, String productDescription, String productStatus, CateProduct CateProduct) {
        this.productId = productId;
        this.productCateId = productCateId;
        this.productName = productName;
        this.productPrice = productPrice;
        this.productImage = productImage;
        this.productDescription = productDescription;
        this.productStatus = productStatus;
        this.CateProduct = CateProduct;
    }

    public Product(int productId, int productCateId, String productName, double productPrice, String productImage, String productDescription, String productStatus) {
        this.productId = productId;
        this.productCateId = productCateId;
        this.productName = productName;
        this.productPrice = productPrice;
        this.productImage = productImage;
        this.productDescription = productDescription;
        this.productStatus = productStatus;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getProductCateId() {
        return productCateId;
    }

    public void setProductCateId(int productCateId) {
        this.productCateId = productCateId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public double getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(double productPrice) {
        this.productPrice = productPrice;
    }

    public String getProductImage() {
        return productImage;
    }

    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }

    public String getProductDescription() {
        return productDescription;
    }

    public void setProductDescription(String productDescription) {
        this.productDescription = productDescription;
    }

    public String getProductStatus() {
        return productStatus;
    }

    public void setProductStatus(String productStatus) {
        this.productStatus = productStatus;
    }

    @Override
    public String toString() {
        return "Product{" + "productId=" + productId + ", productCateId=" + productCateId + ", productName=" + productName + ", productPrice=" + productPrice + ", productImage=" + productImage + ", productDescription=" + productDescription + ", productStatus=" + productStatus + '}';
    }
    
    
}