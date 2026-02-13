<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    String currentPage = request.getRequestURI();
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


</head>
<body class="bg-background-light dark:bg-background-dark text-gray-800 dark:text-gray-200 transition-colors duration-300 overflow hidden">

<nav class="sticky top-0 z-50 bg-surface-light/90 dark:bg-surface-dark/90 backdrop-blur-md border-b border-gray-100 dark:border-gray-800 shadow-sm">
<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
<div class="flex justify-between h-20 items-center">
<div class="flex items-center">
<span class="material-icons text-primary text-3xl mr-2">spa</span>
 <a href="index.jsp" class="font-display font-bold text-2xl text-gray-900 dark:text-white">SalonConnect</a>
</div>


<div class="hidden md:flex space-x-8 items-center">
<a href="index.jsp"
    class="nav-link !text-gray-900 dark:!text-white hover:!text-primary dark:hover:text-primary

   <%= currentPage.endsWith("index.jsp") ? "active" : "" %>">
   Home
</a>


<a href="${pageContext.request.contextPath}/services.jsp"
   class="nav-link !text-gray-900 dark:!text-white hover:!text-primary dark:hover:text-primary
    ${fn:endsWith(pageContext.request.requestURI, '/services.jsp') ? 'active' : ''}">
   Services
</a>




<a href="about.jsp"
   class="nav-link !text-gray-900 dark:!text-white hover:!text-primary dark:hover:text-primary
   <%= currentPage.endsWith("about.jsp") ? "active" : "" %>">
   About Us
</a>

<a href="partners.jsp"
    class="nav-link !text-gray-900 dark:!text-white hover:!text-primary dark:hover:text-primary
   <%= currentPage.endsWith("partners.jsp") ? "active" : "" %>">
    Partners
</a>

</div>
<div class="flex items-center space-x-4">
<button class="p-2 rounded-full hover:bg-gray-100 dark:hover:bg-gray-700 text-gray-500 dark:text-gray-400" id="theme-toggle">
<span class="material-icons">brightness_4</span>
</button>
<a class="hidden md:block px-5 py-2.5 rounded-full text-sm font-bold text-primary border-2 border-primary hover:bg-primary hover:text-white transition-all" href="login.jsp">Sign In</a>
<a class="px-5 py-2.5 rounded-full text-sm font-bold text-white bg-primary hover:bg-opacity-90 transition shadow-lg shadow-primary/30" href="register.jsp">Join Now</a>
</div>
</div>
</div>
</nav>
</body>
</html>