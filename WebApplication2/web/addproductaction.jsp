<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.DataInputStream" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.util.Collection" %>
<%@ page import="java.util.Objects" %><%--
  Created by IntelliJ IDEA.
  User: anthony
  Date: 11/12/16
  Time: 2:59 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="verifytoken.jsp" %>
<%
    Collection<Part> parts = request.getParts();
    String imageString = null;
    String contentType = null;
    byte[] imgDataBa = null;
    String name = null;
    String description = null;
    String price = null;
    for (Part part : parts) {
        InputStream in = part.getInputStream();
        BufferedReader br = new BufferedReader(new InputStreamReader(in));
        String s;
        String value = "";
        if (Objects.equals(part.getName(), "uploadedfile")) {
            contentType = part.getContentType();
            imgDataBa = new byte[(int)part.getSize()];
            DataInputStream dataIs = new DataInputStream(part.getInputStream());
            dataIs.readFully(imgDataBa);
        } else {
            while( (s = br.readLine()) != null) {
                value = value + s;
            }
            switch (part.getName()) {
                case "name" : name = value; break;
                case "Description" : description = value; break;
                case "price" : price = value; break;
            }
        }
    }
    imageString = "\"data:" + contentType + ";base64," +
    Base64.getMimeEncoder().encodeToString(imgDataBa) + "\">";

    try {
        Integer user_id = Integer.valueOf(getCookie(request, "user_id").getValue());
        String username = getCookie(request, "username").getValue();

        boolean result = port.addProduct(user_id, username, name, description, price, imageString);

        if (result) {
            redirectTo(request, out, "/catalog.jsp");
        } else {
            redirectTo(request, out, "/login.jsp");
        }
    } catch (Exception e) {
        redirectTo(request, out, "/login.jsp");
        e.printStackTrace();
    }

%>
