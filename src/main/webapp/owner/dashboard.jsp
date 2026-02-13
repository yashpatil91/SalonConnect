<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

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

<%
int totalRevenue = 0;
int upcomingAppointments = 0;
int activeStaff = 0;

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {
    con = DBConnection.getConnection();

    // TOTAL REVENUE
    ps = con.prepareStatement(
        "SELECT COALESCE(SUM(s.price),0) " +
        "FROM appointments a " +
        "JOIN services s ON a.service_id = s.id " +
        "JOIN salons sl ON a.salon_id = sl.id " +
        "WHERE sl.owner_id=? AND a.status='COMPLETED'"
    );
    ps.setInt(1, ownerId);
    rs = ps.executeQuery();
    if (rs.next()) totalRevenue = rs.getInt(1);
    rs.close();
    ps.close();

    // UPCOMING APPOINTMENTS
    ps = con.prepareStatement(
        "SELECT COUNT(*) FROM appointments a " +
        "JOIN salons sl ON a.salon_id=sl.id " +
        "WHERE sl.owner_id=? AND a.appointment_date>=CURDATE()"
    );
    ps.setInt(1, ownerId);
    rs = ps.executeQuery();
    if (rs.next()) upcomingAppointments = rs.getInt(1);
    rs.close();
    ps.close();

    // ACTIVE STAFF
    ps = con.prepareStatement(
    	    "SELECT COUNT(*) " +
    	    "FROM therapists t " +
    	    "JOIN salons sl ON t.salon_id = sl.id " +
    	    "WHERE sl.owner_id = ?"
    	);
    	ps.setInt(1, ownerId);
    	rs = ps.executeQuery();
    	if (rs.next()) activeStaff = rs.getInt(1);


} catch (Exception e) {
    e.printStackTrace();
} finally {
    try { if (rs != null) rs.close(); } catch (Exception ignored) {}
    try { if (ps != null) ps.close(); } catch (Exception ignored) {}
    try { if (con != null) con.close(); } catch (Exception ignored) {}
}
%>


<!DOCTYPE html>
<html lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>SalonConnect - Salon Owner Dashboard</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,typography,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&amp;family=Lato:wght@300;400;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
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
                    borderRadius: {
                        DEFAULT: "0.75rem",
                    },
                },
            },
        };
    </script>
    <style>
        body { font-family: 'Lato', sans-serif; }
        h1, h2, h3, h4, h5, h6 { font-family: 'Playfair Display', serif; }
        sidebar-link.active 
        {
         @apply bg-primary/10 text-primary border-r-4 border-primary;
        }
    </style>
</head>

<body class="bg-background-light dark:bg-background-dark text-gray-800 dark:text-gray-200 transition-colors duration-300 overflow-x-hidden ">

<nav class="sticky top-0 z-50 bg-surface-light/90 dark:bg-surface-dark/90 backdrop-blur-md border-b border-gray-100 dark:border-gray-800 shadow-sm overflow-x-hidden overflow-y-hidden">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-20 items-center">
        
            <div class="h-20 flex items-center px-8 border-b border-gray-100 dark:border-gray-800">
			<span class="material-symbols-outlined text-primary text-3xl mr-2">spa</span>
			<a href="<%= request.getContextPath() %>/index.jsp"
						   class="font-display font-bold text-2xl text-gray-900 dark:text-white">
						   SalonConnect
						</a>		
		   </div>
            
            <div class="flex items-center space-x-4">
                <a href="dashboard.jsp" class="text-gray-600 dark:text-gray-300 hover:text-primary">Dashboard</a>
                <span class="text-gray-600 dark:text-gray-300"><%= userName %></span>
                <button class="p-2 rounded-full hover:bg-gray-100 dark:hover:bg-gray-700" id="theme-toggle">
       <span class="material-symbols-outlined">dark_mode</span>
         </button>

				<form action="<%= request.getContextPath() %>/logout" method="post" style="display:inline;">
				    <button type="submit"
				        class="px-4 py-2 rounded-full text-sm font-bold text-white bg-red-500 hover:bg-red-600">
				        Logout
				    </button>
				</form>
        </div>
        </div>
   
