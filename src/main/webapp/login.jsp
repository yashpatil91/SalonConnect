<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<title>Login - SalonConnect</title>
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
						class="text-3xl font-display font-bold text-gray-900 dark:text-white mb-2">Welcome
						Back</h2>
					<p class="text-gray-500 dark:text-gray-400">Sign in to your
						account</p>
				</div>
				<%
				String error = request.getParameter("error");
				String success = request.getParameter("success");
				String message = request.getParameter("message");

				if ("invalid".equals(error)) {
				%>
				<div
					class="mt-4 bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-800 dark:text-red-200 px-4 py-3 rounded-lg">
					Invalid email or password</div>

				<%
				} else if ("unauthorized".equals(error)) {
				%>
				<div
					class="mt-4 bg-yellow-50 dark:bg-yellow-900/20 border border-yellow-200 dark:border-yellow-800 text-yellow-800 dark:text-yellow-200 px-4 py-3 rounded-lg">
					Please login to continue</div>

				<%
				} else if ("forbidden".equals(error)) {
				%>
				<div
					class="mt-4 bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-800 dark:text-red-200 px-4 py-3 rounded-lg">
					Access denied</div>

				<%
				} else if ("pending".equals(error)) {
				%>
				<div
					class="mt-4 bg-yellow-50 dark:bg-yellow-900/20 border border-yellow-200 dark:border-yellow-800 text-yellow-800 dark:text-yellow-200 px-4 py-3 rounded-lg">
					Your account is waiting for owner approval.</div>

				<%
				} else if ("rejected".equals(error)) {
				%>
				<div
					class="mt-4 bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-800 dark:text-red-200 px-4 py-3 rounded-lg">
					Your therapist application was rejected.</div>

				<%
				} else if ("registered".equals(success)) {
				%>
				<div
					class="mt-4 bg-green-50 dark:bg-green-900/20 border border-green-200 dark:border-green-800 text-green-800 dark:text-green-200 px-4 py-3 rounded-lg">
					Registration successful! Please login</div>

				<%
				} else if ("logged_out".equals(message)) {
				%>
				<div
					class="mt-4 bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-blue-800 text-blue-800 dark:text-blue-200 px-4 py-3 rounded-lg">
					You have been logged out</div>
					
				<%
				}else if ("exception".equals(error)) {
					%>
					<div class="mt-4 bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-800 dark:text-red-200 px-4 py-3 rounded-lg">
					    Something went wrong! Please try again.
					</div>
					<%
					}
				%>


				<form class="mt-8 space-y-6" action="login" method="POST">
					<div class="space-y-4">
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
						</div>

						<div>
							<label for="password"
								class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Password</label>
							<div class="relative">
								<span class="material-icons absolute left-3 top-3 text-gray-400">lock</span>
								<input id="password" name="password" type="password" required
									class="pl-10 w-full px-4 py-3 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:ring-2 focus:ring-primary focus:border-transparent"
									placeholder="Enter your password" />
							</div>
						</div>
					</div>

					<div>
						<button type="submit"
							class="w-full flex justify-center py-3 px-4 border border-transparent rounded-full shadow-lg text-sm font-bold text-white bg-primary hover:bg-opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary transition">
							Sign In</button>
					</div>

					<div class="text-center text-sm">
						<span class="text-gray-600 dark:text-gray-400">Don't have
							an account?</span> <a href="register.jsp"
							class="font-medium text-primary hover:underline ml-1">Sign up</a>
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


</body>
</html>
