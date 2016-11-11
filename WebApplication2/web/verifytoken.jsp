<%@ page import="app.AppConfig" %>
<%@ page import="java.io.DataOutputStream" %>
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
                    tokenExist = true;
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
