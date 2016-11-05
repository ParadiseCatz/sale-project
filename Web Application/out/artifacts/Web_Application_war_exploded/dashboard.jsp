<%--
  Created by IntelliJ IDEA.
  User: Joshua
  Date: 11/4/2016
  Time: 3:47 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                "catalog": "catalog.php",
                "yourproducts": "yourproduct.php",
                "addproduct": "addproduct.php",
                "sales": "sales.php",
                "purchases": "purchases.php"
            }
            for (var x in navpages) {
                var button = document.getElementById(x);
                button.classList.remove("active");
                var href = obj.contentWindow.location.href;
                var src = href.substr(href.lastIndexOf('/') + 1);
                if (src == navpages[x].concat("?userid=<?php echo $_GET["userid"]; ?>")) {
                    button.className += "active";
                }
            }
        }
        window.onload = function() {
            var navpages = {
                "catalog": "catalog.php",
                "yourproducts": "yourproduct.php",
                "addproduct": "addproduct.php",
                "sales": "sales.php",
                "purchases": "purchases.php"
            }
            for (var key in navpages) {
                var createClickHandler =
                        function(key) {
                            return function() {
                                document.getElementById("frame").src = navpages[key].concat("?userid=<?php echo $_GET["userid"]; ?>");
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
<div id="account">Hi, <span id="username"><?php
	include("config.php");
	$username_query = "SELECT username FROM login WHERE id = " . $_GET["userid"] . ";";
	$username_query_result = mysqli_query($db,$username_query);
	$fetch = mysqli_fetch_array($username_query_result,MYSQLI_ASSOC);
	$username = $fetch["username"];
	echo $username;
	echo "!";
?></span><br><span id="logout"><a href="login.php" class="logout" >logout</a></span></div>

<table class="navbar">
    <tr>
        <td id="catalog">Catalog</td>
        <td id="yourproducts">Your Products</td>
        <td id="addproduct">Add Product</td>
        <td id="sales">Sales</td>
        <td id="purchases">Purchases</td>
    </tr>
</table>


</body>
</html>