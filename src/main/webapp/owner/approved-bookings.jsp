<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.dao.DBConnection"%>

<%
if (session == null || session.getAttribute("userId") == null) {
	response.sendRedirect(request.getContextPath() + "/login.jsp");
	return;
}
String userName = (String) session.getAttribute("userName");
int ownerId = (int) session.getAttribute("userId");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Approved Bookings - SalonConnect</title>

<script src="https://cdn.tailwindcss.com?plugins=forms,typography"></script>
<link
	href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Lato:wght@300;400;700&display=swap"
	rel="stylesheet" />
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet" />
<link rel="icon" type="image/png" href="<%= request.getContextPath() %>/images/icon.jpeg">
<script>
	tailwind.config = {
		darkMode : "class",
		theme : {
			extend : {
				colors : {
					primary : "#D8A48F",
					"background-light" : "#FDFBF7",
					"background-dark" : "#1F1B1A",
					"surface-light" : "#FFFFFF",
					"surface-dark" : "#2D2625"
				},
				fontFamily : {
					display : [ "Playfair Display", "serif" ],
					body : [ "Lato", "sans-serif" ]
				}
			}
		}
	}
</script>

<style>
body {
	font-family: 'Lato', sans-serif;
}

h1, h2, h3, h4 {
	font-family: 'Playfair Display', serif;
}
</style>
</head>

<body class="bg-background-light dark:bg-background-dark text-gray-800 dark:text-gray-200 transition-colors duration-300 overflow-x-hidden">


<!-- NAVBAR -->
<nav class="sticky top-0 z-50 bg-surface-light/90 dark:bg-surface-dark/90 backdrop-blur border-b shadow-sm">
    <div class="max-w-7xl mx-auto px-6 h-20 flex justify-between items-center">
        <div class="flex items-center">
            <span class="material-icons text-primary text-3xl mr-2">spa</span>
		    <a href="<%= request.getContextPath() %>/index.jsp"
						   class="font-display font-bold text-2xl text-gray-900 dark:text-white">
						   SalonConnect
						</a>
        </div>
        <div class="flex items-center space-x-4">
            <a href="dashboard.jsp" class="hover:text-primary">Dashboard</a>
            <a href="view-bookings.jsp" class="hover:text-primary">Pending</a>
            <span><%= userName %></span>
            <a href="<%=request.getContextPath()%>/logout"
               class="bg-red-500 text-white px-4 py-2 rounded-full text-sm font-bold hover:bg-red-600">
                Logout
            </a>
        </div>
    </div>
</nav>

	


	<!-- CONTENT -->
	<div class="max-w-7xl mx-auto px-6 py-10">
		<h1 class="text-4xl font-bold mb-8">Approved Bookings</h1>

		<div class="space-y-6">

			<%
			Connection con = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			boolean hasData = false;

			try {
				con = DBConnection.getConnection();
				String sql = "SELECT a.*, u.name customer_name, u.email, s.name salon_name, "
				+ "srv.name service_name, t.name therapist_name " + "FROM appointments a "
				+ "JOIN users u ON a.user_id = u.id " + "JOIN salons s ON a.salon_id = s.id "
				+ "JOIN services srv ON a.service_id = srv.id " + "JOIN therapists t ON a.therapist_id = t.id "
				+ "WHERE s.owner_id = ? AND a.status = 'APPROVED' "
				+ "ORDER BY a.appointment_date DESC, a.appointment_time";

				ps = con.prepareStatement(sql);
				ps.setInt(1, ownerId);
				rs = ps.executeQuery();

				while (rs.next()) {
					hasData = true;
			%>

			<div
				class="bg-surface-light dark:bg-surface-dark p-6 rounded-2xl shadow border">
				<div class="flex justify-between items-center mb-4">
					<div>
						<h3 class="text-xl font-bold"><%=rs.getString("customer_name")%></h3>
						<p class="text-sm text-gray-500"><%=rs.getString("email")%></p>
					</div>
					<span
						class="px-4 py-2 rounded-full bg-green-100 text-green-800 text-sm font-bold">
						APPROVED </span>
				</div>

				<div class="grid grid-cols-1 md:grid-cols-4 gap-4">
					<div>
						<p class="text-xs text-gray-500">Salon</p>
						<p class="font-bold"><%=rs.getString("salon_name")%></p>
					</div>
					<div>
						<p class="text-xs text-gray-500">Service</p>
						<p class="font-bold"><%=rs.getString("service_name")%></p>
					</div>
					<div>
						<p class="text-xs text-gray-500">Therapist</p>
						<p class="font-bold"><%=rs.getString("therapist_name")%></p>
					</div>
					<div>
						<p class="text-xs text-gray-500">Date & Time</p>
						<p class="font-bold">
							<%=rs.getDate("appointment_date")%>
							at
							<%=rs.getTime("appointment_time")%>
						</p>
					</div>
				</div>
				<!-- this is the complete booking button -->
				<form
					action="<%=request.getContextPath()%>/owner/completeAppointment"
					method="post" class="mt-4 text-right">

					<input type="hidden" name="appointmentId"
						value="<%=rs.getInt("id")%>" />

					<button type="submit"
						class="px-4 py-2 rounded-full bg-blue-600 text-white text-sm font-bold hover:bg-blue-700">
						Mark Completed</button>
				</form>

			</div>
			<%
			}

			if (!hasData) {
			%>
			<div class="text-center py-16">
				<span class="material-icons text-6xl text-gray-300 mb-4">event_available</span>
				<p class="text-lg text-gray-500">No approved bookings yet</p>
			</div>
			<%
			}
			} catch (Exception e) {
			e.printStackTrace();
			%>
			<div class="bg-red-100 text-red-700 p-4 rounded-lg">Error
				loading approved bookings.</div>
			<%
			} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception ignored) {
			}
			try {
				if (ps != null)
					ps.close();
			} catch (Exception ignored) {
			}
			try {
				if (con != null)
					con.close();
			} catch (Exception ignored) {
			}
			}
			%>

		</div>
	</div>
</body>
</html>
