package com.servlet;

import com.dao.TherapistRequestDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/owner/reject-therapist")
public class OwnerRejectTherapistServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int therapistId = Integer.parseInt(request.getParameter("therapistId"));
            int salonId = Integer.parseInt(request.getParameter("salonId"));

            TherapistRequestDAO dao = new TherapistRequestDAO();
            dao.rejectRequest(therapistId, salonId);

        } catch (Exception e) {
            e.printStackTrace();
        }

        // 🔥 FIXED REDIRECT
        response.sendRedirect(request.getContextPath()
                + "/owner/therapist-requests.jsp");
    }
}