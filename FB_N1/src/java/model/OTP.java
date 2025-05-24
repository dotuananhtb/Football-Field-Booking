/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.util.Date;

/**
 *
 * @author Asus
 */
public class OTP {
    private int otpId;
    private int accountId;
    private String otp;
    private Date otpDate;

    public OTP() {
    }

    public OTP(int otpId, int accountId, String otp, Date otpDate) {
        this.otpId = otpId;
        this.accountId = accountId;
        this.otp = otp;
        this.otpDate = otpDate;
    }

    public int getOtpId() {
        return otpId;
    }

    public void setOtpId(int otpId) {
        this.otpId = otpId;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public String getOtp() {
        return otp;
    }

    public void setOtp(String otp) {
        this.otp = otp;
    }

    public Date getOtpDate() {
        return otpDate;
    }

    public void setOtpDate(Date otpDate) {
        this.otpDate = otpDate;
    }

    @Override
    public String toString() {
        return "OTP{" + "otpId=" + otpId + ", accountId=" + accountId + ", otp=" + otp + ", otpDate=" + otpDate + '}';
    }
    
}
