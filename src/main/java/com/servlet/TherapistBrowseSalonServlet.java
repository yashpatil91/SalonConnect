package com.servlet;

import com.dao.SalonDAO;
import com.dao.TherapistDAO;
import com.model.Salon;
import com.model.Therapist;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/therapist/browse-salons")
public class TherapistBrowseSalonServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1️⃣ Session & role validation
        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("userId") == null ||
            !"THERAPIST".equalsIgnoreCase(
                String.valueOf(session.getAttribute("userRole")))) {

            response.sendRedirect(
                request.getContextPath() + "/login.jsp?error=unauthorized");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        // 2️⃣ Load therapist profile
        Therapist therapist =
            new TherapistDAO().getTherapistByUserId(userId);

        if (therapist == null) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp?error=forbidden");
            return;
        }

        // 🔴 👉 PASTE THE BLOCK RIGHT HERE 👇
        // ==================================
        if (therapist.getSalonId() != null &&
            therapist.getSalonId() > 0) {

            response.sendRedirect(
                request.getContextPath()
                + "/therapist/dashboard.jsp?joined=true");
            return;
        }
        // ==================================

        // 3️⃣ Fetch salons
        List<Salon> salons =
            new SalonDAO().getAllSalons();

        request.setAttribute("salons", salons);

        // 4️⃣ Forward to JSP
        request.getRequestDispatcher(
            "/therapist/browse_salons.jsp")
            .forward(request, response);
    }
}
