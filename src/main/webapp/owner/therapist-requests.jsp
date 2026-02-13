<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.dao.TherapistRequestDAO" %>
<%@ page import="com.model.Therapist" %>

<%
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    int ownerId = (int) session.getAttribute("userId");

    TherapistRequestDAO dao = new TherapistRequestDAO();
    List<Therapist> requests = dao.getPendingRequestsForOwner(ownerId);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Therapist Requests</title>
</head>
<body>

<h2>Pending Therapist Requests</h2>

<% if (requests.isEmpty()) { %>
    <p>No pending requests.</p>
<% } else { %>

<table border="1" cellpadding="8">
    <tr>
        <th>Therapist Name</th>
        <th>Specialization</th>
        <th>Experience</th>
        <th>Action</th>
    </tr>

    <% for (Therapist t : requests) { %>
    <tr>
        <td><%= t.getName() %></td>
        <td><%= t.getSpecialization() %></td>
        <td><%= t.getExperience() %> yrs</td>
        <td>
            <form action="<%=request.getContextPath()%>/owner/approve-therapist" method="post" style="display:inline;">
                <input type="hidden" name="therapistId" value="<%= t.getId() %>">
                <input type="hidden" name="salonId" value="<%= t.getSalonId() %>">
                <button type="submit">Approve</button>
            </form>

            <form action="<%=request.getContextPath()%>/owner/reject-therapist" method="post" style="display:inline;">
                <input type="hidden" name="therapistId" value="<%= t.getId() %>">
                <input type="hidden" name="salonId" value="<%= t.getSalonId() %>">
                <button type="submit">Reject</button>
            </form>
        </td>
    </tr>
    <% } %>
</table>

<% } %>

</body>
</html>
