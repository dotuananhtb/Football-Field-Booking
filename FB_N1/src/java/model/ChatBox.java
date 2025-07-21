/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author VAN NGUYEN
 */
public class ChatBox {
    private int id ; 
    private int account_id;
    private String user_input;
    private String bot_response;
    private Timestamp createdAt;

    public ChatBox(int id, int account_id, String user_input, String bot_response, Timestamp createdAt) {
        this.id = id;
        this.account_id = account_id;
        this.user_input = user_input;
        this.bot_response = bot_response;
        this.createdAt = createdAt;
    }

    public ChatBox(int account_id, String user_input, String bot_response, Timestamp createdAt) {
        this.account_id = account_id;
        this.user_input = user_input;
        this.bot_response = bot_response;
        this.createdAt = createdAt;
    }

    public ChatBox() {
    }

   
    
    
    
   

   
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getAccount_id() {
        return account_id;
    }

    public void setAccount_id(int account_id) {
        this.account_id = account_id;
    }

   

    public String getUser_input() {
        return user_input;
    }

    public void setUser_input(String user_input) {
        this.user_input = user_input;
    }

    public String getBot_response() {
        return bot_response;
    }

    public void setBot_response(String bot_response) {
        this.bot_response = bot_response;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "ChatBox{" + "id=" + id + ", account_id=" + account_id + ", user_input=" + user_input + ", bot_response=" + bot_response + ", createdAt=" + createdAt + '}';
    }

    
    
    

   

    
    
    
}
