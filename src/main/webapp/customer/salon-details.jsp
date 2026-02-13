<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.dao.DBConnection" %>
<%
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    String userName = (String) session.getAttribute("userName");
    int salonId = Integer.parseInt(request.getParameter("id"));
    
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    String salonName = "";
    String address = "";
    String city = "";
    String phone = "";
    String description = "";
    double rating = 0.0;
    String imageUrl = "";
    
    try {
        con = DBConnection.getConnection();
        ps = con.prepareStatement("SELECT * FROM salons WHERE id = ?");
        ps.setInt(1, salonId);
        rs = ps.executeQuery();
        
        if (rs.next()) {
            salonName = rs.getString("name");
            address = rs.getString("address");
            city = rs.getString("city");
            phone = rs.getString("phone");
            description = rs.getString("description");
            rating = rs.getDouble("rating");
            imageUrl = rs.getString("image_url");
        }
        else
        {
            response.sendRedirect("search-salon.jsp?error=notfound");
            return;
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception ignored) {}
        try { if (ps != null) ps.close(); } catch (Exception ignored) {}
        try { if (con != null) con.close(); } catch (Exception ignored) {}
    }
    
    if (imageUrl == null || imageUrl.isEmpty()) {
        imageUrl = "https://via.placeholder.com/800x400?text=Salon";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title><%= salonName %> - SalonConnect</title>
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
    <div class="mb-6">
        <a href="services.jsp" class="text-primary hover:underline flex items-center">
            <span class="material-icons mr-1">arrow_back</span> Back to Search
        </a>
    </div>

    <div class="bg-surface-light dark:bg-surface-dark rounded-3xl shadow-xl overflow-hidden border border-gray-100 dark:border-gray-800 mb-8">
        <div class="relative h-96 overflow-hidden">
            <img src="<%= imageUrl %>" alt="<%= salonName %>" class="w-full h-full object-cover"/>
            <div class="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black/70 to-transparent p-8">
                <div class="flex items-center justify-between">
                    <div>
                        <h1 class="text-4xl font-display font-bold text-white mb-2"><%= salonName %></h1>
                        <p class="text-white/90 flex items-center">
                            <span class="material-icons mr-2">place</span> <%= address %>, <%= city %>
                        </p>
                    </div>
                    <div class="bg-white/90 backdrop-blur-sm px-4 py-2 rounded-full flex items-center">
                        <span class="material-icons text-yellow-400 mr-1">star</span>
                        <span class="text-xl font-bold text-gray-800"><%= String.format("%.1f", rating) %></span>
                    </div>
                </div>
            </div>
        </div>

        <div class="p-8">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
                <div class="flex items-center">
                    <span class="material-icons text-primary text-2xl mr-3">phone</span>
                    <div>
                        <p class="text-sm text-gray-500 dark:text-gray-400">Phone</p>
                        <p class="font-bold text-gray-900 dark:text-white"><%= phone %></p>
                    </div>
                </div>
                <div class="flex items-center">
                    <span class="material-icons text-primary text-2xl mr-3">location_on</span>
                    <div>
                        <p class="text-sm text-gray-500 dark:text-gray-400">Address</p>
                        <p class="font-bold text-gray-900 dark:text-white"><%= city %></p>
                    </div>
                </div>
                <div class="flex items-center">
                    <span class="material-icons text-primary text-2xl mr-3">star</span>
                    <div>
                        <p class="text-sm text-gray-500 dark:text-gray-400">Rating</p>
                        <p class="font-bold text-gray-900 dark:text-white"><%= String.format("%.1f", rating) %> / 5.0</p>
                    </div>
                </div>
            </div>

            <div class="mb-8">
                <h2 class="text-2xl font-display font-bold text-gray-900 dark:text-white mb-4">About</h2>
                <p class="text-gray-600 dark:text-gray-300"><%= description != null ? description : "Premium salon services" %></p>
            </div>

            <div class="mb-8">
                <h2 class="text-2xl font-display font-bold text-gray-900 dark:text-white mb-4">Services</h2>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                    <%
                        try {
                            con = DBConnection.getConnection();
                            ps = con.prepareStatement("SELECT * FROM services WHERE salon_id = ? ORDER BY name");
                            ps.setInt(1, salonId);
                            rs = ps.executeQuery();

                            while (rs.next()) {
                                String serviceName = rs.getString("name");
                                String serviceDesc = rs.getString("description");
                                double price = rs.getDouble("price");
                                int duration = rs.getInt("duration");
                    %>
                    <div class="bg-background-light dark:bg-background-dark rounded-2xl p-4 border border-gray-200 dark:border-gray-700">
                        <div class="flex justify-between items-start mb-2">
                            <h3 class="font-bold text-gray-900 dark:text-white"><%= serviceName %></h3>
                            <span class="bg-primary/20 text-primary px-2 py-1 rounded-full text-xs font-bold">₹<%= String.format("%.2f", price) %></span>
                        </div>
                        <p class="text-gray-500 dark:text-gray-400 text-sm mb-2"><%= serviceDesc != null ? serviceDesc : "" %></p>
                        <div class="flex items-center text-gray-600 dark:text-gray-300 text-sm">
                            <span class="material-icons text-sm mr-1">schedule</span>
                            <%= duration %> min
                        </div>
                    </div>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
                            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
                            try { if (con != null) con.close(); } catch (Exception ignored) {}
                        }
                    %>
                </div>
            </div>
            
            <div class="mb-10">
 <h2 class="text-2xl font-display font-bold text-gray-900 dark:text-white mb-6">
        Our Therapists
    </h2>

    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <%
            try {
                con = DBConnection.getConnection();
                ps = con.prepareStatement(
                    "SELECT * FROM therapists WHERE salon_id = ? ORDER BY name"
                );
                ps.setInt(1, salonId);
                rs = ps.executeQuery();

                boolean hasTherapist = false;

                while (rs.next()) {
                    hasTherapist = true;

                    String tName = rs.getString("name");
                    String specialization = rs.getString("specialization");
                    String tPhone = rs.getString("phone");
                    double tRating = rs.getDouble("rating");
                    String tImage = rs.getString("image_url");
                    
                    
                  
                    String finalImageUrl;

                    if (tImage == null || tImage.trim().isEmpty()) {
                        finalImageUrl = request.getContextPath() + "/images/default-therapist.jpg";
                    } else if (tImage.startsWith("http://") || tImage.startsWith("https://")) {
                        finalImageUrl = tImage;
                    } else {
                        finalImageUrl = request.getContextPath() + tImage;
                    }
                    
              
        %>

        <div class="bg-surface-light dark:bg-surface-dark rounded-2xl shadow-md border border-gray-200 dark:border-gray-700 p-5 flex items-start gap-4 hover:shadow-lg transition-all duration-300">

    <!-- Therapist Image -->
    <div class="flex-shrink-0">
        <img src="<%= finalImageUrl %>"
             alt="<%= tName %>"
             onerror="this.src='<%= request.getContextPath() %>/images/default-therapist.jpg'"
             class="w-20 h-20 rounded-full object-cover border-2 border-primary shadow-sm">
    </div>

    <!-- Therapist Info -->
    <div class="flex-1">

        <!-- Name -->
        <h3 class="text-lg font-bold text-gray-900 dark:text-white">
            <%= tName %>
        </h3>

        <!-- Role / Specialization -->
        <p class="text-primary font-semibold text-sm uppercase tracking-wide">
            <%= specialization != null ? specialization : "Professional Therapist" %>
        </p>

        <!-- Rating -->
        <div class="flex items-center gap-1 text-sm mt-1 mb-2">
            <span class="material-icons text-yellow-400 text-base">star</span>
            <span class="font-bold text-gray-800 dark:text-gray-200">
                <%= String.format("%.1f", tRating) %>
            </span>
        </div>

        <!-- Description Placeholder (Optional if you add later) -->
        <p class="text-sm text-gray-600 dark:text-gray-300 leading-relaxed">
            Experienced specialist dedicated to delivering high-quality treatments and personalized care.
        </p>

    </div>

</div>

        

     <%
                }

                if (!hasTherapist) {
        %>
            <p class="text-gray-500 dark:text-gray-400 col-span-full">
                No therapists available for this salon.
            </p>
        <%
                }

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception ignored) {}
                try { if (ps != null) ps.close(); } catch (Exception ignored) {}
                try { if (con != null) con.close(); } catch (Exception ignored) {}
            }
        %>
    </div>
</div>
            
            <div class="text-center">
                <a href="book-appointment.jsp?salonId=<%= salonId %>" class="inline-block px-8 py-4 rounded-full font-bold text-white bg-primary hover:bg-opacity-90 transition shadow-lg text-lg">
                    <span class="material-icons align-middle mr-2">event</span> Book Appointment
                </a>
            </div>
        </div>
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
