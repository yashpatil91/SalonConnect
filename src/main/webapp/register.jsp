<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<title>Register - SalonConnect</title>
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
					secondary : "#8FBC8F",
					"background-light" : "#FDFBF7",
					"background-dark" : "#1F1B1A",
					"surface-light" : "#FFFFFF",
					"surface-dark" : "#2D2625",
				},
				fontFamily : {
					display : [ "Playfair Display", "serif" ],
					body : [ "Lato", "sans-serif" ],
				},
			},
		},
	};
</script>
<style>
body {
	font-family: 'Lato', sans-serif;
}

h1, h2, h3, h4, h5, h6 {
	font-family: 'Playfair Display', serif;
}
</style>
</head>
<body
	class="bg-background-light dark:bg-background-dark text-gray-800 dark:text-gray-200 transition-colors duration-300 overflow-x-hidden">

	<nav
		class="sticky top-0 z-50 bg-surface-light/90 dark:bg-surface-dark/90 backdrop-blur-md border-b border-gray-100 dark:border-gray-800 shadow-sm">
		<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
			<div class="flex justify-between h-20 items-center">
				<div class="flex items-center">
					<span class="material-icons text-primary text-3xl mr-2">spa</span>
					<a href="index.jsp"
						class="font-display font-bold text-2xl text-gray-900 dark:text-white">SalonConnect</a>
				</div>
				<div class="flex items-center space-x-4">
					<button
						class="p-2 rounded-full hover:bg-gray-100 dark:hover:bg-gray-700 text-gray-500 dark:text-gray-400"
						id="theme-toggle">
						<span class="material-icons">brightness_4</span>
					</button>
				</div>
			</div>
		</div>
	</nav>

	<div
		class="min-h-screen flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
		<div
			class="absolute top-0 right-0 -mr-20 -mt-20 w-96 h-96 rounded-full bg-primary/10 blur-3xl"></div>
		<div
			class="absolute bottom-0 left-0 -ml-20 -mb-20 w-80 h-80 rounded-full bg-secondary/10 blur-3xl"></div>

		<div class="max-w-md w-full space-y-8 relative z-10">
			<div
				class="bg-surface-light dark:bg-surface-dark rounded-3xl shadow-2xl p-8 border border-gray-100 dark:border-gray-800">
				<div class="text-center">
					<h2
						class="text-3xl font-display font-bold text-gray-900 dark:text-white mb-2">Create
						Account</h2>
					<p class="text-gray-500 dark:text-gray-400">Join SalonConnect
						today</p>
				</div>

				<%
				String error = request.getParameter("error");

				if ("exists".equals(error)) {
				%>
				<div
					class="mt-4 bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-800 dark:text-red-200 px-4 py-3 rounded-lg">
					Email already registered</div>
				<%
				} else if ("failed".equals(error)) {
				%>
				<div
					class="mt-4 bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-800 dark:text-red-200 px-4 py-3 rounded-lg">
					Registration failed. Please try again</div>
				<%
				} else if ("exception".equals(error)) {
				%>
				<div
					class="mt-4 bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-800 dark:text-red-200 px-4 py-3 rounded-lg">
					An error occurred. Please try again</div>
				<%
				}
				%>

				<form class="mt-8 space-y-6" action="register" method="POST">
					<div class="space-y-4">
						<div>
							<label for="name"
								class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Full
								Name</label>
							<div class="relative">
								<span class="material-icons absolute left-3 top-3 text-gray-400">person</span>
								<input id="name" name="name" type="text" required
									pattern="[A-Za-z]{2,}"
									class="pl-10 w-full px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:ring-2 focus:ring-primary focus:border-transparent"
									placeholder="Enter your full name" />
							</div>
							<p id="nameError" class="text-yellow-500 text-sm mt-2 hidden">
								Name must contain at least 2 alphabets.</p>
						</div>

						<div>
							<label for="email"
								class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Email
								Address</label>
							<div class="relative">
								<span class="material-icons absolute left-3 top-3 text-gray-400">email</span>
								<input id="email" name="email" type="email" required
									class="pl-10 w-full px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:ring-2 focus:ring-primary focus:border-transparent"
									placeholder="Enter your email" />
							</div>
							<!-- Error Message -->
							<p id="emailError" class="text-yellow-500 text-sm mt-2 hidden">
								Please enter a valid email address.</p>
						</div>

						<div>
							<label for="phone"
								class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Phone
								Number</label>
							<div class="relative">
								<span class="material-icons absolute left-3 top-3 text-gray-400">phone</span>
								<input id="phone" name="phone" type="tel" required
									class="pl-10 w-full px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:ring-2 focus:ring-primary focus:border-transparent"
									placeholder="Enter your phone number" />
							</div>
							<!-- Error Message -->
							<p id="phoneError" class="text-yellow-500 text-sm mt-2 hidden">
								Phone number must contain at least 10 digits.</p>
						</div>

						<div>
							<label for="password"
								class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Password</label>
							<div class="relative">
								<span class="material-icons absolute left-3 top-3 text-gray-400">lock</span>
								<input id="password" name="password" type="password" required
									class="pl-10 w-full px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:ring-2 focus:ring-primary focus:border-transparent"
									placeholder="Create a password" />
							</div>
							<!-- Error Message -->
							<p id="passwordError" class="text-yellow-500 text-sm mt-2 hidden">
								Password must be at least 6 characters long.</p>
						</div>

						<div>
							<label for="role"
								class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">I
								am a</label> <select id="role" name="role"
								class="w-full px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:ring-2 focus:ring-primary focus:border-transparent">
								<option value="CUSTOMER">Customer</option>
								<option value="OWNER">Salon Owner</option>
								<option value="THERAPIST">Therapist</option>
							</select>

							<div id="therapistFields" class="space-y-4 hidden mt-4">

								<div>
									<label
										class="block text-sm font-medium text-gray-700 dark:text-gray-300">
										Specialization </label> <input name="specialization"
										class="w-full px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-800"
										placeholder="Hair, Spa, Massage" />
								</div>

								<div>
									<label
										class="block text-sm font-medium text-gray-700 dark:text-gray-300">
										Experience (years) </label> <input name="experience" type="number"
										min="0"
										class="w-full px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-800"
										placeholder="e.g. 3" />
								</div>

							</div>

						</div>
					</div>

					<div>
						<button type="submit"
							class="w-full flex justify-center py-3 px-4 border border-transparent rounded-full shadow-lg text-sm font-bold text-white bg-primary hover:bg-opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary transition">
							Create Account</button>
					</div>

					<div class="text-center text-sm">
						<span class="text-gray-600 dark:text-gray-400">Already have
							an account?</span> <a href="login.jsp"
							class="font-medium text-primary hover:underline ml-1">Sign in</a>
					</div>
				</form>
			</div>
		</div>
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
	<script>
		const nameInput = document.getElementById("name");
		const nameError = document.getElementById("nameError");

		nameInput.addEventListener("input",
				function() {
					const nameValue = nameInput.value.trim();

					// Regex: minimum 2 alphabets, spaces allowed
					const namePattern = /^[A-Za-z ]{2,}$/;

					if (!namePattern.test(nameValue)) {
						// Show error
						nameError.classList.remove("hidden");
						nameInput.classList.add("border-red-500",
								"focus:ring-red-500");
					} else {
						// Hide error
						nameError.classList.add("hidden");
						nameInput.classList.remove("border-red-500",
								"focus:ring-red-500");
					}
				});
	</script>

	<script>
		const emailInput = document.getElementById("email");
		const emailError = document.getElementById("emailError");

		emailInput.addEventListener("blur", function() {
			const emailValue = emailInput.value.trim();

			// Simple email regex
			const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

			if (!emailPattern.test(emailValue)) {
				emailError.classList.remove("hidden");
				emailInput.classList
						.add("border-red-500", "focus:ring-red-500");
			} else {
				emailError.classList.add("hidden");
				emailInput.classList.remove("border-red-500",
						"focus:ring-red-500");
			}
		});
	</script>

	<script>
		const phoneInput = document.getElementById("phone");
		const phoneError = document.getElementById("phoneError");

		phoneInput.addEventListener("input", function() {
			const phoneValue = phoneInput.value.trim();

			// Only digits, minimum 10
			const phonePattern = /^[0-9]{10,}$/;

			if (!phonePattern.test(phoneValue)) {
				phoneError.classList.remove("hidden");
				phoneInput.classList
						.add("border-red-500", "focus:ring-red-500");
			} else {
				phoneError.classList.add("hidden");
				phoneInput.classList.remove("border-red-500",
						"focus:ring-red-500");
			}
		});
	</script>

	<script>
		const passwordInput = document.getElementById("password");
		const passwordError = document.getElementById("passwordError");

		passwordInput.addEventListener("input", function() {
			const passwordValue = passwordInput.value.trim();

			if (passwordValue.length < 6) {
				passwordError.classList.remove("hidden");
				passwordInput.classList.add("border-red-500",
						"focus:ring-red-500");
			} else {
				passwordError.classList.add("hidden");
				passwordInput.classList.remove("border-red-500",
						"focus:ring-red-500");
			}
		});
	</script>

	<script>
		const roleSelect = document.getElementById("role");
		const therapistFields = document.getElementById("therapistFields");

		roleSelect.addEventListener("change", function() {
			therapistFields.classList.toggle("hidden",
					roleSelect.value !== "THERAPIST");
		});
	</script>

</body>
</html>
