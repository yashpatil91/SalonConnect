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
			<meta charset="utf-8" />
			<meta name="viewport" content="width=device-width, initial-scale=1.0" />
			<title>Approved Bookings - SalonConnect</title>
			
			<script src="https://cdn.tailwindcss.com?plugins=forms,typography"></script>
			<link
				href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Lato:wght@300;400;700&display=swap"
				rel="stylesheet" />
			<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
				rel="stylesheet" />
			<link rel="icon" type="image/png" href="<%= request.getContextPath() %>/images/icon.jpeg">
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
			
			<body class="bg-background-light dark:bg-background-dark text-gray-800 dark:text-gray-200 transition-colors duration-300 overflow-x-hidden">
			
			
			<!-- NAVBAR -->
			<nav class="sticky top-0 z-50 bg-surface-light/90 dark:bg-surface-dark/90 backdrop-blur border-b shadow-sm">
			    <div class="max-w-7xl mx-auto px-6 h-20 flex justify-between items-center">
			        <div class="flex items-center">
			            <span class="material-icons text-primary text-3xl mr-2">spa</span>
					    <a href="<%= request.getContextPath() %>/index.jsp"
									   class="font-display font-bold text-2xl text-gray-900 dark:text-white">
									   SalonConnect
									</a>
			        </div>
			        <div class="flex items-center space-x-4">
			            <a href="dashboard.jsp" class="hover:text-primary">Dashboard</a>
			            <a href="view-bookings.jsp" class="hover:text-primary">Pending</a>
			            <span><%= userName %></span>
			            <button class="p-2 rounded-full hover:bg-gray-100 dark:hover:bg-gray-700 text-gray-500 dark:text-gray-400" id="theme-toggle">
 						<span class="material-icons">brightness_4</span>
						</button>
			            <a href="<%=request.getContextPath()%>/logout"
			               class="bg-red-500 text-white px-4 py-2 rounded-full text-sm font-bold hover:bg-red-600">
			                Logout
			            </a>
			        </div>
			    </div>
			</nav>
			
				
			
			<div class="max-w-7xl mx-auto p-6">
			
			<!-- ================= PENDING BOOKINGS ================= -->
			<h2 class="text-2xl font-semibold text-slate-900 dark:text-white mb-6 flex items-center gap-2">
			    <span class="material-icons text-orange-500">schedule</span>
			    Pending Bookings
			</h2>
			
			<%
			Connection con = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			boolean hasPending = false;
			
			try {
			    con = DBConnection.getConnection();
			    String sql =
			        "SELECT a.*, u.name customer_name, u.email, s.name salon_name, " +
			        "srv.name service_name, t.name therapist_name " +
			        "FROM appointments a " +
			        "JOIN users u ON a.user_id = u.id " +
			        "JOIN salons s ON a.salon_id = s.id " +
			        "JOIN services srv ON a.service_id = srv.id " +
			        "JOIN therapists t ON a.therapist_id = t.id " +
			        "WHERE s.owner_id = ? AND a.status = 'PENDING' " +
			        "ORDER BY a.appointment_date, a.appointment_time";
			
			    ps = con.prepareStatement(sql);
			    ps.setInt(1, ownerId);
			    rs = ps.executeQuery();
			
			    while (rs.next()) {
			        hasPending = true;
			%>
			
		<div class="bg-white dark:bg-surface-dark border border-gray-200 dark:border-gray-700 rounded-xl shadow-sm dark:shadow-lg hover:shadow-md dark:hover:shadow-xl  transition mb-6">

			
			    <!-- Header -->
			    <div class="flex flex-col md:flex-row md:justify-between md:items-center px-6 py-4 border-b">
			        <div>
			            <h3 class="text-lg font-semibold text-slate-900 dark:text-white">
			                <%=rs.getString("customer_name")%>
			            </h3>
			            <p class="text-sm text-gray-500 dark:text-white"><%=rs.getString("email")%></p>
			        </div>
			
			        <span class="mt-3 md:mt-0 inline-flex items-center gap-1 px-4 py-1 rounded-full text-sm font-semibold bg-orange-100 text-orange-700">
			            <span class="material-icons text-sm dark:text-white">hourglass_top</span>
			            Pending
			        </span>
			    </div>
			
			    <!-- Details -->
			    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 px-6 py-5 text-sm text-gray-700">
			        <div>
			            <p class="text-gray-500 dark:text-white">Salon</p>
			            <p class="font-medium dark:text-white"><%=rs.getString("salon_name")%></p>
			        </div>
			        <div>
			            <p class="text-gray-500 dark:text-white">Service</p>
			            <p class="font-medium dark:text-white"><%=rs.getString("service_name")%></p>
			        </div>
			        <div>
			            <p class="text-gray-500 dark:text-white">Therapist</p>
			            <p class="font-medium dark:text-white"><%=rs.getString("therapist_name")%></p>
			        </div>
			        <div>
			            <p class="text-gray-500 dark:text-white">Date & Time</p>
			            <p class="font-medium dark:text-white">
			                <%=rs.getDate("appointment_date")%> •
			                <%=rs.getTime("appointment_time")%>
			            </p>
			        </div>
			    </div>
			
			    <!-- Actions -->
			    <div class="flex justify-end gap-3 px-6 pb-5">
			        <form action="<%=request.getContextPath()%>/rejectAppointment" method="post">
			            <input type="hidden" name="id" value="<%=rs.getInt("id")%>">
			            <button
			                class="px-4 py-2 rounded-lg border border-red-500 text-red-500 font-semibold hover:bg-red-500 hover:text-white transition">
			                Reject
			            </button>
			        </form>
			
			        <form action="<%=request.getContextPath()%>/ApproveAppointmentServlet" method="post">
			            <input type="hidden" name="id" value="<%=rs.getInt("id")%>">
			            <button
			                class="px-4 py-2 rounded-lg bg-green-600 text-white font-semibold hover:bg-green-700 transition">
			                Approve
			            </button>
			        </form>
			    </div>
			</div>
			
			<%
			    }
			} catch (Exception e) {
			    e.printStackTrace();
			}
			
			if (!hasPending) {
			%>
			<p class="text-gray-500">No pending bookings</p>
			<%
			}
			%>
			
			<!-- ================= APPROVED BOOKINGS ================= -->
			<h2 class="text-2xl font-semibold text-slate-900 dark:text-white mb-6 flex items-center gap-2">
			    <span class="material-icons text-green-600">check_circle</span>
			    Approved Bookings
			</h2>
			
			<%
			boolean hasApproved = false;
			
			try {
			    String sql =
			        "SELECT a.*, u.name customer_name, u.email, s.name salon_name, " +
			        "srv.name service_name, t.name therapist_name " +
			        "FROM appointments a " +
			        "JOIN users u ON a.user_id = u.id " +
			        "JOIN salons s ON a.salon_id = s.id " +
			        "JOIN services srv ON a.service_id = srv.id " +
			        "JOIN therapists t ON a.therapist_id = t.id " +
			        "WHERE s.owner_id = ? AND a.status = 'APPROVED' " +
			        "ORDER BY a.appointment_date DESC";
			
			    ps = con.prepareStatement(sql);
			    ps.setInt(1, ownerId);
			    rs = ps.executeQuery();
			
			    while (rs.next()) {
			        hasApproved = true;
			%>
			
		<div class="bg-white dark:bg-surface-dark 
            border border-gray-200 dark:border-gray-700 
            rounded-xl 
            shadow-sm dark:shadow-lg 
            hover:shadow-md dark:hover:shadow-xl 
            transition 
            mb-6">

			
			    <div class="flex flex-col md:flex-row md:justify-between md:items-center px-6 py-4 border-b">
			        <div>
			            <h3 class="text-lg font-semibold text-gray-900 dark:text-white"> 
			                <%=rs.getString("customer_name")%>
			            </h3>
			            <p class="text-sm text-gray-500 dark:text-white"><%=rs.getString("email")%></p>
			        </div>
			
			        <span class="mt-3 md:mt-0 inline-flex items-center gap-1 px-4 py-1 rounded-full text-sm font-semibold bg-green-100 text-green-700">
			            <span class="material-icons text-sm">verified</span>
			            Approved
			        </span>
			    </div>
			
			    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 px-6 py-5 text-sm text-gray-700">
			        <div>
			            <p class="text-gray-500 dark:text-white">Salon</p>
			            <p class="font-medium dark:text-white"><%=rs.getString("salon_name")%></p>
			        </div>
			        <div>
			            <p class="text-gray-500 dark:text-white">Service</p>
			            <p class="font-medium dark:text-white"><%=rs.getString("service_name")%></p>
			        </div>
			        <div>
			            <p class="text-gray-500 dark:text-white">Therapist</p>
			            <p class="font-medium dark:text-white"><%=rs.getString("therapist_name")%></p>
			        </div>
			        <div>
			            <p class="text-gray-500 dark:text-white">Date & Time</p>
			            <p class="font-medium dark:text-white">
			                <%=rs.getDate("appointment_date")%> •
			                <%=rs.getTime("appointment_time")%>
			            </p>
			        </div>
			    </div>
			
			    <div class="flex justify-end px-6 pb-5">
			        <form action="<%=request.getContextPath()%>/owner/completeAppointment" method="post">
			            <input type="hidden" name="appointmentId" value="<%=rs.getInt("id")%>">
			            <button
			                class="px-5 py-2 rounded-full bg-blue-600 text-white font-semibold hover:bg-blue-700 transition">
			                Mark as Completed
			            </button>
			        </form>
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
			
			if (!hasApproved) {
			%>
			<div class="bg-white border border-dashed rounded-xl p-10 text-center text-gray-500">
			    <span class="material-icons text-4xl mb-2">event_busy</span>
			    <p class="font-semibold">No pending bookings</p>
			</div>
			<%
			}
			%>
			
<script>
        const themeToggleBtn = document.getElementById('theme-toggle');
        const darkIcon = '<span class="material-icons">dark_mode</span>';
        const lightIcon = '<span class="material-icons">light_mode</span>';
        // Check local storage or system preference
        if (localStorage.getItem('color-theme') === 'dark' || (!('color-theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
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
			</div>
			</body>
			</html>
