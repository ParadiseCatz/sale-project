<%@ page import="app.AppConfig" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.DataOutputStream" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.util.Objects" %><%--
  Created by IntelliJ IDEA.
  User: anthony
  Date: 11/12/16
  Time: 12:34 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    public void redirectToLogin(HttpServletRequest request, HttpServletResponse response){
        String reqURL = String.valueOf(request.getRequestURL());
        String redirectURL = reqURL.replaceFirst(request.getServletPath(), "/login.jsp");
        response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", redirectURL);
    }

%>

<%!
    public void setUserInfo(HttpServletResponse response, String token) throws IOException {
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

                String user_id = (String) jsonObject.get("user_id");
                Cookie user_id_cookie = new Cookie("user_id",user_id);


                String username = (String) jsonObject.get("username");
                Cookie username_cookie = new Cookie("username",username);

                String full_name = (String) jsonObject.get("full_name");
                Cookie full_name_cookie = new Cookie("full_name",user_id);

                Integer session_age = Integer.valueOf((String)jsonObject.get("session_age"));
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
    Cookie[] cookies;
    // Get an array of Cookies associated with this domain
    cookies = request.getCookies();
    if( cookies != null ){
        boolean tokenExist = false;
        for (Cookie cookie : cookies) {
            if (Objects.equals(cookie.getName(), "token")) {
                tokenExist = true;
                String token = cookie.getValue();

                String url = AppConfig.get("identity_service_url") + "/Auth";
                URL obj = new URL(url);
                HttpURLConnection con = (HttpURLConnection) obj.openConnection();
                //add request header
                con.setRequestMethod("POST");
                con.setRequestProperty("Accept-Language", "en-US,en;q=0.5");
                String urlParameters = "token=" + token;
                con.setDoOutput(true);
                DataOutputStream wr = new DataOutputStream(con.getOutputStream());
                wr.writeBytes(urlParameters);
                wr.flush();
                wr.close();
                int responseCode = con.getResponseCode();
                if (responseCode == 200) {
                    BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
                    String s = br.readLine();
                    JSONParser parser = new JSONParser();
                    try {
                        Object obj2 = parser.parse(s);
                        JSONObject jsonObject = (JSONObject) obj2;
                        Integer session_age = Integer.valueOf((String)jsonObject.get("session_age"));
                        cookie.setMaxAge(session_age);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    tokenExist = true;
                    setUserInfo(response, token);
                }
                break;
            }
        }
        if (!tokenExist) {
            redirectToLogin(request, response);
        }
    }else{
        redirectToLogin(request, response);
    }

%>
