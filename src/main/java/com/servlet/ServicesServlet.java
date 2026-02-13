package com.servlet;

import com.model.ServiceDAO;
import com.model.Service;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/services")
public class ServicesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Call DAO
        List<Service> services = ServiceDAO.getAllServices();

        // 2. Send data to JSP
        request.setAttribute("services", services);

        // 3. Forward to JSP
        request.getRequestDispatcher("services.jsp").forward(request, response);
    }
}
