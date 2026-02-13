package com.servlet;

import com.dao.AppointmentDAO;
import com.dao.TherapistDAO;
import com.model.Appointment;
import com.model.Therapist;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/therapist/schedule")
public class TherapistScheduleServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        // 1️⃣ Therapist info
        TherapistDAO therapistDAO = new TherapistDAO();
        Therapist therapist = therapistDAO.getTherapistByUserId(userId);

        if (therapist == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 2️⃣ Fetch schedule appointments
        AppointmentDAO appointmentDAO = new AppointmentDAO();
        List<Appointment> upcomingAppointments =
                appointmentDAO.getUpcomingAppointments(therapist.getId());

        // 3️⃣ Send to JSP
        request.setAttribute("therapist", therapist);
        request.setAttribute("appointments", upcomingAppointments);

        request.getRequestDispatcher("/therapist/schedule.jsp")
               .forward(request, response);
    }
}
