<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>

<%
    List<Object[]> applications =
        (List<Object[]>) request.getAttribute("applications");
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Applications</title>
</head>
<body>

<h2>My Salon Applications</h2>

<% if (applications == null || applications.isEmpty()) { %>
    <p>You have not applied to any salons yet.</p>
<% } else { %>
    <table border="1" cellpadding="8">
        <tr>
            <th>Salon Name</th>
            <th>City</th>
            <th>Status</th>
            <th>Applied On</th>
        </tr>

        <% for (Object[] row : applications) { %>
        <tr>
            <td><%= row[0] %></td>
            <td><%= row[1] %></td>
            <td><%= row[2] %></td>
            <td><%= row[3] %></td>
        </tr>
        <% } %>
    </table>
<% } %>

</body>
</html>
