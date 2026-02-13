<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.dao.DBConnection" %>
<%
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    String userName = (String) session.getAttribute("userName");
    int userId = (int) session.getAttribute("userId");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>My Appointments - SalonConnect</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,typography"></script>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Lato:wght@300;400;700&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
    <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/images/icon.jpeg">
    <script>
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        primary: "#D8A48F",
                        secondary: "#8FBC8F",
                        "background-light": "#FDFBF7",
                        "background-dark": "#1F1B1A",
                        "surface-light": "#FFFFFF",
                        "surface-dark": "#2D2625",
                    },
                    fontFamily: {
                        display: ["Playfair Display", "serif"],
                        body: ["Lato", "sans-serif"],
                    },
                },
            },
        };
    </script>
    <style>
        body { font-family: 'Lato', sans-serif; }
        h1, h2, h3, h4, h5, h6 { font-family: 'Playfair Display', serif; }
    </style>
</head>
<body class="bg-background-light dark:bg-background-dark text-gray-800 dark:text-gray-200 transition-colors duration-300 overflow-x-hidden">

<nav class="sticky top-0 z-50 bg-surface-light/90 dark:bg-surface-dark/90 backdrop-blur-md border-b border-gray-100 dark:border-gray-800 shadow-sm">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-20 items-center">
            <div class="flex items-center">
                <span class="material-icons text-primary text-3xl mr-2">spa</span>
				<a href="<%= request.getContextPath() %>/index.jsp"
						   class="font-display font-bold text-2xl text-gray-900 dark:text-white">
						   SalonConnect
						</a>

            </div>
            <div class="flex items-center space-x-4">
                <a href="dashboard.jsp" class="text-gray-600 dark:text-gray-300 hover:text-primary">Dashboard</a>
                <a href="search-salon.jsp" class="text-gray-600 dark:text-gray-300 hover:text-primary">Search</a>
                <span class="text-gray-600 dark:text-gray-300"><%= userName %></span>
                <button class="p-2 rounded-full hover:bg-gray-100 dark:hover:bg-gray-700" id="theme-toggle">
                    <span class="material-icons">brightness_4</span>
                </button>
                <a href="<%= request.getContextPath() %>/logout" class="px-4 py-2 rounded-full text-sm font-bold text-white bg-red-500 hover:bg-red-600">Logout</a>
            </div>
        </div>
    </div>
</nav>

