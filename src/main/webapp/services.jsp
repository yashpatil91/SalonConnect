<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.dao.DBConnection"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<title>Explore Salons &amp; Services - SalonConnect</title>
<script
	src="https://cdn.tailwindcss.com?plugins=forms,typography,container-queries"></script>
<link
	href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&amp;family=Lato:wght@300;400;700&amp;display=swap"
	rel="stylesheet" />
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
	rel="stylesheet" />
<script>
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        primary: "#D8A48F",
                        secondary: "#8FBC8F",
                        "background-light": "#FDFBF7",
                        "background-dark": "#1F1B1A",
                        "surface-light": "#FFFFFF",
                        "surface-dark": "#2D2625",
                    },
                    fontFamily: {
                        display: ["Playfair Display", "serif"],
                        body: ["Lato", "sans-serif"],
                    },
                    borderRadius: {
                        DEFAULT: "0.75rem",
                    },
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
        }
   
        .hidden-service {
        display: none;
         }
</style>
    
</head>
<body
	class="bg-background-light dark:bg-background-dark text-gray-800 dark:text-gray-200 transition-colors duration-300">
	<!-- Navbar Section  -->
	<jsp:include page="navbar.jsp" />

	<main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
		<div class="mb-12">
			<div
				class="bg-white dark:bg-surface-dark p-2 rounded-2xl shadow-sm border border-gray-100 dark:border-gray-800 flex flex-col md:flex-row items-center w-full">
				<div
					class="flex-1 w-full md:w-auto px-4 py-2 border-b md:border-b-0 md:border-r border-gray-200 dark:border-gray-700 flex items-center">
					<span class="material-icons text-gray-400 mr-3">search</span> <input
						class="w-full bg-transparent border-none focus:ring-0 text-sm text-gray-700 dark:text-gray-200 placeholder-gray-400"
						placeholder="Treatment or Venue name" type="text" />
				</div>
				<div class="flex-1 w-full md:w-auto px-4 py-2 flex items-center">
					<span class="material-icons text-gray-400 mr-3">location_on</span>
					<input
						class="w-full bg-transparent border-none focus:ring-0 text-sm text-gray-700 dark:text-gray-200 placeholder-gray-400"
						placeholder="Current Location" type="text" />
				</div>
				<div class="px-2 w-full md:w-auto mt-2 md:mt-0">
					<button
						class="w-full md:w-auto bg-primary text-white hover:bg-opacity-90 font-bold py-2.5 px-8 rounded-xl transition shadow-md shadow-primary/20">
						Search</button>
				</div>
			</div>
		</div>
		<section class="mb-20">
			<div
				class="flex flex-col md:flex-row md:items-end justify-between gap-4 mb-8">
				<div>
					<h1
						class="text-3xl md:text-4xl font-display font-bold text-gray-900 dark:text-white">
						Explore <span class="text-primary italic">Salons</span>
					</h1>
					<p class="text-gray-500 dark:text-gray-400 mt-2">Discover
						premium wellness destinations near you</p>
				</div>
				<div class="flex items-center gap-3">
					<span class="text-sm text-gray-500 dark:text-gray-400">Sort
						by:</span> <select
						class="bg-white dark:bg-surface-dark border-gray-200 dark:border-gray-800 rounded-full text-sm font-bold focus:ring-primary focus:border-primary px-4 py-2 pr-10">
						<option>Most Popular</option>
						<option>Highest Rated</option>
						<option>Price: Low to High</option>
					</select>
				</div>
			</div>




			<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8"
				id="salonGrid">

				<%
				Connection con = null;
				PreparedStatement ps = null;
				ResultSet rs = null;
				boolean hasSalon = false;
				int count = 0;

				try {

					con = DBConnection.getConnection();
					ps = con.prepareStatement("SELECT * FROM salons ORDER BY created_at DESC");
					rs = ps.executeQuery();

					while (rs.next()) {

						count++;
						hasSalon = true;

						int salonId = rs.getInt("id");
						String name = rs.getString("name");
						String city = rs.getString("city");
						String description = rs.getString("description");
						String phone = rs.getString("phone");
						String image = rs.getString("image_url");
						double rating = rs.getDouble("rating");

						if (image == null || image.trim().equals("")) {
					image = "images/default-salon.jpg";
						}

						String hiddenClass = (count > 3) ? "hidden extra-salon" : "";
				%>

				<div
					class="bg-surface-light dark:bg-surface-dark rounded-2xl overflow-hidden shadow-sm hover:shadow-xl transition-all duration-300 border border-gray-100 dark:border-gray-800 group <%=hiddenClass%>">

					<!-- Image -->
					<div class="relative h-64 overflow-hidden">
						<img src="<%=image%>" alt="<%=name%>"
							class="w-full h-full object-cover group-hover:scale-110 transition duration-700" />

						<div
							class="absolute top-4 left-4 bg-white/90 dark:bg-black/70 backdrop-blur-md text-xs font-bold px-2.5 py-1.5 rounded-lg flex items-center gap-1 shadow-sm">
							<span class="material-icons text-yellow-400 text-sm">star</span>
							<%=rating%>
						</div>
					</div>

					<div class="p-6">

						<h3
							class="text-xl font-bold text-gray-900 dark:text-white group-hover:text-primary transition mb-2">
							<%=name%>
						</h3>

						<p
							class="text-gray-500 dark:text-gray-400 text-sm flex items-center gap-1 mb-2">
							<span class="material-icons text-base">location_on</span>
							<%=city%>
						</p>

						<p
							class="text-gray-500 dark:text-gray-400 text-sm flex items-center gap-1 mb-3">
							<span class="material-icons text-base">call</span>
							<%=phone%>
						</p>

						<div class="mb-4">
							<p id="desc-<%=salonId%>"
								class="text-gray-600 dark:text-gray-300 text-sm overflow-hidden line-clamp-2 transition-all duration-300">
								<%=description%>
							</p>

							<button type="button"
								onclick="toggleDescription('<%=salonId%>')"
								class="text-primary text-xs font-semibold mt-1 hover:underline focus:outline-none">
								Read more</button>
						</div>

						<div
							class="flex items-center justify-between pt-4 border-t border-gray-100 dark:border-gray-800">
							<a href="customer/salon-details.jsp?id=<%=salonId%>"
								class="bg-gray-900 dark:bg-white text-white dark:text-gray-900 px-6 py-2.5 rounded-xl font-bold text-sm hover:bg-primary dark:hover:bg-primary hover:text-white transition text-center">
								Book Salon </a>
						</div>

					</div>
				</div>

				<%
				}

				if (!hasSalon) {
				%>
				<p class="col-span-3 text-center text-gray-500">No salons
					available.</p>
				<%
				}

				} catch (Exception e) {
				out.println("Error: " + e.getMessage());
				} finally {
				if (rs != null)
				rs.close();
				if (ps != null)
				ps.close();
				}
				%>

			</div>

			<div class="mt-8 text-center">
				<button id="toggleSalonBtn" onclick="toggleSalons()"
					class="px-8 py-3 rounded-full border border-gray-200 dark:border-gray-700 text-gray-600 dark:text-gray-300 font-bold hover:bg-primary hover:text-white hover:border-primary transition-all">
					View All Salons</button>
			</div>



		</section>
		<section class="border-t border-gray-100 dark:border-gray-800 pt-20">
			<div class="mb-8 text-center max-w-2xl mx-auto">
				<h2
					class="text-3xl md:text-4xl font-display font-bold text-gray-900 dark:text-white">
					Popular <span class="text-primary italic">Services</span>
				</h2>
				<p class="text-gray-500 dark:text-gray-400 mt-2">Book individual
					treatments directly from our top-rated specialists</p>
			</div>
			
