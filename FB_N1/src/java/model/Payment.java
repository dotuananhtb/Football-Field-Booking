package model;

public class Payment {
    private int payId;
    private Integer bookingId;
    private String transactionCode;
    private double transferAmount;
    private String payTime;
    private String confirmedTime;
    private String payStatus;
    private String gateway;
    private String content;
    private String description;
    private String rawData;

    public Payment(int payId, Integer bookingId, String transactionCode, double transferAmount, String payTime, String confirmedTime, String payStatus, String gateway, String content, String description, String rawData) {
        this.payId = payId;
        this.bookingId = bookingId;
        this.transactionCode = transactionCode;
        this.transferAmount = transferAmount;
        this.payTime = payTime;
        this.confirmedTime = confirmedTime;
        this.payStatus = payStatus;
        this.gateway = gateway;
        this.content = content;
        this.description = description;
        this.rawData = rawData;
    }

    public Payment() {
    }

    // Getters & Setters
    public int getPayId() { return payId; }
    public void setPayId(int payId) { this.payId = payId; }

    public Integer getBookingId() { return bookingId; }
    public void setBookingId(Integer bookingId) { this.bookingId = bookingId; }

    public String getTransactionCode() { return transactionCode; }
    public void setTransactionCode(String transactionCode) { this.transactionCode = transactionCode; }

    public double getTransferAmount() { return transferAmount; }
    public void setTransferAmount(double transferAmount) { this.transferAmount = transferAmount; }

    public String getPayTime() { return payTime; }
    public void setPayTime(String payTime) { this.payTime = payTime; }

    public String getConfirmedTime() { return confirmedTime; }
    public void setConfirmedTime(String confirmedTime) { this.confirmedTime = confirmedTime; }

    public String getPayStatus() { return payStatus; }
    public void setPayStatus(String payStatus) { this.payStatus = payStatus; }

    public String getGateway() { return gateway; }
    public void setGateway(String gateway) { this.gateway = gateway; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getRawData() { return rawData; }
    public void setRawData(String rawData) { this.rawData = rawData; }
}
