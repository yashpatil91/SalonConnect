<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.dao.DBConnection" %>

<%
if (session == null || session.getAttribute("userId") == null) {
    response.sendRedirect("login.jsp");
    return;
}

int userId = (int) session.getAttribute("userId");
String userName = (String) session.getAttribute("userName");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Dashboard - SalonConnect</title>

<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&amp;family=Inter:wght@300;400;500;600&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet"/>
<link rel="icon" type="image/png" href="<%= request.getContextPath() %>/images/icon.jpeg">
<script src="https://cdn.tailwindcss.com?plugins=forms,typography"></script>
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
                    borderRadius: {
                        DEFAULT: "0.75rem",
                        "xl": "1rem",
                        "2xl": "1.5rem",
                    },
                },
            },
        };
        function toggleDarkMode() {
            document.documentElement.classList.toggle('dark');
        }
    </script>
<style>
        body {
            font-family: 'Inter', sans-serif;
        }
        .sidebar-active {
           background-color: #eab8a3;
    color: #1f2937;
        }
    </style>
</head>

<body class="bg-background-light dark:bg-background-dark text-gray-800 dark:text-gray-200 transition-colors duration-300 overflow-x-hidden">

<aside class="w-72 bg-card-light dark:bg-card-dark border-r border-slate-200 dark:border-stone-800 flex flex-col fixed h-full z-50 overflow-y-auto">

<div class="p-8 flex items-center space-x-3">
<span class="material-icons-round text-primary text-3xl">spa</span>
<a href="<%= request.getContextPath() %>/index.jsp"
						   class="font-display font-bold text-2xl text-gray-900 dark:text-white">
						   SalonConnect
						</a>
</div>
<div class="px-8 mb-8">
<div class="flex flex-col items-center text-center p-6 rounded-2xl bg-slate-50 dark:bg-stone-900/50 border border-slate-100 dark:border-stone-800">
<div class="w-20 h-20 rounded-full overflow-hidden mb-3 ring-2 ring-primary ring-offset-4 ring-offset-card-light dark:ring-offset-card-dark">
<img alt="Ram Patil Profile Image" class="w-full h-full object-cover" src="<%= request.getContextPath() %>/images/default-user.jpg"/>
</div>
<h3 class="font-semibold text-lg text-slate-900 dark:text-white"><%= userName %></h3>
</div>
</div>
<nav class="flex-1 px-4 space-y-1">
<a class="flex items-center space-x-3 px-4 py-3 rounded-lg sidebar-active transition-all group" href="#">
<span class="material-icons-round">dashboard</span>
<span class="font-medium">Dashboard</span>
</a>
<a class="flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-600 dark:text-stone-400 hover:bg-slate-100 dark:hover:bg-stone-800 transition-all group" href="search-salon.jsp">
<span class="material-icons-round group-hover:text-primary">search</span>
<span class="font-medium">Search Salons</span>
</a>
<a class="flex items-center space-x-3 px-4 py-3 rounded-lg text-slate-600 dark:text-stone-400 hover:bg-slate-100 dark:hover:bg-stone-800 transition-all group" href="my-appointments.jsp">
<span class="material-icons-round group-hover:text-primary">event_note</span>
<span class="font-medium">My Appointments</span>
</a>


</nav>
<div class="p-6 border-t border-slate-100 dark:border-stone-800 space-y-4">
<button class="w-full flex items-center justify-between px-4 py-2 rounded-lg bg-slate-100 dark:bg-stone-800 hover:opacity-80 transition-all" onclick="toggleDarkMode()">
<span class="text-sm font-medium">Appearance</span>
<span class="material-icons-round text-primary text-xl">dark_mode</span>
</button>
<button class="w-full bg-red-500 hover:bg-red-600 text-white flex items-center justify-center space-x-2 py-3 rounded-xl transition-all shadow-lg shadow-red-500/20">
  <a href="<%= request.getContextPath() %>/logout" class="px-4 py-2 rounded-full text-sm font-bold text-white bg-red-500 hover:bg-red-600">Logout</a>
</button>
</div>
</aside>

