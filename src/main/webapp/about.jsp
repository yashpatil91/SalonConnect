<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SalonConnect - Our Services</title>


<script src="https://cdn.tailwindcss.com?plugins=forms,typography"></script>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Lato:wght@300;400;700&display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Manrope:wght@300;400;500;600;700;800&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
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

/* ===== FORCE NAV TEXT COLOR (LIGHT MODE) ===== */
nav a {
    color: #1f2937 !important; /* dark gray */
}

/* ===== FORCE NAV TEXT COLOR (DARK MODE) ===== */
.dark nav a {
    color: #ffffff !important;
}



        body {
            font-family: 'Lato', sans-serif;
       	 }
        h1, h2, h3, h4, h5, h6 {
            font-family: 'Playfair Display', serif;
		}
		.material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        	}
  /*header section*/ 

  body { 
    font-family: 'Lato', sans-serif;
  }

  h1, h2, h3, h4, h5, h6 {
    font-family: 'Playfair Display', serif;
  }

  /* ===== Animations ===== */
  .fade-up {
    animation: fadeUp 0.9s ease-out both;
  }

  .fade-delay-1 { animation-delay: .2s; }
  .fade-delay-2 { animation-delay: .4s; }
  .fade-delay-3 { animation-delay: .6s; }

  @keyframes fadeUp {
    from { 
      opacity: 0; 
      transform: translateY(40px); 
    }
    to { 
      opacity: 1; 
      transform: translateY(0); 
    }
  }
  
     /*Our Mission*/
 /* ===== Initial Hidden State ===== */
.slide-left,
.slide-right {
  opacity: 0;
  transition: all 1s ease;
}

/* Left Animation */
.slide-left {
  transform: translateX(-80px);
}

/* Right Animation */
.slide-right {
  transform: translateX(80px);
}

/* Active State */
.slide-left.show,
.slide-right.show {
  opacity: 1;
  transform: translateX(0);
}
 /*Image Css*/
 /* Target ONLY the image block inside the 2-column grid */
.grid.lg\:grid-cols-2 > .relative > .aspect-square {
  border: 4px solid #d8a48f;
  box-shadow: 0 25px 60px rgba(216, 164, 143, 0.35);
  transition: all 0.4s ease;
}

.grid.lg\:grid-cols-2 > .relative > .aspect-square:hover {
  transform: scale(1.04);
  box-shadow: 0 35px 80px rgba(216, 164, 143, 0.45);
}

/* Small floating image */
.grid.lg\:grid-cols-2 > .relative > .absolute {
  border: 4px solid #d8a48f !important;
  box-shadow: 0 20px 50px rgba(0, 0, 0, 0.25);
  transition: all 0.4s ease;
}

.grid.lg\:grid-cols-2 > .relative > .absolute:hover {
  transform: scale(1.05);
  box-shadow: 0 30px 70px rgba(0, 0, 0, 0.35);
}
 /*Our values cards*/
 /* Initial hidden state */
.feature-card {
  opacity: 0;
  transform: translateY(-60px);
  transition: opacity 3 s ease, transform 3 s ease;
}

/* When visible */
.feature-card.show {
  opacity: 1;
  transform: translateY(0);
}
 
/*Our Values*/
/* ===== Cards ===== */
.feature-card {
  border: 3px solid #d8a48f;
  box-shadow: 0 12px 30px rgba(216,164,143,.25);
  transition: all .4s ease;
}

.feature-card:hover {
  transform: translateY(-10px) scale(1.02);
  box-shadow: 0 25px 50px rgba(216,164,143,.45);
}

/* ===== Founder Cards ===== */
.founder-card img {
  transition: transform .6s ease;
}

.founder-card:hover img {
  transform: scale(1.08);
}
/* Card border & border shadow */
/* styles.css */
.feature-card {
  border: 2px solid #d8a48f;
  box-shadow: 0 0 0 1px rgba(216, 164, 143, 0.25);
}

