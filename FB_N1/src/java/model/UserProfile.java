/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Asus
 */
public class UserProfile {

    private int accountId;
    private int roleId;
    private String firstName;
    private String lastName;
    private String address;
    private String gender;
    private String phone;
    private String avatar;

    public UserProfile() {
    }

    public UserProfile(int roleId, String firstName, String lastName, String address, String gender, String phone, String avatar) {

        this.roleId = roleId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.address = address;
        this.gender = gender;
        this.phone = phone;
        this.avatar = avatar;
    }

    public UserProfile(int accountId, int roleId, String firstName, String lastName, String address, String gender, String phone, String avatar) {
        this.accountId = accountId;
        this.roleId = roleId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.address = address;
        this.gender = gender;
        this.phone = phone;
        this.avatar = avatar;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    @Override
    public String toString() {
        return "UserProfile{" + "accountId=" + accountId + ", roleId=" + roleId + ", firstName=" + firstName + ", lastName=" + lastName + ", address=" + address + ", gender=" + gender + ", phone=" + phone + ", avatar=" + avatar + '}';
    }

}
