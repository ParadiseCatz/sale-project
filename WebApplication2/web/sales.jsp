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
<%@include file="verifytoken.jsp" %>
<html>
<head>
    <title>Sales</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
<h2 class="pagetitle">Here are your sales</h2>
<hr>
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
            java.util.List<market.Produk> result = port.sales(userID);

            for (market.Produk temp:result){
                //Looping melakukan print catalog
                out.println("<div class=\"username\">" + temp.getUsername() + "</div>");
                out.println("<div class=\"tanggal\"> added this on "+ temp.getWaktuDitambahkan() + "</div>");
                out.println("<hr>");
                out.println("<div class=\"container\">");
                out.println("<div class=\"divGambar\">");

                //TODO BENERIN PRINT FOTO
                out.println("<img src=\"" + temp.getNamaFoto() + "\" class=\"GambarKatalog\">");
                //TODO

                out.println("</div>");
                out.println("<div class=\"divDesc\">");
                out.println("<span class=\"NamaBarang\">"+ temp.getNamaBarang()+"</span><br>");
                DecimalFormat formatter=new DecimalFormat("###,###,###",DecimalFormatSymbols.getInstance(Locale.GERMANY));

                out.println("<span class=\"HargaBarang\"> IDR " + formatter.format(temp.getHarga()) + "</span><br>");
                out.println("<span class=\"DeskripsiBarang\">"+ temp.getDeskripsi() +"</span><br>");
                out.println("</div>");
                out.println("<div class=\"divLike\">");
                String id_barang=Integer.toString(temp.getId());
                String jumlah_like=Integer.toString(temp.getJumlahLike());
                out.println("<span id=\"productlikes#"+id_barang+"\">" +jumlah_like+"</span> likes<br>");
                String jumlah_beli=Integer.toString(temp.getJumlahBeli());
                out.println(jumlah_beli +"  purchases<br><br>");

                //jax ws mengecek jumlah like
                try {
                     // TODO initialize WS operation arguments here
                    int idUser = userid;
                    int idBarang = temp.getId();
                    // TODO process result here
                    java.lang.Boolean resultLike = port.checkLike(idUser, idBarang);
                    if (resultLike=true){
                        //kasus jika sudah like
                        out.println("<span class=\"like\" data-product-id=\""+idBarang+"\">LIKE");
                    }
                    else
                    {
                        //kasus jika belum like
                        out.println("<span class=\"liked\" data-product-id=\""+idBarang+"\">LIKED");
                    }
                    out.println("</span>");
                    String urlPurchase;
                    urlPurchase="ConfirmationPurchase.php?userid_pembeli="+idUser
                            +"&userid_penjual="+temp.getIdPenjual()+"&nama_barang="
                            +temp.getNamaBarang()+"&path_foto="+temp.getNamaFoto()
                            +"&harga_barang="+temp.getHarga()+"&id_barang="
                            +temp.getId();
                    out.println("<a href=\""+urlPurchase+"\" class=\"buy\">BUY</a>");
                    out.println("</div>");
                    out.println("</div>");
                    out.println("<br><hr>");
                } catch (Exception ex) {
                    // TODO handle custom exceptions here
                }





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