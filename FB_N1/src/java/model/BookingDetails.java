/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author VAN NGUYEN
 */


public class BookingDetails {
    private int bookingDetailsId;
    private int bookingId;
    private int slotFieldId;
    private double slotFieldPrice;

    public BookingDetails(int bookingDetailsId, int bookingId, int slotFieldId, double slotFieldPrice) {
        this.bookingDetailsId = bookingDetailsId;
        this.bookingId = bookingId;
        this.slotFieldId = slotFieldId;
        this.slotFieldPrice = slotFieldPrice;
    }

    public BookingDetails() {
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
    
    
    
}
