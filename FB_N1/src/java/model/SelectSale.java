/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author VAN NGUYEN
 */
public class SelectSale {
    
    private int id;
    private int sale_id;

    public SelectSale(int id, int sale_id) {
        this.id = id;
        this.sale_id = sale_id;
    }

    public SelectSale() {
    }

    public SelectSale(int sale_id) {
        this.sale_id = sale_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getSale_id() {
        return sale_id;
    }

    public void setSale_id(int sale_id) {
        this.sale_id = sale_id;
    }

    @Override
    public String toString() {
        return "SelectSale{" + "id=" + id + ", sale_id=" + sale_id + '}';
    }
    
    
    
    
}
