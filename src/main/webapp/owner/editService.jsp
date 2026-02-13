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

    String serviceIdStr = request.getParameter("serviceId");
    if (serviceIdStr == null || serviceIdStr.trim().isEmpty()) {
        out.println("<h3>Service ID missing or invalid</h3>");
        return;
    }
    int serviceId = Integer.parseInt(serviceIdStr);

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String category = "";
    String serviceName = "";
    String description = "";
    double price = 0.0;
    int duration = 0;
    String imageUrl = "";
    int salonId = 0;

    try {
        con = DBConnection.getConnection();
        ps = con.prepareStatement("SELECT * FROM services WHERE id = ?");
        ps.setInt(1, serviceId);
       
        rs = ps.executeQuery();

        if (rs.next()) {
            category = rs.getString("category");
            serviceName = rs.getString("name");
            description = rs.getString("description");
            price = rs.getDouble("price");
            duration = rs.getInt("duration");
            imageUrl = rs.getString("image_url");
            salonId = rs.getInt("salon_id");
        } else {
            response.sendRedirect("view-services.jsp?error=unauthorized");
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
    <title>Edit Service - SalonConnect</title>
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
</head>
<body class="bg-background-light dark:bg-background-dark text-gray-800 dark:text-gray-200 transition-colors duration-300 overflow-x-hidden">

<nav class="sticky top-0 z-50 bg-surface-light/90 dark:bg-surface-dark/90 backdrop-blur-md border-b border-gray-100 dark:border-gray-800 shadow-sm">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-20 items-center">
            <div class="flex items-center">
                <span class="material-icons text-primary text-3xl mr-2">spa</span>
                <a href="<%= request.getContextPath() %>/index.jsp"
                   class="font-display font-bold text-2xl text-gray-900 dark:text-white">SalonConnect</a>
            </div>
            <div class="flex items-center space-x-4">
                <a href="dashboard.jsp" class="text-gray-600 dark:text-gray-300 hover:text-primary">Dashboard</a>
                <span class="text-gray-600 dark:text-gray-300"><%= userName %></span>
                <a href="<%= request.getContextPath() %>/logout" class="px-4 py-2 rounded-full text-sm font-bold text-white bg-red-500 hover:bg-red-600">Logout</a>
                <button class="p-2 rounded-full hover:bg-gray-100 dark:hover:bg-gray-700" id="theme-toggle">
                    <span class="material-icons">brightness_4</span>
                </button>
            </div>
        </div>
    </div>
</nav>

<div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
    <div class="mb-6">
        <a href="view-services.jsp" class="text-primary hover:underline flex items-center">
            <span class="material-icons mr-1">arrow_back</span> Back to Services
        </a>
    </div>

    <div class="bg-surface-light dark:bg-surface-dark rounded-3xl shadow-xl p-8 border border-gray-100 dark:border-gray-800">
        <h1 class="text-3xl font-display font-bold text-gray-900 dark:text-white mb-2">Edit Service</h1>
        
        <form action="<%= request.getContextPath() %>/owner/EditServiceServlet" method="post">
            <input type="hidden" name="serviceId" value="<%= serviceId %>">
            <input type="hidden" name="salonId" value="<%= salonId %>">

            <div class="mb-4">
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Category *</label>
                <select name="category" required
                        class="w-full px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:ring-2 focus:ring-primary">
                    <option value="">Select Category</option>
                    <option value="haircuts" <%= "haircuts".equals(category) ? "selected" : "" %>>Haircuts</option>
                    <option value="massage" <%= "massage".equals(category) ? "selected" : "" %>>Massage</option>
                    <option value="nail-care" <%= "nail-care".equals(category) ? "selected" : "" %>>Nail Care</option>
                    <option value="facials" <%= "facials".equals(category) ? "selected" : "" %>>Facials</option>
                    <option value="wellness" <%= "wellness".equals(category) ? "selected" : "" %>>Wellness</option>
                    <option value="premium" <%= "premium".equals(category) ? "selected" : "" %>>Premium</option>
                </select>
            </div>

            <div class="mb-4">
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Service Name *</label>
                <input type="text" name="name" value="<%= serviceName %>" required
                       class="w-full px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:ring-2 focus:ring-primary"
                       placeholder="Service Name"/>
            </div>

            <div class="mb-4">
                <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Description</label>
                <textarea name="description" rows="3"
                          class="w-full px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:ring-2 focus:ring-primary"
                          placeholder="Describe the service..."><%= description %></textarea>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-4">
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Price (₹$) *</label>
                    <input type="number" name="price" value="<%= price %>" step="0.01" min="0" required
                           class="w-full px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:ring-2 focus:ring-primary"/>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Duration (minutes) *</label>
                    <input type="number" name="duration" value="<%= duration %>" min="1" required
                           class="w-full px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:ring-2 focus:ring-primary"/>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Image URL</label>
                    <input type="url" name="imageUrl" value="<%= imageUrl %>"
                           class="w-full px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:ring-2 focus:ring-primary"/>
                </div>
            </div>

            <div class="flex justify-end space-x-4">
                <a href="view-services.jsp" class="px-6 py-3 border border-gray-300 dark:border-gray-600 rounded-full font-bold text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-800 transition">
                    Cancel
                </a>
                <button type="submit" class="px-6 py-3 rounded-full font-bold text-white bg-primary hover:bg-opacity-90 transition shadow-lg">
                    Update Service
                </button>
            </div>
        </form>
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