<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">

<%
Connection con2 = null;
PreparedStatement ps2 = null;
ResultSet rs2 = null;
int serviceCount = 0;

try {

    con2 = DBConnection.getConnection();
    ps2 = con2.prepareStatement("SELECT * FROM services ORDER BY id DESC");
    rs2 = ps2.executeQuery();

    while (rs2.next()) {

        serviceCount++;

        int serviceId = rs2.getInt("id");
        String serviceName = rs2.getString("name");
        double price = rs2.getDouble("price");
        String duration = rs2.getString("duration");
        String image = rs2.getString("image_url");

        if (image == null || image.trim().equals("")) {
            image = "images/default-service.jpg";
        }
%>

    <div class="service-card <%= serviceCount > 4 ? "hidden-service" : "" %> bg-surface-light dark:bg-surface-dark p-4 rounded-2xl border border-gray-100 dark:border-gray-800 hover:shadow-lg transition-all group">

        <!-- Image -->
        <div class="h-40 rounded-xl overflow-hidden mb-4">
            <img src="<%= image %>"
                 alt="<%= serviceName %>"
                 class="w-full h-full object-cover group-hover:scale-105 transition duration-500" />
        </div>

        <!-- Title + Price -->
        <div class="flex justify-between items-start mb-2">
            <h4 class="text-lg font-bold text-gray-900 dark:text-white">
                <%= serviceName %>
            </h4>
            <span class="text-primary font-bold">
                ₹<%= price %>
            </span>
        </div>

        <!-- Duration -->
        <p class="text-xs text-gray-400 dark:text-gray-500 flex items-center mb-4">
            <span class="material-icons text-sm mr-1">schedule</span>
            <%= duration %>
        </p>

        <!-- Button -->
        <a href="book-service.jsp?id=<%= serviceId %>"
           class="block text-center w-full py-2.5 rounded-xl bg-primary/10 text-primary font-bold text-sm hover:bg-primary hover:text-white transition-colors">
            Book Now
        </a>

    </div>

<%
    }

} catch (Exception e) {
    out.println("Error: " + e.getMessage());
} finally {
    if (rs2 != null) rs2.close();
    if (ps2 != null) ps2.close();
}
%>

