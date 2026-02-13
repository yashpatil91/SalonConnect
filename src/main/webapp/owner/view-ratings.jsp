<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.dao.DBConnection" %>
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
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>View Ratings - SalonConnect</title>
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
    <h1 class="text-4xl font-display font-bold text-gray-900 dark:text-white mb-8">Customer Ratings & Reviews</h1>

    <div class="space-y-6">
        <%
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                con = DBConnection.getConnection();
                String sql = "SELECT r.*, u.name as customer_name, s.name as salon_name, " +
                            "t.name as therapist_name, srv.name as service_name " +
                            "FROM ratings r " +
                            "JOIN users u ON r.user_id = u.id " +
                            "JOIN salons s ON r.salon_id = s.id " +
                            "JOIN therapists t ON r.therapist_id = t.id " +
                            "JOIN appointments a ON r.appointment_id = a.id " +
                            "JOIN services srv ON a.service_id = srv.id " +
                            "WHERE s.owner_id = ? " +
                            "ORDER BY r.created_at DESC";
                ps = con.prepareStatement(sql);
                ps.setInt(1, ownerId);
                rs = ps.executeQuery();

                while (rs.next()) {
                    String customerName = rs.getString("customer_name");
                    String salonName = rs.getString("salon_name");
                    String therapistName = rs.getString("therapist_name");
                    String serviceName = rs.getString("service_name");
                    int rating = rs.getInt("rating");
                    String review = rs.getString("review");
                    Timestamp createdAt = rs.getTimestamp("created_at");
        %>
        <div class="bg-surface-light dark:bg-surface-dark rounded-2xl p-6 border border-gray-100 dark:border-gray-800 shadow-lg">
            <div class="flex justify-between items-start mb-4">
                <div>
                    <h3 class="text-xl font-bold text-gray-900 dark:text-white mb-1"><%= customerName %></h3>
                    <p class="text-sm text-gray-500 dark:text-gray-400"><%= createdAt %></p>
                </div>
                <div class="flex items-center bg-yellow-100 dark:bg-yellow-900/30 px-3 py-1 rounded-full">
                    <span class="material-icons text-yellow-400 text-sm mr-1">star</span>
                    <span class="font-bold text-gray-800 dark:text-white"><%= rating %>/5</span>
                </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-4">
                <div>
                    <p class="text-xs text-gray-500 dark:text-gray-400 mb-1">Salon</p>
                    <p class="font-bold text-gray-900 dark:text-white"><%= salonName %></p>
                </div>
                <div>
                    <p class="text-xs text-gray-500 dark:text-gray-400 mb-1">Service</p>
                    <p class="font-bold text-gray-900 dark:text-white"><%= serviceName %></p>
                </div>
                <div>
                    <p class="text-xs text-gray-500 dark:text-gray-400 mb-1">Therapist</p>
                    <p class="font-bold text-gray-900 dark:text-white"><%= therapistName %></p>
                </div>
            </div>

            <% if (review != null && !review.trim().isEmpty()) { %>
            <div class="bg-background-light dark:bg-background-dark rounded-lg p-4 border border-gray-200 dark:border-gray-700">
                <p class="text-gray-700 dark:text-gray-300"><%= review %></p>
            </div>
            <% } %>
        </div>
        <%
                }

                if (!rs.isBeforeFirst()) {
        %>
        <div class="text-center py-12">
            <span class="material-icons text-gray-300 dark:text-gray-600 text-6xl mb-4">star_border</span>
            <p class="text-gray-500 dark:text-gray-400 text-lg">No ratings yet</p>
        </div>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
        %>
        <div class="bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-800 dark:text-red-200 px-4 py-3 rounded-lg">
            Error loading ratings. Please try again.
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
    const themeToggleBtn = document.getElementById('theme-toggle');
    const darkIcon = '<span class="material-icons">dark_mode</span>';
    const lightIcon = '<span class="material-icons">light_mode</span>';
    
    if (localStorage.getItem('color-theme') === 'dark' || (!('color-theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
        document.documentElement.classList.add('dark');
        themeToggleBtn.innerHTML = lightIcon;
    } else {
        themeToggleBtn.innerHTML = darkIcon;
    }
    
    themeToggleBtn.addEventListener('click', function() {
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
