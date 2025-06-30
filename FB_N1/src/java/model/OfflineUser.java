/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Đỗ Tuấn Anh
 */
public class OfflineUser {

    private int offlineUserId;
    private String fullName;
    private String phone;
    private String email;
    private String createdDate;
    private int createdBy;

    public OfflineUser() {
    }

    public OfflineUser(int offlineUserId, String fullName, String phone, String email, String createdDate, int createdBy) {
        this.offlineUserId = offlineUserId;
        this.fullName = fullName;
        this.phone = phone;
        this.email = email;
        this.createdDate = createdDate;
        this.createdBy = createdBy;
    }

    @Override
    public String toString() {
        return super.toString(); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }

    public int getOfflineUserId() {
        return offlineUserId;
    }

    public void setOfflineUserId(int offlineUserId) {
        this.offlineUserId = offlineUserId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

   

   
}
