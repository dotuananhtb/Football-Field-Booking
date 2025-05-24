/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

public class CheckingSlot {
    private int checkingSlotId;
    private int slotFieldId;
    private int bookingId;
    private Date slotDate;
    private String status;
    private String note;

    public CheckingSlot() {
    }

    public CheckingSlot(int checkingSlotId, int slotFieldId, int bookingId, Date slotDate, String status, String note) {
        this.checkingSlotId = checkingSlotId;
        this.slotFieldId = slotFieldId;
        this.bookingId = bookingId;
        this.slotDate = slotDate;
        this.status = status;
        this.note = note;
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

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public Date getSlotDate() {
        return slotDate;
    }

    public void setSlotDate(Date slotDate) {
        this.slotDate = slotDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    @Override
    public String toString() {
        return "CheckingSlot{" + "checkingSlotId=" + checkingSlotId + ", slotFieldId=" + slotFieldId + ", bookingId=" + bookingId + ", slotDate=" + slotDate + ", status=" + status + ", note=" + note + '}';
    }
    
}