</nav>

			<aside class="w-64 bg-surface-light dark:bg-surface-dark border-r border-gray-100 dark:border-gray-800 fixed h-full z-20">
			
			<div class="px-8 mb-8">
			<div class="flex flex-col items-center text-center p-6 rounded-2xl bg-slate-50 dark:bg-stone-900/50 border border-slate-100 dark:border-stone-800">
			<div class="w-20 h-20 rounded-full overflow-hidden mb-3 ring-2 ring-primary ring-offset-4 ring-offset-card-light dark:ring-offset-card-dark">
			<img alt="Ram Patil Profile Image" class="w-full h-full object-cover" src="https://static.vecteezy.com/system/resources/previews/005/129/844/original/profile-user-icon-isolated-on-white-background-eps10-free-vector.jpg"/>
			</div>
			<h3 class="font-semibold text-lg text-slate-900 dark:text-white"><%= userName %></h3>
			</div>
			</div>
			
			<nav class="mt-8 px-4 space-y-2">
			<a class="sidebar-link active flex items-center px-4 py-3 rounded-xl transition-all duration-200" href="dashboard.jsp">
			<span class="material-symbols-outlined mr-3">dashboard</span>
			<span class="font-medium">Dashboard</span>
			</a>
			<a class="sidebar-link flex items-center px-4 py-3 rounded-xl hover:bg-gray-50 dark:hover:bg-gray-800 text-gray-500 dark:text-gray-400 transition-all duration-200" href="view-bookings.jsp">
			<span class="material-symbols-outlined mr-3">calendar_month</span>
			<span class="font-medium">Appointments</span>
			</a>
			
			<!-- Burron for Salon Join Requests -->
			<a class="sidebar-link flex items-center px-4 py-3 rounded-xl hover:bg-gray-50 dark:hover:bg-gray-800 text-gray-500 dark:text-gray-400 transition-all duration-200" href="therapist-requests.jsp">
			<span class="material-symbols-outlined mr-3">group_add</span>
			<span class="font-medium">Therapist Join Requests</span>
			</a>
			
			
			
			<a class="sidebar-link flex items-center px-4 py-3 rounded-xl hover:bg-gray-50 dark:hover:bg-gray-800 text-gray-500 dark:text-gray-400 transition-all duration-200" href="view-therapists.jsp">
			<span class="material-symbols-outlined mr-3">group</span>
			<span class="font-medium">Staff</span>
			</a>
			<a class="sidebar-link flex items-center px-4 py-3 rounded-xl hover:bg-gray-50 dark:hover:bg-gray-800 text-gray-500 dark:text-gray-400 transition-all duration-200" href="view-services.jsp">
			<span class="material-symbols-outlined mr-3">content_cut</span>
			<span class="font-medium">Services</span>
			</a>
			<a class="sidebar-link flex items-center px-4 py-3 rounded-xl hover:bg-gray-50 dark:hover:bg-gray-800 text-gray-500 dark:text-gray-400 transition-all duration-200" href="view-salon.jsp">
			<span class="material-symbols-outlined mr-3">monitoring</span>
			<span class="font-medium">Salon</span>
			</a>
			<a class="sidebar-link flex items-center px-4 py-3 rounded-xl hover:bg-gray-50 dark:hover:bg-gray-800 text-gray-500 dark:text-gray-400 transition-all duration-200 mt-10" href="view-ratings.jsp">
			<span class="material-symbols-outlined mr-3"><svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#1f1f1f"><path d="M580-360q33 0 56.5-23.5T660-440q0-33-23.5-56.5T580-520q-15 0-28.5 5.5T527-500l-107-54v-12l107-54q11 9 24.5 14.5T580-600q33 0 56.5-23.5T660-680q0-33-23.5-56.5T580-760q-33 0-56.5 23.5T500-680v6l-107 54q-11-9-24.5-14.5T340-640q-33 0-56.5 23.5T260-560q0 33 23.5 56.5T340-480q15 0 28.5-5.5T393-500l107 54v6q0 33 23.5 56.5T580-360ZM80-80v-720q0-33 23.5-56.5T160-880h640q33 0 56.5 23.5T880-800v480q0 33-23.5 56.5T800-240H240L80-80Zm126-240h594v-480H160v525l46-45Zm-46 0v-480 480Z"/></svg></span>
			<span class="font-medium">Ratings</span>
			</a>
			</nav>
			<div class="absolute bottom-0 w-full p-6 border-t border-gray-100 dark:border-gray-800">
			<div class="flex items-center gap-3">
			<div class="w-10 h-10 rounded-full bg-primary flex items-center justify-center text-white font-bold">SO</div>
			<div class="overflow-hidden">
			<p class="text-sm font-bold truncate">Luxe Spa Owner</p>
			<p class="text-xs text-gray-500">Business Plan</p>
			</div>
			</div>
			</div>
			</aside>
			<main class="flex-1 ml-64 p-8">
			<header class="flex justify-between items-center mb-10">
			<div>
			<h1 class="text-3xl font-bold text-gray-900 dark:text-white">Good morning, <%= userName %></h1>
			</div>
			<div class="flex items-center gap-4">
			<button class="p-2.5 rounded-full bg-white dark:bg-surface-dark border border-gray-100 dark:border-gray-800 text-gray-500 shadow-sm">
			<span class="material-symbols-outlined">notifications</span>
			</button>
			<%
			    LocalDate today = LocalDate.now();
			    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEEE, dd MMM yyyy");
			    String currentDate = today.format(formatter);
			%>
			
			<div class="flex items-center gap-2 bg-white dark:bg-surface-dark px-4 py-2 rounded-full border border-gray-100 dark:border-gray-800 shadow-sm">
			    <span class="material-symbols-outlined text-secondary">calendar_today</span>
			    <span class="text-sm font-medium"><%= currentDate %></span>
			</div>

			</div>
			</header>
			<div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-10">
			<div class="bg-surface-light dark:bg-surface-dark p-6 rounded-[2rem] border border-gray-100 dark:border-gray-800 shadow-sm hover:shadow-md transition">
			<div class="flex justify-between items-start mb-4">
			<div class="p-3 bg-green-50 dark:bg-green-900/20 rounded-2xl">
			<span class="material-symbols-outlined text-secondary">payments</span>
			</div>
			<span class="text-xs font-bold text-secondary bg-green-50 dark:bg-green-900/20 px-2 py-1 rounded-full">+12.5%</span>
			</div>
			<p class="text-gray-500 text-sm font-medium">Total Revenue</p>
			<h3 class="text-2xl font-bold text-gray-900 dark:text-white mt-1">
			    ₹<%= totalRevenue %>
			</h3>
			
			
			<p class="text-xs text-gray-400 mt-2">vs. last month ($11,100)</p>
			</div>
			<div class="bg-surface-light dark:bg-surface-dark p-6 rounded-[2rem] border border-gray-100 dark:border-gray-800 shadow-sm hover:shadow-md transition">
			<div class="flex justify-between items-start mb-4">
			<div class="p-3 bg-pink-50 dark:bg-pink-900/20 rounded-2xl text-primary">
			<span class="material-symbols-outlined">event_available</span>
			</div>
			</div>
			<p class="text-gray-500 text-sm font-medium">Upcoming Appointments</p>
			<h3 class="text-2xl font-bold text-gray-900 dark:text-white mt-1">
			    <%= upcomingAppointments %>
			</h3>
			<p class="text-xs text-gray-400 mt-2">8 confirmed for today</p>
			</div>
			<div class="bg-surface-light dark:bg-surface-dark p-6 rounded-[2rem] border border-gray-100 dark:border-gray-800 shadow-sm hover:shadow-md transition">
			<div class="flex justify-between items-start mb-4">
			<div class="p-3 bg-blue-50 dark:bg-blue-900/20 rounded-2xl text-blue-500">
			<span class="material-symbols-outlined">badge</span>
			</div>
			</div>
			<p class="text-gray-500 text-sm font-medium">Active Staff</p>
			<h3 class="text-2xl font-bold text-gray-900 dark:text-white mt-1">
			    <%= activeStaff %>
			</h3>
			<p class="text-xs text-gray-400 mt-2">3 staff on leave today</p>
			</div>
