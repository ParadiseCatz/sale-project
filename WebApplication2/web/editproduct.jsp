<%--
  Created by IntelliJ IDEA.
  User: Joshua
  Date: 11/4/2016
  Time: 3:51 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="style.css">
    <script src="validation.js"></script>
    <title> Product</title>
</head>
<body>
<h2 class="pagetitle">Please update your product here</h2>
<hr>
<form id="AddProductForm" onsubmit="return validateAddProduct(this)" method="post" action="editaction.php" enctype="multipart/form-data">
    <input type="hidden" name="userid" value="<?php echo $_GET["userid"]; ?>">
    <input type="hidden" name="idbarang" value="<?php echo $_GET["idbarang"]; ?>">
    <label for="Name">Name</label>
    <input type="text" id="Name" name="nama" value="<?php echo $_GET["namabarang"]; ?>"><br>
    <label for="Description">Description(max 200 chars)</label>
    <textarea maxlength="200" rows="3" name="Description" form="AddProductForm" class="Text" id="Description" name="Description" ><?php echo $_GET["deskripsi"]; ?></textarea>
    <label for="Price">Price (IDR)</label>
    <input type="text" id="Price" name="price" value="<?php echo $_GET["harga"]; ?>"><br>
    <table >
        <tr>
            <th><label for="Photo" style="font-weight:normal;">Photo</label></th>
            <th><button type="button" style="float:left;">Choose File</button></th>
            <th><p><?php echo $_GET["path"]; ?></p></th>
        </tr>
    </table>
    <div id="tombol"><input type="submit" class="button" value="Update" id="Update">
        <input type="button" class="button" value="Cancel" onclick="window.history.back();">
    </div>
</form>
</body>
</html>