<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
    <h1 class="text-4xl font-display font-bold text-gray-900 dark:text-white mb-8">My Appointments</h1>

	
    <% if ("booked".equals(request.getParameter("success"))) { %>
        <div class="mb-4 bg-green-50 dark:bg-green-900/20 border border-green-200 dark:border-green-800 text-green-800 dark:text-green-200 px-4 py-3 rounded-lg">
            Appointment booked successfully! Waiting for salon approval.
        </div>
    <% } %>
    
    <% if ("deleted".equals(request.getParameter("success"))) { %>
    <div class="mb-4 bg-green-50 dark:bg-green-900/20 border border-green-200 dark:border-green-800
                text-green-800 dark:text-green-200 px-4 py-3 rounded-lg">
        Appointment cancelled successfully.
    </div>
    <% } %>
    

    <div class="space-y-4">
        <%
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                con = DBConnection.getConnection();
                String sql = "SELECT a.*, " +
                        "s.name as salon_name, s.address, s.city, " +
                        "srv.name as service_name, srv.price, " +
                        "t.name as therapist_name, " +
                        "r.id as rating_id " +
                        "FROM appointments a " +
                        "LEFT JOIN ratings r ON a.id = r.appointment_id " +
                        "JOIN salons s ON a.salon_id = s.id " +
                        "JOIN services srv ON a.service_id = srv.id " +
                        "JOIN therapists t ON a.therapist_id = t.id " +
                        "WHERE a.user_id = ? " +
                        "ORDER BY a.appointment_date DESC, a.appointment_time DESC";

                ps = con.prepareStatement(sql);
                ps.setInt(1, userId);
                rs = ps.executeQuery();

                while (rs.next()) {
                    int appointmentId = rs.getInt("id");
                    String salonName = rs.getString("salon_name");
                    String city = rs.getString("city");
                    String serviceName = rs.getString("service_name");
                    double price = rs.getDouble("price");
                    String therapistName = rs.getString("therapist_name");
                    Date appointmentDate = rs.getDate("appointment_date");
                    Time appointmentTime = rs.getTime("appointment_time");
                    Time endTime = rs.getTime("end_time");
                    String status = rs.getString("status");
                    Integer ratingId = (Integer) rs.getObject("rating_id");

                    
                    String statusColor = "";
                    String statusIcon = "";
                    
                    switch (status) {
                        case "PENDING":
                            statusColor = "bg-orange-100 dark:bg-orange-900/30 text-orange-800 dark:text-orange-200 border-orange-200 dark:border-orange-800";
                            statusIcon = "schedule";
                            break;
                        case "APPROVED":
                            statusColor = "bg-green-100 dark:bg-green-900/30 text-green-800 dark:text-green-200 border-green-200 dark:border-green-800";
                            statusIcon = "check_circle";
                            break;
                        case "REJECTED":
                            statusColor = "bg-red-100 dark:bg-red-900/30 text-red-800 dark:text-red-200 border-red-200 dark:border-red-800";
                            statusIcon = "cancel";
                            break;
                        case "COMPLETED":
                            statusColor = "bg-blue-100 dark:bg-blue-900/30 text-blue-800 dark:text-blue-200 border-blue-200 dark:border-blue-800";
                            statusIcon = "done_all";
                            break;
                        default:
                            statusColor = "bg-gray-100 dark:bg-gray-800 text-gray-800 dark:text-gray-200 border-gray-200 dark:border-gray-700";
                            statusIcon = "info";
                    }
        %>
        <div class="bg-surface-light dark:bg-surface-dark rounded-2xl p-6 border border-gray-100 dark:border-gray-800 shadow-lg">
            <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-4">
                <div>
                    <h3 class="text-xl font-bold text-gray-900 dark:text-white mb-1"><%= salonName %></h3>
                    <p class="text-gray-500 dark:text-gray-400 text-sm flex items-center">
                        <span class="material-icons text-sm mr-1">place</span> <%= city %>
                    </p>
                </div>
                <div class="<%= statusColor %> px-4 py-2 rounded-full border flex items-center mt-2 md:mt-0">
                    <span class="material-icons text-sm mr-1"><%= statusIcon %></span>
                    <span class="font-bold text-sm"><%= status %></span>
                </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-4">
                <div>
                    <p class="text-xs text-gray-500 dark:text-gray-400 mb-1">Service</p>
                    <p class="font-bold text-gray-900 dark:text-white"><%= serviceName %></p>
                </div>
                <div>
                    <p class="text-xs text-gray-500 dark:text-gray-400 mb-1">Therapist</p>
                    <p class="font-bold text-gray-900 dark:text-white"><%= therapistName %></p>
                </div>
                <div>
                    <p class="text-xs text-gray-500 dark:text-gray-400 mb-1">Date & Time</p>
                    <p class="font-bold text-gray-900 dark:text-white"><%= appointmentDate %> at <%= appointmentTime %></p>
                </div>
                <div>
                    <p class="text-xs text-gray-500 dark:text-gray-400 mb-1">Price</p>
                    <p class="font-bold text-gray-900 dark:text-white">₹<%= String.format("%.2f", price) %></p>
                </div>
            </div>
     <!-- Delete Section -->
			<% if ("PENDING".equals(status) || "APPROVED".equals(status)) { %>
			    <div class="flex justify-end mt-4">
			        <form action="<%= request.getContextPath() %>/deleteAppointment"
			              method="post"
			              onsubmit="return confirm('Are you sure you want to cancel this appointment?');">
			            
			            <input type="hidden" name="appointmentId" value="<%= appointmentId %>">
			            
			            <button type="submit"
			                    class="px-4 py-2 rounded-full bg-red-500 text-white hover:bg-red-600 transition text-sm font-bold flex items-center">
			                <span class="material-icons text-sm mr-1">cancel</span>
			                Cancel Appointment
			            </button>
			        </form>
			    </div>
			<% } %>


        <!-- Rating Section -->
        <% if ("COMPLETED".equals(status) && ratingId == null) { %>

    <div class="flex justify-end">
        <a href="add-rating.jsp?appointmentId=<%= appointmentId %>"
           class="px-4 py-2 rounded-full font-bold text-white bg-primary hover:bg-opacity-90 transition text-sm flex items-center">
            <span class="material-icons text-sm mr-1">star</span>
            Rate Service
        </a>
    </div>

    <% } else if ("COMPLETED".equals(status) && ratingId != null) { %>

    <div class="flex justify-end">
        <span class="text-green-600 font-bold flex items-center">
            <span class="material-icons text-sm mr-1">check_circle</span>
            Rated
        </span>
    </div>

   <% } %>
        
 </div>
        
        <%
                }

                if (!rs.isBeforeFirst()) {
        %>
        <div class="text-center py-12">
            <span class="material-icons text-gray-300 dark:text-gray-600 text-6xl mb-4">event</span>
            <p class="text-gray-500 dark:text-gray-400 text-lg mb-4">No appointments yet</p>
            <a href="search-salon.jsp" class="inline-block px-6 py-3 rounded-full font-bold text-white bg-primary hover:bg-opacity-90 transition shadow-lg">
                Book Your First Appointment
            </a>
        </div>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
        %>
        <div class="bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-800 dark:text-red-200 px-4 py-3 rounded-lg">
            Error loading appointments. Please try again.
        </div>
        <%
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception ignored) {}
                try { if (ps != null) ps.close(); } catch (Exception ignored) {}
                try { if (con != null) con.close(); } catch (Exception ignored) {}
            }
        %>
    </div>
