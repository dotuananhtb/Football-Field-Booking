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
    private int maxSlot;
    private int salePercent;
    private String description;

    public Sale() {
    }

    public Sale(int saleId, int minSlot, int maxSlot, int salePercent, String description) {
        this.saleId = saleId;
        this.minSlot = minSlot;
        this.maxSlot = maxSlot;
        this.salePercent = salePercent;
        this.description = description;
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

    public int getMaxSlot() {
        return maxSlot;
    }

    public void setMaxSlot(int maxSlot) {
        this.maxSlot = maxSlot;
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
        return "Sale{" + "saleId=" + saleId + ", minSlot=" + minSlot + ", maxSlot=" + maxSlot + ", salePercent=" + salePercent + ", description=" + description + '}';
    }

}
