<%--
  Created by IntelliJ IDEA.
  User: Joshua
  Date: 11/4/2016
  Time: 3:47 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="verifytoken.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Sale Project</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <script>
        function resizeIframe(obj) {
            obj.height = obj.contentDocument.documentElement.scrollHeight + 'px';
            obj.width = obj.contentWindow.document.body.scrollWidth + 'px';
            var navpages = {
                "catalog": "catalog.jsp",
                "yourproducts": "yourproduct.jsp",
                "addproduct": "addproduct.jsp",
                "sales": "sales.jsp",
                "purchases": "purchases.jsp"
            }
            for (var x in navpages) {
                var button = document.getElementById(x);
                button.classList.remove("active");
                var href = obj.contentWindow.location.href;
                var src = href.substr(href.lastIndexOf('/') + 1);
                if (src == "login.jsp") {
                    location.reload();
                }
                if (src == navpages[x]) {
                    button.className += "active";
                }
            }
        }
        window.onload = function() {
            var navpages = {
                "catalog": "catalog.jsp",
                "yourproducts": "yourproduct.jsp",
                "addproduct": "addproduct.jsp",
                "sales": "sales.jsp",
                "purchases": "purchases.jsp"
            }
            for (var key in navpages) {
                var createClickHandler =
                        function(key) {
                            return function() {
                                document.getElementById("frame").src = navpages[key];
                                resizeIframe(document.getElementById("frame"));
                            };
                        };
                var button = document.getElementById(key);
                button.onclick = createClickHandler(key);
            }
        };
    </script>
</head>
<body>

<h1 id="title"><span id="Sale">Sale</span><span id="Project">Project</span></h1>
<div id="account">Hi, <span id="username">
        
        <%
    if (getCookie(request, "full_name") != null) out.print(getCookie(request, "full_name").getValue());
    else out.print("NULL");%>
    
    </span><br><span id="logout"><a href="login.php" class="logout" >logout</a></span></div>

<table class="navbar">
    <tr>
        <td id="catalog">Catalog</td>
        <td id="yourproducts">Your Products</td>
        <td id="addproduct">Add Product</td>
        <td id="sales">Sales</td>
        <td id="purchases">Purchases</td>
    </tr>
</table>
<iframe id="frame" src="catalog.jsp" onload="resizeIframe(this)" frameborder=0 scrolling="no"></iframe>
</body>
</html>