</div>

<script>
    setTimeout(() => {
        const msg = document.getElementById("flashMessage");
        if (msg) {
            msg.style.transition = "opacity 0.5s ease";
            msg.style.opacity = "0";
            setTimeout(() => msg.remove(), 500);
        }
    }, 2000); // 2 seconds
</script>
<script>
        const themeToggleBtn = document.getElementById('theme-toggle');
        const darkIcon = '<span class="material-icons">dark_mode</span>';
        const lightIcon = '<span class="material-icons">light_mode</span>';
        // Check local storage or system preference
        if (localStorage.getItem('color-theme') === 'dark' || (!('color-theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
            document.documentElement.classList.add('dark');
            themeToggleBtn.innerHTML = lightIcon;
        } else {
            document.documentElement.classList.remove('dark');
            themeToggleBtn.innerHTML = darkIcon;
        }
        themeToggleBtn.addEventListener('click', function() {
            // if set via local storage previously
            if (localStorage.getItem('color-theme')) {
                if (localStorage.getItem('color-theme') === 'light') {
                    document.documentElement.classList.add('dark');
                    localStorage.setItem('color-theme', 'dark');
                    this.innerHTML = lightIcon;
                } else {
                    document.documentElement.classList.remove('dark');
                    localStorage.setItem('color-theme', 'light');
                    this.innerHTML = darkIcon;
                }
            } else {
                // if NOT set via local storage previously
                if (document.documentElement.classList.contains('dark')) {
                    document.documentElement.classList.remove('dark');
                    localStorage.setItem('color-theme', 'light');
                    this.innerHTML = darkIcon;
                } else {
                    document.documentElement.classList.add('dark');
                    localStorage.setItem('color-theme', 'dark');
                    this.innerHTML = lightIcon;
                }
            }
        });
    </script>



</body>
</html>