<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 
 <!DOCTYPE html>
<html lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Explore Salons &amp; Services - SalonConnect</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,typography,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&amp;family=Lato:wght@300;400;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
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
    </style>
</head>
<body class="bg-background-light dark:bg-background-dark text-gray-800 dark:text-gray-200 transition-colors duration-300">
<!-- Navbar Section  -->
<jsp:include page="navbar.jsp" />

<main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
<div class="mb-12">
<div class="bg-white dark:bg-surface-dark p-2 rounded-2xl shadow-sm border border-gray-100 dark:border-gray-800 flex flex-col md:flex-row items-center w-full">
<div class="flex-1 w-full md:w-auto px-4 py-2 border-b md:border-b-0 md:border-r border-gray-200 dark:border-gray-700 flex items-center">
<span class="material-icons text-gray-400 mr-3">search</span>
<input class="w-full bg-transparent border-none focus:ring-0 text-sm text-gray-700 dark:text-gray-200 placeholder-gray-400" placeholder="Treatment or Venue name" type="text"/>
</div>
<div class="flex-1 w-full md:w-auto px-4 py-2 flex items-center">
<span class="material-icons text-gray-400 mr-3">location_on</span>
<input class="w-full bg-transparent border-none focus:ring-0 text-sm text-gray-700 dark:text-gray-200 placeholder-gray-400" placeholder="Current Location" type="text"/>
</div>
<div class="px-2 w-full md:w-auto mt-2 md:mt-0">
<button class="w-full md:w-auto bg-primary text-white hover:bg-opacity-90 font-bold py-2.5 px-8 rounded-xl transition shadow-md shadow-primary/20">
                        Search
                    </button>
</div>
</div>
</div>
<section class="mb-20">
<div class="flex flex-col md:flex-row md:items-end justify-between gap-4 mb-8">
<div>
<h1 class="text-3xl md:text-4xl font-display font-bold text-gray-900 dark:text-white">Explore <span class="text-primary italic">Salons</span></h1>
<p class="text-gray-500 dark:text-gray-400 mt-2">Discover premium wellness destinations near you</p>
</div>
<div class="flex items-center gap-3">
<span class="text-sm text-gray-500 dark:text-gray-400">Sort by:</span>
<select class="bg-white dark:bg-surface-dark border-gray-200 dark:border-gray-800 rounded-full text-sm font-bold focus:ring-primary focus:border-primary px-4 py-2 pr-10">
<option>Most Popular</option>
<option>Highest Rated</option>
<option>Price: Low to High</option>
</select>
</div>
</div>
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
<div class="bg-surface-light dark:bg-surface-dark rounded-2xl overflow-hidden shadow-sm hover:shadow-xl transition-all duration-300 border border-gray-100 dark:border-gray-800 group">
<div class="relative h-64 overflow-hidden">
<img alt="Luxe Salon" class="w-full h-full object-cover group-hover:scale-110 transition duration-700" src="https://lh3.googleusercontent.com/aida-public/AB6AXuB5WlLD95deYclMAq-4eH0Yq8iqYQSY8bPTzR1E_ViGf_tCTei2LBoSA8D0ucKp3ccTAyxyV7e0SInGjXrONodanhgfYIZXWD-nYJJfyLIx_pezmL7UdOf9MLaF15DXCu_cPAA7Daa2NOueig2IJ6KO6_uYSb59UecR8FHT0aHJtlkg27KK49N2XuTLZpq2pyN4jQvgp7EmiupAdo_j974_sVAZbNH8spekreT5-CzeO3UclkfXqhNEM-vTK8a0kWEeU2jBln-Bm_HW"/>
<div class="absolute top-4 left-4 bg-white/90 dark:bg-black/70 backdrop-blur-md text-xs font-bold px-2.5 py-1.5 rounded-lg flex items-center gap-1 shadow-sm">
<span class="material-icons text-yellow-400 text-sm">star</span> 4.9 <span class="text-gray-400 dark:text-gray-500 font-normal ml-0.5">(2.1k)</span>
</div>
<button class="absolute top-4 right-4 p-2 rounded-full bg-white/20 hover:bg-white text-white hover:text-primary backdrop-blur-md transition">
<span class="material-icons text-xl">favorite_border</span>
</button>
</div>
<div class="p-6">
<h3 class="text-xl font-bold text-gray-900 dark:text-white group-hover:text-primary transition mb-1">Luxe Spa &amp; Salon</h3>
<p class="text-gray-500 dark:text-gray-400 text-sm flex items-center gap-1 mb-4">
<span class="material-icons text-base">location_on</span> Downtown • 0.8 mi
                        </p>