<main class="ml-72 flex-1 p-10">
<header class="mb-10 flex justify-between items-end">
<div>
<h1 class="font-display text-4xl font-bold text-slate-900 dark:text-white mb-2">Welcome, <%= userName %>!</h1>
<p class="text-slate-500 dark:text-stone-400">Your hair and wellness journey continues here.</p>
</div>
<!-- ================= STATS SECTION ================= -->

<%
int totalBookings = 0;
int pendingBookings = 0;
int approvedBookings = 0;

Connection con1 = null;
PreparedStatement ps1 = null;
ResultSet rs1 = null;

try {
    con1 = DBConnection.getConnection();

    String sql = "SELECT COUNT(*) as total, " +
                 "SUM(CASE WHEN status='PENDING' THEN 1 ELSE 0 END) as pending, " +
                 "SUM(CASE WHEN status='APPROVED' THEN 1 ELSE 0 END) as approved " +
                 "FROM appointments WHERE user_id=?";

    ps1 = con1.prepareStatement(sql);
    ps1.setInt(1, userId);
    rs1 = ps1.executeQuery();

    if (rs1.next()) {
        totalBookings = rs1.getInt("total");
        pendingBookings = rs1.getInt("pending");
        approvedBookings = rs1.getInt("approved");
    }

} catch (Exception e) {
    e.printStackTrace();
} finally {
    try { if (rs1 != null) rs1.close(); } catch (Exception ignored) {}
    try { if (ps1 != null) ps1.close(); } catch (Exception ignored) {}
    try { if (con1 != null) con1.close(); } catch (Exception ignored) {}
}
%>

<div class="hidden lg:flex items-center space-x-4">
<div class="flex -space-x-3">

</div>

</div>
</header>


<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-10">
<div class="bg-card-light dark:bg-card-dark p-6 rounded-2xl border border-slate-100 dark:border-stone-800 shadow-sm">
<div class="flex items-center justify-between mb-4">
<span class="material-icons-round text-primary bg-primary/10 p-2 rounded-lg">event_available</span>

</div>
<p class="text-slate-500 dark:text-stone-400 text-sm font-medium">Total Bookings</p>
<h2 class="text-3xl font-bold text-slate-900 dark:text-white"><%= totalBookings %></h2>
</div>


<div  class="bg-card-light dark:bg-card-dark p-6 rounded-2xl border border-slate-100 dark:border-stone-800 shadow-sm">
<div class="flex items-center justify-between mb-4">
<span class="material-icons text-green-500 bg-green-100 dark:bg-green-900/30 p-2 rounded-lg text-2xl">
    check_circle
</span>
</div>
<p class="text-gray-500 dark:text-gray-400 text-sm">Approved</p>
<h2 class="text-3xl font-bold text-gray-900 dark:text-white mt-2"><%= approvedBookings %></h2>
</div>


<div class="bg-card-light dark:bg-card-dark p-6 rounded-2xl border border-slate-100 dark:border-stone-800 shadow-sm">
<div class="flex items-center justify-between mb-4">
<span class="material-icons-round text-primary bg-primary/10 p-2 rounded-lg">hourglass_empty</span>
</div>
<p class="text-slate-500 dark:text-stone-400 text-sm font-medium">Pending Approvals</p>
<h2 class="text-3xl font-bold text-slate-900 dark:text-white"><%= pendingBookings %></h2>
</div>
</div>


<!-- ================= UPCOMING APPOINTMENT ================= -->

<%
String salonName = null;
String therapistName = null;
String appointmentDate = null;
String appointmentTime = null;

Connection con2 = null;
PreparedStatement ps2 = null;
ResultSet rs2 = null;

