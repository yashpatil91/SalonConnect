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
    int salonId = Integer.parseInt(request.getParameter("salonId"));
    
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String salonName = "";
    
    try {
        con = DBConnection.getConnection();
        ps = con.prepareStatement("SELECT name FROM salons WHERE id = ? AND owner_id = ?");
        ps.setInt(1, salonId);
        ps.setInt(2, ownerId);
        rs = ps.executeQuery();
        
        if (rs.next()) {
            salonName = rs.getString("name");
        } else {
            response.sendRedirect("view-therapists.jsp?error=unauthorized");
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
    <title>Add Therapist - SalonConnect</title>
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

<div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
    <div class="mb-6">
        <a href="view-therapists.jsp" class="text-primary hover:underline flex items-center">
            <span class="material-icons mr-1">arrow_back</span> Back to Therapists
        </a>
    </div>

    <div class="bg-surface-light dark:bg-surface-dark rounded-3xl shadow-xl p-8 border border-gray-100 dark:border-gray-800">
        <h1 class="text-3xl font-display font-bold text-gray-900 dark:text-white mb-2">Add Therapist</h1>
        <p class="text-gray-500 dark:text-gray-400 mb-6">For: <%= salonName %></p>

        <form action="addTherapist" method="POST" class="space-y-6">
            <input type="hidden" name="salonId" value="<%= salonId %>"/>
            
            <div>
                <label for="name" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Therapist Name *</label>
                <input type="text" id="name" name="name" required
                       class="w-full px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:ring-2 focus:ring-primary focus:border-transparent"
                       placeholder="Enter therapist name"/>
            </div>

            <div>
                <label for="specialization" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Specialization</label>
                <input type="text" id="specialization" name="specialization"
                       class="w-full px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:ring-2 focus:ring-primary focus:border-transparent"
                       placeholder="e.g., Hair Styling, Spa Therapy, Nail Art"/>
            </div>

            <div>
                <label for="phone" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Phone Number</label>
                <input type="tel" id="phone" name="phone"
                       class="w-full px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:ring-2 focus:ring-primary focus:border-transparent"
                       placeholder="Enter phone number"/>
            </div>
			<div>
			    <label for="email" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Email</label>
			    <input type="email" name="email"
			           class="w-full px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:ring-2 focus:ring-primary focus:border-transparent"
			           placeholder="therapist@email.com">
			</div>
            

            <div>
			    <label for="imageUrl" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
			        Image URL
			        <span class="text-xs text-gray-500">(Optional)</span>
			    </label>
			
			    <input type="url" id="imageUrl" name="imageUrl"
			           class="w-full px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-lg
			                  bg-white dark:bg-gray-800 text-gray-900 dark:text-white
			                  focus:ring-2 focus:ring-primary focus:border-transparent"
			           placeholder="Leave empty to use default therapist image"/>
			</div>

            <div class="flex justify-end space-x-4">
                <a href="view-therapists.jsp" class="px-6 py-3 border border-gray-300 dark:border-gray-600 rounded-full font-bold text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-800 transition">
                    Cancel
                </a>
                <button type="submit" class="px-6 py-3 rounded-full font-bold text-white bg-primary hover:bg-opacity-90 transition shadow-lg">
                    Add Therapist
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

<script>
document.querySelector("form").addEventListener("submit", function () {
    const img = document.getElementById("imageUrl");
    if (img && img.value) {
        img.value = img.value.trim();
    }
});
</script>


</body>
</html>
