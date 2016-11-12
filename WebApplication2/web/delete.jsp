<%-- 
    Document   : delete
    Created on : Nov 12, 2016, 11:29:49 PM
    Author     : Joshua
--%>

<%@page import="java.text.DecimalFormatSymbols"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Locale"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="verifytoken.jsp" %>

    <%
        int userid;
        if (getCookie(request,"user_id")!=null){
            userid=Integer.parseInt(getCookie(request,"user_id").getValue());
            out.println("<input type=\"hidden\" name=\"userid\" value="+userid+">");
        }
        else
        {
            userid=-1;
        }
        if (userid!=-1){
            try {
                market.Market_Service service = new market.Market_Service();
                market.Market port = service.getMarketPort();
                 // TODO initialize WS operation arguments here
                int userID = userid;
                int idbarang = Integer.parseInt(request.getParameter("idbarang"));
                String namabarang = request.getParameter("namabarang");
                // TODO process result here
                port.delete(userID, idbarang, namabarang);
               //out.println(idbarang);
               //out.println(namabarang);
                //String site = new String("/yourproduct.jsp");
                //response.setStatus(response.SC_MOVED_TEMPORARILY);
                //response.setHeader("Location", site);
        } catch (Exception ex) {
            // TODO handle custom exceptions here
        }
    }
    %>
