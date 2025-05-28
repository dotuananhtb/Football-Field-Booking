/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Đỗ Tuấn Anh
 */
public class EmailVerificationToken {

    private int id;
    private int accountId;
    private String token;
    private String createdAt;
    private String expiresAt;
    private boolean isUsed;

    public EmailVerificationToken() {
    }

    public EmailVerificationToken(int id, int accountId, String token, String createdAt, String expiresAt, boolean isUsed) {
        this.id = id;
        this.accountId = accountId;
        this.token = token;
        this.createdAt = createdAt;
        this.expiresAt = expiresAt;
        this.isUsed = isUsed;
    }

    public EmailVerificationToken(int accountId, String token, String createdAt, String expiresAt, boolean isUsed) {
        this.accountId = accountId;
        this.token = token;
        this.createdAt = createdAt;
        this.expiresAt = expiresAt;
        this.isUsed = isUsed;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public String getExpiresAt() {
        return expiresAt;
    }

    public void setExpiresAt(String expiresAt) {
        this.expiresAt = expiresAt;
    }

    public boolean isUsed() {
        return isUsed;
    }

    public void setUsed(boolean isUsed) {
        this.isUsed = isUsed;
    }
}
