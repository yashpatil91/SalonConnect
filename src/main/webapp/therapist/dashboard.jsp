<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<%@page
	import="java.time.LocalDate, java.time. format.DateTimeFormatter"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<title>Therapist Dashboard - SalonConnect</title>
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
<body
	class="bg-background-light dark:bg-background-dark text-gray-800 dark:text-gray-200 transition-colors duration-300 overflow-hidden">
	<div class="flex h-screen overflow-hidden">
		<aside
			class="w-64 bg-sidebar-bg dark:bg-surface-dark border-r border-gray-100 dark:border-gray-800 flex flex-col z-20 shadow-soft">
			<div class="p-8 flex items-center mb-2">
				<span class="material-symbols-outlined text-primary text-3xl mr-2">spa</span>
				<span
					class="font-display font-bold text-xl text-gray-900 dark:text-white leading-none tracking-tight">SalonConnect</span>
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
							class="text-sm font-bold text-gray-900 dark:text-white truncate">Elena
							Gilbert</p>
						<p class="text-xs text-gray-400 truncate font-medium">Lead
							Massage Therapist</p>
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
					<div
						class="flex items-center bg-white dark:bg-surface-dark px-5 py-2 rounded-full shadow-sm border border-gray-100 dark:border-gray-700">
						<span
							class="text-sm font-medium mr-3 text-gray-600 dark:text-gray-300">Available
							for walk-ins</span> <label
							class="relative inline-flex items-center cursor-pointer">
							<input checked="" class="sr-only peer" type="checkbox" />
							<div
								class="w-11 h-6 bg-gray-200 peer-focus:outline-none rounded-full peer dark:bg-gray-700 peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-secondary"></div>
						</label>
					</div>

					<!-- button for dark and white mode  -->
										<button id="theme-toggle"
						class="p-2 rounded-full hover:bg-gray-100 dark:hover:bg-gray-700 text-gray-500 dark:text-gray-400">
						<span class="material-symbols-outlined">dark_mode</span>
					</button>
					
					</button>
					
										
					<button
						class="p-2 text-gray-400 hover:text-primary transition-colors relative">
						<span class="material-symbols-outlined">notifications</span> <span
							class="absolute top-2 right-2 w-2 h-2 bg-red-400 rounded-full border border-white"></span>
					</button>

					<button>
						<spam class="material-symbols-outlined">account_circle</spam>
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



						<div
							class="bg-surface-light dark:bg-surface-dark p-8 rounded-[2rem] border border-transparent shadow-[0_8px_30px_rgb(0,0,0,0.04)]">
							<div class="mb-8">
								<div class="flex items-center mb-5">
									<img alt="Client"
										class="w-12 h-12 rounded-full mr-4 border border-gray-100 shadow-sm"
										src="https://lh3.googleusercontent.com/aida-public/AB6AXuD6ivLk6oejRPf6q9isd6KyqV6zNpzrb4tPQdGSCx3xx30lw-WyKc6-ND-qkoU1VaafM63ZrX6Mq4y_1C7RrsbOXstagt8vbiszAELGmE9_20MNHpNWJbMtbdG5cdTVGTUXh_umOMQa-CjOJgKt9Jct3nzUkYf1Spvti7FDgQyjZ3E1-fAY4EDG2V0vPB7itk1uubkvyS6IyDaq-3H5CaSWyYUo80qoILeAQEISM5SmssE4rnQF1wyCnW05YdyuOElFmQqUqC6ktNah" />
									<div>
										<h4 class="font-bold text-gray-900 dark:text-white text-base">Sarah
											Jenkins</h4>
										<p class="text-xs text-gray-400">Frequent Client</p>
									</div>
								</div>
								<div
									class="bg-background-light dark:bg-background-dark p-5 rounded-2xl border border-gray-50 dark:border-gray-700 relative">
									<span
										class="absolute -top-3 left-6 text-4xl text-primary/20 font-serif">"</span>
									<p
										class="text-sm text-gray-600 dark:text-gray-300 italic leading-relaxed pt-2">
										Prefers lavender scent. Sensitive to high pressure on the
										lower back area. First time deep tissue client.</p>
								</div>
							</div>
							<div
								class="space-y-6 pt-6 border-t border-gray-100 dark:border-gray-700">
								<h4
									class="text-xs font-bold text-gray-400 uppercase tracking-widest mb-4">Recent
									Activity</h4>
								<div class="flex items-start space-x-4">
									<div
										class="w-2 h-2 rounded-full bg-secondary mt-1.5 shadow-[0_0_0_4px_rgba(143,188,143,0.2)]"></div>
									<p
										class="text-sm text-gray-600 dark:text-gray-400 leading-snug">
										<span class="font-bold text-gray-900 dark:text-white">Jessica
											Moore</span> gave a 5-star review for Swedish Massage.
									</p>
								</div>
								<div class="flex items-start space-x-4">
									<div
										class="w-2 h-2 rounded-full bg-primary mt-1.5 shadow-[0_0_0_4px_rgba(216,164,143,0.2)]"></div>
									<p
										class="text-sm text-gray-600 dark:text-gray-400 leading-snug">
										<span class="font-bold text-gray-900 dark:text-white">Michael
											Chen</span> rescheduled for 01:00 PM.
									</p>
								</div>
							</div>
							<button
								class="w-full mt-8 py-3.5 bg-gray-50 dark:bg-gray-800 text-gray-600 dark:text-gray-300 font-bold text-sm rounded-xl hover:bg-primary/10 hover:text-primary transition-all">
								View Full History</button>
						</div>
						<div
							class="bg-gray-900 text-white p-8 rounded-[2rem] shadow-2xl shadow-gray-200 dark:shadow-none relative overflow-hidden">
							<div
								class="absolute top-0 right-0 -mr-16 -mt-16 w-48 h-48 bg-primary/20 rounded-full blur-3xl"></div>
							<div
								class="absolute bottom-0 left-0 -ml-16 -mb-16 w-32 h-32 bg-secondary/10 rounded-full blur-2xl"></div>
							<h3 class="font-display font-bold text-xl mb-6 relative z-10">Availability</h3>
							<div
								class="grid grid-cols-7 gap-3 text-center text-[10px] mb-3 font-bold text-gray-500 uppercase tracking-wider relative z-10">
								<span>M</span><span>T</span><span>W</span><span>T</span><span>F</span><span>S</span><span>S</span>
							</div>
							<div
								class="grid grid-cols-7 gap-3 text-center text-sm relative z-10">
								<span
									class="p-2 text-primary font-bold bg-primary/20 rounded-xl">24</span>
								<span class="p-2 text-gray-300">25</span> <span
									class="p-2 text-gray-300">26</span> <span
									class="p-2 text-gray-300">27</span> <span
									class="p-2 font-bold bg-white/10 rounded-xl text-white">28</span>
								<span class="p-2 opacity-30">29</span> <span
									class="p-2 opacity-30">30</span>
							</div>
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