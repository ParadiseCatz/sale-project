<%@ page import="app.AppConfig" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="javax.xml.ws.BindingProvider" %>
<%@ page import="javax.xml.ws.handler.MessageContext" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.DataOutputStream" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.util.*" %><%--
  Created by IntelliJ IDEA.
  User: anthony
  Date: 11/12/16
  Time: 12:34 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    market.Market_Service service = new market.Market_Service();
    market.Market port = service.getMarketPort();
%>

<%!
    public void setTokenOnSOAPHeader(String token) {
        Map<String, Object> req_ctx = ((BindingProvider)port).getRequestContext();

        Map<String, List<String>> headers = new HashMap<>();
        headers.put("token", Collections.singletonList(token));
        req_ctx.put(MessageContext.HTTP_REQUEST_HEADERS, headers);
    }
%>

<%!
    public void redirectToLogin(HttpServletRequest request, HttpServletResponse response){
        String reqURL = String.valueOf(request.getRequestURL());
        String redirectURL = reqURL.replaceFirst(request.getServletPath(), "/login.jsp");
        response.setStatus(HttpServletResponse.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", redirectURL);
    }

    public void redirectTo(HttpServletRequest request, JspWriter out, String location){
        String reqURL = String.valueOf(request.getRequestURL());
        String redirectURL = reqURL.replaceFirst(request.getServletPath(), location);
        try {
            out.println(" <script>\n" +
                    "    window.onload = function() {\n" +
                    "    location.href = \"" + redirectURL + "\"\n" +
                    "};\n" +
                    "</script>");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }



%>

<%!
    public Cookie getCookie(HttpServletRequest request, String key){
        Cookie[] cookies;
        cookies = request.getCookies();
        if( cookies != null ) {
            for (Cookie cookie : cookies) {
                if (Objects.equals(cookie.getName(), key)) {
                    return cookie;
                }
            }
        }
        return null;
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
    Cookie tokenCookie = getCookie(request, "token");
    if (tokenCookie != null){
        String token = tokenCookie.getValue();
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
                Integer session_age = Integer.valueOf(jsonObject.get("session_age").toString());
                tokenCookie.setMaxAge(session_age / 1000);
            } catch (Exception e) {
                e.printStackTrace();
            }
            setUserInfo(response, token);
            setTokenOnSOAPHeader(token);
        } else {
            redirectToLogin(request, response);
        }
    } else {
        redirectToLogin(request, response);
    }

%>