<div class="flex flex-wrap gap-2 mb-6">
<span class="px-2.5 py-1 bg-primary/10 text-primary text-[10px] uppercase font-bold tracking-widest rounded-md">Hair</span>
<span class="px-2.5 py-1 bg-primary/10 text-primary text-[10px] uppercase font-bold tracking-widest rounded-md">Spa</span>
<span class="px-2.5 py-1 bg-primary/10 text-primary text-[10px] uppercase font-bold tracking-widest rounded-md">Facial</span>
</div>
<div class="flex items-center justify-between pt-4 border-t border-gray-100 dark:border-gray-800">
<div>
<p class="text-[10px] uppercase font-bold text-gray-400 dark:text-gray-500">Starting from</p>
<span class="text-xl font-display font-bold text-gray-900 dark:text-white">$45.00</span>
</div>
<button class="bg-gray-900 dark:bg-white text-white dark:text-gray-900 px-6 py-2.5 rounded-xl font-bold text-sm hover:bg-primary dark:hover:bg-primary hover:text-white transition">Book Salon</button>
</div>
</div>
</div>
<div class="bg-surface-light dark:bg-surface-dark rounded-2xl overflow-hidden shadow-sm hover:shadow-xl transition-all duration-300 border border-gray-100 dark:border-gray-800 group">
<div class="relative h-64 overflow-hidden">
<img alt="Urban Glow" class="w-full h-full object-cover group-hover:scale-110 transition duration-700" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBF65H0TDa95NWNlSBh22MXMST6Djali9cjVMF__mPm3M4mRN-SJy-8UcYC-hSFVp0ofqrkxVXclLJF-mPG8u0mfbkZr6QLlm9_qjpuN7_VD8ROfbPzPTejfr6_wbWXJ-hzrDa_MWwxe_TDAHd8Uv7WKsCy7Yc7RhAmjZ78BDv1EH7pQ_5UMdcwx0Ez5iDbsYq4wYVDsOpUDxxZigs5w4QAqX-1ijRpEP3e5wnKU9o2RLBTSWB7utIpc3omnKz5na1jswiwbNgAnK4R"/>
<div class="absolute top-4 left-4 bg-white/90 dark:bg-black/70 backdrop-blur-md text-xs font-bold px-2.5 py-1.5 rounded-lg flex items-center gap-1 shadow-sm">
<span class="material-icons text-yellow-400 text-sm">star</span> 4.8 <span class="text-gray-400 dark:text-gray-500 font-normal ml-0.5">(850)</span>
</div>
<div class="absolute top-4 left-24 bg-secondary text-white text-[10px] font-bold px-2 py-1.5 rounded-lg shadow-sm uppercase tracking-wider">Discounted</div>
</div>
<div class="p-6">
<h3 class="text-xl font-bold text-gray-900 dark:text-white group-hover:text-primary transition mb-1">Urban Glow Studio</h3>
<p class="text-gray-500 dark:text-gray-400 text-sm flex items-center gap-1 mb-4">
<span class="material-icons text-base">location_on</span> West Village • 1.2 mi
                        </p>
<div class="flex flex-wrap gap-2 mb-6">
<span class="px-2.5 py-1 bg-primary/10 text-primary text-[10px] uppercase font-bold tracking-widest rounded-md">Nails</span>
<span class="px-2.5 py-1 bg-primary/10 text-primary text-[10px] uppercase font-bold tracking-widest rounded-md">Makeup</span>
</div>
<div class="flex items-center justify-between pt-4 border-t border-gray-100 dark:border-gray-800">
<div>
<p class="text-[10px] uppercase font-bold text-gray-400 dark:text-gray-500">Starting from</p>
<span class="text-xl font-display font-bold text-gray-900 dark:text-white">$30.00</span>
</div>
<button class="bg-gray-900 dark:bg-white text-white dark:text-gray-900 px-6 py-2.5 rounded-xl font-bold text-sm hover:bg-primary dark:hover:bg-primary hover:text-white transition">Book Salon</button>
</div>
</div>
</div>
<div class="bg-surface-light dark:bg-surface-dark rounded-2xl overflow-hidden shadow-sm hover:shadow-xl transition-all duration-300 border border-gray-100 dark:border-gray-800 group">
<div class="relative h-64 overflow-hidden">
<img alt="Serenity Wellness" class="w-full h-full object-cover group-hover:scale-110 transition duration-700" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBVARMYniP9wn8cB61DBD3o_yPn7F0nvRiB4YsdePamivV2sZqEa5OvEVu0SgRSS0qLDcppva2lrYAIPEUFt2olMh_lCHOFBDhNyaJBO5C6YfGxKCDrXXXgkxcLCn2N-3KgYpv9KwFo5n8WVR87t945zJSuuNwfgbz-PWvfX3s5Cy0avP43DIEBVkzmiTcYjHy0-ziN9QyJpZcXNrrlj5E35jSK8S6j5qkCJA5t2D9yofiA3JT9KcN3zq9wtH-2efIK4V8QGKnoWT4Z"/>
<div class="absolute top-4 left-4 bg-white/90 dark:bg-black/70 backdrop-blur-md text-xs font-bold px-2.5 py-1.5 rounded-lg flex items-center gap-1 shadow-sm">
<span class="material-icons text-yellow-400 text-sm">star</span> 5.0 <span class="text-gray-400 dark:text-gray-500 font-normal ml-0.5">(420)</span>
</div>
</div>
<div class="p-6">
<h3 class="text-xl font-bold text-gray-900 dark:text-white group-hover:text-primary transition mb-1">Serenity Wellness</h3>
<p class="text-gray-500 dark:text-gray-400 text-sm flex items-center gap-1 mb-4">
<span class="material-icons text-base">location_on</span> Brooklyn • 3.5 mi
                        </p>
