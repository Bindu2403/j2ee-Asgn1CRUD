<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.Base64" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Cache-Control" content="no-store" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta http-equiv="Expires" content="0" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link rel="stylesheet" href="home.css">
   
    <title>POS</title>
    	
</head>
<body>
    <div class="menu_bar">
            <h1 class="logo"><a href="home.jsp">humber<span>POS</span></a></h1>

           <ul>
                <li><a href="home.jsp">Home</a></li>
                <% String userType = (String) session.getAttribute("type");
					if (userType != null && userType.equals("admin")) 
					{ %>
					<li><a href="Add_Item.jsp">Add Item</a></li>
					<% } else {%>
					<li><a href="#" id="regular">Add Item</a></li>
					<%} %>
                
                <li><% String name = (String) session.getAttribute("username"); %>
                    <a href="#"><%=name %><i class="fas fa-caret-down"></i></a>
                    <div class="dropdown_menu">
                        <ul><% String type = (String) session.getAttribute("type"); %>
                            <li><a href="#"><%=type %></a></li>
                            <li><a href="#" id="logoutLink">Logout</a></li>
                        </ul>
                    </div>
                
                </li>
            </ul>
     </div>   

    <div class="card_container">
    <%
    String jdbcURL = "jdbc:mysql://localhost:3306/RestaurantDB";
    String username = "root";
    String password = "Binchow1428";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection connection = DriverManager.getConnection(jdbcURL, username, password);
        String selectQuery = "SELECT * FROM menu_itmes";
        PreparedStatement preparedStatement = connection.prepareStatement(selectQuery);
        ResultSet resultSet = preparedStatement.executeQuery();

        while (resultSet.next()) {
            String item_name = resultSet.getString("item_name");
            String desc = resultSet.getString("short_desc");
            String flavor = resultSet.getString("flavor");
            String ingrediants = resultSet.getString("ingrediants");
            String price = resultSet.getString("price");

            Blob imageBlob = resultSet.getBlob("image_data");
            if (imageBlob != null) {
                InputStream imageStream = imageBlob.getBinaryStream();
                int imageLength = (int) imageBlob.length();
                byte[] imageBytes = new byte[imageLength];
                imageStream.read(imageBytes);

                
                String base64Image = "data:image/jpeg;base64," + Base64.getEncoder().encodeToString(imageBytes);
    %>
    
    <div class="card">
        <img src="<%= base64Image %>" alt="<%= item_name %>">
        <div class="card_content">
            <h3><%= item_name %></h3>
            <p><%= desc %></p>
            <ul>
            <% String taste = flavor.toLowerCase();
					if (taste != null && taste.equals("spicy")) 
					{ %>	
                <li><span>Flavor :</span><%= flavor %>&#127798;</li>
                <% } else {%>
                <li><span>Flavor :</span><%= flavor %></li>
                <%} %>
                <li><span>Ingredient :</span><%= ingrediants %></li>
                <li><span>Price :$</span><%= price %></li>
            </ul>
        </div>
    </div>
    <%
            }
        }
    } catch (SQLException | IOException e) {
        e.printStackTrace();
    }
    %>
</div>
    <footer class="footer">
            <p>Copyright &copy; 2023  , humberPOS&commat;Humber College</p>
    </footer>
    
    <script>
		function logout() {
        				window.location.href = "index.jsp";
			}
		document.getElementById("logoutLink").addEventListener("click", function (e) {
    			e.preventDefault(); 
    				logout();
    				history.replaceState(null, null, "index.jsp");
			});
		window.addEventListener("popstate", function () {
			window.location.href = "index.jsp";
		});
		
		document.addEventListener("DOMContentLoaded", function () {
		    var regularLink = document.getElementById("regular");
		    if (regularLink) {
		        regularLink.addEventListener("click", function (event) {
		            event.preventDefault(); 
		            alert("You are not an admin. You cannot access this page.");
		        });
		    }
		});
</script>        
</body>
</html>
