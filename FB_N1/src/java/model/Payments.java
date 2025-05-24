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
import java.util.Date;

public class Payments {
    private int payId;
    private int bookingId;
    private Date payTime;
    private Date confirmedTime;
    private String payStatus;
    private BigDecimal amountPay;
    private String qrCodeUrl;
    private String description;
    private String transactionCode;

    public Payments(int payId, int bookingId, Date payTime, Date confirmedTime, String payStatus, BigDecimal amountPay, String qrCodeUrl, String description, String transactionCode) {
        this.payId = payId;
        this.bookingId = bookingId;
        this.payTime = payTime;
        this.confirmedTime = confirmedTime;
        this.payStatus = payStatus;
        this.amountPay = amountPay;
        this.qrCodeUrl = qrCodeUrl;
        this.description = description;
        this.transactionCode = transactionCode;
    }

    public Payments() {
    }

    public int getPayId() {
        return payId;
    }

    public void setPayId(int payId) {
        this.payId = payId;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public Date getPayTime() {
        return payTime;
    }

    public void setPayTime(Date payTime) {
        this.payTime = payTime;
    }

    public Date getConfirmedTime() {
        return confirmedTime;
    }

    public void setConfirmedTime(Date confirmedTime) {
        this.confirmedTime = confirmedTime;
    }

    public String getPayStatus() {
        return payStatus;
    }

    public void setPayStatus(String payStatus) {
        this.payStatus = payStatus;
    }

    public BigDecimal getAmountPay() {
        return amountPay;
    }

    public void setAmountPay(BigDecimal amountPay) {
        this.amountPay = amountPay;
    }

    public String getQrCodeUrl() {
        return qrCodeUrl;
    }

    public void setQrCodeUrl(String qrCodeUrl) {
        this.qrCodeUrl = qrCodeUrl;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTransactionCode() {
        return transactionCode;
    }

    public void setTransactionCode(String transactionCode) {
        this.transactionCode = transactionCode;
    }
    
    
    
    
}
