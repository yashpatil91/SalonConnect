<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>My Schedule - SalonConnect</title>

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
				class="block px-4 py-3 rounded-lg bg-primary/10 text-primary font-bold">
				My Schedule
			</a>
		</nav>
	</aside>

	<!-- Main Content -->
	<main class="flex-1 p-10 overflow-y-auto">

		<!-- Header -->
		<div class="flex justify-between items-center mb-10">
			<h1 class="text-3xl font-bold">My Schedule</h1>
			<span class="text-sm text-gray-500">
				Welcome, ${sessionScope.userName}
			</span>
		</div>

		<!-- Appointments Grid -->
		<div class="grid md:grid-cols-2 xl:grid-cols-3 gap-6">

			<c:forEach var="appt" items="${appointments}">

				<div class="bg-white rounded-2xl shadow-sm hover:shadow-md transition-all p-6 border">

					<!-- Client -->
					<h3 class="text-xl font-bold mb-2">
						${appt.clientName}
					</h3>

					<!-- Service -->
					<p class="text-gray-500 text-sm mb-4">
						${appt.serviceName}
					</p>

					<!-- Time -->
					<div class="mb-4">
						<p class="text-sm">
							<span class="font-semibold">Time:</span>
							${appt.appointmentTime}
						</p>
					</div>

					<!-- Status Badge -->
					<div class="mb-4">
						<span class="px-3 py-1 text-xs font-bold rounded-full
							${appt.status eq 'COMPLETED' ?
								'bg-green-100 text-green-600' :
								appt.status eq 'APPROVED' ?
								'bg-blue-100 text-blue-600' :
								'bg-gray-100 text-gray-600'}">
							${appt.status}
						</span>
					</div>

					<!-- Complete Button -->
					<!--<c:if test="${appt.status eq 'APPROVED'}">
						<form method="post"
							action="${pageContext.request.contextPath}/completeAppointment">

							<input type="hidden" name="appointmentId"
								value="${appt.id}" />

							<button type="submit"
								class="w-full py-2 bg-primary text-white rounded-full font-bold text-sm hover:opacity-90 transition-all">
								Mark Completed
							</button>

						</form>
					</c:if> -->

				</div>

			</c:forEach>

		</div>

		<!-- Empty Message -->
		<c:if test="${empty appointments}">
			<div class="text-center mt-20 text-gray-400">
				No upcoming appointments.
			</div>
		</c:if>

	</main>

</div>

</body>
</html>
