<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>POS</title>
    
    <meta http-equiv="Cache-Control" content="no-store" />
    <link rel="stylesheet" href="index.css">
   
</head>
<body>
    <div class="card">
        <h2 class="logo">humber<span>POS</span></h2>
        
        <form id="login" action="home.jsp" method="post">
        
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" value="" placeholder="Enter Username" required>
            <% String flag = (String)session.getAttribute("flag");
					if (flag != null && flag.equals("false")) 
					{ %>
            <div class="small_text">
                        <small id="emailHelp">Invalid Username</small>
            </div>
            <% }%>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" value="" placeholder="Enter Password" required>
            <% String flag1 = (String)session.getAttribute("flag");
					if (flag1 != null && flag1.equals("false")) 
					{ %>
            <div class="small_text">
                        <small id="emailHelp">Invalid Password</small>
            </div>
            <% }%>
            <div class="center-button">
                <input type="submit" value="Login">
            </div>
        </form>
    </div>
    <script>
document.addEventListener("DOMContentLoaded", function () {
    // Get references to the form elements
    var loginForm = document.getElementById("login");
    var usernameField = document.getElementById("username");
    var passwordField = document.getElementById("password");

    // Clear the form fields when the page loads
    usernameField.value = "";
    passwordField.value = "";
});
</script>
    
</body>
</html>