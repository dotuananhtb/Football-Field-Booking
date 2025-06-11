/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Đỗ Tuấn Anh
 */
public class CheckingSlot {

    private int checkingSlotId;
    private int slotFieldId;
    private String slotDate;
    private String status;

    public CheckingSlot() {
    }

    public CheckingSlot(int checkingSlotId, int slotFieldId, String slotDate, String status) {
        this.checkingSlotId = checkingSlotId;
        this.slotFieldId = slotFieldId;
        this.slotDate = slotDate;
        this.status = status;
    }

    public int getCheckingSlotId() {
        return checkingSlotId;
    }

    public void setCheckingSlotId(int checkingSlotId) {
        this.checkingSlotId = checkingSlotId;
    }

    public int getSlotFieldId() {
        return slotFieldId;
    }

    public void setSlotFieldId(int slotFieldId) {
        this.slotFieldId = slotFieldId;
    }

    public String getSlotDate() {
        return slotDate;
    }

    public void setSlotDate(String slotDate) {
        this.slotDate = slotDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "CheckingSlot{" + "checkingSlotId=" + checkingSlotId + ", slotFieldId=" + slotFieldId + ", slotDate=" + slotDate + ", status=" + status + '}';
    }

}
