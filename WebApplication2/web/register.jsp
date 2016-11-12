<%--
  Created by IntelliJ IDEA.
  User: Joshua
  Date: 11/4/2016
  Time: 3:42 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="app.AppConfig" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.DataOutputStream" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="style.css">
    <script src="validation.js"></script>
    <title>Register</title>
</head>
<body>
<h1 id="title"><span id="Sale">Sale</span><span id="Project">Project</span></h1>
<h2 class="pagetitle">Please register</h2>
<hr>

<form id="registerForm" class="form" action="register.jsp" method = "post" onsubmit="return validateRegister(this);">
    <label for="fullname">Full Name</label>
    <input type="text" id="fullname" name="fullname" ><br>
    <label for="username">Username</label>
    <input type="text" id="username" name="username" ><br>
    <label for="email">Email</label>
    <input type="text" id="email" name="email" ><br>
    <label for="password">Password</label>
    <input type="password" id="password" name="password" ><br>
    <label for="confirmpassword">Confirm Password</label>
    <input type="password" id="confirmpassword" name="confirmpassword" ><br>
    <label for="fulladdress">Full Address</label>
    <textarea rows="2" name="fulladdress" form="registerForm" class="Text" id="fulladdress"  ></textarea>

    <label for="postalcode">Postal Code</label>
    <input type="text" id="postalcode" name="postalcode" ><br>
    <label for="phonenumber">Phone Number</label>
    <input type="text" id="phonenumber" name="phonenumber" ><br>
    <div id="tombol"><input type="submit" class="button" value="REGISTER" id="Register"></div>
</form>

<%
        String FullName=request.getParameter("fullname");
        String UserName=request.getParameter("username");
        String Email=request.getParameter("email");
        String Password=request.getParameter("password");
        String ConfirmPassword=request.getParameter("confirmpassword");
        String FullAddress=request.getParameter("fulladdress");
        String PostalCode=request.getParameter("postalcode");
        String PhoneNumber=request.getParameter("phonenumber");
    
        String url = AppConfig.get("identity_service_url") + "/Register";
        URL obj = new URL(url);
        HttpURLConnection con = (HttpURLConnection) obj.openConnection();
        //add reuqest header
        con.setRequestMethod("POST");
        con.setRequestProperty("Accept-Language", "en-US,en;q=0.5");
        String urlParameters = "fullname=" + FullName + "&username=" + UserName
                + "&email=" + Email + "&password=" + Password
                + "&confirmpassword=" + ConfirmPassword + "&fulladdress=" + FullAddress
                + "&postalcode=" + PostalCode + "&phonenumber=" + PhoneNumber;
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
        if(responseCode == 200){
            BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String s = br.readLine();
            out.println("Json = "+s);
            JSONParser parser = new JSONParser();
            try {
                Object obj2 = parser.parse(s);
                JSONObject jsonObject = (JSONObject) obj2;
                String token = jsonObject.get("token").toString();
                Cookie cookietoken = new Cookie("token",token);
                out.println("token = " + token);
                Integer session_age = Integer.valueOf(jsonObject.get("session_age").toString());
                cookietoken.setMaxAge(session_age / 1000);
                response.addCookie(cookietoken);
                out.println("date = " + session_age);
                //Redirect to Dashboard
                String reqURL = String.valueOf(request.getRequestURL());
                String redirectURL = reqURL.replaceFirst(request.getServletPath(), "/dashboard.jsp");
                response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", redirectURL);
            } catch (Exception e) {
                    e.printStackTrace();
            }

        }
        else {
            int responseCode2 = con.getResponseCode();
            out.println("Response Code : " + responseCode2);
            //response.setStatus(response.SC_MOVED_TEMPORARILY);
            //response.setHeader("Location", site);
        }
    
%>


<p>Already registered? Login <a href="login.jsp">here</a></p>
</body>
</html>