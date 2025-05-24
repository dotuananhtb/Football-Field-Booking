/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class CateProduct {
    private int productCateId;
    private String cateName;

    public CateProduct() {
    }

    public CateProduct(int productCateId, String cateName) {
        this.productCateId = productCateId;
        this.cateName = cateName;
    }

    public int getProductCateId() {
        return productCateId;
    }

    public void setProductCateId(int productCateId) {
        this.productCateId = productCateId;
    }

    public String getCateName() {
        return cateName;
    }

    public void setCateName(String cateName) {
        this.cateName = cateName;
    }

    @Override
    public String toString() {
        return "CateProduct{" + "productCateId=" + productCateId + ", cateName=" + cateName + '}';
    }
    
    
}
