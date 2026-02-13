<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.dao.TherapistRequestDAO"%>
<%@ page import="com.model.Therapist"%>

<%
if (session == null || session.getAttribute("userId") == null) {
	response.sendRedirect(request.getContextPath() + "/login.jsp");
	return;
}

String userName = (String) session.getAttribute("userName");
int ownerId = (int) session.getAttribute("userId");

TherapistRequestDAO dao = new TherapistRequestDAO();
List<Therapist> requests = dao.getPendingRequestsForOwner(ownerId);
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Approved Bookings - SalonConnect</title>

<script src="https://cdn.tailwindcss.com?plugins=forms,typography"></script>
<link
	href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Lato:wght@300;400;700&display=swap"
	rel="stylesheet" />
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet" />
<link rel="icon" type="image/png"
	href="<%=request.getContextPath()%>/images/icon.jpeg">
<script>
	tailwind.config = {
		darkMode : "class",
		theme : {
			extend : {
				colors : {
					primary : "#D8A48F",
					"background-light" : "#FDFBF7",
					"background-dark" : "#1F1B1A",
					"surface-light" : "#FFFFFF",
					"surface-dark" : "#2D2625"
				},
				fontFamily : {
					display : [ "Playfair Display", "serif" ],
					body : [ "Lato", "sans-serif" ]
				}
			}
		}
	}
</script>

<style>
body {
	font-family: 'Lato', sans-serif;
}

h1, h2, h3, h4 {
	font-family: 'Playfair Display', serif;
}
</style>
</head>

<body
	class="bg-background-light dark:bg-background-dark text-gray-800 dark:text-gray-200 transition-colors duration-300 overflow-x-hidden">


	<!-- NAVBAR -->
	<nav
		class="sticky top-0 z-50 bg-surface-light/90 dark:bg-surface-dark/90 backdrop-blur border-b shadow-sm">
		<div
			class="max-w-7xl mx-auto px-6 h-20 flex justify-between items-center">
			<div class="flex items-center">
				<span class="material-icons text-primary text-3xl mr-2">spa</span> <a
					href="<%=request.getContextPath()%>/index.jsp"
					class="font-display font-bold text-2xl text-gray-900 dark:text-white">
					SalonConnect </a>
			</div>
			<div class="flex items-center space-x-4">
				<a href="dashboard.jsp" class="hover:text-primary">Dashboard</a> <a
					href="view-bookings.jsp" class="hover:text-primary">Pending</a> <span><%=userName%></span>
				<button
					class="p-2 rounded-full hover:bg-gray-100 dark:hover:bg-gray-700 text-gray-500 dark:text-gray-400"
					id="theme-toggle">
					<span class="material-icons">brightness_4</span>
				</button>
				<a href="<%=request.getContextPath()%>/logout"
					class="bg-red-500 text-white px-4 py-2 rounded-full text-sm font-bold hover:bg-red-600">
					Logout </a>
			</div>
		</div>
	</nav>



	<div class="max-w-7xl mx-auto px-6 py-12">

		<!-- Page Title -->
		<div class="text-center mb-8">
			<h1
				class="text-3xl font-display font-bold text-gray-900 dark:text-white">
				Pending Therapist Requests</h1>
			<p class="text-gray-500 dark:text-gray-400 mt-2">Review and
				approve therapist applications</p>
		</div>

		<%
		if (requests == null || requests.isEmpty()) {
		%>

		<!-- Empty State -->
		<div
			class="bg-white dark:bg-surface-dark rounded-2xl shadow-md p-10 text-center border border-gray-100 dark:border-gray-800">
			<span class="material-icons text-primary text-5xl mb-4">groups</span>
			<h3 class="text-lg font-semibold mb-2">No Pending Requests</h3>
			<p class="text-gray-500 dark:text-gray-400">You currently have no
				therapist applications waiting for approval.</p>
		</div>

		<%
		} else {
		%>

		<div
			class="bg-white dark:bg-surface-dark rounded-2xl shadow-lg border border-gray-100 dark:border-gray-800 overflow-hidden">

			<!-- Table Header -->
			<div
				class="grid grid-cols-5 bg-gray-50 dark:bg-gray-800 px-6 py-4 font-semibold text-sm uppercase tracking-wide text-gray-600 dark:text-gray-300">
				<div>Therapist</div>
				<div>Specialization</div>
				<div>Experience</div>
				<div class="col-span-2 text-center">Actions</div>
			</div>

			<%
			for (Therapist t : requests) {
			%>

			<!-- Single Row -->
			<div
				class="grid grid-cols-5 items-center px-6 py-5 border-t border-gray-100 dark:border-gray-800 hover:bg-gray-50 dark:hover:bg-gray-900 transition">

				<!-- Name -->
				<div class="flex items-center gap-3">
					<div
						class="w-10 h-10 rounded-full bg-primary/20 flex items-center justify-center">
						<span class="material-icons text-primary text-lg">person</span>
					</div>
					<span class="font-medium text-gray-900 dark:text-white"> <%=t.getName()%>
					</span>
				</div>

				<!-- Specialization -->
				<div class="text-gray-600 dark:text-gray-300">
					<%=t.getSpecialization()%>
				</div>

				<!-- Experience -->
				<div class="text-gray-600 dark:text-gray-300">
					<%=t.getExperience()%>
					years
				</div>

				<!-- Approve -->
				<!-- Actions -->
				<div class="flex justify-center col-span-2  gap-2">

					<form
						action="<%=request.getContextPath()%>/owner/approve-therapist"
						method="post">
						<input type="hidden" name="therapistId" value="<%=t.getId()%>">
						<input type="hidden" name="salonId" value="<%=t.getSalonId()%>">
						<button type="submit"
							class="bg-green-500 hover:bg-green-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition">
							Approve</button>
					</form>

					<form action="<%=request.getContextPath()%>/owner/reject-therapist"
						method="post">
						<input type="hidden" name="therapistId" value="<%=t.getId()%>">
						<input type="hidden" name="salonId" value="<%=t.getSalonId()%>">
						<button type="submit"
							class="bg-red-500 hover:bg-red-600 text-white px-4 py-2 rounded-full text-sm font-semibold transition">
							Reject</button>
					</form>

				</div>
			</div>

			<%
			}
			%>

		</div>

		<%
		}
		%>

	</div>


	<script>
		        const themeToggleBtn = document.getElementById('theme-toggle');
		const darkIcon = '<span class="material-icons">dark_mode</span>';
		const lightIcon = '<span class="material-icons">light_mode</span>';
		// Check local storage or system preference
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
			// if set via local storage previously
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
				// if NOT set via local storage previously
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
