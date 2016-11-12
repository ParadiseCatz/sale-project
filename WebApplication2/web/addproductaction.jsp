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
<%
    Collection<Part> parts = request.getParts();
    String imageString = null;
    String contentType = null;
    byte[] imgDataBa = null;
    boolean switchFile = false;
    for (Part part : parts) {
        InputStream in = part.getInputStream();
        BufferedReader br = new BufferedReader(new InputStreamReader(in));
        String s;
        out.println(part.getName() + ": \n");
        if (Objects.equals(part.getName(), "uploadedfile")) {
            contentType = part.getContentType();
            switchFile = true;
        }
        if (switchFile) {
            imgDataBa = new byte[(int)part.getSize()];
            DataInputStream dataIs = new DataInputStream(part.getInputStream());
            dataIs.readFully(imgDataBa);
            switchFile = false;
        } else {
            while( (s = br.readLine()) != null) {
                out.println(s + "\n");
            }
        }
    }
    out.println(contentType);
//    out.println(imageString);
    out.println(Base64.getEncoder().encodeToString(imgDataBa));
    out.print("<img src=\"data:" + contentType + ";base64,");
    out.print(Base64.getMimeEncoder().encodeToString(imgDataBa) + "\">");
    out.println("ASDASD");

%>
