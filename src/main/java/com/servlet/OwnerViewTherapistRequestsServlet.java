package com.servlet;

import com.dao.TherapistRequestDAO;
import com.model.Therapist;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/owner/therapist-requests")
public class OwnerViewTherapistRequestsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            !"OWNER".equalsIgnoreCase((String) session.getAttribute("userRole"))) {

            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int ownerId = (int) session.getAttribute("userId");

        TherapistRequestDAO dao = new TherapistRequestDAO();
        List<Therapist> requests = dao.getPendingRequestsForOwner(ownerId);

        request.setAttribute("requests", requests);
        request.getRequestDispatcher("/owner/view-therapists.jsp")
               .forward(request, response);
    }
}
