package com.servlet;

import com.dao.TherapistRequestDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/owner/approve-therapist")
public class OwnerApproveTherapistServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("userId") == null ||
            !"OWNER".equalsIgnoreCase((String) session.getAttribute("userRole"))) {

            response.sendRedirect(request.getContextPath() + "/login.jsp?error=unauthorized");
            return;
        }

        int therapistId = Integer.parseInt(request.getParameter("therapistId"));
        int salonId = Integer.parseInt(request.getParameter("salonId"));

        TherapistRequestDAO dao = new TherapistRequestDAO();

        boolean success = dao.approveRequest(therapistId, salonId);

        if (success) {
            response.sendRedirect(
                request.getContextPath() + "/owner/therapist-requests?success=approved"
            );
        } else {
            response.sendRedirect(
                request.getContextPath() + "/owner/therapist-requests?error=already_joined"
            );
        }
    }
}
