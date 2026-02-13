<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.model.Salon" %>
<%@ page import="com.model.Therapist" %>
<%@ page import="com.dao.TherapistDAO" %>
<%@ page import="com.dao.TherapistRequestDAO" %>

<%
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    int userId = (int) session.getAttribute("userId");

    Therapist therapist =
        new TherapistDAO().getTherapistByUserId(userId);

    TherapistRequestDAO requestDAO =
        new TherapistRequestDAO();

    List<Salon> salons =
        (List<Salon>) request.getAttribute("salons");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Browse Salons</title>
</head>
<body>

<h2>Available Salons</h2>

<% if (salons == null || salons.isEmpty()) { %>

    <p>No salons available.</p>

<% } else { %>

<ul>
<% for (Salon s : salons) {

       String status =
           requestDAO.getRequestStatus(
               therapist.getId(), s.getId());
%>

<li style="margin-bottom:12px;">
    <strong><%= s.getName() %></strong>
    (<%= s.getCity() %>)
    - Rating: <%= s.getRating() %>

    <% if (status == null) { %>

        <!-- Apply -->
        <form method="post"
              action="<%=request.getContextPath()%>/therapist/apply-salon"
              style="display:inline; margin-left:10px;">
            <input type="hidden" name="salonId" value="<%=s.getId()%>"/>
            <button type="submit">Apply</button>
        </form>

    <% } else if ("PENDING".equals(status)) { %>

        <span style="color:orange; margin-left:10px;">
            Status: Pending
        </span>

    <% } else if ("REJECTED".equals(status)) { %>

        <span style="color:red; margin-left:10px;">
            Status: Rejected
        </span>

    <% } else if ("APPROVED".equals(status)) { %>

        <span style="color:green; margin-left:10px;">
            Approved (Joined)
        </span>

    <% } %>
</li>

<% } %>
</ul>

<% } %>

</body>
</html>
