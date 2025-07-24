/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Đỗ Tuấn Anh
 */
public class Sale {

    private int saleId;
    private int minSlot;
    private int salePercent;
    private String description;
    private String sale_name;

    public Sale() {
    }

    public Sale(int saleId, int minSlot, int salePercent, String description, String sale_name) {
        this.saleId = saleId;
        this.minSlot = minSlot;
        this.salePercent = salePercent;
        this.description = description;
        this.sale_name = sale_name;
    }

    public Sale(int minSlot, int salePercent, String description, String sale_name) {
        this.minSlot = minSlot;
        this.salePercent = salePercent;
        this.description = description;
        this.sale_name = sale_name;
    }

   

    public int getSaleId() {
        return saleId;
    }

    public void setSaleId(int saleId) {
        this.saleId = saleId;
    }

    public int getMinSlot() {
        return minSlot;
    }

    public void setMinSlot(int minSlot) {
        this.minSlot = minSlot;
    }

    public String getSale_name() {
        return sale_name;
    }

    public void setSale_name(String sale_name) {
        this.sale_name = sale_name;
    }


    public int getSalePercent() {
        return salePercent;
    }

    public void setSalePercent(int salePercent) {
        this.salePercent = salePercent;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "Sale{" + "saleId=" + saleId + ", minSlot=" + minSlot + ", salePercent=" + salePercent + ", description=" + description + ", sale_name=" + sale_name + '}';
    }

   

}