<div class="flex flex-wrap gap-2 mb-6">
<span class="px-2.5 py-1 bg-primary/10 text-primary text-[10px] uppercase font-bold tracking-widest rounded-md">Massage</span>
<span class="px-2.5 py-1 bg-primary/10 text-primary text-[10px] uppercase font-bold tracking-widest rounded-md">Holistic</span>
</div>
<div class="flex items-center justify-between pt-4 border-t border-gray-100 dark:border-gray-800">
<div>
<p class="text-[10px] uppercase font-bold text-gray-400 dark:text-gray-500">Starting from</p>
<span class="text-xl font-display font-bold text-gray-900 dark:text-white">$65.00</span>
</div>
<button class="bg-gray-900 dark:bg-white text-white dark:text-gray-900 px-6 py-2.5 rounded-xl font-bold text-sm hover:bg-primary dark:hover:bg-primary hover:text-white transition">Book Salon</button>
</div>
</div>
</div>
</div>
<div class="mt-8 text-center">
<button class="px-8 py-3 rounded-full border border-gray-200 dark:border-gray-700 text-gray-600 dark:text-gray-300 font-bold hover:bg-primary hover:text-white hover:border-primary transition-all">
                    View All Salons
                </button>
</div>
</section>
<section class="border-t border-gray-100 dark:border-gray-800 pt-20">
<div class="mb-8 text-center max-w-2xl mx-auto">
<h2 class="text-3xl md:text-4xl font-display font-bold text-gray-900 dark:text-white">Popular <span class="text-primary italic">Services</span></h2>
<p class="text-gray-500 dark:text-gray-400 mt-2">Book individual treatments directly from our top-rated specialists</p>
</div>
<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
<div class="bg-surface-light dark:bg-surface-dark p-4 rounded-2xl border border-gray-100 dark:border-gray-800 hover:shadow-lg transition-all group">
<div class="h-40 rounded-xl overflow-hidden mb-4">
<img alt="Haircut" class="w-full h-full object-cover group-hover:scale-105 transition duration-500" src="https://lh3.googleusercontent.com/aida-public/AB6AXuB5WlLD95deYclMAq-4eH0Yq8iqYQSY8bPTzR1E_ViGf_tCTei2LBoSA8D0ucKp3ccTAyxyV7e0SInGjXrONodanhgfYIZXWD-nYJJfyLIx_pezmL7UdOf9MLaF15DXCu_cPAA7Daa2NOueig2IJ6KO6_uYSb59UecR8FHT0aHJtlkg27KK49N2XuTLZpq2pyN4jQvgp7EmiupAdo_j974_sVAZbNH8spekreT5-CzeO3UclkfXqhNEM-vTK8a0kWEeU2jBln-Bm_HW"/>
</div>
<div class="flex justify-between items-start mb-2">
<h4 class="text-lg font-bold text-gray-900 dark:text-white">Signature Haircut</h4>
<span class="text-primary font-bold">$60</span>
</div>
<p class="text-xs text-gray-400 dark:text-gray-500 flex items-center mb-4">
<span class="material-icons text-sm mr-1">schedule</span> 45 mins
                    </p>
