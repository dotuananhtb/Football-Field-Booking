/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Đỗ Tuấn Anh
 */
public class TypeOfField {

    private int fieldTypeId;
    private String fieldTypeName;

    public TypeOfField() {
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

    public TypeOfField(int fieldTypeId, String fieldTypeName) {
        this.fieldTypeId = fieldTypeId;
        this.fieldTypeName = fieldTypeName;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("TypeOfField{");
        sb.append("fieldTypeId=").append(fieldTypeId);
        sb.append(", fieldTypeName=").append(fieldTypeName);
        sb.append('}');
        return sb.toString();
    }

}
