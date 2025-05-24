/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Asus
 */
public class TypeOfField {
     private int fieldTypeId;
    private String fieldTypeName;

    public TypeOfField() {
    }

    public TypeOfField(int fieldTypeId, String fieldTypeName) {
        this.fieldTypeId = fieldTypeId;
        this.fieldTypeName = fieldTypeName;
    }

    public int getFieldTypeId() {
        return fieldTypeId;
    }

    public void setFieldTypeId(int fieldTypeId) {
        this.fieldTypeId = fieldTypeId;
    }

    public String getFieldTypeName() {
        return fieldTypeName;
    }

    public void setFieldTypeName(String fieldTypeName) {
        this.fieldTypeName = fieldTypeName;
    }

    @Override
    public String toString() {
        return "TypeOfField{" + "fieldTypeId=" + fieldTypeId + ", fieldTypeName=" + fieldTypeName + '}';
    }
    
}