<button class="w-full py-2.5 rounded-xl bg-primary/10 text-primary font-bold text-sm hover:bg-primary hover:text-white transition-colors">Book Now</button>
</div>
<div class="bg-surface-light dark:bg-surface-dark p-4 rounded-2xl border border-gray-100 dark:border-gray-800 hover:shadow-lg transition-all group">
<div class="h-40 rounded-xl overflow-hidden mb-4">
<img alt="Balayage" class="w-full h-full object-cover group-hover:scale-105 transition duration-500" src="https://lh3.googleusercontent.com/aida-public/AB6AXuB5WlLD95deYclMAq-4eH0Yq8iqYQSY8bPTzR1E_ViGf_tCTei2LBoSA8D0ucKp3ccTAyxyV7e0SInGjXrONodanhgfYIZXWD-nYJJfyLIx_pezmL7UdOf9MLaF15DXCu_cPAA7Daa2NOueig2IJ6KO6_uYSb59UecR8FHT0aHJtlkg27KK49N2XuTLZpq2pyN4jQvgp7EmiupAdo_j974_sVAZbNH8spekreT5-CzeO3UclkfXqhNEM-vTK8a0kWEeU2jBln-Bm_HW"/>
</div>
<div class="flex justify-between items-start mb-2">
<h4 class="text-lg font-bold text-gray-900 dark:text-white">Full Balayage</h4>
<span class="text-primary font-bold">$180</span>
</div>
<p class="text-xs text-gray-400 dark:text-gray-500 flex items-center mb-4">
<span class="material-icons text-sm mr-1">schedule</span> 150 mins
                    </p>
<button class="w-full py-2.5 rounded-xl bg-primary/10 text-primary font-bold text-sm hover:bg-primary hover:text-white transition-colors">Book Now</button>
</div>
<div class="bg-surface-light dark:bg-surface-dark p-4 rounded-2xl border border-gray-100 dark:border-gray-800 hover:shadow-lg transition-all group">
<div class="h-40 rounded-xl overflow-hidden mb-4">
<img alt="Massage" class="w-full h-full object-cover group-hover:scale-105 transition duration-500" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBVARMYniP9wn8cB61DBD3o_yPn7F0nvRiB4YsdePamivV2sZqEa5OvEVu0SgRSS0qLDcppva2lrYAIPEUFt2olMh_lCHOFBDhNyaJBO5C6YfGxKCDrXXXgkxcLCn2N-3KgYpv9KwFo5n8WVR87t945zJSuuNwfgbz-PWvfX3s5Cy0avP43DIEBVkzmiTcYjHy0-ziN9QyJpZcXNrrlj5E35jSK8S6j5qkCJA5t2D9yofiA3JT9KcN3zq9wtH-2efIK4V8QGKnoWT4Z"/>
</div>
<div class="flex justify-between items-start mb-2">
<h4 class="text-lg font-bold text-gray-900 dark:text-white">Deep Tissue</h4>
<span class="text-primary font-bold">$120</span>
</div>
<p class="text-xs text-gray-400 dark:text-gray-500 flex items-center mb-4">
<span class="material-icons text-sm mr-1">schedule</span> 60 mins
                    </p>
<button class="w-full py-2.5 rounded-xl bg-primary/10 text-primary font-bold text-sm hover:bg-primary hover:text-white transition-colors">Book Now</button>
</div>
<div class="bg-surface-light dark:bg-surface-dark p-4 rounded-2xl border border-gray-100 dark:border-gray-800 hover:shadow-lg transition-all group">
<div class="h-40 rounded-xl overflow-hidden mb-4">
<img alt="Facial" class="w-full h-full object-cover group-hover:scale-105 transition duration-500" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBVARMYniP9wn8cB61DBD3o_yPn7F0nvRiB4YsdePamivV2sZqEa5OvEVu0SgRSS0qLDcppva2lrYAIPEUFt2olMh_lCHOFBDhNyaJBO5C6YfGxKCDrXXXgkxcLCn2N-3KgYpv9KwFo5n8WVR87t945zJSuuNwfgbz-PWvfX3s5Cy0avP43DIEBVkzmiTcYjHy0-ziN9QyJpZcXNrrlj5E35jSK8S6j5qkCJA5t2D9yofiA3JT9KcN3zq9wtH-2efIK4V8QGKnoWT4Z"/>
</div>
<div class="flex justify-between items-start mb-2">
<h4 class="text-lg font-bold text-gray-900 dark:text-white">Hydrating Facial</h4>
<span class="text-primary font-bold">$95</span>
</div>
<p class="text-xs text-gray-400 dark:text-gray-500 flex items-center mb-4">
<span class="material-icons text-sm mr-1">schedule</span> 60 mins
                    </p>
<button class="w-full py-2.5 rounded-xl bg-primary/10 text-primary font-bold text-sm hover:bg-primary hover:text-white transition-colors">Book Now</button>
</div>
</div>
</section>
</main>

<!-- Footer Section  -->

<%@ include file="footer.jsp" %>

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

</body></html>