</div>
<div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
<div class="lg:col-span-2 bg-surface-light dark:bg-surface-dark rounded-[2rem] border border-gray-100 dark:border-gray-800 shadow-sm overflow-hidden">
<div class="p-6 border-b border-gray-100 dark:border-gray-800 flex justify-between items-center">
<h3 class="text-xl font-bold text-gray-900 dark:text-white">Recent Appointments</h3>
<button class="text-primary text-sm font-bold hover:underline">View All</button>
</div>
<div class="overflow-x-auto">

<table class="w-full text-left">
    <thead>
        <tr class="bg-gray-50 dark:bg-gray-800/50">
            <th class="px-6 py-4 text-xs font-bold text-gray-500 uppercase tracking-wider">Client Name</th>
            <th class="px-6 py-4 text-xs font-bold text-gray-500 uppercase tracking-wider">Service</th>
            <th class="px-6 py-4 text-xs font-bold text-gray-500 uppercase tracking-wider">Assigned Staff</th>
            <th class="px-6 py-4 text-xs font-bold text-gray-500 uppercase tracking-wider">Status</th>
        </tr>
    </thead>

<%
    

    try {
        con = DBConnection.getConnection();

        String sql =
            "SELECT a.status, " +
            "u.name AS client_name, " +
            "s.name AS service_name, " +
            "t.name AS therapist_name " +
            "FROM appointments a " +
            "JOIN users u ON a.user_id = u.id " +
            "JOIN services s ON a.service_id = s.id " +
            "JOIN therapists t ON a.therapist_id = t.id " +
            "JOIN salons sl ON a.salon_id = sl.id " +
            "WHERE sl.owner_id = ? " +
            "ORDER BY a.created_at DESC " +
            "LIMIT 5";

        ps = con.prepareStatement(sql);
        ps.setInt(1, ownerId);
        rs = ps.executeQuery();
%>

    <tbody class="divide-y divide-gray-100 dark:divide-gray-800">
    <%
        while (rs.next()) {
            String status = rs.getString("status");
    %>
        <tr class="hover:bg-gray-50 dark:hover:bg-gray-800/30 transition">
            <!-- Client -->
            <td class="px-6 py-4">
                <div class="flex items-center">
                    <div class="w-8 h-8 rounded-full bg-gray-200 mr-3 overflow-hidden">
                        <img 
                            src="<%= request.getContextPath() %>/images/default-user.jpg"
                            alt="User"
                            class="w-full h-full object-cover"
                        />
                    </div>
                    <span class="font-medium"><%= rs.getString("client_name") %></span>
                </div>
            </td>

            <!-- Service -->
            <td class="px-6 py-4 text-sm">
                <%= rs.getString("service_name") %>
            </td>

            <!-- Therapist -->
            <td class="px-6 py-4 text-sm">
                <%= rs.getString("therapist_name") %>
            </td>

            <!-- Status -->
            <td class="px-6 py-4">
                <%
                    if ("PENDING".equalsIgnoreCase(status)) {
                %>
                    <span class="px-3 py-1 bg-yellow-100 dark:bg-yellow-900/30 text-yellow-700 dark:text-yellow-400 text-xs font-bold rounded-full">
                        Pending
                    </span>
                <%
                    } else if ("APPROVED".equalsIgnoreCase(status)) {
                %>
                    <span class="px-3 py-1 bg-green-100 dark:bg-green-900/30 text-green-700 dark:text-green-400 text-xs font-bold rounded-full">
                        Confirmed
                    </span>
                <%
                    } else if ("COMPLETED".equalsIgnoreCase(status)) {
                %>
                    <span class="px-3 py-1 bg-gray-100 dark:bg-gray-700 text-gray-500 dark:text-gray-400 text-xs font-bold rounded-full">
                        Completed
                    </span>
                <%
                    } else {
                %>
                    <span class="px-3 py-1 bg-gray-100 text-gray-500 text-xs font-bold rounded-full">
                        Rejected
                    </span>
                <%
                    }
                %>
            </td>
        </tr>
    <%
        }
    %>
    </tbody>

<%
} catch (Exception e) {
    e.printStackTrace();
} finally {
    try { if (rs != null) rs.close(); } catch (Exception ignored) {}
    try { if (ps != null) ps.close(); } catch (Exception ignored) {}
    try { if (con != null) con.close(); } catch (Exception ignored) {}
}
%>


