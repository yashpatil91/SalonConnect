<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.model.Salon"%>
<%@ page import="com.model.Therapist"%>
<%@ page import="com.dao.TherapistDAO"%>
<%@ page import="com.dao.TherapistRequestDAO"%>

<%
if (session == null || session.getAttribute("userId") == null) {
	response.sendRedirect(request.getContextPath() + "/login.jsp");
	return;
}

int userId = (int) session.getAttribute("userId");

Therapist therapist = new TherapistDAO().getTherapistByUserId(userId);

TherapistRequestDAO requestDAO = new TherapistRequestDAO();

List<Salon> salons = (List<Salon>) request.getAttribute("salons");
%>

<!DOCTYPE html>
<html>
<head>
<title>Browse Salons</title>

<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/icon?family=Material+Icons+Round"
	rel="stylesheet">

<script
	src="https://cdn.tailwindcss.com?plugins=forms,typography,container-queries"></script>
<link
	href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&amp;family=Lato:wght@300;400;700&amp;display=swap"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"
	rel="stylesheet" />
<script>
	tailwind.config = {
		darkMode : "class",
		theme : {
			extend : {
				colors : {
					primary : "#D8A48F", // Soft pastel terracotta/rose gold
					secondary : "#8FBC8F", // Soft sage green accent
					"background-light" : "#FDFBF7", // Warm off-white
					"background-dark" : "#1F1B1A", // Dark warm charcoal
					"surface-light" : "#FFFFFF",
					"surface-dark" : "#2D2625",
					"sidebar-bg" : "#FEFDFC", // Very light off-white for sidebar
					"nav-active-bg" : "#FFF5F0", // Very light peach for active item
				},
				fontFamily : {
					display : [ "Playfair Display", "serif" ],
					body : [ "Lato", "sans-serif" ],
				},
				borderRadius : {
					DEFAULT : "0.75rem",
				},
				boxShadow : {
					'soft' : '0 4px 20px -2px rgba(0, 0, 0, 0.05)',
				}
			},
		},
	};
</script>
<style type="text/tailwindcss">
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
            @apply absolute right-0 top-0 bottom-0 w-1.5 rounded-l-md;
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

<body
	class="bg-background-light dark:bg-background-dark text-gray-800 dark:text-gray-200 transition-colors duration-300 overflow-hidden">
	<div class="flex h-screen overflow-hidden">

		<!-- Sidebar -->
		<aside
			class="w-64 bg-sidebar-bg dark:bg-surface-dark border-r border-gray-100 dark:border-gray-800 flex flex-col z-20 shadow-soft">
			<div class="p-8 flex items-center mb-2">
				<span class="material-symbols-outlined text-primary text-3xl mr-2">spa</span>
				<a href="<%=request.getContextPath()%>/index.jsp"
					class="font-display font-bold text-2xl text-gray-900 dark:text-white">SalonConnect</a>
			</div>
			<nav
				class="flex-1 px-6 space-y-4 overflow-y-auto custom-scrollbar pt-4">
				<a
					class="flex items-center px-4 py-3.5 text-gray-500 dark:text-gray-400 hover:bg-gray-50 dark:hover:bg-gray-800 rounded-lg text-sm font-bold transition-all group"
					href="<%=request.getContextPath()%>/therapist/dashboard"> <span
					class="material-symbols-outlined mr-4 text-[22px]">dashboard</span>
					Dashboard
				</a> <a
					class="flex items-center px-4 py-3.5 text-gray-500 dark:text-gray-400 hover:bg-gray-50 dark:hover:bg-gray-800 rounded-lg text-sm font-bold transition-all group"
					href="<%=request.getContextPath()%>/therapist/schedule"> <span
					class="material-symbols-outlined mr-4 text-[22px] group-hover:text-primary transition-colors">calendar_month</span>
					My Schedule
				</a> <a
					class="sidebar-item-active flex items-center px-4 py-3.5 rounded-lg text-sm font-bold transition-all"
					href="<%=request.getContextPath()%>/therapist/browse-salons"> <span
					class="material-symbols-outlined mr-4 text-[22px] group-hover:text-primary transition-colors">
						store </span> Browse Salons
				</a> <a
					class="flex items-center px-4 py-3.5 text-gray-500 dark:text-gray-400 hover:bg-gray-50 dark:hover:bg-gray-800 rounded-lg text-sm font-bold transition-all group"
					href="#"> <span
					class="material-symbols-outlined mr-4 text-[22px] group-hover:text-primary transition-colors">group</span>
					Clients
				</a> <a
					class="flex items-center px-4 py-3.5 text-gray-500 dark:text-gray-400 hover:bg-gray-50 dark:hover:bg-gray-800 rounded-lg text-sm font-bold transition-all group"
					href="#"> <span
					class="material-symbols-outlined mr-4 text-[22px] group-hover:text-primary transition-colors">payments</span>
					Earnings

				</a> <a
					class="flex items-center px-4 py-3.5 text-gray-500 dark:text-gray-400 hover:bg-gray-50 dark:hover:bg-gray-800 rounded-lg text-sm font-bold transition-all group"
					href="#"> <span
					class="material-symbols-outlined mr-4 text-[22px] group-hover:text-primary transition-colors">settings</span>
					Settings
				</a> 
				<a
				 class="flex items-center px-4 py-3.5 text-gray-500 dark:text-gray-400 hover:bg-gray-50 dark:hover:bg-gray-800 rounded-lg text-sm font-bold transition-all group"
				 href="<%=request.getContextPath()%>/therapist/my-applications">
				<span class="material-symbols-outlined mr-4 text-[22px] group-hover:text-primary transition-colors">work</span>
				 My Applications
				  </a>



			</nav>
			<div
				class="p-6 border-t border-gray-100 dark:border-gray-800 mt-auto">
				<div class="flex items-center">
					<div class="relative">
						<img alt="Therapist Profile"
							class="w-10 h-10 rounded-full object-cover border border-gray-200"
							src="https://lh3.googleusercontent.com/aida-public/AB6AXuDGm2eey5s0LhIOz4XTm-OasNjcoyE2SPdPLD4L78f56LTEYHWCLPbPo8-3r7PlIJu9nHJD7WZLo2ZRBzeQ9_K0HGDt5yozkyA2OS3HbZw-R9EidiAeiwXloEsc0nbR4Ly-WnYF1Lu7KcDrdBLW4VNsUjKvRsyQUJK0RYhRTotDWpjkA0ha6yY7nkUyWMxgdPR71muZibAsRctG-5UBI4H7Ncoh3Ba5UdAdXM391OcQm9UEHa3QKSotlxPqB3o142haZatAwe7ugLt4" />
						<div
							class="absolute bottom-0 right-0 w-3 h-3 bg-secondary border-2 border-white dark:border-surface-dark rounded-full"></div>

					</div>
					<div class="ml-3 overflow-hidden">
						<p
							class="text-sm font-bold text-gray-900 dark:text-white truncate">${therapist.name}</p>
						<p class="text-xs text-gray-400 truncate font-medium">
							Therapist</p>
					</div>
				</div>
			</div>
		</aside>

		<!-- Main Content -->
		<main
			class="flex-1 flex flex-col overflow-hidden bg-background-light p-5 dark:bg-background-dark">

			<!-- Header -->
			<header
				class="h-24 bg-background-light dark:bg-background-dark border-b  flex items-center justify-between px-10 z-10">
				<div>
					<h1 class="text-3xl font-bold">Salons</h1>

				</div>

				<div class="flex items-center space-x-6">
					<!-- button for dark and white mode  -->
					<button
						class="p-2 rounded-full hover:bg-gray-100 dark:hover:bg-gray-700 text-gray-500 dark:text-gray-400"
						id="theme-toggle">
						<span class="material-icons">brightness_4</span>
					</button>




					<button
						class="p-2 text-gray-400 hover:text-primary transition-colors relative">
						<span class="material-symbols-outlined">notifications</span> <span
							class="absolute top-2 right-2 w-2 h-2 bg-red-400 rounded-full border border-white"></span>
					</button>


					<!-- button for home  -->
					<button>
						<a href="<%=request.getContextPath()%>/index.jsp"> <span
							class="material-symbols-outlined text-gray-400 hover:text-primary transition-colors">home</span>
						</a>
					</button>


					<!-- Logout Button -->
					<a href="<%=request.getContextPath()%>/logout"
						class="px-6 py-2 bg-red-500 text-white rounded-full font-bold text-sm
              hover:bg-red-600 transition-all shadow-lg shadow-red-500/20">
						Logout </a>

				</div>

			</header>



