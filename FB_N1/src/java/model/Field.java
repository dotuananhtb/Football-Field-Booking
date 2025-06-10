/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import model.*;

/**
 *
 * @author Đỗ Tuấn Anh
 */
public class Field {
    private int fieldId;
    private int zoneId;
    private int fieldTypeId;
    private String fieldName;
    private String image;
    private String status;
    private String description;
    private Zone Zone;
    private TypeOfField TypeOfField;
    private SlotsOfField SlotsOfField;

    public Field(int fieldId, String fieldName, String image, String status, String description, Zone Zone, TypeOfField TypeOfField, SlotsOfField SlotsOfField) {
        this.fieldId = fieldId;
        this.fieldName = fieldName;
        this.image = image;
        this.status = status;
        this.description = description;
        this.Zone = Zone;
        this.TypeOfField = TypeOfField;
        this.SlotsOfField = SlotsOfField;
    }

    public Field(int fieldId, int zoneId, int fieldTypeId, String fieldName, String image, String status, String description) {
        this.fieldId = fieldId;
        this.zoneId = zoneId;
        this.fieldTypeId = fieldTypeId;
        this.fieldName = fieldName;
        this.image = image;
        this.status = status;
        this.description = description;
    }

    public Field() {
    }

    public int getFieldId() {
        return fieldId;
    }

    public void setFieldId(int fieldId) {
        this.fieldId = fieldId;
    }

    public int getZoneId() {
        return zoneId;
    }

    public void setZoneId(int zoneId) {
        this.zoneId = zoneId;
    }

    public int getFieldTypeId() {
        return fieldTypeId;
    }

    public void setFieldTypeId(int fieldTypeId) {
        this.fieldTypeId = fieldTypeId;
    }

    public String getFieldName() {
        return fieldName;
    }

    public void setFieldName(String fieldName) {
        this.fieldName = fieldName;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Zone getZone() {
        return Zone;
    }

    public void setZone(Zone Zone) {
        this.Zone = Zone;
    }

    public TypeOfField getTypeOfField() {
        return TypeOfField;
    }

    public void setTypeOfField(TypeOfField TypeOfField) {
        this.TypeOfField = TypeOfField;
    }

    public SlotsOfField getSlotsOfField() {
        return SlotsOfField;
    }

    public void setSlotsOfField(SlotsOfField SlotsOfField) {
        this.SlotsOfField = SlotsOfField;
    }

//    @Override
//    public String toString() {
//        return "Field{" + "fieldId=" + fieldId + ", zoneId=" + zoneId + ", fieldTypeId=" + fieldTypeId + ", fieldName=" + fieldName + ", image=" + image + ", status=" + status + ", description=" + description + '}';
//    }

    @Override
    public String toString() {
        return "Field{" + "fieldId=" + fieldId + ", zoneId=" + zoneId + ", fieldTypeId=" + fieldTypeId + ", fieldName=" + fieldName + ", image=" + image + ", status=" + status + ", description=" + description + ", Zone=" + Zone + ", TypeOfField=" + TypeOfField + ", SlotsOfField=" + SlotsOfField + '}';
    }
    
    
    
    
}
