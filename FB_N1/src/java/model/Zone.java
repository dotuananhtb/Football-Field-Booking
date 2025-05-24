/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Asus
 */
public class Zone {
    private int zoneId;
    private String address;

    public Zone() {
    }

    public Zone(int zoneId, String address) {
        this.zoneId = zoneId;
        this.address = address;
    }

    public int getZoneId() {
        return zoneId;
    }

    public void setZoneId(int zoneId) {
        this.zoneId = zoneId;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Override
    public String toString() {
        return "Zone{" + "zoneId=" + zoneId + ", address=" + address + '}';
    }
    
}
