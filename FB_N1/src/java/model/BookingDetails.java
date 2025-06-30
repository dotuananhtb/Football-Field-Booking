/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;

/**
 *
 * @author Đỗ Tuấn Anh
 */
public class BookingDetails {

    private int bookingDetailsId;

    private int bookingId;
    private String bookingDetailsCode;
    private int slotFieldId;
    private BigDecimal slotFieldPrice;
    private int extraMinutes;
    private BigDecimal extraFee;
    private String slotDate;      // Định dạng yyyy-MM-dd
    private String startTime;     // VD: "17:00"
    private String endTime;       // VD: "18:30"
    private String note;
    private int statusCheckingId;

    public BookingDetails(int bookingDetailsId, int bookingId, String bookingDetailsCode, int slotFieldId, BigDecimal slotFieldPrice, int extraMinutes, BigDecimal extraFee, String slotDate, String startTime, String endTime, String note, int statusCheckingId) {
        this.bookingDetailsId = bookingDetailsId;
        this.bookingId = bookingId;
        this.bookingDetailsCode = bookingDetailsCode;
        this.slotFieldId = slotFieldId;
        this.slotFieldPrice = slotFieldPrice;
        this.extraMinutes = extraMinutes;
        this.extraFee = extraFee;
        this.slotDate = slotDate;
        this.startTime = startTime;
        this.endTime = endTime;
        this.note = note;
        this.statusCheckingId = statusCheckingId;
    }

    public String getBookingDetailsCode() {
        return bookingDetailsCode;
    }

    public void setBookingDetailsCode(String bookingDetailsCode) {
        this.bookingDetailsCode = bookingDetailsCode;
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

    public BookingDetails() {
    }

    public BookingDetails(int bookingDetailsId, int bookingId, int slotFieldId, BigDecimal slotFieldPrice, int extraMinutes, BigDecimal extraFee, String slotDate, String note, int statusCheckingId) {
        this.bookingDetailsId = bookingDetailsId;
        this.bookingId = bookingId;
        this.slotFieldId = slotFieldId;
        this.slotFieldPrice = slotFieldPrice;
        this.extraMinutes = extraMinutes;
        this.extraFee = extraFee;
        this.slotDate = slotDate;
        this.note = note;
        this.statusCheckingId = statusCheckingId;
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

    public BigDecimal getSlotFieldPrice() {
        return slotFieldPrice;
    }

    public void setSlotFieldPrice(BigDecimal slotFieldPrice) {
        this.slotFieldPrice = slotFieldPrice;
    }

    public int getExtraMinutes() {
        return extraMinutes;
    }

    public void setExtraMinutes(int extraMinutes) {
        this.extraMinutes = extraMinutes;
    }

    public BigDecimal getExtraFee() {
        return extraFee;
    }

    public void setExtraFee(BigDecimal extraFee) {
        this.extraFee = extraFee;
    }

    public String getSlotDate() {
        return slotDate;
    }

    public void setSlotDate(String slotDate) {
        this.slotDate = slotDate;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public int getStatusCheckingId() {
        return statusCheckingId;
    }

    public void setStatusCheckingId(int statusCheckingId) {
        this.statusCheckingId = statusCheckingId;
    }

    @Override
    public String toString() {
        return "BookingDetails{" + "bookingDetailsId=" + bookingDetailsId + ", bookingId=" + bookingId + ", slotFieldId=" + slotFieldId + ", slotFieldPrice=" + slotFieldPrice + ", extraMinutes=" + extraMinutes + ", extraFee=" + extraFee + ", slotDate=" + slotDate + ", note=" + note + ", statusCheckingId=" + statusCheckingId + '}';
    }

}