try {

    con2 = DBConnection.getConnection();

    String sql =
        "SELECT a.appointment_date, a.appointment_time, " +
        "s.name AS salon_name, t.name AS therapist_name " +
        "FROM appointments a " +
        "JOIN salons s ON a.salon_id = s.id " +
        "JOIN therapists t ON a.therapist_id = t.id " +
        "WHERE a.user_id = ? " +
        "AND a.status IN ('PENDING','APPROVED') " +
        "AND a.appointment_date >= CURDATE() " +
        "ORDER BY a.appointment_date ASC, a.appointment_time ASC " +
        "LIMIT 1";

    ps2 = con2.prepareStatement(sql);
    ps2.setInt(1, userId);
    rs2 = ps2.executeQuery();

    if (rs2.next()) {
        salonName = rs2.getString("salon_name");
        therapistName = rs2.getString("therapist_name");
        appointmentDate = rs2.getString("appointment_date");
        appointmentTime = rs2.getString("appointment_time");
    }

} catch (Exception e) {
    e.printStackTrace();
} finally {
    try { if (rs2 != null) rs2.close(); } catch (Exception ignored) {}
    try { if (ps2 != null) ps2.close(); } catch (Exception ignored) {}
    try { if (con2 != null) con2.close(); } catch (Exception ignored) {}
}
%>


<div class="grid grid-cols-1 md:grid-cols-3 gap-8 mb-10">


 
<div class="lg:col-span-2 bg-slate-900 dark:bg-stone-900 rounded-2xl p-8 relative overflow-hidden shadow-xl text-white">

<div class="relative z-10">

<div class="bg-surface-light dark:bg-surface-dark rounded-2xl p-8 shadow-lg">

  <span class="text-xs uppercase tracking-widest text-primary">
    Upcoming Appointment
  </span>

  <% if (salonName != null) { %>

    <h3 class="text-2xl font-bold mt-3">
      <%= salonName %>
    </h3>

    <p class="text-gray-500 mt-2 flex items-center gap-1">
      <span class="material-icons text-sm">place</span>
      Salon
    </p>

    <div class="grid grid-cols-3 gap-6 mt-6 text-sm">
      <div>
        <p class="text-gray-400">Date</p>
        <p class="font-semibold"><%= appointmentDate %></p>
      </div>

      <div>
        <p class="text-gray-400">Time</p>
        <p class="font-semibold"><%= appointmentTime %></p>
      </div>

      <div>
        <p class="text-gray-400">Therapist</p>
        <p class="font-semibold"><%= therapistName %></p>
      </div>
    </div>

    <div class="mt-6">
      <a href="my-appointments.jsp"
         class="inline-block bg-primary text-white px-6 py-2 rounded-full">
        View Details
      </a>
    </div>

  <% } else { %>

    <p class="text-gray-400 mt-4">
      No upcoming appointments.
    </p>

    <a href="search-salon.jsp"
       class="inline-block mt-4 bg-primary text-white px-6 py-2 rounded-full">
       Book Now
    </a>

  <% } %>

</div>
</div>
</div>
<div class="bg-primary rounded-2xl p-8 flex flex-col justify-between text-white shadow-xl shadow-primary/20">
<div>
<h3 class="text-2xl font-display font-bold mb-3 leading-tight">Book your next self-care session.</h3>
<p class="text-white/80 text-sm">Treat yourself to the premium experience you deserve.</p>
</div>
<div class="flex justify-end">
<a  class="w-12 h-12 bg-white/20 rounded-full flex items-center justify-center cursor-pointer hover:bg-white/30 transition-all" href="search-salon.jsp">

<span class="material-icons-round">arrow_forward</span>
  </a>
</div>
</div>
</div>


<!-- ================= RECOMMENDED SALONS ================= -->

<h2 class="text-2xl font-bold mb-4">Recommended Salons</h2>
 <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <%
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                con = DBConnection.getConnection();
                ps = con.prepareStatement("SELECT * FROM salons ORDER BY rating DESC, name LIMIT 3");
                rs = ps.executeQuery();

                while (rs.next()) {
                    int salonId = rs.getInt("id");
                    String salonName1 = rs.getString("name");
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
                <img src="<%= imageUrl %>" alt="<%= salonName1 %>" class="w-full h-full object-cover"/>
                <div class="absolute top-4 right-4 bg-white dark:bg-black/70 backdrop-blur-sm px-3 py-1 rounded-full flex items-center shadow-sm">
                    <span class="material-icons text-yellow-400 text-sm mr-1">star</span>
                    <span class="text-sm font-bold text-gray-800 dark:text-white"><%= String.format("%.1f", rating) %></span>
                </div>
            </div>
            <div class="p-6">
                <h3 class="text-xl font-display font-bold text-gray-900 dark:text-white mb-2"><%= salonName1 %></h3>
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
