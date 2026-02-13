<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.dao.DBConnection" %>
<!DOCTYPE html>
<html lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>

<script src="https://cdn.tailwindcss.com?plugins=forms,typography"></script>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Lato:wght@300;400;700&display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
<link rel="icon" type="image/png" href="<%= request.getContextPath() %>/images/icon.jpeg">

<script>
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        primary: "#D8A48F", // Soft pastel terracotta/rose gold
                        secondary: "#8FBC8F", // Soft sage green accent
                        "background-light": "#FDFBF7", // Warm off-white
                        "background-dark": "#1F1B1A", // Dark warm charcoal
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
<style>
.hero-title {
    animation: slideFade 1s ease-out forwards;
}

.hero-title span {
    display: inline-block;
    animation: glowText 2.5s ease-in-out infinite;
}

/* Animations */
@keyframes slideFade {
    from {
        opacity: 0;
        transform: translateY(40px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

@keyframes glowText {
    0% {
        text-shadow: 0 0 0 rgba(216, 164, 143, 0.4);
    }
    50% {
        text-shadow: 0 0 20px rgba(216, 164, 143, 0.8);
    }
    100% {
        text-shadow: 0 0 0 rgba(216, 164, 143, 0.4);
    }
}




/*paragraph line*/
.hero-text {
    opacity: 0;
    animation: fadeUpText 1.2s ease-out forwards;
    animation-delay: 0.4s;
}

@keyframes fadeUpText {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.search-box {
    border: 2px solid rgba(216, 164, 143, 0.35); /* soft primary border */
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.06);   /* light default shadow */
    transition: 
        border-color 0.3s ease,
        box-shadow 0.3s ease,
        transform 0.3s ease;
}

.search-box:hover {
    border-color: rgba(216, 164, 143, 0.6);
    box-shadow: 0 12px 28px rgba(0, 0, 0, 0.10); /* slightly stronger */
    transform: translateY(-2px);               /* subtle lift */
}

.search-box:focus-within {
    border-color: #D8A48F; /* primary color */
    box-shadow:
        0 0 0 5px rgba(216, 164, 143, 0.25),   /* glow ring */
        0 14px 32px rgba(0, 0, 0, 0.12);       /* depth shadow */
}

/*header section*/

/* Border effect using pseudo-element */
.mb-10.relative {
    position: relative;
}

/* Create animated border */
.mb-10.relative::before {
    content: "";
    position: absolute;
    inset: -6px;
    border-radius: 1.75rem;
    background: linear-gradient(
        120deg,
        #D8A48F,
        #8FBC8F,
        #D8A48F
    );
    z-index: 0;
    opacity: 0.8;
    transition: opacity 0.5s ease, filter 0.5s ease;
    filter: blur(0.5px);
}

/* Hover border glow */
.mb-10.relative:hover::before {
    opacity: 1;
    filter: blur(2px);
}

/* Keep image above border */
.feature-image {
    position: relative;
    z-index: 10;
    background: #fff;
}


/*Image animation*/
/* Image entrance animation */
.feature-image {
    animation: imageFloat 6s ease-in-out infinite;
    transition: transform 0.6s ease;
}

/* Hover zoom */
.feature-image:hover {
    transform: scale(1.05);
}

/* Floating effect */
@keyframes imageFloat {
    0% {
        transform: translateY(0);
    }
    50% {
        transform: translateY(-12px);
    }
    100% {
        transform: translateY(0);
    }
}
/*Information animation*/
/* Initial hidden state */
.feature-content {
    opacity: 0;
    transform: translateX(-80px);
    transition: opacity 0.9s ease, transform 0.9s ease;
}

/* Visible state */
.feature-content.show {
    opacity: 1;
    transform: translateX(0);
}

/* Child stagger animation */
.feature-content h2,
.feature-content p,
.feature-content li {
    opacity: 0;
    transform: translateY(25px);
    transition: opacity 0.6s ease, transform 0.6s ease;
}

.feature-content.show h2 {
    opacity: 1;
    transform: translateY(0);
    transition-delay: 0.2s;
}

.feature-content.show p {
    opacity: 1;
    transform: translateY(0);
    transition-delay: 0.4s;
}

.feature-content.show li:nth-child(1) {
    opacity: 1;
    transform: translateY(0);
    transition-delay: 0.6s;
}

.feature-content.show li:nth-child(2) {
    opacity: 1;
    transform: translateY(0);
    transition-delay: 0.8s;
}

.feature-content.show li:nth-child(3) {
    opacity: 1;
    transform: translateY(0);
    transition-delay: 1s;
}



/*Seamless Booking*/
.service-card {
    border: 1.5px solid rgba(216, 164, 143, 0.25);
    transition: border-color 0.3s ease, box-shadow 0.3s ease;
}

.service-card:hover {
    border-color: #D8A48F;
    box-shadow: 0 0 0 4px rgba(216, 164, 143, 0.35);
}

/*glow cards*/
.nav-link {
    color: #ffffff !important;
    margin-left: 15px;
    font-weight: 600;
    font-size: 15px;
    padding: 6px 14px;
    border-radius: 20px;
    transition: all 0.25s ease;
}

.nav-link:hover {
    color: #F2C1AE !important; /* Soft pastel rose */
}

.active {
    border-bottom: 3px solid #F2C1AE;
    color: #F2C1AE !important;
}

 body {
            font-family: 'Lato', sans-serif;
        }
        h1, h2, h3, h4, h5, h6 {
            font-family: 'Playfair Display', serif;
        }

.salon-slider {
  overflow: hidden;
  position: relative;
  width: 100%;
}

.salon-track {
  display: flex;
  gap: 20px;
  animation: scroll 25s linear infinite;
  width: max-content;
  margin-top: 20px;
  margin-bottom: 20px;
}

.salon-track:hover {
  animation-play-state: paused;
  /* pause on hover */
}
/* continuous scroll */
@keyframes scroll {
  0% {
    transform: translateX(0);
  }

  100% {
    transform: translateX(-50%);
  }
}



    </style>
</head>


<body class="bg-background-light dark:bg-background-dark text-gray-800 dark:text-gray-200 transition-colors duration-300 overflow-x-hidden">






<!-- Navbar Section  -->
<jsp:include page="navbar.jsp" />


<div 
  class="relative bg-cover bg-center overflow-hidden"
style="background-image: url('https://images.unsplash.com/photo-1621605815971-fbc98d665033?auto=format&fit=crop&w=1600&q=80');"

>

    <!-- Overlay for readability -->
    <div class="absolute inset-0 bg-white/80 dark:bg-black/70"></div>

    <!-- Decorative Blobs -->
    <div class="absolute top-0 right-0 -mr-20 -mt-20 w-96 h-96 rounded-full bg-primary/20 blur-3xl"></div>
    <div class="absolute bottom-0 left-0 -ml-20 -mb-20 w-80 h-80 rounded-full bg-secondary/20 blur-3xl"></div>

    <!-- Content -->
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-20 lg:py-28 relative z-10">
        <div class="text-center max-w-3xl mx-auto">

            <h1 class="hero-title text-5xl md:text-6xl font-display font-bold text-gray-900 dark:text-white mb-6 leading-tight">
                Beauty & Wellness <br/>
                <span class="text-primary italic">Reimagined</span>
            </h1>

            <p class="hero-text text-xl text-gray-600 dark:text-gray-300 mb-10 leading-relaxed">
                Book appointments with the best salons, spas, and therapists near you.
                Manage your beauty schedule effortlessly.
            </p>

            <div class="search-box bg-surface-light/90 dark:bg-surface-dark/90 backdrop-blur-md p-3 rounded-full shadow-xl shadow-gray-200/50 dark:shadow-black/30 max-w-4xl mx-auto flex flex-col md:flex-row items-center">

                <div class="flex-1 w-full md:w-auto px-4 py-2 border-b md:border-b-0 md:border-r border-gray-200 dark:border-gray-700 flex items-center">
                    <span class="material-icons text-gray-400 mr-3">search</span>
                    <input
                        class="w-full bg-transparent border-none focus:ring-0 text-gray-700 dark:text-gray-200 placeholder-gray-400 dark:placeholder-gray-500"
                        placeholder="Service (e.g. Haircut, Massage)"
                        type="text"
                    />
                </div>

                <div class="flex-1 w-full md:w-auto px-4 py-2 flex items-center">
                    <span class="material-icons text-gray-400 mr-3">location_on</span>
                    <input
                        class="w-full bg-transparent border-none focus:ring-0 text-gray-700 dark:text-gray-200 placeholder-gray-400 dark:placeholder-gray-500"
                        placeholder="Location or Zip Code"
                        type="text"
                    />
                </div>

                <button class="w-full md:w-auto bg-primary hover:bg-opacity-90 text-white font-bold py-3 px-8 rounded-full transition shadow-md mt-3 md:mt-0">
                    Search
                </button>

            </div>

        </div>
    </div>
</div>



<section class="py-16 bg-white dark:bg-surface-dark">
<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
<div class="text-center mb-12">
<h2 class="text-3xl font-display font-bold italic text-primary mb-4 text-primary italic ">Explore by Service</h2>
<p class="text-gray-500 dark:text-white">Discover top-rated professionals for every need</p>
</div>
<div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-6">
<a href="services.jsp"
   class="service-card group flex flex-col items-center p-6 rounded-2xl
          bg-background-light dark:bg-background-dark
          hover:-translate-y-1 transition duration-300">
    
    <div class="w-16 h-16 rounded-full bg-pink-100 dark:bg-pink-900/30
                flex items-center justify-center mb-4 text-primary
                group-hover:bg-primary group-hover:text-white transition">
        <span class="material-icons text-3xl">content_cut</span>
    </div>

    <span class="font-medium text-gray-700 dark:text-gray-200 group-hover:text-primary transition">
        Haircuts
    </span>
</a>

<a href="services.jsp"
   class="service-card group flex flex-col items-center p-6 rounded-2xl
          bg-background-light dark:bg-background-dark
          hover:-translate-y-1 transition duration-300">

<div class="w-16 h-16 rounded-full bg-blue-100 dark:bg-blue-900/30 flex items-center justify-center mb-4 text-blue-500 group-hover:bg-blue-500 group-hover:text-white transition">
<span class="material-icons text-3xl">spa</span>
</div>
<span class="font-medium text-gray-700 dark:text-gray-200 group-hover:text-blue-500 transition">Massage</span>
</a>

<a href="services.jsp"
   class="service-card group flex flex-col items-center p-6 rounded-2xl
          bg-background-light dark:bg-background-dark
          hover:-translate-y-1 transition duration-300">

<div class="w-16 h-16 rounded-full bg-purple-100 dark:bg-purple-900/30 flex items-center justify-center mb-4 text-purple-500 group-hover:bg-purple-500 group-hover:text-white transition">
<span class="material-icons text-3xl">brush</span>
</div>
<span class="font-medium text-gray-700 dark:text-gray-200 group-hover:text-purple-500 transition">Nail Care</span>
</a>
<a href="services.jsp"
   class="service-card group flex flex-col items-center p-6 rounded-2xl
          bg-background-light dark:bg-background-dark
          hover:-translate-y-1 transition duration-300">

<div class="w-16 h-16 rounded-full bg-orange-100 dark:bg-orange-900/30 flex items-center justify-center mb-4 text-orange-500 group-hover:bg-orange-500 group-hover:text-white transition">
<span class="material-icons text-3xl">face</span>
</div>
<span class="font-medium text-gray-700 dark:text-gray-200 group-hover:text-orange-500 transition">Facials</span>
</a>
<a href="services.jsp"
   class="service-card group flex flex-col items-center p-6 rounded-2xl
          bg-background-light dark:bg-background-dark
          hover:-translate-y-1 transition duration-300">

<div class="w-16 h-16 rounded-full bg-green-100 dark:bg-green-900/30 flex items-center justify-center mb-4 text-green-500 group-hover:bg-green-500 group-hover:text-white transition">
<span class="material-icons text-3xl">self_improvement</span>
</div>
<span class="font-medium text-gray-700 dark:text-gray-200 group-hover:text-green-500 transition">Wellness</span>
</a>
<a href="services.jsp"
   class="service-card group flex flex-col items-center p-6 rounded-2xl
          bg-background-light dark:bg-background-dark
          hover:-translate-y-1 transition duration-300">

<div class="w-16 h-16 rounded-full bg-gray-100 dark:bg-gray-800 flex items-center justify-center mb-4 text-gray-500 group-hover:bg-gray-500 group-hover:text-white transition">
<span class="material-icons text-3xl">grid_view</span>
</div>
<span class="font-medium text-gray-700 dark:text-gray-200 group-hover:text-gray-500 transition">View All</span>
</a>
</div>
</div>
</section>

<section class="py-20 bg-background-light dark:bg-background-dark">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">

        <div class="flex justify-center items-center mb-12">
            <div class="text-center">
                <h2 class="text-3xl font-display font-bold italic text-primary mb-4">
                    Featured Salons
                </h2>
                <p class="text-gray-500 dark:text-white">
			    Handpicked top-rated salons near you
			   </p>

            </div>
     </div>


		   <div class="salon-slider">
<div class="salon-track">


</div>
<div class="salon-slider">
<div class="salon-track grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
 <%
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;



try {
    con = DBConnection.getConnection();
    ps = con.prepareStatement("SELECT * FROM salons ORDER BY rating DESC, name LIMIT 5");
    rs = ps.executeQuery();

    while (rs.next()) {

        int salonId = rs.getInt("id");
        String salonName1 = rs.getString("name");
        String city = rs.getString("city");
        String description = rs.getString("description");
        double rating = rs.getDouble("rating");
        String imageUrl = rs.getString("image_url");

        if (imageUrl == null || imageUrl.trim().isEmpty()) {
            imageUrl = "/images/default-salon.jpg";
        }

        String finalImageUrl = 
            (imageUrl.startsWith("http://") || imageUrl.startsWith("https://"))
            ? imageUrl
            : request.getContextPath() + imageUrl;
%>

    <!-- Salon Card -->
    <div class="w-[320px] flex-shrink-0 bg-surface-light dark:bg-surface-dark 
                rounded-3xl overflow-hidden shadow-lg 
                hover:shadow-2xl transition 
                border border-gray-100 dark:border-gray-800 
                flex flex-col">

        <div class="relative w-full h-48 overflow-hidden">
            <img src="<%= finalImageUrl %>" 
                 alt="<%= salonName1 %>" 
                 class="w-full h-full object-cover block"/>

            <div class="absolute top-4 right-4 
                        bg-white dark:bg-black/70 
                        backdrop-blur-sm px-3 py-1 
                        rounded-full flex items-center shadow-sm">
                <span class="material-icons text-yellow-400 text-sm mr-1">star</span>
                <span class="text-sm font-bold text-gray-800 dark:text-white">
                    <%= String.format("%.1f", rating) %>
                </span>
            </div>
        </div>

        <div class="p-6 flex flex-col flex-grow">
            <h3 class="text-xl font-display font-bold 
                       text-gray-900 dark:text-white 
                       mb-2 line-clamp-1">
                <%= salonName1 %>
            </h3>

            <p class="text-gray-500 dark:text-gray-400 
                      text-sm flex items-center mb-2">
                <span class="material-icons text-sm mr-1">place</span>
                <%= city %>
            </p>

            <p class="text-gray-600 dark:text-gray-300 
                      text-sm mb-4 line-clamp-2">
                <%= description != null ? description : "Premium salon services" %>
            </p>

            <div class="mt-auto">
                <a href="customer/salon-details.jsp?id=<%= salonId %>" 
                   class="block w-full text-center px-4 py-2 
                          bg-primary text-white 
                          rounded-full hover:bg-opacity-90 
                          transition text-sm font-bold">
                    View Details & Book
                </a>
            </div>
        </div>
    </div>
		   
		      
        <%
                }

                if (!rs.isBeforeFirst()) {
        %>
      
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
        %>
        <div class="col-span-full bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-800 dark:text-red-200 px-4 py-3 rounded-lg">
            Error loading salons. Please try again.
        </div>
        <%
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception ignored) {}
                try { if (ps != null) ps.close(); } catch (Exception ignored) {}
                try { if (con != null) con.close(); } catch (Exception ignored) {}
            }
        %>
</div>
</div>
<div class="mt-8 text-center md:hidden">
<a class="inline-flex items-center text-primary font-bold hover:underline" href="#">
                    View all salons <span class="material-icons text-sm ml-1">arrow_forward</span>
</a>
</div>
</div>
</section>

<section class="py-20 bg-primary/5 dark:bg-surface-dark border-t border-gray-100 dark:border-gray-800">
<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
<div class="lg:grid lg:grid-cols-2 lg:gap-16 items-center">
<div class="mb-10 lg:mb-0 relative ">
<div class="absolute inset-0 bg-primary/20 rounded-3xl transform rotate-3 scale-105 z-0"></div>

<img
    src="https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?auto=format&fit=crop&w=1000&q=80"
    alt="Salon booking"
    class="feature-image relative z-10 rounded-3xl shadow-2xl w-full object-cover h-[500px]"
/>

</div>

<div class="feature-content">
<h2 class="text-3xl font-display font-bold italic text-primary mb-6 text-primary italic ">Seamless Booking, Verified Salons</h2>
<p class="text-lg text-gray-600 dark:text-gray-300 mb-6">
                        Say goodbye to endless phone calls and scheduling conflicts. Our platform connects you directly with the best salons in town.
                    </p>
<ul class="space-y-6">
<li class="feature-item flex items-start">
<div class="flex-shrink-0 bg-primary/20 rounded-full p-2 mt-1">
<span class="material-icons text-primary text-xl">check_circle</span>
</div>
<div class="ml-4">
<h4 class="text-lg font-bold text-gray-900 dark:text-white">Real-time Availability</h4>
<p class="text-gray-500 dark:text-gray-400 text-sm mt-1">See therapist schedules instantly and book slots that work for you.</p>
</div>
</li>
<li class="feature-item flex items-start">
<div class="flex-shrink-0 bg-primary/20 rounded-full p-2 mt-1">
<span class="material-icons text-primary text-xl">verified_user</span>
</div>
<div class="ml-4">
<h4 class="text-lg font-bold text-gray-900 dark:text-white">Verified Reviews</h4>
<p class="text-gray-500 dark:text-gray-400 text-sm mt-1">Make informed decisions based on genuine ratings from real customers.</p>
</div>
</li>
<li class="feature-item flex items-start">
<div class="flex-shrink-0 bg-primary/20 rounded-full p-2 mt-1">
<span class="material-icons text-primary text-xl">notifications_active</span>
</div>
<div class="ml-4">
<h4 class="text-lg font-bold text-gray-900 dark:text-white">Smart Reminders</h4>
<p class="text-gray-500 dark:text-gray-400 text-sm mt-1">Get automated email and SMS notifications so you never miss a pampering session.</p>
</div>

</li>
</ul>
</div>
</div>
</div>
</section>

<section class="py-20">
    <div class="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8">

        <!-- Gradient Border Wrapper -->
        <div class="bg-gradient-to-r from-primary/40 to-secondary/40 
                    p-[2px] rounded-[2.2rem] 
                    hover:shadow-[0_0_40px_rgba(216,164,143,0.4)]
                    transition duration-500">

            <!-- Main Card -->
            <div class="bg-primary/5 dark:bg-surface-dark from-gray-900 to-gray-800 
                        dark:from-gray-800 dark:to-gray-900
                        rounded-[2rem] p-10 md:p-16 
                        text-center relative overflow-hidden 
                        shadow-2xl
                        transform hover:-translate-y-1 transition duration-500">

                <!-- Glow Blobs -->
                <div class="relative z-10">
                    <h2 class="text-3xl md:text-4xl font-display font-bold text-white mb-6">
                        Are you a Salon Owner?
                    </h2>

                    <p class="text-gray-300 text-lg mb-8 max-w-2xl mx-auto">
                        Streamline your operations, manage appointments efficiently,
                        and grow your customer base with our all-in-one management solution.
                    </p>

                    <div class="flex flex-col sm:flex-row justify-center gap-4">

                        <!-- Primary Button -->
                        <a href="register.jsp"
                           class="bg-primary hover:bg-primary/90 text-white font-bold 
                                  py-3 px-8 rounded-full transition 
                                  shadow-lg hover:shadow-[0_0_25px_rgba(216,164,143,0.6)]
                                  transform hover:-translate-y-1">
                            Register Your Business
                        </a>

                        <!-- Secondary Button -->
                        <a href="partners.jsp"
                           class="border-2 border-white/30 text-white 
                                  hover:bg-white/10 font-bold 
                                  py-3 px-8 rounded-full transition
                                  hover:shadow-[0_0_20px_rgba(255,255,255,0.3)]">
                            Learn More
                        </a>

                    </div>
                </div>
            </div>
        </div>

    </div>
</section>

<script>
document.addEventListener("DOMContentLoaded", () => {
    const content = document.querySelector(".feature-content");

    const observer = new IntersectionObserver(
        (entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add("show");
                }
            });
        },
        { threshold: 0.3 }
    );

    if (content) observer.observe(content);
});
</script>


<!-- Footer Section  -->

<%@ include file="footer.jsp" %>

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

</body></html>