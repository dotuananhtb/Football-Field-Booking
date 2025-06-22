/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Đỗ Tuấn Anh
 */
public class OfflineCustomer {

    private int bookingId;
    private int offlineUserId;

    public OfflineCustomer() {
    }

    public OfflineCustomer(int bookingId, int offlineUserId) {
        this.bookingId = bookingId;
        this.offlineUserId = offlineUserId;
    }

    @Override
    public String toString() {
        return super.toString(); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getOfflineUserId() {
        return offlineUserId;
    }

    public void setOfflineUserId(int offlineUserId) {
        this.offlineUserId = offlineUserId;
    }

   

}
