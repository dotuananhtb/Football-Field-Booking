/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Đỗ Tuấn Anh
 */
public class BookingDetails {
     private int bookingDetailsId;
    private int bookingId;
    private int slotFieldId;
    private double slotFieldPrice;
    private int extraMinutes;
    private double extraFee;

    public BookingDetails() {
    }

    public BookingDetails(int bookingDetailsId, int bookingId, int slotFieldId, double slotFieldPrice, int extraMinutes, double extraFee) {
        this.bookingDetailsId = bookingDetailsId;
        this.bookingId = bookingId;
        this.slotFieldId = slotFieldId;
        this.slotFieldPrice = slotFieldPrice;
        this.extraMinutes = extraMinutes;
        this.extraFee = extraFee;
    }

    public int getBookingDetailsId() {
        return bookingDetailsId;
    }

    public void setBookingDetailsId(int bookingDetailsId) {
        this.bookingDetailsId = bookingDetailsId;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
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

    public int getExtraMinutes() {
        return extraMinutes;
    }

    public void setExtraMinutes(int extraMinutes) {
        this.extraMinutes = extraMinutes;
    }

    public double getExtraFee() {
        return extraFee;
    }

    public void setExtraFee(double extraFee) {
        this.extraFee = extraFee;
    }

    @Override
    public String toString() {
        return "BookingDetails{" + "bookingDetailsId=" + bookingDetailsId + ", bookingId=" + bookingId + ", slotFieldId=" + slotFieldId + ", slotFieldPrice=" + slotFieldPrice + ", extraMinutes=" + extraMinutes + ", extraFee=" + extraFee + '}';
    }

    
}
