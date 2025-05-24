/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Asus
 */
public class StatusAccount {
     private int statusId;
    private int statusAccount;
    private String description;

    public StatusAccount(int statusId, int statusAccount, String description) {
        this.statusId = statusId;
        this.statusAccount = statusAccount;
        this.description = description;
    }

    public StatusAccount() {
    }

    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    public int getStatusAccount() {
        return statusAccount;
    }

    public void setStatusAccount(int statusAccount) {
        this.statusAccount = statusAccount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "StatusAccount{" + "statusId=" + statusId + ", statusAccount=" + statusAccount + ", description=" + description + '}';
    }
    
}
