<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.DataOutputStream" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>
<%@ page import="javax.net.ssl.HttpsURLConnection" %>

<!DOCTYPE html>
<html>
<head>
<title>Login</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>

<h1 id="title"><span id="Sale">Sale</span><span id="Project">Project</span></h1>
<h2 class="pagetitle">Please login</h2>
<hr>
<form class="form" action="login.jsp" method = "POST">
<label for="username">Email or Username</label>
<input type="text" name="username" id="username"><br>
<label for="password">Password</label>
<input type="password" name="password" id="password"><br>
<div id="tombol"><input type="submit" class="button" value="Login"></div>
</form>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    if(username != null && password != null){
        String url = "http://localhost:8081/Identity%20Service/loginservlet";
        URL obj = new URL(url);
        HttpURLConnection con = (HttpURLConnection) obj.openConnection();
        //add reuqest header
        con.setRequestMethod("POST");
        con.setRequestProperty("User-Agent", "Mozilla/5.0");
        con.setRequestProperty("Accept-Language", "en-US,en;q=0.5");
        String urlParameters = "username=" + username + "&password=" + password;
        // Send post request
        con.setDoOutput(true);
        DataOutputStream wr = new DataOutputStream(con.getOutputStream());
        wr.writeBytes(urlParameters);
        wr.flush();
        wr.close();
        int responseCode = con.getResponseCode();
        out.println("Sending POST to " + url);
        out.println(urlParameters);
        out.println("Response Code : " + responseCode);
        
    } 
%>





<p>Don't have an account yet? Register <a href="register.jsp">here</a></p>


</body>
</html>