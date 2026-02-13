package com.servlet;

import com.dao.TherapistDAO;
import com.dao.TherapistRequestDAO;
import com.model.Therapist;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/therapist/my-applications")
public class TherapistApplicationsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("userId") == null ||
            !"THERAPIST".equalsIgnoreCase(
                String.valueOf(session.getAttribute("userRole")))) {

            response.sendRedirect(
                request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        Therapist therapist =
            new TherapistDAO().getTherapistByUserId(userId);

        TherapistRequestDAO dao = new TherapistRequestDAO();

        request.setAttribute(
            "applications",
            dao.getApplicationsForTherapist(therapist.getId())
        );

        request.getRequestDispatcher(
            "/therapist/my_applications.jsp")
            .forward(request, response);
    }
}
