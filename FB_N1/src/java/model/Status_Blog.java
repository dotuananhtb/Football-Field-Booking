/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author VAN NGUYEN
 */
public class Status_Blog {
    private int status_id;
    private String status_des;

    public Status_Blog(int status_id, String status_des) {
        this.status_id = status_id;
        this.status_des = status_des;
    }

    public Status_Blog() {
    }
    
    

    public int getStatus_id() {
        return status_id;
    }

    public void setStatus_id(int status_id) {
        this.status_id = status_id;
    }

    public String getStatus_des() {
        return status_des;
    }

    public void setStatus_des(String status_des) {
        this.status_des = status_des;
    }

    @Override
    public String toString() {
        return "Status_Blog{" + "status_id=" + status_id + ", status_des=" + status_des + '}';
    }
    
    
    
}
