<%-- 
    Document   : tester
    Created on : Nov 8, 2016, 9:54:25 PM
    Author     : ASUS
--%>

<%@page import="market.Produk"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    <%-- start web service invocation --%><hr/>
    <%
    try {
	market.Market_Service service = new market.Market_Service();
	market.Market port = service.getMarketPort();
	 // TODO initialize WS operation arguments here
	int userID = 0;
	java.lang.String searchType = "";
	java.lang.String searchKey = "";
	// TODO process result here
	java.util.List<market.Produk> result = port.listCatalog(userID, searchType, searchKey);
	out.println("Result = "+result);
        Produk a=result.get(0);
        out.println(a.getId());
        out.println(a.getIdPenjual());
        out.println(a.getUsername());
        out.println(a.getNamaBarang());
        out.println(a.getWaktuDitambahkan());
        out.println(a.getNamaFoto());
        out.println(a.getJumlahBeli());
    } catch (Exception ex) {
	// TODO handle custom exceptions here
    }
    %>
    <%-- end web service invocation --%><hr/>


    </body>
</html>
