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
public class Booking {

    private int bookingId;
    private int accountId;
    private Integer saleId; // Dữ liệu có thể null
    private String bookingDate;
    private BigDecimal totalAmount;
    private String email;

    public Booking(int bookingId, int accountId, Integer saleId, String bookingDate, BigDecimal totalAmount, String email) {
        this.bookingId = bookingId;
        this.accountId = accountId;
        this.saleId = saleId;
        this.bookingDate = bookingDate;
        this.totalAmount = totalAmount;
        this.email = email;
    }

    // Getters & Setters
    public Booking() {
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public Integer getSaleId() {
        return saleId;
    }

    public void setSaleId(Integer saleId) {
        this.saleId = saleId;
    }

    public String getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(String bookingDate) {
        this.bookingDate = bookingDate;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public String toString() {
        return "Booking{" + "bookingId=" + bookingId + ", accountId=" + accountId + ", saleId=" + saleId + ", bookingDate=" + bookingDate + ", totalAmount=" + totalAmount + ", email=" + email + '}';
    }

}
