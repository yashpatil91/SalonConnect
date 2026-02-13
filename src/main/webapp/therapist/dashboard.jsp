<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.dao.DBConnection"%>


<%@page
	import="java.time.LocalDate, java.time. format.DateTimeFormatter"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<title>Therapist Dashboard - SalonConnect</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">

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
            @apply absolute right-0 top-0 bottom-0 w-1.5  rounded-l-md;
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
		<aside
			class="w-64 bg-sidebar-bg dark:bg-surface-dark border-r border-gray-100 dark:border-gray-800 flex flex-col z-20 shadow-soft">
			<div class="p-8 flex items-center mb-2">
				<span class="material-symbols-outlined text-primary text-3xl mr-2">spa</span>
				<a href="<%= request.getContextPath() %>/index.jsp"
						class="font-display font-bold text-2xl text-gray-900 dark:text-white">SalonConnect</a>
			</div>
			<nav
				class="flex-1 px-6 space-y-4 overflow-y-auto custom-scrollbar pt-4">
				<a
					class="sidebar-item-active flex items-center px-4 py-3.5 rounded-lg text-sm font-bold transition-all"
					href="<%=request.getContextPath()%>/therapist/dashboard"> <span
					class="material-symbols-outlined mr-4 text-[22px]">dashboard</span>
					Dashboard
				</a> <a
					class="flex items-center px-4 py-3.5 text-gray-500 dark:text-gray-400 hover:bg-gray-50 dark:hover:bg-gray-800 rounded-lg text-sm font-bold transition-all group"
					href="<%=request.getContextPath()%>/therapist/schedule"> <span
					class="material-symbols-outlined mr-4 text-[22px] group-hover:text-primary transition-colors">calendar_month</span>
					My Schedule
				</a> <a
					class="flex items-center px-4 py-3.5 text-gray-500 dark:text-gray-400 hover:bg-gray-creation dark:hover:bg-gray-800 rounded-lg text-sm font-bold transition-all group"
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
				</a> <span
					class="material-symbols-outlined mr-4 text-[22px] group-hover:text-primary transition-colors">work</span>
				<a href="<%=request.getContextPath()%>/therapist/my-applications">
					My Applications </a>



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
		<main
			class="flex-1 flex flex-col overflow-hidden bg-background-light dark:bg-background-dark">
			<header
				class="h-24 bg-background-light dark:bg-background-dark border-b border-transparent flex items-center justify-between px-10 z-10">
				<div>
					<h1
						class="text-3xl font-display font-bold text-gray-900 dark:text-white">
						Welcome back, ${therapist.name}</h1>

					<p class="mt-2">
						<span
							class="px-3 py-1 text-xs bg-primary/10 text-primary rounded-full font-bold">
							${therapist.salonName} </span>
					</p>

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
			<div class="flex-1 overflow-y-auto px-10 pb-10 custom-scrollbar">
				<div class="grid grid-cols-1 md:grid-cols-3 gap-8 mb-10">
					<div
						class="bg-surface-light dark:bg-surface-dark p-8 rounded-[2rem] border border-transparent shadow-[0_8px_30px_rgb(0,0,0,0.04)] hover:shadow-[0_8px_30px_rgb(0,0,0,0.08)] transition-all">
						<div class="flex items-start justify-between mb-6">
							<div class="p-3 bg-nav-active-bg rounded-2xl">
								<span class="material-symbols-outlined text-primary text-2xl">event_available</span>
							</div>
							<span
								class="text-[10px] font-bold text-secondary uppercase tracking-wider py-1 px-2 bg-secondary/10 rounded-lg">+2
								from yesterday</span>
						</div>
						<p
							class="text-sm font-medium text-gray-500 dark:text-gray-400 mb-2">Total
							Appointments Today</p>

						<h3
							class="text-4xl font-display font-bold text-gray-900 dark:text-white">
							${todayCount} Sessions</h3>


					</div>
					<div
						class="bg-surface-light dark:bg-surface-dark p-8 rounded-[2rem] border border-transparent shadow-[0_8px_30px_rgb(0,0,0,0.04)] hover:shadow-[0_8px_30px_rgb(0,0,0,0.08)] transition-all">
						<div class="flex items-start justify-between mb-6">
							<div class="p-3 bg-secondary/10 rounded-2xl">
								<span class="material-symbols-outlined text-secondary text-2xl">schedule</span>
							</div>
							<span
								class="text-[10px] font-bold text-gray-400 uppercase tracking-wider py-1 px-2 bg-gray-100 dark:bg-gray-800 rounded-lg">Starts
								in 15m</span>
						</div>
						<p
							class="text-sm font-medium text-gray-500 dark:text-gray-400 mb-2">Upcoming
							Next</p>

						<c:choose>
							<c:when test="${not empty nextAppointment}">
								<h3
									class="text-3xl font-display font-bold text-gray-900 dark:text-white leading-tight">
									${nextAppointment.clientName}</h3>
								<p class="text-sm text-gray-400 mt-1 font-medium">
									${nextAppointment.serviceName}</p>
							</c:when>
							<c:otherwise>
								<h3 class="text-2xl font-display font-bold text-gray-400">
									No upcoming appointments</h3>
							</c:otherwise>
						</c:choose>



					</div>
					<div
						class="bg-surface-light dark:bg-surface-dark p-8 rounded-[2rem] border border-transparent shadow-[0_8px_30px_rgb(0,0,0,0.04)] hover:shadow-[0_8px_30px_rgb(0,0,0,0.08)] transition-all">
						<div class="flex items-start justify-between mb-6">
							<div class="p-3 bg-blue-50 dark:bg-blue-900/20 rounded-2xl">
								<span class="material-symbols-outlined text-blue-500 text-2xl">payments</span>
							</div>
							<span
								class="text-[10px] font-bold text-blue-500 uppercase tracking-wider py-1 px-2 bg-blue-50 dark:bg-blue-900/20 rounded-lg">On
								track</span>
						</div>
						<p
							class="text-sm font-medium text-gray-500 dark:text-gray-400 mb-2">Total
							Earnings</p>

						<h3
							class="text-4xl font-display font-bold text-gray-900 dark:text-white">
							₹ ${weeklyEarnings}</h3>



					</div>
				</div>
				<div class="grid grid-cols-1 lg:grid-cols-3 gap-10">
					<div class="lg:col-span-2 space-y-8">
						<div class="flex items-center justify-between">
							<h2
								class="text-2xl font-display font-bold text-gray-900 dark:text-white">Today's
								Agenda</h2>
							<%
							LocalDate today = LocalDate.now();
							DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEEE, MMM dd");
							String formattedDate = today.format(formatter);
							%>

							<span
								class="text-sm font-bold text-primary bg-primary/10 px-3 py-1 rounded-lg">
								<%=formattedDate%>
							</span>
						</div>
						<div class="space-y-5">

							<c:forEach var="appt" items="${todayAppointments}">

								<div
									class="bg-surface-light dark:bg-surface-dark p-1 rounded-[2rem] border border-gray-100 dark:border-gray-800 shadow-sm hover:shadow-lg hover:-translate-y-0.5 transition-all duration-300">


									<div class="flex-1 flex items-center p-5">

										<div
											class="w-24 flex-shrink-0 text-center border-r border-gray-100 dark:border-gray-700 mr-6">
											<p class="text-sm font-bold text-primary">

												<fmt:formatDate value="${appt.appointmentDate}"
													pattern="dd MMM yyyy" />
												<br />
												<fmt:formatDate value="${appt.appointmentTime}"
													pattern="hh:mm a" />

											</p>


										</div>

										<div class="flex-1">
											<div class="flex items-center justify-between mb-1.5">

												<h4
													class="text-lg font-bold text-gray-900 dark:text-white font-display">
													${appt.clientName}</h4>

												<span
													class="px-3 py-1 text-[10px] font-bold uppercase rounded-full
                        ${appt.status eq 'COMPLETED' ? 
                          'bg-green-50 text-green-600' : 
                          appt.status eq 'APPROVED' ? 
                          'bg-blue-50 text-blue-600' : 
                          'bg-gray-100 text-gray-600'}">

													${appt.status} </span>

											</div>

											<p
												class="text-sm text-gray-500 dark:text-gray-400 flex items-center font-medium">
												${appt.serviceName}</p>
										</div>

										<!-- Complete Button -->
										<!--<c:if test="${appt.status eq 'APPROVED'}">
											<form method="post"
												action="${pageContext.request.contextPath}/therapist/completeAppointment">

												<input type="hidden" name="appointmentId" value="${appt.id}" />

												<button type="submit"
													class="ml-4 px-4 py-2 bg-primary text-white rounded-full text-xs font-bold hover:bg-[#c99683] transition-all">
													Complete</button>

											</form> -->
										</c:if>

									</div>

								</div>

							</c:forEach>

							<c:if test="${empty todayAppointments}">
								<div class="text-center text-gray-400 py-10">No
									appointments today.</div>
							</c:if>

							<div class="border-t border-gray-100 dark:border-gray-800 my-10"></div>

							<!-- ================== UPCOMING APPOINTMENTS ================== -->

							<div class="mt-12">
								<h2
									class="text-2xl font-display font-bold text-gray-900 dark:text-white mb-6">
									Upcoming Appointments</h2>

								<c:forEach var="up" items="${upcomingAppointments}">

									<c:if test="${up.status ne 'COMPLETED'}">

										<div
											class="bg-surface-light dark:bg-surface-dark p-5 rounded-2xl shadow-sm mb-4 border border-gray-100 dark:border-gray-700">

											<div class="flex justify-between items-center">

												<div>
													<h4 class="font-bold text-gray-900 dark:text-white">
														${up.clientName}</h4>

													<p class="text-sm text-gray-500">${up.serviceName}</p>
												</div>

												<div class="text-right">
													<!--  <p class="text-sm font-bold text-primary">
														${up.appointmentTime}</p> -->
													<fmt:formatDate value="${up.appointmentDate}"
														pattern="dd MMM yyyy" />
													<br />
													<fmt:formatDate value="${up.appointmentTime}"
														pattern="hh:mm a" />

													<span
														class="px-3 py-1 text-[10px] font-bold uppercase rounded-full
                            ${up.status eq 'APPROVED' ? 
                              'bg-blue-50 text-blue-600' : 
                              'bg-gray-100 text-gray-600'}">

														${up.status} </span>
												</div>

											</div>

										</div>

									</c:if>

								</c:forEach>

								<c:if test="${empty upcomingAppointments}">
									<div class="text-center text-gray-400 py-6">No upcoming
										appointments.</div>
								</c:if>
							</div>

						</div>

					</div>






					<div class="space-y-8">
						<div class="flex items-center justify-between">
							<h2
								class="text-2xl font-display font-bold text-gray-900 dark:text-white">Client
								Notes</h2>
						</div>


						<div
							class="bg-surface-light dark:bg-surface-dark p-8 rounded-[2rem] shadow-soft">
							<h2 class="text-2xl font-display font-bold mb-6">⭐ Your
								Ratings</h2>

							<div class="flex items-center mb-6">
								<span class="text-yellow-500 text-xl mr-2">★</span> <span
									class="text-lg font-bold"> ${therapist.rating} </span> <span
									class="text-sm text-gray-500 ml-2">Average Rating</span>
							</div>

							<c:if test="${empty ratings}">
								<p class="text-gray-400 text-sm">No reviews yet.</p>
							</c:if>

							<c:forEach var="r" items="${ratings}">
								<div class="mb-4 p-4 bg-gray-50 dark:bg-gray-800 rounded-xl">
									<div class="flex justify-between items-center mb-1">
										<span class="font-bold text-sm text-yellow-500"> ★
											${r.rating}/5 </span> <span class="text-xs text-gray-400">
											${r.createdAt} </span>
									</div>

									<p class="text-sm text-gray-600 dark:text-gray-300">
										${r.review}</p>
								</div>
							</c:forEach>
						</div>



						
						
					</div>
				</div>
			</div>
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