.feature-card:hover {
  box-shadow: 0 12px 30px -8px rgba(216, 164, 143, 0.45);
}
/*Meet the founders*/
/* ===== Cards ===== */
.feature-card {
  border: 2px solid #d8a48f;
  box-shadow: 0 0 0 1px rgba(216, 164, 143, 0.25);
  transition: all 0.4s ease;
}

.feature-card:hover {
  transform: translateY(-10px) scale(1.02);
  box-shadow: 0 25px 50px rgba(216, 164, 143, 0.45);
}

/* ===== Founder Image Zoom ===== */
.founder-card img {
  transition: transform 0.6s ease;
}

.founder-card:hover img {
  transform: scale(1.08);
}

/* ===== CTA ===== */
.cta-card {
  border: 2px solid #d8a48f;
  transition: all .4s ease;
}

.cta-card:hover {
  box-shadow: 0 30px 80px rgba(216,164,143,.45);
  transform: translateY(-6px);
}

/* ===== Buttons ===== */
.btn-primary {
  background: #d8a48f;
  color: #fff;
  transition: .3s ease;
}

.btn-primary:hover {
  transform: translateY(-3px) scale(1.05);
  box-shadow: 0 12px 30px rgba(216,164,143,.5);
}

.btn-outline {
  border: 2px solid #d8a48f;
  color: #d8a48f;
  background: transparent;
  transition: .3s ease;
}

.btn-outline:hover {
  background: #d8a48f;
  color: #fff;
  transform: translateY(-3px);
}

    </style>
</head>
<body class="bg-background-light dark:bg-background-dark text-gray-800 dark:text-gray-200 transition-colors duration-300 overflow-x-hidden">



<!-- Navbar Section  -->
<%@ include file="navbar.jsp" %>

<!-- Hero Section -->
<section class="relative h-[600px] flex items-center justify-center overflow-hidden">
  <div class="absolute inset-0 z-0">
 <img
  alt="Salon Background"
  class="w-full h-full object-cover"
src="${pageContext.request.contextPath}/images/aboutimage.jpg"
/>


    <div class="absolute inset-0 bg-gradient-to-b from-white/40 via-white/20 to-background-light dark:from-background-dark/60 dark:to-background-dark"></div>
  </div>

  <div class="relative z-10 text-center px-4 max-w-4xl">
    <span class="inline-block px-4 py-1.5 mb-6 rounded-full bg-primary/10 text-primary text-sm font-bold tracking-wide uppercase fade-up fade-delay-1">
      Our Story
    </span>

    <h1 class="text-5xl md:text-7xl font-black mb-8 leading-tight tracking-tight fade-up fade-delay-2">
      Crafting a sanctuary for <span class="text-primary">self-care</span>.
    </h1>

    <p class="text-lg md:text-xl text-gray-600 dark:text-gray-300 leading-relaxed max-w-2xl mx-auto font-medium fade-up fade-delay-3">
      From a simple idea to a serene bridge between you and the art of professional beauty.
      We believe everyone deserves a seamless path to wellness.
    </p>
  </div>
</section>
<!-- Mission Section -->
<section class="py-10 px-6">
<div class="max-w-7xl mx-auto">
<div class="grid lg:grid-cols-2 gap-16 items-center">
<div class="relative">
<div class="aspect-square rounded-xl overflow-hidden shadow-2xl">
<img alt="Beauty Treatment" class="w-full h-full object-cover" data-alt="Detailed shot of high-quality facial treatment tools" src="${pageContext.request.contextPath}/images/cutting.jpg"/>
</div>
<div class="absolute -bottom-8 -right-8 w-64 h-64 rounded-xl overflow-hidden border-8 border-background-light dark:border-background-dark shadow-xl hidden md:block">
<img alt="Salon Detail" class="w-full h-full object-cover" data-alt="Minimalist modern beauty salon reception desk"  src="${pageContext.request.contextPath}/images/access.jpg"/>
</div>
</div>
<div class="space-y-8">
<h2 class="text-4xl font-display font-bold italic text-primary mb-4 text-primary italic ">Our Mission</h2>
<p class="text-lg font-semibold"">

                            To empower every individual with seamless access to top-tier beauty and wellness services, fostering a community built on care, trust, and professional excellence.
                        </p>
