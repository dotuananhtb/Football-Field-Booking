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
public class BookingDetailsDTO {

    private int bookingDetailsId;
    private String fieldName;
    private String imageUrl;
    private String startTime;
    private String endTime;
    private String slotDate;
    private BigDecimal slotPrice;
    private BigDecimal extraFee;
    private String statusName;
    private int statusId; // Thêm dòng này
    private String note;
    private int extraMinutes;

    public BookingDetailsDTO() {
    }

    public BookingDetailsDTO(int bookingDetailsId, String fieldName, String imageUrl, String startTime,
            String endTime, String slotDate, BigDecimal slotPrice, BigDecimal extraFee,
            String statusName, int statusId, String note, int extraMinutes) {
        this.bookingDetailsId = bookingDetailsId;
        this.fieldName = fieldName;
        this.imageUrl = imageUrl;
        this.startTime = startTime;
        this.endTime = endTime;
        this.slotDate = slotDate;
        this.slotPrice = slotPrice;
        this.extraFee = extraFee;
        this.statusName = statusName;
        this.statusId = statusId;
        this.note = note;
        this.extraMinutes = extraMinutes;
    }

    // Getter & Setter cho statusId
    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    public BigDecimal getTotalPrice() {
        if (slotPrice == null) {
            slotPrice = BigDecimal.ZERO;
        }
        if (extraFee == null) {
            extraFee = BigDecimal.ZERO;
        }
        return slotPrice.add(extraFee);
    }

    public int getBookingDetailsId() {
        return bookingDetailsId;
    }

    public void setBookingDetailsId(int bookingDetailsId) {
        this.bookingDetailsId = bookingDetailsId;
    }

    public String getFieldName() {
        return fieldName;
    }

    public void setFieldName(String fieldName) {
        this.fieldName = fieldName;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
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

    public String getSlotDate() {
        return slotDate;
    }

    public void setSlotDate(String slotDate) {
        this.slotDate = slotDate;
    }

    public BigDecimal getSlotPrice() {
        return slotPrice;
    }

    public void setSlotPrice(BigDecimal slotPrice) {
        this.slotPrice = slotPrice;
    }

    public BigDecimal getExtraFee() {
        return extraFee;
    }

    public void setExtraFee(BigDecimal extraFee) {
        this.extraFee = extraFee;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public int getExtraMinutes() {
        return extraMinutes;
    }

    public void setExtraMinutes(int extraMinutes) {
        this.extraMinutes = extraMinutes;
    }

    @Override
    public String toString() {
        return "BookingDetailsDTO{" + "bookingDetailsId=" + bookingDetailsId + ", fieldName=" + fieldName + ", imageUrl=" + imageUrl + ", startTime=" + startTime + ", endTime=" + endTime + ", slotDate=" + slotDate + ", slotPrice=" + slotPrice + ", extraFee=" + extraFee + ", statusName=" + statusName + ", note=" + note + ", extraMinutes=" + extraMinutes + '}';
    }

}
