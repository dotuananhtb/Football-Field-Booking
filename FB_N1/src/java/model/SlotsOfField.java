/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Đỗ Tuấn Anh
 */
public class SlotsOfField {

    private int slotFieldId;
    private double slotFieldPrice;

    private Field field;           // để biết ca này thuộc sân nào (nếu cần)
    private SlotsOfDay slotInfo;   // thông tin giờ bắt đầu/kết thúc

    // Getters & Setters
    public SlotsOfField() {
    }

    public SlotsOfField(int slotFieldId, double slotFieldPrice, Field field, SlotsOfDay slotInfo) {
        this.slotFieldId = slotFieldId;
        this.slotFieldPrice = slotFieldPrice;
        this.field = field;
        this.slotInfo = slotInfo;
    }

    public int getSlotFieldId() {
        return slotFieldId;
    }

    public void setSlotFieldId(int slotFieldId) {
        this.slotFieldId = slotFieldId;
    }

    public double getSlotFieldPrice() {
        return slotFieldPrice;
    }

    public void setSlotFieldPrice(double slotFieldPrice) {
        this.slotFieldPrice = slotFieldPrice;
    }

    public Field getField() {
        return field;
    }

    public void setField(Field field) {
        this.field = field;
    }

    public SlotsOfDay getSlotInfo() {
        return slotInfo;
    }

    public void setSlotInfo(SlotsOfDay slotInfo) {
        this.slotInfo = slotInfo;
    }

    @Override
    public String toString() {
        return "SlotsOfField{" + "slotFieldId=" + slotFieldId + ", slotFieldPrice=" + slotFieldPrice + ", field=" + field + ", slotInfo=" + slotInfo + '}';
    }

}
