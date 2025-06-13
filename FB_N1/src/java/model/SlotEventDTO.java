/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Đỗ Tuấn Anh
 */
public class SlotEventDTO {

    private int id;
    private String title;
    private String start;
    private String end;
    private String status; // VD: "booked", "available", "pending", "cancelled", "maintenance"
    private String color;  // FullCalendar dùng để phân biệt màu
    private String description; // (tuỳ chọn) tooltip hoặc chi tiết hiển thị
    private String slotDate;

    public SlotEventDTO() {
    }

    public SlotEventDTO(int id, String title, String start, String end, String status, String color, String description) {
        this.id = id;
        this.title = title;
        this.start = start;
        this.end = end;
        this.status = status;
        this.color = color;
        this.description = description;
    }

    public String getSlotDate() {
        return slotDate;
    }

    public void setSlotDate(String slotDate) {
        this.slotDate = slotDate;
    }

    public SlotEventDTO(int id, String title, String start, String end, String status, String color, String description, String slotDate) {
        this.id = id;
        this.title = title;
        this.start = start;
        this.end = end;
        this.status = status;
        this.color = color;
        this.description = description;
        this.slotDate = slotDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getStart() {
        return start;
    }

    public void setStart(String start) {
        this.start = start;
    }

    public String getEnd() {
        return end;
    }

    public void setEnd(String end) {
        this.end = end;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "SlotEventDTO{" + "id=" + id + ", title=" + title + ", start=" + start + ", end=" + end + ", status=" + status + ", color=" + color + ", description=" + description + '}';
    }

}
