package com.servlet;

import com.dao.AppointmentDAO;
import com.dao.TherapistDAO;
import com.model.Appointment;
import com.model.Therapist;
import com.model.Rating;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/therapist/dashboard")
public class TherapistDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        TherapistDAO therapistDAO = new TherapistDAO();
        Therapist therapist = therapistDAO.getTherapistByUserId(userId);

        if (therapist == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        AppointmentDAO appointmentDAO = new AppointmentDAO();

        int todayCount = appointmentDAO.getTodayAppointmentCount(therapist.getId());
        Appointment nextAppointment = appointmentDAO.getNextUpcomingAppointment(therapist.getId());
        double weeklyEarnings = appointmentDAO.getWeeklyEarnings(therapist.getId());
        List<Appointment> todayAppointments = appointmentDAO.getTodayAppointments(therapist.getId());
        List<Appointment> upcomingAppointments = appointmentDAO.getUpcomingAppointments(therapist.getId());

        // 🔥 NEW — get ratings
        List<Rating> ratings = therapistDAO.getRatingsByTherapist(therapist.getId());

        request.setAttribute("therapist", therapist);
        request.setAttribute("todayCount", todayCount);
        request.setAttribute("nextAppointment", nextAppointment);
        request.setAttribute("weeklyEarnings", weeklyEarnings);
        request.setAttribute("todayAppointments", todayAppointments);
        request.setAttribute("upcomingAppointments", upcomingAppointments);

        // 🔥 NEW
        request.setAttribute("ratings", ratings);

        request.getRequestDispatcher("/therapist/dashboard.jsp")
                .forward(request, response);
    }
}
