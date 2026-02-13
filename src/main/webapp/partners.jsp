<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SalonConnect - Book Your Appointment</title>


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
/*Header animation*/
/* ===== Hero Text Animation ===== */

/* Parent container animation */
.flex.flex-col.gap-6.lg\:order-2.order-1.lg\:pl-10 {
  opacity: 0;
  transform: translateY(40px);
  animation: fadeSlideUp 1s ease forwards;
}

/* Heading animation */
.flex.flex-col.gap-6.lg\:order-2.order-1.lg\:pl-10 h1 {
  opacity: 0;
  transform: translateY(30px);
  animation: fadeSlideUp 1s ease forwards;
  animation-delay: 0.3s;
}

/* Paragraph animation */
.flex.flex-col.gap-6.lg\:order-2.order-1.lg\:pl-10 p {
  opacity: 0;
  transform: translateY(30px);
  animation: fadeSlideUp 1s ease forwards;
  animation-delay: 0.6s;
}

/* Button animation */
.flex.flex-col.gap-6.lg\:order-2.order-1.lg\:pl-10 a {
  opacity: 0;
  transform: translateY(30px);
  animation: fadeSlideUp 1s ease forwards;
  animation-delay: 0.9s;
}

/* Keyframes */
@keyframes fadeSlideUp {
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
/* ===== Card Border + Shadow ===== */

.step-card {
  border: 2px solid #d8a48f; /* Soft brand border */
  box-shadow: 0 15px 35px rgba(216, 164, 143, 0.25);
  transition: all 0.3s ease;
}

/* Hover Effect Enhancement */
.step-card:hover {
  box-shadow: 0 25px 60px rgba(216, 164, 143, 0.45);
  transform: translateY(-6px);
}

/*Cards animation*/
/* Initial state (hidden) */
.step-card {
  opacity: 0;
  transform: translateY(50px);
  transition: opacity 0.8s ease, transform 0.8s ease;
}

/* Active state (visible) */
.step-card.show {
  opacity: 1;
  transform: translateY(0);
}

/* Stagger delay */
.step-card:nth-of-type(1).show {
  transition-delay: 0.2s;
}

.step-card:nth-of-type(2).show {
  transition-delay: 0.4s;
}

.step-card:nth-of-type(3).show {
  transition-delay: 0.6s;
}


/* Section Layout */
.video-split-section {
  padding-left:120px;
  padding-top:50px;
  padding-bottom: 50px;

}

.video-split {
  display: flex;
  align-items: stretch;
  border-radius: 12px;
  overflow: hidden;
  min-height: 350px;
}

/* ===== Image Left ===== */
.image-left {
    flex: 1;
    height: 450px;
    border-radius: 12px;
    overflow: hidden;
}

.image-left img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    border-radius: 12px;
}
/* Right: Content */
.content-right {
  flex: 1;
  padding: 0px 40px;
  text-align: left;
  background: linear-gradient(90deg, rgba(0, 0, 0, 1), #b58e7e);
  display: flex;
  flex-direction: column;
  justify-content: center;
  width: 640px;
  height: 450px;
}

.content-right h2 {
  font-size: 2.2rem;
  margin-bottom: 15px;
  text-transform: uppercase;
  font-weight: 700;
  padding-top: 10px;
  background: linear-gradient(90deg, #F2C1AE, #ffffff, #F2C1AE);
  background-size: 200% auto;
  background-clip: text;
  -webkit-text-fill-color: transparent;
  animation: shine 4s linear infinite;
  margin-block-start: 0px;
}

@keyframes shine {
  to {
    background-position: 200% center;
  }
}
/*Your Journey*/
/* Hidden state */
.timeline-line > div {
  opacity: 0;
  transform: translateY(60px);
  transition: opacity 0.8s ease, transform 0.8s ease;
}

/* Visible state */
.timeline-line > div.show {
  opacity: 1;
  transform: translateY(0);
}


/* Timeline */
.step {
  display: flex;
  align-items: flex-start;
  margin-bottom: 5px;
  gap: 18px;
}

.step-icon {
  width: 30px;
  height: 30px;
  border-radius: 50%;
  background: #F2C1AE;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #111;
  font-size: 1.2rem;
  flex-shrink: 0;
  transition: transform 0.4s ease;
}

.step:hover .step-icon {
  transform: scale(1.2) rotate(10deg);
}

.step-content h4 {
  margin: 0;
  font-size: 15.7px;
  font-weight: 600;
  color: #fff;
}

.step-content p {
  margin: 5px 0 0;
  font-size: 0.95rem;
  color: #ccc;
  margin-bottom: 5px;
}

/* CTA Button */
.btn-glow {
  display: inline-block;
  padding: 5px 10px;
  font-size: 15px;
  font-weight: 600;
  text-transform: uppercase;
  border: none;
  border-radius: 30px;
  background: #F2C1AE;
  color: #111;
  cursor: pointer;
  text-decoration: none;
  transition: 0.3s ease;
  width: 135px;
  text-align: center;
  animation: bounceBtn 2s infinite;
}

.btn-glow:hover {
  background: #fff;
  color: #111;
}

@keyframes bounceBtn {

  0%,
  100% {
    transform: translateY(0);
  }

  50% {
    transform: translateY(-5px);
  }
}

/* Responsive */
@media (max-width: 900px) {
  .video-split {
    flex-direction: column;
  }

  .content-right {
    text-align: center;
  }

  .timeline {
    text-align: left;
    display: inline-block;
  }
}


.step-number {
  background: #f4b183;
  color: white;
  border-radius: 50%;
  display: flex; 
  animation: pulse 1.5s infinite;
}
@keyframes pulse {
  0% { box-shadow: 0 0 0 0 rgba(244,177,131,0.6); }
  70% { box-shadow: 0 0 0 15px rgba(244,177,131,0); }
  100% { box-shadow: 0 0 0 0 rgba(244,177,131,0); }
}
.step-card:nth-child(1) { animation-delay: 0.2s; }
.step-card:nth-child(2) { animation-delay: 0.5s; }
.step-card:nth-child(3) { animation-delay: 0.8s; }

@keyframes fadeUp {
  to {
    opacity: 1;
    transform: translateY(0);
  }
}


.stat-card {
  padding: 8px 20px;
  border: 2px solid #e5e7eb;
  border-radius: 9999px; /* OVAL SHAPE */
  transition: all 0.3s ease;
}

.stat-card:hover {
  border-color: #f4b183;
}


.map-wrapper{
  display:flex;
  justify-content:center;
  align-items:center;
  padding:40px;
}
path{
  animation: move 2s linear infinite;
}

@keyframes move{
  to{ stroke-dashoffset:-24; }
}
g{
  animation:pulse 1.5s infinite;
}
		
    </style>
</head>
<body class="bg-background-light dark:bg-background-dark text-gray-800 dark:text-gray-200 transition-colors duration-300 overflow-x-hidden">



<!-- Navbar Section  -->
<%@ include file="navbar.jsp" %>



<section class="relative pt-10 pb-20 px-6 md:px-12 bg-brand-cream overflow-hidden">
<div class="max-w-7xl mx-auto grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
<!-- Left: Image -->
<div class="relative rounded-[40px] overflow-hidden shadow-2xl lg:order-1 order-2 h-full min-h-[500px]">
<img alt="Salon Interior" class="w-full h-full object-cover" src="${pageContext.request.contextPath}/images/cutting.jpg"/>
</div>
<!-- Right: Content -->
<div class="flex flex-col gap-6 lg:order-2 order-1 lg:pl-10">
<h1 class="text-5xl font-display font-bold italic text-primary mb-4 text-primary italic ">
          Grow Your Salon Business with SalonConnect
        </h1>
<p class="text-white text-lg leading-relaxed max-w-lg"
>
          Reach more clients, streamline your bookings, and manage your staff effortlessly with our all-in-one partner platform. Designed for the modern salon professional.
        </p>
<div class="flex flex-wrap gap-4 mt-4">
<a class="px-8 py-3 border border-brand-dark text-brand-dark rounded-full font-medium hover:bg-gray-50 transition-colors" href="register.jsp">
            Get Started
          </a>

</div>
</div>
</div>
</section>
<!-- END: Hero Section -->
<!-- BEGIN: Why Partner Section -->
<section class="py-16 px-6 md:px-12 bg-white dark:bg-surface-dark">
<div class="max-w-7xl mx-auto">
<div class="text-center mb-16">
<h2 class="text-4xl font-display font-bold italic text-primary mb-4 text-center">
  Why Partner with Us?
</h2>

<p class="text-white text-lg leading-relaxed max-w-lg">
 
</p>

          Unlock exclusive benefits designed to help your salon thrive in the digital age. We provide the tools, you provide the talent.
        </p>
</div>
<div class="grid grid-cols-1 md:grid-cols-3 gap-8">
<!-- Card 1 -->
<div class="step-card feature-card p-10 rounded-xl bg-background-light dark:bg-background-dark flex flex-col items-start gap-4 hover:-translate-y-1 transition-transform duration-300">
<div class="step-number w-12 h-12 rounded-full flex items-center justify-center mb-2" style="background-color: #FFF5F5; color: #D98E7F;"><i class="fa-solid fa-arrow-trend-up text-lg">1</i></div>
<h3 class="font-serif text-2xl font-medium font-bold !text-primary">Increased Visibility</h3>
<p class="text-white text-lg leading-relaxed max-w-lg">
            Get discovered by thousands by local clients looking for professional beauty services every single day.
          </p>
</div>
<!-- Card 2 -->
<div class="step-card feature-card p-10 rounded-xl bg-background-light dark:bg-background-dark flex flex-col items-start gap-4 hover:-translate-y-1 transition-transform duration-300">
<div class="step-number w-12 h-12 rounded-full flex items-center justify-center mb-2" style="background-color: #FFF5F5; color: #D98E7F;"><i class="fa-solid fa-calendar-check text-lg">2</i></div>
<h3 class="font-serif text-2xl font-medium font-bold !text-primary">Easy Scheduling</h3>
<p class="text-white text-lg leading-relaxed max-w-lg">
            Automated booking systems that reduces no-shows and manages your staff calendar 24/7 without a phone call.
          </p>
</div>
<!-- Card 3 -->
<div class="step-card feature-card p-10 rounded-xl bg-background-light dark:bg-background-dark flex flex-col items-start gap-4 hover:-translate-y-1 transition-transform duration-300">
<div class="step-number w-12 h-12 rounded-full flex items-center justify-center mb-2" style="background-color: #FFF5F5; color: #D98E7F;"><i class="fa-solid fa-shield-halved text-lg">3</i></div>
<h3 class="font-serif text-2xl font-medium font-bold !text-primary">Secure Payments</h3>
<p class="text-white text-lg leading-relaxed max-w-lg">
            Get paid faster with our integrated, encrypted payment processing and payouts directly to your bank account.
          </p>
</div>
</div>
</div>
</section>
<!-- END: Why Partner Section -->
<!-- BEGIN: How It Works Section -->
<section class="py-14 px-6 md:px-12 bg-brand-tan relative" style="bg-primary/5 dark:bg-surface-dark border-t border-gray-100 dark:border-gray-800">
<div class=" mx-auto grid grid-cols-1 md:grid-cols-2 gap-16 items-center" style="padding-left: 90px;">
<div>
<div class="text-center mb-10 ">
<h2 class="text-4xl font-display font-bold italic text-primary mb-4 text-primary italic ">How it Works</h2>
</div>
<!-- Timeline Container -->
<div class="relative timeline-line pl-12 md:pl-0">
<!-- Step 1 -->
<div class="relative mb-16 md:ml-12">
<!-- Number Circle -->
<div class="absolute -left-[54px] md:-left-[64px] top-12 w-10 h-10 rounded-full bg-brand-orange text-white flex items-center justify-center font-bold z-10 shadow-md" style="background-color: #F08060;">
             1
           </div>
<div class="flex flex-col items-start text-left">
<h3 class="text-2xl font-display font-bold text-primary mb-2 text-primary italic ">Register Your Salon</h3>
<p class="text-white text-lg leading-relaxed max-w-lg"
>
               Quick sign-up process. Provide your business name, contact details, and salon location to get started.
             </p>
</div>
</div>
<!-- Step 2 -->
<div class="relative mb-16 md:ml-12">
<!-- Number Circle -->
<div class="absolute -left-[54px] md:-left-[64px] top-12 w-10 h-10 rounded-full bg-brand-orange text-white flex items-center justify-center font-bold z-10 shadow-md" style="background-color: #F08060;">
             2
           </div>
<div class="flex flex-col items-start text-left">
<h3 class="text-2xl font-display font-bold text-primary mb-2 text-primary italic ">Set Your Services</h3>
<p class="text-white text-lg leading-relaxed max-w-lg"
>
               List your signature treatments, set competitive prices, and assign specific staff members to services.
             </p>
</div>
</div>
<!-- Step 3 -->
<div class="relative md:ml-12">
<!-- Number Circle -->
<div class="absolute -left-[54px] md:-left-[64px] top-12 w-10 h-10 rounded-full bg-brand-orange text-white flex items-center justify-center font-bold z-10 shadow-md" style="background-color: #F08060;">
             3
           </div>
<div class="flex flex-col items-start text-left">
<h3 class="text-2xl font-display font-bold text-primary mb-2 text-primary italic ">Start Receiving Bookings</h3>
<p class="text-white text-lg leading-relaxed max-w-lg"
>
               Go live on our platform! Clients find your salon, view portfolio, and book appointments directly from their phone.
             </p>
</div>
</div>
</div>
</div>

<div class="flex  justify-center map-wrapper" style="margin-top: 40px;">
<svg width="360" height="360" viewBox="0 0 360 360">
<defs>
  <linearGradient id="pathGradient" x1="0%" y1="0%" x2="100%" y2="100%">
    <stop offset="0%" stop-color="#F08060"/>
    <stop offset="100%" stop-color="#FFB88C"/>
  </linearGradient>
</defs>
  <!-- DOTTED ZIG-ZAG PATH -->
  <path
    d="M 70 300
       C 140 260, 220 260, 290 220
       S 220 160, 140 160
       S 220 60, 290 40"
    fill="none"
    stroke="url(#pathGradient)"
    stroke-width="6"
    stroke-dasharray="12 12"
    stroke-linecap="round"
  />

  <!-- PIN 1 (BOTTOM LEFT) -->
  <g transform="translate(50,260)">
    <path d="M20 0 C9 0 0 9 0 20 C0 34 20 54 20 54 C20 54 40 34 40 20 C40 9 31 0 20 0Z"
          fill="#FFE5DE" stroke="#F08060" stroke-width="4"/>
    <circle cx="20" cy="20" r="6" fill="none" stroke="#F08060" stroke-width="3"/>
  </g>

  <!-- PIN 2 (MIDDLE RIGHT) -->
  <g transform="translate(260,150)">
    <path d="M20 0 C9 0 0 9 0 20 C0 34 20 54 20 54 C20 54 40 34 40 20 C40 9 31 0 20 0Z"
          fill="#FFE5DE" stroke="#F08060" stroke-width="4"/>
    <circle cx="20" cy="20" r="6" fill="none" stroke="#F08060" stroke-width="3"/>
  </g>

  <!-- PIN 3 (TOP RIGHT) -->
  <g transform="translate(260,10)">
    <path d="M20 0 C9 0 0 9 0 20 C0 34 20 54 20 54 C20 54 40 34 40 20 C40 9 31 0 20 0Z"
          fill="#FFE5DE" stroke="#F08060" stroke-width="4"/>
    <circle cx="20" cy="20" r="6" fill="none" stroke="#F08060" stroke-width="3"/>
  </g>

</svg>
</div>
</div>
</section>

<section class="video-split-section" data-aos="fade-up" data-aos-duration="1500">
  <div class="container">
    <div class="video-split">
      <!-- Left: Image -->
<div class="image-left">
    <img src="${pageContext.request.contextPath}/images/aboutimage.jpg" alt="Salon Journey">
</div>

      <!-- Right: Content -->
      <div class="content-right" data-aos="fade-left" style="padding-bottom: 30px; padding-top: 20px;">
        <h2 class="text-2xl font-display font-bold text-primary mb-4 text-primary italic ">Your Journey With SalonConnect</h2>
        
        <div class="timeline">
          <div class="step" data-aos="fade-left" data-aos-delay="200">
            <div class="step-icon"><i class="bi bi-lightning-charge-fill"></i></div>
            <div class="step-content">
              <h4>Day 1: Welcome Glow</h4>
              <p>Start your beauty journey with expert salon care</p>
            </div>
          </div>
          <div class="step" data-aos="fade-left" data-aos-delay="300">
            <div class="step-icon"><i class="bi bi-heart-pulse-fill"></i></div>
            <div class="step-content">
              <h4>1 Month:Noticeable Shine</h4>
              <p>Notice healthier hair skin confidence and overall freshness</p>
            </div>
          </div>
          <div class="step" data-aos="fade-left" data-aos-delay="400">
            <div class="step-icon"><i class="bi bi-fire"></i></div>
            <div class="step-content">
              <h4>3 Months:Visible Transformation</h4>
              <p>See visible transformation in style texture and appearance</p>
            </div>
          </div>
          <div class="step" data-aos="fade-left" data-aos-delay="500">
            <div class="step-icon"><i class="bi bi-trophy-fill"></i></div>
            <div class="step-content">
              <h4>6 Months: Signature Look</h4>
              <p>Achieve signature look with long lasting confidence and glow.</p>
            </div>
          </div>
        </div>
        <!-- CTA Button -->
        <a class="btn-glow" data-aos="zoom-in" data-aos-delay="600">Start Today</a>
      </div>
    </div>
  </div>
</section>

<!-- END: How It Works Section -->
<!-- BEGIN: Stats Section -->
<section class="py-10 px-6 md:px-12">
<div class="max-w-7xl mx-auto">
<div class="grid grid-cols-2 md:grid-cols-4 gap-10 text-center">
<!-- Stat 1 -->
<div class="stat-card bg-background-light dark:bg-background-dark flex flex-col gap-2">
<span class="font-serif text-4xl md:text-5xl font-bold !text-primary">5,000+</span>
<span class="text-white text-lg leading-relaxed max-w-lg">Partner Salons</span>
</div>
<!-- Stat 2 -->
<div class="stat-card bg-background-light dark:bg-background-dark flex flex-col gap-2">
<span class="font-serif text-4xl md:text-5xl font-bold !text-primary">120k</span>
<span class="text-white text-lg leading-relaxed max-w-lg">Monthly Bookings</span>
</div>
<!-- Stat 3 -->
<div class="stat-card bg-background-light dark:bg-background-dark flex flex-col gap-2">
<span class="font-serif text-4xl md:text-5xl font-bold !text-primary">98%</span>
<span class="text-white text-lg leading-relaxed max-w-lg">Partner Satisfaction</span>
</div>
<!-- Stat 4 -->
<div class="stat-card bg-background-light dark:bg-background-dark flex flex-col gap-2">
<span class="font-serif text-4xl md:text-5xl font-bold !text-primary">15%</span>
<span class="text-white text-lg leading-relaxed max-w-lg">Revenue Growth</span>
</div>
</div>
</div>
</section>
<!-- END: Stats Section -->
<script>
  window.addEventListener("load", function () {
    const cards = document.querySelectorAll(".step-card");
    cards.forEach((card, index) => {
      setTimeout(() => {
        card.classList.add("show");
      }, index * 200);
    });
  });
</script>

<%--your journey --%>
<script>
document.addEventListener("DOMContentLoaded", function () {

  const steps = document.querySelectorAll(".timeline-line > div");

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

  steps.forEach((step) => {
    observer.observe(step);
  });

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