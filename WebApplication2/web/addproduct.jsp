<%@ page import="java.util.Collection" %>
<%@ page import="java.io.*" %><%--
  Created by IntelliJ IDEA.
  User: Joshua
  Date: 11/4/2016
  Time: 3:48 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="verifytoken.jsp" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="style.css">
    <%--<script src="validation.js"></script>--%>
    <title>Add Product</title>
</head>
<body>
<h2 class="pagetitle">Please add your product here</h2>
<hr>
<form id="AddProductForm" method="post" action="addproductaction.jsp" enctype="multipart/form-data">
    <input type="hidden" name="userid" value="">
    <label for="Name">Name</label>
    <input type="text" id="Name" name="name"><br>
    <label for="Description">Description(max 200 chars)</label>
    <textarea maxlength="200" rows="3" name="Description" form="AddProductForm" class="Text" id="Description" name="Description"></textarea>
    <label for="Price">Price (IDR)</label>
    <input type="text" id="Price" name="price"><br>
    <label for="File">Photo</label>
    <input type="File" id="File" accept="image/*" name="uploadedfile"><br>
    <div id="tombol"><input type="submit" class="button" value="Add" id="Add">
        <input type="button" class="button" value="Cancel" onclick="window.history.back();"></div>
</form>

</body>
</html>
