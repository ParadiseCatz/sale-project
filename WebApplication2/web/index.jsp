<%-- 
    Document   : index
    Created on : Nov 8, 2016, 9:59:53 PM
    Author     : ASUS
--%>

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
	// TODO process result here
	java.util.List<market.Produk> result = port.listCatalog(userID);
	out.println("Result = "+result);
    } catch (Exception ex) {
	// TODO handle custom exceptions here
    }
    %>
    <%-- end web service invocation --%><hr/>

    </body>
</html>