</div> <!-- ✅ IMPORTANT: Grid closed here -->

<!-- View All Button -->
</div>  <!-- Services Grid Closed -->

<!-- View All Button -->
<div class="mt-8 text-center">
    <button id="toggleServicesBtn" onclick="toggleServices()"
        class="px-8 py-3 rounded-full border border-gray-200 dark:border-gray-700 text-gray-600 dark:text-gray-300 font-bold hover:bg-primary hover:text-white hover:border-primary transition-all">
        View All Services
    </button>
</div>

<%-- ✅ ADD IT HERE --%>
<% if (serviceCount <= 4) { %>
<script>
document.addEventListener("DOMContentLoaded", function(){
    var btn = document.getElementById("toggleServicesBtn");
    if (btn) {
        btn.style.display = "none";
    }
});
</script>
<% } %>

</section>   <!-- Section closed here -->




	</main>

	<!-- Footer Section  -->

	<%@ include file="footer.jsp"%>

	<script>
        const themeToggleBtn = document.getElementById('theme-toggle');
        const darkIcon = '<span class="material-icons">dark_mode</span>';
        const lightIcon = '<span class="material-icons">light_mode</span>';
        if (localStorage.getItem('color-theme') === 'dark' || (!('color-theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
            document.documentElement.classList.add('dark');
            themeToggleBtn.innerHTML = lightIcon;
        } else {
            document.documentElement.classList.remove('dark');
            themeToggleBtn.innerHTML = darkIcon;
        }
        themeToggleBtn.addEventListener('click', function() {
            if (document.documentElement.classList.contains('dark')) {
                document.documentElement.classList.remove('dark');
                localStorage.setItem('color-theme', 'light');
                this.innerHTML = darkIcon;
            } else {
                document.documentElement.classList.add('dark');
                localStorage.setItem('color-theme', 'dark');
                this.innerHTML = lightIcon;
            }
        });
    </script>


	<script>
let salonsExpanded = false;

function toggleSalons() {
    const hiddenSalons = document.querySelectorAll(".extra-salon");
    const btn = document.getElementById("toggleSalonBtn");

    if (!salonsExpanded) {
        hiddenSalons.forEach(el => el.classList.remove("hidden"));
        btn.textContent = "Show Less";
        salonsExpanded = true;
    } else {
        hiddenSalons.forEach(el => el.classList.add("hidden"));
        btn.textContent = "View All Salons";
        salonsExpanded = false;

        document.getElementById("salonGrid").scrollIntoView({ behavior: "smooth" });
    }
}
</script>


<script>
let servicesExpanded = false;

function toggleServices() {
    const hiddenServices = document.querySelectorAll(".hidden-service");
    const btn = document.getElementById("toggleServicesBtn");
    const serviceSection = document.getElementById("servicesSection");

    if (!servicesExpanded) {
        // Show all
        hiddenServices.forEach(card => {
            card.classList.remove("hidden-service");
        });
        btn.textContent = "Show Less";
        servicesExpanded = true;

    } else {
        // Hide extra
        hiddenServices.forEach(card => {
            card.classList.add("hidden-service");
        });
        btn.textContent = "View All Services";
        servicesExpanded = false;

        // 🔥 Scroll back smoothly
        serviceSection.scrollIntoView({ behavior: "smooth" });
    }
}
</script>


	<script>
function toggleDescription(id) {
    const desc = document.getElementById("desc-" + id);
    const button = desc.nextElementSibling;

    if (desc.classList.contains("line-clamp-2")) {
        desc.classList.remove("line-clamp-2");
        button.textContent = "Show less";
    } else {
        desc.classList.add("line-clamp-2");
        button.textContent = "Read more";
    }
}
</script>

</body>
</html>