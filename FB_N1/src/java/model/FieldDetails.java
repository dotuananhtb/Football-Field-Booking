/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Asus
 */
public class FieldDetails {
    private int fieldId;
    private String fieldName;
    private String address;
    private String fieldTypeName;
    private String image;
    private String description;
    private String status;
    private double minPrice; // Giá thấp nhất của sân

    public FieldDetails() {
    }

    public FieldDetails(int fieldId, String fieldName, String address, String fieldTypeName, String image, String description, String status, double minPrice) {
        this.fieldId = fieldId;
        this.fieldName = fieldName;
        this.address = address;
        this.fieldTypeName = fieldTypeName;
        this.image = image;
        this.description = description;
        this.status = status;
        this.minPrice = minPrice;
    }

    public int getFieldId() {
        return fieldId;
    }

    public void setFieldId(int fieldId) {
        this.fieldId = fieldId;
    }

    public String getFieldName() {
        return fieldName;
    }

    public void setFieldName(String fieldName) {
        this.fieldName = fieldName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getFieldTypeName() {
        return fieldTypeName;
    }

    public void setFieldTypeName(String fieldTypeName) {
        this.fieldTypeName = fieldTypeName;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(double minPrice) {
        this.minPrice = minPrice;
    }

    @Override
    public String toString() {
        return "FieldDetails{" + "fieldId=" + fieldId + ", fieldName=" + fieldName + ", address=" + address + ", fieldTypeName=" + fieldTypeName + ", image=" + image + ", description=" + description + ", status=" + status + ", minPrice=" + minPrice + '}';
    }
    
}