<div class="space-y-4">
<div class="flex gap-4 items-start">
<div class="size-6 mt-1 flex items-center justify-center text-primary">
<span class="material-symbols-outlined font-bold">check_circle</span>
</div>
<p class="text-lg font-semibold">Bridging clients with hand-picked experts</p>
</div>
<div class="flex gap-4 items-start">
<div class="size-6 mt-1 flex items-center justify-center text-primary">
<span class="material-symbols-outlined font-bold">check_circle</span>
</div>
<p class="text-lg font-semibold">Ensuring quality and safety in every booking</p>
</div>
<div class="flex gap-4 items-start">
<div class="size-6 mt-1 flex items-center justify-center text-primary">
<span class="material-symbols-outlined font-bold">check_circle</span>
</div>
<p class="text-lg font-semibold">Promoting mental rejuvenation through beauty</p>
</div>
</div>
</div>
</div>
</div>
</section>
<!-- Values Section -->
<section class="py-10 bg-white dark:bg-background-dark/50">
  <div class="max-w-7xl mx-auto px-6">

    <div class="text-center max-w-2xl mx-auto mb-16">
      <h2 class="text-4xl font-display font-bold italic text-primary mb-4 text-primary italic ">Our Core Values</h2>
      <p class="text-lg font-semibold">
        The principles that guide every booking and every interaction between our community members.
      </p>
    </div>

    <div class="grid md:grid-cols-3 gap-8">

      <!-- Value 1 -->
      <div class="feature-card p-10 rounded-xl bg-background-light dark:bg-background-dark">
        <div class="w-14 h-14 bg-primary/10 rounded-lg flex items-center justify-center text-primary mb-8">
          <span class="material-symbols-outlined text-3xl">verified_user</span>
        </div>
        <h3 class="text-2xl font-bold mb-4 text-primary">Trust</h3>
        <p class="text-lg font-semibold">
          Verified professionals and secure, transparent booking processes for your absolute peace of mind.
        </p>
      </div>

      <!-- Value 2 -->
      <div class="feature-card p-10 rounded-xl bg-background-light dark:bg-background-dark">
        <div class="w-14 h-14 bg-primary/10 rounded-lg flex items-center justify-center text-primary mb-8">
          <span class="material-symbols-outlined text-3xl">star</span>
        </div>
        <h3 class="text-2xl font-bold mb-4 text-primary">Quality</h3>
        <p class="text-lg font-semibold">
          Hand-picked salons and premium therapists committed to the highest industry standards and results.
        </p>
      </div>

      <!-- Value 3 -->
      <div class="feature-card p-10 rounded-xl bg-background-light dark:bg-background-dark">
        <div class="w-14 h-14 bg-primary/10 rounded-lg flex items-center justify-center text-primary mb-8">
          <span class="material-symbols-outlined text-3xl">psychology</span>
        </div>
        <h3 class="text-2xl font-bold mb-4 text-primary">Wellness</h3>
       <p class="text-lg font-semibold">
          Prioritizing self-care and mental rejuvenation as an essential, accessible part of your lifestyle.
        </p>
      </div>

    </div>
  </div>
</section>

