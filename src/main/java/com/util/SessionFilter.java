package com.util;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebFilter(urlPatterns = {"/customer/*", "/owner/*", "/therapist/*"})
public class SessionFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // No initialization required
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        HttpSession session = httpRequest.getSession(false);
        String contextPath = httpRequest.getContextPath();
        String uri = httpRequest.getRequestURI();

        // 🔐 Not logged in
        if (session == null || session.getAttribute("userId") == null) {
            httpResponse.sendRedirect(contextPath + "/login.jsp?error=unauthorized");
            return;
        }

        String userRole = (String) session.getAttribute("userRole");

        if (userRole == null) {
            httpResponse.sendRedirect(contextPath + "/login.jsp?error=unauthorized");
            return;
        }

        // 🔒 Customer access
        if (uri.startsWith(contextPath + "/customer/")
                && !"CUSTOMER".equalsIgnoreCase(userRole)) {

            httpResponse.sendRedirect(contextPath + "/login.jsp?error=forbidden");
            return;
        }

        // 🔒 Owner access
        if (uri.startsWith(contextPath + "/owner/")
                && !"OWNER".equalsIgnoreCase(userRole)) {

            httpResponse.sendRedirect(contextPath + "/login.jsp?error=forbidden");
            return;
        }

        // 🔒 Therapist access
        if (uri.startsWith(contextPath + "/therapist/")
                && !"THERAPIST".equalsIgnoreCase(userRole)) {

            httpResponse.sendRedirect(contextPath + "/login.jsp?error=forbidden");
            return;
        }

        // ✅ Authorized
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // No cleanup required
    }
}
