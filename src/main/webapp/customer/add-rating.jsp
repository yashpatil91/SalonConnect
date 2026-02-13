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
    int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
    
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    String salonName = "";
    String serviceName = "";
    String therapistName = "";
    
    try {
        con = DBConnection.getConnection();
        String sql = "SELECT s.name as salon_name, srv.name as service_name, t.name as therapist_name " +
                    "FROM appointments a " +
                    "JOIN salons s ON a.salon_id = s.id " +
                    "JOIN services srv ON a.service_id = srv.id " +
                    "JOIN therapists t ON a.therapist_id = t.id " +
                    "WHERE a.id = ? AND a.user_id = ?";
        ps = con.prepareStatement(sql);
        ps.setInt(1, appointmentId);
        ps.setInt(2, userId);
        rs = ps.executeQuery();
        
        if (rs.next()) {
            salonName = rs.getString("salon_name");
            serviceName = rs.getString("service_name");
            therapistName = rs.getString("therapist_name");
        } else {
            response.sendRedirect("my-appointments.jsp?error=notfound");
            return;
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception ignored) {}
        try { if (ps != null) ps.close(); } catch (Exception ignored) {}
        try { if (con != null) con.close(); } catch (Exception ignored) {}
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Rate Service - SalonConnect</title>
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
        .star-rating {
            display: flex;
            gap: 0.5rem;
            font-size: 2rem;
        }
        .star {
            cursor: pointer;
            color: #d1d5db;
            transition: color 0.2s;
        }
        .star.active {
            color: #fbbf24;
        }
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

<div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
    <div class="mb-6">
        <a href="my-appointments.jsp" class="text-primary hover:underline flex items-center">
            <span class="material-icons mr-1">arrow_back</span> Back to Appointments
        </a>
    </div>

    <div class="bg-surface-light dark:bg-surface-dark rounded-3xl shadow-xl p-8 border border-gray-100 dark:border-gray-800">
        <h1 class="text-3xl font-display font-bold text-gray-900 dark:text-white mb-2">Rate Your Experience</h1>
        <p class="text-gray-500 dark:text-gray-400 mb-6">Help others by sharing your experience</p>

        <div class="bg-background-light dark:bg-background-dark rounded-2xl p-4 mb-6 border border-gray-200 dark:border-gray-700">
            <p class="text-sm text-gray-500 dark:text-gray-400 mb-1">Salon</p>
            <p class="font-bold text-gray-900 dark:text-white mb-2"><%= salonName %></p>
            <p class="text-sm text-gray-500 dark:text-gray-400 mb-1">Service</p>
            <p class="font-bold text-gray-900 dark:text-white mb-2"><%= serviceName %></p>
            <p class="text-sm text-gray-500 dark:text-gray-400 mb-1">Therapist</p>
            <p class="font-bold text-gray-900 dark:text-white"><%= therapistName %></p>
        </div>

        <form action="addRating" method="POST" class="space-y-6">
            <input type="hidden" name="appointmentId" value="<%= appointmentId %>"/>
            <input type="hidden" name="rating" id="ratingValue" value="5"/>

            <div>
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-3">Your Rating *</label>
                <div class="star-rating" id="starRating">
                    <span class="star active" data-rating="1">★</span>
                    <span class="star active" data-rating="2">★</span>
                    <span class="star active" data-rating="3">★</span>
                    <span class="star active" data-rating="4">★</span>
                    <span class="star active" data-rating="5">★</span>
                </div>
            </div>

            <div>
                <label for="review" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Your Review</label>
                <textarea id="review" name="review" rows="5"
                          class="w-full px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:ring-2 focus:ring-primary focus:border-transparent"
                          placeholder="Share your experience..."></textarea>
            </div>

            <div class="flex justify-end space-x-4">
                <a href="my-appointments.jsp" class="px-6 py-3 border border-gray-300 dark:border-gray-600 rounded-full font-bold text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-800 transition">
                    Cancel
                </a>
                <button type="submit" class="px-6 py-3 rounded-full font-bold text-white bg-primary hover:bg-opacity-90 transition shadow-lg">
                    Submit Rating
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    const stars = document.querySelectorAll('.star');
    const ratingValue = document.getElementById('ratingValue');

    stars.forEach(star => {
        star.addEventListener('click', function() {
            const rating = parseInt(this.getAttribute('data-rating'));
            ratingValue.value = rating;
            
            stars.forEach((s, index) => {
                if (index < rating) {
                    s.classList.add('active');
                } else {
                    s.classList.remove('active');
                }
            });
        });
    });

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
