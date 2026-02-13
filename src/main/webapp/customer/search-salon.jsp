<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.dao.DBConnection" %>
<%
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    String userName = (String) session.getAttribute("userName");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Search Salons - SalonConnect</title>
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
                <a href="my-appointments.jsp" class="text-gray-600 dark:text-gray-300 hover:text-primary">My Appointments</a>
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
    <h1 class="text-4xl font-display font-bold text-gray-900 dark:text-white mb-8">Find Your Perfect Salon</h1>

    <div class="bg-surface-light dark:bg-surface-dark rounded-3xl shadow-xl p-6 border border-gray-100 dark:border-gray-800 mb-8">
        <form action="<%= request.getContextPath() %>/searchSalons" method="GET" class="space-y-4">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div>
                    <label for="city" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">City</label>
                    <div class="relative">
                        <span class="material-icons absolute left-3 top-3 text-gray-400">location_on</span>
                        <input type="text" id="city" name="city"
                               class="pl-10 w-full px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:ring-2 focus:ring-primary focus:border-transparent"
                               placeholder="Enter city"/>
                    </div>
                </div>

                <div>
                    <label for="service" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Service</label>
                    <div class="relative">
                        <span class="material-icons absolute left-3 top-3 text-gray-400">spa</span>
                        <input type="text" id="service" name="service"
                               class="pl-10 w-full px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:ring-2 focus:ring-primary focus:border-transparent"
                               placeholder="e.g., Haircut, Spa"/>
                    </div>
                </div>

                <div>
                    <label for="minRating" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Min Rating</label>
                    <select id="minRating" name="minRating"
                            class="w-full px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:ring-2 focus:ring-primary focus:border-transparent">
                        <option value="">Any Rating</option>
                        <option value="4.5">4.5+ Stars</option>
                        <option value="4.0">4.0+ Stars</option>
                        <option value="3.5">3.5+ Stars</option>
                        <option value="3.0">3.0+ Stars</option>
                    </select>
                </div>
            </div>

            <div class="flex justify-end">
                <button type="submit" class="px-6 py-3 rounded-full font-bold text-white bg-primary hover:bg-opacity-90 transition shadow-lg flex items-center">
                    <span class="material-icons mr-2">search</span> Search Salons
                </button>
            </div>
        </form>
    </div>

    <h2 class="text-2xl font-display font-bold text-gray-900 dark:text-white mb-6">All Salons</h2>

    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <%
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                con = DBConnection.getConnection();
                ps = con.prepareStatement("SELECT * FROM salons ORDER BY rating DESC, name LIMIT 20");
                rs = ps.executeQuery();

                while (rs.next()) {
                    int salonId = rs.getInt("id");
                    String salonName = rs.getString("name");
                    String address = rs.getString("address");
                    String city = rs.getString("city");
                    String description = rs.getString("description");
                    double rating = rs.getDouble("rating");
                    String imageUrl = rs.getString("image_url");
                    
                    if (imageUrl == null || imageUrl.isEmpty()) {
                        imageUrl = "https://via.placeholder.com/400x300?text=Salon";
                    }
        %>
        <div class="bg-surface-light dark:bg-surface-dark rounded-3xl overflow-hidden shadow-lg hover:shadow-2xl transition border border-gray-100 dark:border-gray-800">
            <div class="relative h-48 overflow-hidden">
                <img src="<%= imageUrl %>" alt="<%= salonName %>" class="w-full h-full object-cover"/>
                <div class="absolute top-4 right-4 bg-white dark:bg-black/70 backdrop-blur-sm px-3 py-1 rounded-full flex items-center shadow-sm">
                    <span class="material-icons text-yellow-400 text-sm mr-1">star</span>
                    <span class="text-sm font-bold text-gray-800 dark:text-white"><%= String.format("%.1f", rating) %></span>
                </div>
            </div>
            <div class="p-6">
                <h3 class="text-xl font-display font-bold text-gray-900 dark:text-white mb-2"><%= salonName %></h3>
                <p class="text-gray-500 dark:text-gray-400 text-sm flex items-center mb-2">
                    <span class="material-icons text-sm mr-1">place</span> <%= city %>
                </p>
                <p class="text-gray-600 dark:text-gray-300 text-sm mb-4 line-clamp-2"><%= description != null ? description : "Premium salon services" %></p>
                <a href="salon-details.jsp?id=<%= salonId %>" class="block text-center px-4 py-2 bg-primary text-white rounded-full hover:bg-opacity-90 transition text-sm font-bold">
                    View Details & Book
                </a>
            </div>
        </div>
        <%
                }

                if (!rs.isBeforeFirst()) {
        %>
        <div class="col-span-full text-center py-12">
            <span class="material-icons text-gray-300 dark:text-gray-600 text-6xl mb-4">store</span>
            <p class="text-gray-500 dark:text-gray-400 text-lg">No salons found</p>
        </div>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
        %>
        <div class="col-span-full bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-800 dark:text-red-200 px-4 py-3 rounded-lg">
            Error loading salons. Please try again.
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