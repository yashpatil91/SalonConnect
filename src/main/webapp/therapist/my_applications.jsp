<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>

<%
    List<Object[]> applications =
        (List<Object[]>) request.getAttribute("applications");
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Applications</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Lato:wght@300;400;700&display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
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
<body>

<div class="flex h-screen">
	<!-- Sidebar -->
	<aside class="w-64 bg-white border-r shadow-sm flex flex-col">
		<div class="p-6 text-xl font-display font-bold text-primary">
		<span class="material-symbols-outlined text-primary text-3xl mr-2">spa</span>
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
					class="block px-4 py-3 rounded-lg text-gray-600 hover:bg-gray-100">
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
				 <a href="#"
					class="block px-4 py-3 rounded-lg text-gray-600 hover:bg-gray-100">
					Settings
				</a> 
				<a href="<%=request.getContextPath()%>/therapist/my-applications"
				class="block px-4 py-3 rounded-lg bg-primary/10 text-primary font-bold">
					My Applications </a>
					
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
				class="h-24 bg-background-light dark:bg-background-dark border-b flex items-center justify-between px-10 z-10">
				<div>
					<h1 class="text-3xl font-bold">My Applications</h1>

				

				</div>
				<div class="flex items-center space-x-6">
					
					
			

					

				</div>



			
		<div class="flex justify-between items-center">
				<span class="text-sm text-gray-500">
				Welcome, ${sessionScope.userName}
			</span>
			
			<!-- button for dark and white mode  -->
	<button
						class="p-2 rounded-full hover:bg-gray-100 dark:hover:bg-gray-700 text-gray-500 dark:text-gray-400"
						id="theme-toggle">
						<span class="material-icons">brightness_4</span>
					</button>
							
	

		</div>
	</header>















<% if (applications == null || applications.isEmpty()) { %>
    <p>You have not applied to any salons yet.</p>
<% } else { %>
    <table border="1" cellpadding="8" >
        <tr>
            <th>Salon Name</th>
            <th>City</th>
            <th>Status</th>
            <th>Applied On</th>
        </tr>

        <% for (Object[] row : applications) { %>
        <tr>
            <td><%= row[0] %></td>
            <td><%= row[1] %></td>
            <td><%= row[2] %></td>
            <td><%= row[3] %></td>
        </tr>
        <% } %>
    </table>
<% } %>



<script>
		const themeToggleBtn = document.getElementById('theme-toggle');
		const darkIcon = '<span class="material-icons">dark_mode</span>';
		const lightIcon = '<span class="material-icons">light_mode</span>';

		if (localStorage.getItem('color-theme') === 'dark'
				|| (!('color-theme' in localStorage) && window
						.matchMedia('(prefers-color-scheme: dark)').matches)) {
			document.documentElement.classList.add('dark');
			themeToggleBtn.innerHTML = lightIcon;
		} else {
			document.documentElement.classList.remove('dark');
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
	</main>
	</div>
	
</body>
</html>