</table>



</div>
</div>
		<div class="bg-surface-light dark:bg-surface-dark p-8 rounded-[2rem] border border-gray-100 dark:border-gray-800 shadow-sm">
		<h3 class="text-xl font-bold text-gray-900 dark:text-white mb-6">Quick Actions</h3>
		<div class="space-y-4">
		
	     <a href="view-therapists.jsp"
		   class="w-full flex items-center justify-between p-4 bg-primary/5 hover:bg-primary/10 text-primary border border-primary/20 rounded-2xl transition group">
		
		    <div class="flex items-center">
		        <span class="material-symbols-outlined mr-3">person_add</span>
		        <span class="font-bold">Add New Staff</span>
		    </div>
		
		    <span class="material-symbols-outlined text-sm group-hover:translate-x-1 transition">
		        arrow_forward_ios
		    </span>
		</a>
		
		
		
		<a href="dashboard.jsp"
		   class="w-full flex items-center justify-between p-4 bg-secondary/5 hover:bg-secondary/10 text-secondary border border-secondary/20 rounded-2xl transition group">
		
		    <div class="flex items-center">
		        <span class="material-symbols-outlined mr-3">campaign</span>
		        <span class="font-bold">Create Promotion</span>
		    </div>
		
		    <span class="material-symbols-outlined text-sm group-hover:translate-x-1 transition">
		        arrow_forward_ios
		    </span>
		</a>
		
		
		<a href="view-services.jsp"
		   class="w-full flex items-center justify-between p-4 bg-gray-50 dark:bg-gray-800/50 hover:bg-gray-100 dark:hover:bg-gray-800 text-gray-700 dark:text-gray-300 border border-transparent rounded-2xl transition group">
		
		    <div class="flex items-center">
		        <span class="material-symbols-outlined mr-3">add_box</span>
		        <span class="font-bold">New Service</span>
		    </div>
		
		    <span class="material-symbols-outlined text-sm group-hover:translate-x-1 transition">
		        arrow_forward_ios
		    </span>
		</a>
			     
		
		
		
		</div>
		<div class="mt-10 p-6 bg-gradient-to-br from-gray-900 to-gray-800 dark:from-gray-800 dark:to-gray-900 rounded-3xl relative overflow-hidden text-white">
		<div class="relative z-10">
		<h4 class="font-display font-bold text-lg mb-2">Need Help?</h4>
		<p class="text-xs text-gray-300 mb-4">Check our documentation or contact support for any issues.</p>
		<button class="bg-white text-gray-900 text-xs font-bold px-4 py-2 rounded-full">Support Center</button>
		</div>
		<span class="material-symbols-outlined absolute -bottom-4 -right-4 text-white/10 text-8xl">contact_support</span>
		</div>
		</div>
		</div>
		</main>


<script>
const themeToggleBtn = document.getElementById('theme-toggle');
const darkIcon = '<span class="material-symbols-outlined">dark_mode</span>';
const lightIcon = '<span class="material-symbols-outlined">light_mode</span>';

if (localStorage.getItem('color-theme') === 'dark') {
    document.documentElement.classList.add('dark');
    themeToggleBtn.innerHTML = lightIcon;
} else {
    themeToggleBtn.innerHTML = darkIcon;
}

themeToggleBtn.addEventListener('click', function() {
    document.documentElement.classList.toggle('dark');

    if (document.documentElement.classList.contains('dark')) {
        localStorage.setItem('color-theme', 'dark');
        this.innerHTML = lightIcon;
    } else {
        localStorage.setItem('color-theme', 'light');
        this.innerHTML = darkIcon;
    }
});
</script>

</body></html>