<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="app.AppConfig" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.DataOutputStream" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.InputStreamReader" %>
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

<%!
    private void setUserInfo(HttpServletResponse response, String token) throws IOException {
        String url = AppConfig.get("identity_service_url") + "/UserInfo";
        URL obj = new URL(url);
        HttpURLConnection con = (HttpURLConnection) obj.openConnection();
        //add request header
        con.setRequestMethod("POST");
        con.setRequestProperty("Accept-Language", "en-US,en;q=0.5");
        String urlParameters = "token=" + token;
        con.setDoOutput(true);
        DataOutputStream wr = new DataOutputStream(con.getOutputStream());
        wr.writeBytes(urlParameters); wr.flush(); wr.close();
        int responseCode = con.getResponseCode();
        if (responseCode == 200) {
            BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String s = br.readLine();
            JSONParser parser = new JSONParser();
            try {

                Object obj2 = parser.parse(s);
                JSONObject jsonObject = (JSONObject) obj2;

                String user_id = jsonObject.get("user_id").toString();
                Cookie user_id_cookie = new Cookie("user_id",user_id);


                String username = jsonObject.get("username").toString();
                Cookie username_cookie = new Cookie("username",username);

                String full_name = jsonObject.get("full_name").toString();
                Cookie full_name_cookie = new Cookie("full_name",full_name);

                Integer session_age = Integer.valueOf(jsonObject.get("session_age").toString());
                user_id_cookie.setMaxAge(session_age / 1000);
                username_cookie.setMaxAge(session_age / 1000);
                full_name_cookie.setMaxAge(session_age / 1000);

                response.addCookie(user_id_cookie);
                response.addCookie(username_cookie);
                response.addCookie(full_name_cookie);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

%>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    if(username != null && password != null){
        String url = AppConfig.get("identity_service_url") + "/Login";
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
//        out.println("Sending POST to " + url);
//        out.println(urlParameters);
//        out.println("Response Code : " + responseCode);
        if(responseCode == 200){
            BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String s = br.readLine();
//            out.println("Json = "+s);
            JSONParser parser = new JSONParser();
            try {
                Object obj2 = parser.parse(s);
                JSONObject jsonObject = (JSONObject) obj2;
                String token = jsonObject.get("token").toString();
                Cookie cookietoken = new Cookie("token",token);
//                out.println("token = " + token);
                Integer session_age = Integer.valueOf(jsonObject.get("session_age").toString());
                cookietoken.setMaxAge(session_age / 1000);
                response.addCookie(cookietoken);
                setUserInfo(response, token);
//                out.println("date = " + session_age);
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
    } 
%>





<p>Don't have an account yet? Register <a href="register.jsp">here</a></p>


</body>
</html>