<%
if (salons == null || salons.isEmpty()) {
%>

<div class="text-center mt-20 text-gray-400 dark:text-gray-500">
    No salons available.
</div>

<%
} else {
%>

<div class="grid md:grid-cols-2 xl:grid-cols-3 gap-6 mt-6">

<%
for (Salon s : salons) {

    String status = requestDAO.getRequestStatus(therapist.getId(), s.getId());
%>

<div class="bg-white dark:bg-stone-800 
            rounded-2xl p-6 
            shadow-md hover:shadow-xl 
            transition-all duration-300 
            border border-gray-200 dark:border-stone-700">

    <!-- Salon Name -->
    <h3 class="text-xl font-bold text-gray-900 dark:text-white mb-2">
        <%= s.getName() %>
    </h3>

    <!-- City -->
    <p class="text-sm text-gray-600 dark:text-gray-300 mb-2">
        📍 <%= s.getCity() %>
    </p>

    <!-- Rating -->
    <p class="text-sm text-yellow-500 font-semibold mb-4">
        ⭐ Rating: <%= s.getRating() %>
    </p>

    <% if (status == null) { %>

        <!-- Apply Button -->
        <form method="post"
              action="<%=request.getContextPath()%>/therapist/apply-salon">
            <input type="hidden" name="salonId" value="<%=s.getId()%>" />

            <button type="submit"
                class="w-full py-2 bg-primary text-white rounded-full 
                       font-semibold hover:opacity-90 transition-all">
                Apply
            </button>
        </form>

    <% } else if ("PENDING".equals(status)) { %>

        <span class="inline-block px-4 py-2 text-sm font-semibold 
             bg-yellow-100 text-yellow-700 
             dark:bg-yellow-900 dark:text-yellow-300 
             rounded-full">
            Status: Pending
        </span>

    <% } else if ("REJECTED".equals(status)) { %>

        <span class="inline-block px-4 py-2 text-sm font-semibold 
                     bg-red-100 text-red-700 
                     dark:bg-red-900 dark:text-red-300 
                     rounded-full">
            Rejected
        </span>

    <% } else if ("APPROVED".equals(status)) { %>

        <span class="inline-block px-4 py-2 text-sm font-semibold 
                     bg-green-100 text-green-700 
                     dark:bg-green-900 dark:text-green-300 
                     rounded-full">
            Approved (Joined)
        </span>

    <% } %>

</div>

<%
}
%>

</div>

<%
}
%>

	</main>
</div>
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
</body>
</html>
