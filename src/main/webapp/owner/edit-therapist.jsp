<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    String userName = (String) session.getAttribute("userName");

    Integer idObj = (Integer) request.getAttribute("id");
    Integer salonIdObj = (Integer) request.getAttribute("salonId");

    if (idObj == null || salonIdObj == null) {
        response.sendRedirect("view-therapists.jsp");
        return;
    }

    int id = idObj;
    int salonId = salonIdObj;

    
    
    String name = (String) request.getAttribute("name");
    String email = (String) request.getAttribute("email");
    String phone = (String) request.getAttribute("phone");
    String specialization = (String) request.getAttribute("specialization");
    String imageUrl = (String) request.getAttribute("imageUrl");

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Edit Therapist - SalonConnect</title>

    <script src="https://cdn.tailwindcss.com?plugins=forms,typography"></script>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Lato:wght@300;400;700&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
  <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/images/icon.jpeg">
    <style>
        body { font-family: 'Lato', sans-serif; }
        h1, h2, h3 { font-family: 'Playfair Display', serif; }
    </style>
</head>

<body class="bg-background-light dark:bg-background-dark text-gray-800 dark:text-gray-200 transition-colors duration-300 overflow-x-hidden">

<!-- NAVBAR (UNCHANGED) -->
<nav class="sticky top-0 z-50 bg-surface-light/90 dark:bg-surface-dark/90 backdrop-blur-md border-b shadow-sm">
    <div class="max-w-7xl mx-auto px-4 flex justify-between h-20 items-center">
        <div class="flex items-center">
            <span class="material-icons text-primary text-3xl mr-2">spa</span>
            <a href="<%=request.getContextPath()%>/index.jsp"
               class="font-display font-bold text-2xl">
                SalonConnect
            </a>
        </div>

        <div class="flex items-center space-x-4">
            <a href="dashboard.jsp" class="hover:text-primary">Dashboard</a>
            <span><%= userName %></span>
            <button class="p-2 rounded-full hover:bg-gray-100 dark:hover:bg-gray-700" id="theme-toggle">
                    <span class="material-icons">brightness_4</span>
                </button>
            <a href="<%=request.getContextPath()%>/logout"
               class="px-4 py-2 rounded-full text-sm text-white bg-red-500">
                Logout
            </a>
        </div>
    </div>
</nav>

<!-- CONTENT -->
<div class="max-w-4xl mx-auto px-4 py-8">

    <div class="mb-6">
        <a href="view-therapists.jsp?salonId=<%= salonId %>"
           class="text-primary flex items-center">
            <span class="material-icons mr-1">arrow_back</span>
            Back to Therapists
        </a>
    </div>

    <div class="bg-surface-light dark:bg-surface-dark rounded-3xl shadow-xl p-8">
        <h1 class="text-3xl font-bold mb-6">Edit Therapist</h1>

        <form action="<%= request.getContextPath() %>/owner/editTherapist"  method="post" class="mt-6">

            <input type="hidden" name="id" value="<%= id %>">
            <input type="hidden" name="salonId" value="<%= salonId %>">

            <!-- Name -->
            <div>
                <label class="block text-sm font-medium mb-2">Therapist Name *</label>
                <input type="text" name="name" required
                       value="<%= name %>"
                       class="w-full px-4 py-3 border rounded-lg">
            </div>

            <!-- Specialization -->
            <div>
                <label class="block text-sm font-medium mb-2">Specialization</label>
                <input type="text" name="specialization"
                       value="<%= specialization %>"
                       class="w-full px-4 py-3 border rounded-lg">
            </div>

            <!-- Phone -->
            <div>
                <label class="block text-sm font-medium mb-2">Phone Number</label>
                <input type="tel" name="phone"
                       value="<%= phone %>"
                       class="w-full px-4 py-3 border rounded-lg">
            </div>

            <!-- Email (UI SAME AS ADD PAGE) -->
            <div>
                <label class="block text-sm font-medium mb-2">Email</label>
                <input type="email" name="email"
                       value="<%= email %>"
                       class="w-full px-4 py-3 border rounded-lg">
            </div>
            
           

			<!-- Image URL -->
			<div>
			    <label class="block text-sm font-medium mb-2">Image URL</label>
			    <input type="url" name="imageUrl"
			           value="<%= imageUrl != null ? imageUrl : "" %>"
			           class="w-full px-4 py-3 border rounded-lg"
			           placeholder="Enter image URL">
			</div>
            

            <!-- Buttons -->
            <div class="flex justify-end gap-4 mt-6">
		    <a href="view-therapists.jsp?salonId=<%= salonId %>"
		       class="px-6 py-3 border border-gray-400 rounded-full font-bold text-gray-700 hover:bg-gray-100">
		        Cancel
		    </a>
		
		    <button type="submit"
		            class="px-6 py-3 rounded-full font-bold text-white bg-indigo-600 hover:bg-indigo-700 transition shadow-lg">
		        Update Therapist
		    </button>
		</div>

		    
		    
		    
		    

        </form>
    </div>
</div>

<script>
    const themeToggleBtn = document.getElementById('theme-toggle');
    const darkIcon = '<span class="material-icons">dark_mode</span>';
    const lightIcon = '<span class="material-icons">light_mode</span>';
    
    if (localStorage.getItem('color-theme') === 'dark' || (!('color-theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
        document.documentElement.classList.add('dark');
        themeToggleBtn.innerHTML = lightIcon;
    } else {
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
