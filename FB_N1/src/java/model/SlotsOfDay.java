/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Đỗ Tuấn Anh
 */
public class SlotsOfDay {

    private int slotId;
    private String startTime;
    private String endTime;
    private int fieldTypeId;

    public SlotsOfDay() {
    }

    public SlotsOfDay(int slotId, String startTime, String endTime, int fieldTypeId) {
        this.slotId = slotId;
        this.startTime = startTime;
        this.endTime = endTime;
        this.fieldTypeId = fieldTypeId;
    }

    public int getSlotId() {
        return slotId;
    }

    public void setSlotId(int slotId) {
        this.slotId = slotId;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public int getFieldTypeId() {
        return fieldTypeId;
    }

    public void setFieldTypeId(int fieldTypeId) {
        this.fieldTypeId = fieldTypeId;
    }

    @Override
    public String toString() {
        return "SlotsOfDay{" + "slotId=" + slotId + ", startTime=" + startTime + ", endTime=" + endTime + ", fieldTypeId=" + fieldTypeId + '}';
    }

}
