package com.servlet;

import com.dao.TherapistDAO;
import com.dao.TherapistRequestDAO;
import com.model.Therapist;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/therapist/apply-salon")
public class ApplySalonServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // 🔐 Security check
        if (session == null ||
            session.getAttribute("userId") == null ||
            !"THERAPIST".equalsIgnoreCase((String) session.getAttribute("userRole"))) {

            response.sendRedirect(request.getContextPath() + "/login.jsp?error=unauthorized");
            return;
        }

        int salonId = Integer.parseInt(request.getParameter("salonId"));
        int userId = (int) session.getAttribute("userId");

        TherapistDAO therapistDAO = new TherapistDAO();
        Therapist therapist = therapistDAO.getTherapistByUserId(userId);

        if (therapist == null) {
            response.sendRedirect(request.getContextPath() + "/therapist/dashboard.jsp");
            return;
        }

        // 🚫 BLOCK if already approved in any salon
        if (therapist.getSalonId() != null ||
            "APPROVED".equalsIgnoreCase(therapist.getStatus())) {

            response.sendRedirect(
                request.getContextPath() + "/therapist/browse-salons?error=already_assigned"
            );
            return;
        }

        TherapistRequestDAO requestDAO = new TherapistRequestDAO();

        // 🔒 Block duplicate apply to SAME salon
        if (requestDAO.hasExistingRequest(therapist.getId(), salonId)) {
            response.sendRedirect(
                request.getContextPath() + "/therapist/browse-salons?error=already_applied"
            );
            return;
        }

        // ✅ Safe apply
        requestDAO.createRequest(therapist.getId(), salonId);

        response.sendRedirect(
            request.getContextPath() + "/therapist/browse-salons?success=applied"
        );
    }
}
