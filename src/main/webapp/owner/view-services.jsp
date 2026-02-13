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
    <title>Manage Services - SalonConnect</title>
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
    <div class="flex justify-between items-center mb-8">
        <h1 class="text-4xl font-display font-bold text-gray-900 dark:text-white">Manage Services</h1>
    </div>

    <% if ("added".equals(request.getParameter("success"))) { %>
        <div class="mb-4 bg-green-50 dark:bg-green-900/20 border border-green-200 dark:border-green-800 text-green-800 dark:text-green-200 px-4 py-3 rounded-lg">
            Service added successfully!
        </div>
    <% } %>

    <%
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            
            // Get all salons owned by this user
            ps = con.prepareStatement("SELECT * FROM salons WHERE owner_id = ? ORDER BY name");
            ps.setInt(1, ownerId);
            rs = ps.executeQuery();

            while (rs.next()) {
                int salonId = rs.getInt("id");
                String salonName = rs.getString("name");
    %>
    
    <div class="bg-surface-light dark:bg-surface-dark rounded-3xl shadow-lg p-6 border border-gray-100 dark:border-gray-800 mb-6">
        <div class="flex justify-between items-center mb-4">
            <h2 class="text-2xl font-display font-bold text-gray-900 dark:text-white"><%= salonName %></h2>
            <a href="add-service.jsp?salonId=<%= salonId %>" class="px-4 py-2 rounded-full font-bold text-white bg-primary hover:bg-opacity-90 transition shadow-lg flex items-center text-sm">
                <span class="material-icons text-sm mr-1">add</span> Add Service
            </a>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            <%
                PreparedStatement ps2 = con.prepareStatement("SELECT * FROM services WHERE salon_id = ? ORDER BY name");
                ps2.setInt(1, salonId);
                ResultSet rs2 = ps2.executeQuery();
                
                boolean hasServices = false;
                while (rs2.next()) {
                    hasServices = true;
                    String serviceName = rs2.getString("name");
                    String serviceDesc = rs2.getString("description");
                    double price = rs2.getDouble("price");
                    int duration = rs2.getInt("duration");
            %>
            <div class="bg-background-light dark:bg-background-dark rounded-2xl p-4 border border-gray-200 dark:border-gray-700">
                <div class="flex items-start justify-between mb-2">
                    <h3 class="text-lg font-bold text-gray-900 dark:text-white"><%= serviceName %></h3>
                    <span class="bg-primary/20 text-primary px-2 py-1 rounded-full text-xs font-bold">$<%= String.format("%.2f", price) %></span>
                </div>
                <p class="text-gray-500 dark:text-gray-400 text-sm mb-3"><%= serviceDesc != null ? serviceDesc : "No description" %></p>
                <div class="flex items-center text-gray-600 dark:text-gray-300 text-sm">
                    <span class="material-icons text-sm mr-1">schedule</span>
                    <%= duration %> minutes
                </div>
                <div class="flex space-x-2 mt-2">
		        <form action="editService.jsp" method="get" style="display:inline;">
		            <input type="hidden" name="serviceId" value="<%= rs2.getInt("id") %>">
		            <button type="submit" class="px-3 py-1 bg-blue-500 text-white rounded hover:bg-blue-600 text-sm">
		                Edit
		            </button>
		        </form>
		        <form action="<%= request.getContextPath() %>/owner/deleteService" method="post"
				      onsubmit="return confirm('Are you sure you want to delete this service?');"
				      style="display:inline;">
				      
				    <input type="hidden" name="serviceId" value="<%= rs2.getInt("id") %>">
				
				    <button type="submit"
				        class="px-3 py-1 bg-red-500 text-white rounded hover:bg-red-600 text-sm">
				        Delete
				    </button>
				</form>
		        
                 </div>
                
            </div>
            <%
                }
                
                if (!hasServices) {
            %>
            <div class="col-span-full text-center py-8 text-gray-500 dark:text-gray-400">
                <span class="material-icons text-4xl mb-2">spa</span>
                <p>No services added yet</p>
            </div>
            <%
                }
                rs2.close();
                ps2.close();
            %>
        </div>
    </div>

    <%
            }
            
            if (!rs.isBeforeFirst()) {
    %>
    <div class="text-center py-12">
        <span class="material-icons text-gray-300 dark:text-gray-600 text-6xl mb-4">store</span>
        <p class="text-gray-500 dark:text-gray-400 text-lg mb-4">No salons found. Please add a salon first.</p>
        <a href="add-salon.jsp" class="inline-block px-6 py-3 rounded-full font-bold text-white bg-primary hover:bg-opacity-90 transition shadow-lg">
            Add Salon
        </a>
    </div>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
    %>
    <div class="bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-800 dark:text-red-200 px-4 py-3 rounded-lg">
        Error loading services. Please try again.
    </div>
    <%
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }
    %>
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
