/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.util.Date;
/**
 *
 * @author Asus
 */
public class Account {
    private int accountId;
    private int statusId;
    private String username;
    private String password;
    private String email;
    private String createdAt;
    private UserProfile userProfile;
    public Account() {
    }

    public Account(int accountId, int statusId, String username, String password, String email, String createdAt, UserProfile userProfile) {
        this.accountId = accountId;
        this.statusId = statusId;
        this.username = username;
        this.password = password;
        this.email = email;
        this.createdAt = createdAt;
        this.userProfile = userProfile;
    }

    public Account(int statusId, String username, String password, String email, String createdAt, UserProfile userProfile) {
        this.statusId = statusId;
        this.username = username;
        this.password = password;
        this.email = email;
        this.createdAt = createdAt;
        this.userProfile = userProfile;
    }
    
    
    

    public UserProfile getUserProfile() {
        return userProfile;
    }

    public void setUserProfile(UserProfile userProfile) {
        this.userProfile = userProfile;
    }
    

    

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Account{" + "accountId=" + accountId + ", statusId=" + statusId + ", username=" + username + ", password=" + password + ", email=" + email + ", createdAt=" + createdAt + '}';
    }
    
}
