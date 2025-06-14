/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

/**
 *
 * @author Đỗ Tuấn Anh
 */
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class ToastUtil {

    public static void setSuccessToast(HttpServletRequest request, String message) {
        setToast(request, "success", message);
    }

    public static void setErrorToast(HttpServletRequest request, String message) {
        setToast(request, "error", message);
    }

    public static void setWarningToast(HttpServletRequest request, String message) {
        setToast(request, "warning", message);
    }

    public static void setInfoToast(HttpServletRequest request, String message) {
        setToast(request, "info", message);
    }

    private static void setToast(HttpServletRequest request, String type, String message) {
        HttpSession session = request.getSession();
        session.setAttribute("toastType", type);
        session.setAttribute("toastMessage", message);
    }
}
