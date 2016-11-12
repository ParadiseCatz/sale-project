<%--
  Created by IntelliJ IDEA.
  User: Joshua
  Date: 11/4/2016
  Time: 3:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page import="java.text.DecimalFormatSymbols"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Locale"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="verifytoken.jsp" %><!DOCTYPE html>

<html>
<head>
	<title>Sales</title>
	<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<h2 class="pagetitle">Here are your sales</h2>
	
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
        %>
        <br>
         <%-- start web service invocation --%><hr/>
    <%
    if (userid!=-1){
        try {
            market.Market_Service service = new market.Market_Service();
            market.Market port = service.getMarketPort();
             // TODO initialize WS operation arguments here
            int userID = userid;
            // TODO process result here
            java.util.List<market.Transaction> result = port.sales(userID);
            int jumlah = 0 ;
            for (market.Transaction temp2:result){
                ++jumlah;
            }
            if(jumlah>0){
                for (market.Transaction temp:result){
                    out.println("<div class=\"tanggal\"> "+ temp.getWaktuTransaksi() + "</div>");
                    out.println("<hr>");
                    out.println("<div class=\"container\">");
                    out.println("<div class=\"divGambar\">");
                    out.println("<img src=\"" + temp.getFoto() + "\" class=\"GambarKatalog\">");
                    out.println("</div>");
                    out.println("<div class=\"divDesc\">");
                    out.println("<span class=\"NamaBarang\">"+ temp.getNamaBarang()+"</span><br>");
                    DecimalFormat formatter=new DecimalFormat("###,###,###",DecimalFormatSymbols.getInstance(Locale.GERMANY));
                    out.println("<span class=\"HargaBarang\"> IDR " + formatter.format(temp.getQuantity()*temp.getHargaBarang()) + "</span><br>");
                    out.println("<span class=\"HargaBarang\">"+ temp.getQuantity() +" pcs</span><br>");
                    out.println("<span class=\"HargaBarang\"> @IDR "+ temp.getHargaBarang() +" pcs</span><br>");
                    out.println("<br>");
                    out.println("<span class=\"DeskripsiBarang\"> bought by "+ temp.getCosignee() +"</span><br>");
                    out.println("</div>");
                    out.println("<div class=\"divInvoice\">");
                    out.println("<span>Delivery to <b>" + temp.getCosignee() + "</b></span><br>");
                    out.println("<span>" + temp.getFullAddress() + "</span><br>");
                    out.println("<span>" + temp.getPostalCode() + "</span><br>");
                    out.println("<span>" + temp.getPhoneNumber() + "</span><br>");
                    out.println("</div>");
                    out.println("</div>");
                    out.println("<br><hr>");
                    out.println("<div>");                    
                }
            }
            else{
                out.println("<h2 class=\"pagetitle\">You have no purchases, please buy something first !</h2>");
            }

        } catch (Exception ex) {
            // TODO handle custom exceptions here
            out.println("<h1>" + ex.toString()+"</h1>");
        }
    }
    else
    {
        out.println("<h1>Cookie NULL</h1>");
    }
    
        %>    
    <%-- end web service invocation --%>
        
	
</body>
</html>