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
public class BookingSlotInfo {

    private int bookingDetailsId;
    private int bookingId;
    private String bookingDate;
    private String slotDate;
    private String startTime;
    private String endTime;
    private String fieldName;
    private String fieldTypeName;
    private BigDecimal slotFieldPrice;
    private String slotStatus;
    private String customerName;
    private String phone;
    private String email;
    private String note;

    public BookingSlotInfo() {
    }

    public BookingSlotInfo(int bookingDetailsId, int bookingId, String bookingDate, String slotDate, String startTime, String endTime, String fieldName, String fieldTypeName, BigDecimal slotFieldPrice, String slotStatus, String customerName, String phone, String email, String note) {
        this.bookingDetailsId = bookingDetailsId;
        this.bookingId = bookingId;
        this.bookingDate = bookingDate;
        this.slotDate = slotDate;
        this.startTime = startTime;
        this.endTime = endTime;
        this.fieldName = fieldName;
        this.fieldTypeName = fieldTypeName;
        this.slotFieldPrice = slotFieldPrice;
        this.slotStatus = slotStatus;
        this.customerName = customerName;
        this.phone = phone;
        this.email = email;
        this.note = note;
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

    public String getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(String bookingDate) {
        this.bookingDate = bookingDate;
    }

    public String getSlotDate() {
        return slotDate;
    }

    public void setSlotDate(String slotDate) {
        this.slotDate = slotDate;
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

    public String getFieldName() {
        return fieldName;
    }

    public void setFieldName(String fieldName) {
        this.fieldName = fieldName;
    }

    public String getFieldTypeName() {
        return fieldTypeName;
    }

    public void setFieldTypeName(String fieldTypeName) {
        this.fieldTypeName = fieldTypeName;
    }

    public BigDecimal getSlotFieldPrice() {
        return slotFieldPrice;
    }

    public void setSlotFieldPrice(BigDecimal slotFieldPrice) {
        this.slotFieldPrice = slotFieldPrice;
    }

    public String getSlotStatus() {
        return slotStatus;
    }

    public void setSlotStatus(String slotStatus) {
        this.slotStatus = slotStatus;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = (phone == null) ? "" : phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = (note == null) ? "" : note;
    }

    @Override
    public String toString() {
        return "BookingSlotInfo{" + "bookingDetailsId=" + bookingDetailsId + ", bookingId=" + bookingId + ", bookingDate=" + bookingDate + ", slotDate=" + slotDate + ", startTime=" + startTime + ", endTime=" + endTime + ", fieldName=" + fieldName + ", fieldTypeName=" + fieldTypeName + ", slotFieldPrice=" + slotFieldPrice + ", slotStatus=" + slotStatus + ", customerName=" + customerName + ", phone=" + phone + ", email=" + email + ", note=" + note + '}';
    }

}
