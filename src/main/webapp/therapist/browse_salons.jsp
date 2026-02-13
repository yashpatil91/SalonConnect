<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.model.Salon" %>
<%@ page import="com.model.Therapist" %>
<%@ page import="com.dao.TherapistDAO" %>
<%@ page import="com.dao.TherapistRequestDAO" %>

<%
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    int userId = (int) session.getAttribute("userId");

    Therapist therapist =
        new TherapistDAO().getTherapistByUserId(userId);

    TherapistRequestDAO requestDAO =
        new TherapistRequestDAO();

    List<Salon> salons =
        (List<Salon>) request.getAttribute("salons");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Browse Salons</title>
    
<script src="https://cdn.tailwindcss.com"></script>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Lato:wght@300;400;700&display=swap" rel="stylesheet"/>

<script>
tailwind.config = {
	darkMode: "class",
	theme: {
		extend: {
			colors: {
				primary: "#D8A48F",
				secondary: "#8FBC8F",
				"background-light": "#FDFBF7",
				"surface-light": "#FFFFFF"
			},
			fontFamily: {
				display: ["Playfair Display", "serif"],
				body: ["Lato", "sans-serif"]
			}
		}
	}
}
</script>
    
    
    <style>
body { font-family: 'Lato', sans-serif; }
h1,h2,h3 { font-family: 'Playfair Display', serif; }

type="text/tailwindcss">
        body {
            font-family: 'Lato', sans-serif;
        }
        h1, h2, h3, h4, h5, h6 {
            font-family: 'Playfair Display', serif;
        }.sidebar-item-active {
            @apply bg-nav-active-bg text-primary relative;
        }
        .sidebar-item-active::after {
            content: '';
            @apply absolute right-0 top-0 bottom-0 w-1.5 bg-primary rounded-l-md;
        }
        .custom-scrollbar::-webkit-scrollbar {
            width: 4px;
        }
        .custom-scrollbar::-webkit-scrollbar-track {
            background: transparent;
        }
        .custom-scrollbar::-webkit-scrollbar-thumb {
            background: #D8A48F55;
            border-radius: 10px;
        }
    
</style>
</head>
 <body class="bg-background-light text-gray-800">

<div class="flex h-screen">

	<!-- Sidebar -->
	<aside class="w-64 bg-white border-r shadow-sm flex flex-col">
		<div class="p-6 text-xl font-display font-bold text-primary">
			SalonConnect
		
		</div>

		<nav class="flex-1 px-4 space-y-2">
			<a href="${pageContext.request.contextPath}/therapist/dashboard"
				class="block px-4 py-3 rounded-lg text-gray-600 hover:bg-gray-100">
				Dashboard
			</a>

			<a href="${pageContext.request.contextPath}/therapist/schedule"
				class="block px-4 py-3 rounded-lg text-gray-600 hover:bg-gray-100">
				My Schedule
			</a>
					<a href="<%=request.getContextPath()%>/therapist/browse-salons"
					class="block px-4 py-3 rounded-lg bg-primary/10 text-primary font-bold">
						 Browse Salons
				</a> 
				<a href="#"
					class="block px-4 py-3 rounded-lg text-gray-600 hover:bg-gray-100">
					Clients
				</a>
				 <a href="#"
					class="block px-4 py-3 rounded-lg text-gray-600 hover:bg-gray-100">
					Earnings
				</a> 
					
					<!-- Logout Button -->
					<div class="flex-1 p-4 overflow-y-auto">
					<a href="<%=request.getContextPath()%>/logout"
						class="px-6 py-2 bg-red-500 text-white rounded-full font-bold text-sm
              hover:bg-red-600 transition-all shadow-lg shadow-red-500/20">
						Logout </a>
					</div>
		</nav>
	</aside>
   
   <!-- Main Content -->
	<main class="flex-1 p-5 overflow-y-auto">

		<!-- Header -->
		<header
				class="h-24 bg-background-light dark:bg-background-dark border-b  flex items-center justify-between px-10 z-10">
				<div>
					<h1 class="text-3xl font-bold">Salons</h1>

				

				</div>
				


			
		<div class="flex justify-between items-center">
			
			<span class="text-sm text-gray-500">
				Welcome, ${sessionScope.userName}
			</span>
				<!-- button for dark and white mode  -->
										<button id="theme-toggle"
						class="p-2 rounded-full hover:bg-gray-100 dark:hover:bg-gray-700 text-gray-500 dark:text-gray-400">
						<span class="material-symbols-outlined">dark_mode</span>
					</button>
		

		</div>
	</header>
	

		

		


   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
<h2>Available Salons</h2>

<% if (salons == null || salons.isEmpty()) { %>

    <p>No salons available.</p>

<% } else { %>

<ul>
<% for (Salon s : salons) {

       String status =
           requestDAO.getRequestStatus(
               therapist.getId(), s.getId());
%>

<li style="margin-bottom:12px;">
    <strong><%= s.getName() %></strong>
    (<%= s.getCity() %>)
    - Rating: <%= s.getRating() %>

    <% if (status == null) { %>

        <!-- Apply -->
        <form method="post"
              action="<%=request.getContextPath()%>/therapist/apply-salon"
              style="display:inline; margin-left:10px;">
            <input type="hidden" name="salonId" value="<%=s.getId()%>"/>
            <button type="submit">Apply</button>
        </form>

    <% } else if ("PENDING".equals(status)) { %>

        <span style="color:orange; margin-left:10px;">
            Status: Pending
        </span>

    <% } else if ("REJECTED".equals(status)) { %>

        <span style="color:red; margin-left:10px;">
            Status: Rejected
        </span>

    <% } else if ("APPROVED".equals(status)) { %>

        <span style="color:green; margin-left:10px;">
            Approved (Joined)
        </span>

    <% } %>
</li>

<% } %>
</ul>

<% } %>
</div>
	</main>
</body>
</html>
