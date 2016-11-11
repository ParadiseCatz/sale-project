<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="org.json.simple.parser.ParseException" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>

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
<form class="form" action="login.jsp" method="POST">
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
        String url = "http://localhost:8081/Identity_Service/loginservlet";
        URL obj = new URL(url);
        HttpURLConnection con = (HttpURLConnection) obj.openConnection();
        //add reuqest header
        con.setRequestMethod("POST");
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
        if(responseCode == 200){
            BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String s = br.readLine();
            out.println("Json = "+s);
            JSONParser parser = new JSONParser();
            try {
                Object obj2 = parser.parse(s);
                JSONObject jsonObject = (JSONObject) obj2;
                String token = (String) jsonObject.get("token");
                Cookie cookietoken = new Cookie("token",token);
                cookietoken.setMaxAge(60*60*24);
                out.println("token = " + token);
                String date = (String) jsonObject.get("expirytime");
                Cookie cookietime = new Cookie("expirytime",date);
                cookietime.setMaxAge(60*60*24);
                response.addCookie(cookietoken);
                response.addCookie(cookietime);
                out.println("date = " + date);
            } catch (FileNotFoundException e) {
                    e.printStackTrace();
            } catch (IOException e) {
                    e.printStackTrace();
            } catch (ParseException e) {
                    e.printStackTrace();
            }
            //pindah page ke dashboard
            /*String site = new String("http://localhost:8080/Web_Application/login.jsp");
            response.setStatus(response.SC_MOVED_TEMPORARILY);
            response.setHeader("Location", site);*/
        }
        else{
            String site = new String("http://localhost:8080/Web_Application/login.jsp");
            int responseCode2 = con.getResponseCode();
            out.println("Response Code : " + responseCode2);
            //response.setStatus(response.SC_MOVED_TEMPORARILY);
            //response.setHeader("Location", site);
        }
    } 
%>





<p>Don't have an account yet? Register <a href="register.jsp">here</a></p>


</body>
</html>