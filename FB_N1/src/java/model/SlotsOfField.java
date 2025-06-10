/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author VAN NGUYEN
 */
import java.math.BigDecimal;

public class SlotsOfField {
    private int slotFieldId;
    private int slotId;
    private int fieldId;
    private double slotFieldPrice;

    public SlotsOfField(int slotFieldId, int slotId, int fieldId, double slotFieldPrice) {
        this.slotFieldId = slotFieldId;
        this.slotId = slotId;
        this.fieldId = fieldId;
        this.slotFieldPrice = slotFieldPrice;
    }

    public SlotsOfField() {
    }

    public int getSlotFieldId() {
        return slotFieldId;
    }

    public void setSlotFieldId(int slotFieldId) {
        this.slotFieldId = slotFieldId;
    }

    public int getSlotId() {
        return slotId;
    }

    public void setSlotId(int slotId) {
        this.slotId = slotId;
    }

    public int getFieldId() {
        return fieldId;
    }

    public void setFieldId(int fieldId) {
        this.fieldId = fieldId;
    }

    public double getSlotFieldPrice() {
        return slotFieldPrice;
    }

    public void setSlotFieldPrice(double slotFieldPrice) {
        this.slotFieldPrice = slotFieldPrice;
    }

    @Override
    public String toString() {
        return "SlotsOfField{" + "slotFieldId=" + slotFieldId + ", slotId=" + slotId + ", fieldId=" + fieldId + ", slotFieldPrice=" + slotFieldPrice + '}';
    }
    
    
}


