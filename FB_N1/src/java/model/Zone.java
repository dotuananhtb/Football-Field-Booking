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
    private String zone_name;
    private String address;
    private int status;
    private StatusZone status_id;
    public Zone() {
    }

    public Zone(int zoneId, String zone_name, String address, int status) {
        this.zoneId = zoneId;
        this.zone_name = zone_name;
        this.address = address;
        this.status = status;
    }

    public Zone(int zoneId, String zone_name, String address, int status, StatusZone status_id) {
        this.zoneId = zoneId;
        this.zone_name = zone_name;
        this.address = address;
        this.status = status;
        this.status_id = status_id;
    }

    public Zone(String zone_name, String address, int status) {
        this.zone_name = zone_name;
        this.address = address;
        this.status = status;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public StatusZone getStatus_id() {
        return status_id;
    }

    public void setStatus_id(StatusZone status_id) {
        this.status_id = status_id;
    }

    

   

    

    public int getZoneId() {
        return zoneId;
    }

    public void setZoneId(int zoneId) {
        this.zoneId = zoneId;
    }

    public String getZone_name() {
        return zone_name;
    }

    public void setZone_name(String zone_name) {
        this.zone_name = zone_name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Override
    public String toString() {
        return "Zone{" + "zoneId=" + zoneId + ", zone_name=" + zone_name + ", address=" + address + ", status=" + status + '}';
    }

    

   

}