<!-- Meet the Founders -->
<section class="py-12 px-6 bg-white dark:bg-background-dark/50">
  <div class="max-w-7xl mx-auto">

    <!-- Section Heading -->
    <div class="text-center max-w-2xl mx-auto mb-14">
      <h2 class="text-4xl font-display font-bold italic text-primary mb-4">
        Meet the Founders
      </h2>
      <p class="text-lg font-semibold">
        The visionaries behind SalonEase who are dedicated to transforming the beauty industry landscape.
      </p>
    </div>

    <!-- Cards Grid -->
    <div class="grid gap-10 sm:grid-cols-2 lg:grid-cols-3">

      <!-- Card 1 -->
      <div class="feature-card founder-card bg-white dark:bg-neutral-900 rounded-2xl overflow-hidden">
        <div class="h-80 overflow-hidden">
          <img
            src="${pageContext.request.contextPath}/images/menfounder.jpg"
            alt="Sophia Chen"
            class="w-full h-full object-cover"
          />
        </div>

        <div class="p-6 text-center">
          <h3 class="text-2xl font-bold mb-1">Aditya Sharma</h3>
          <span class="text-xs uppercase tracking-wider font-semibold text-primary">
            CEO & Co-Founder
          </span>
          <p class="text-lg font-semibold">
            With 12 years in beauty tech, Aditya envisioned a world where wellness is just a tap away.
          </p>
        </div>
      </div>

      <!-- Card 2 -->
      <div class="feature-card founder-card bg-white dark:bg-neutral-900 rounded-2xl overflow-hidden">
        <div class="h-80 overflow-hidden">
          <img
           src="${pageContext.request.contextPath}/images/womenfounder.jpg"
            alt="Marcus Thorne"
            class="w-full h-full object-cover"
          />
        </div>

        <div class="p-6 text-center">
          <h3 class="text-2xl font-bold mb-1">Aashvi Sen</h3>
          <span class="text-xs uppercase tracking-wider font-semibold text-primary">
            COO & Co-Founder
          </span>
          <p class="text-lg font-semibold">
            Former salon owner Aashvi ensures the platform serves therapists as much as it serves clients.
          </p>
        </div>
      </div>

      <!-- Card 3 -->
      <div class="feature-card founder-card bg-white dark:bg-neutral-900 rounded-2xl overflow-hidden">
        <div class="h-80 overflow-hidden">
          <img
            src="${pageContext.request.contextPath}/images/founder.jpg"
            alt="Elena Rodriguez"
            class="w-full h-full object-cover"
          />
        </div>

        <div class="p-6 text-center">
          <h3 class="text-2xl font-bold mb-1">Kabir Malhotra</h3>
          <span class="text-xs uppercase tracking-wider font-semibold text-primary">
            Head of Experience
          </span>
          <p class="text-lg font-semibold">
            Kabir focuses on the emotional journey of every user, ensuring serenity at every touchpoint.
          </p>
        </div>
      </div>

    </div>
  </div>
</section>


<!-- CTA Section -->
<section class="py-12 px-6">
  <div class="max-w-6xl mx-auto">

    <!-- Card -->
    <div class="cta-card text-center rounded-3xl p-10 md:p-14 bg-transparent">
      
      <h2 class="text-3xl md:text-4xl font-black text-gray-900 dark:text-white mb-6 tracking-tight">
        Ready to transform your beauty routine?
      </h2>

      <p class="text-gray-600 dark:text-gray-400 text-lg mb-10 max-w-2xl mx-auto">
        Join our growing community of beauty enthusiasts and top-tier professionals today.
      </p>

      <!-- Buttons -->
      <div class="flex flex-col sm:flex-row gap-4 justify-center">
        <button class="btn-primary px-10 py-4 font-black rounded-full shadow-lg"><a href="login.jsp">
          Join the Community
        </button>

        <button class="btn-outline px-10 py-4 font-black rounded-full"><a href="services.jsp">
          Explore Services
        </button>
      </div>

    </div>

  </div>
</section>


</main>
<%--our values--%>
<script>
document.addEventListener("DOMContentLoaded", function () {

  const cards = document.querySelectorAll(".feature-card");

  const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        entry.target.classList.add("show");
        observer.unobserve(entry.target); // animate only once
      }
    });
  }, {
    threshold: 0.2
  });

  cards.forEach((card) => {
    observer.observe(card);
  });

});
</script>

<script>
document.addEventListener("DOMContentLoaded", function () {
  const leftSection = document.querySelector(".grid > div:first-child");
  const rightSection = document.querySelector(".grid > div:last-child");

  leftSection.classList.add("slide-left");
  rightSection.classList.add("slide-right");

  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add("show");
      }
    });
  }, { threshold: 0.3 });

  observer.observe(leftSection);
  observer.observe(rightSection);
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
</body>
</html>