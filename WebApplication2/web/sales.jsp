<%--
  Created by IntelliJ IDEA.
  User: Joshua
  Date: 11/4/2016
  Time: 3:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="verifytoken.jsp" %>
<!DOCTYPE html>

<html>
<head>
    <title>Sales</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
<h2 class="pagetitle">Here are your sales</h2>
<hr>
<?php
		include("config.php");
		$userid = $_GET["userid"];
		$sql = "
			SELECT *
	        FROM   transaction
	        WHERE  id_penjual = " . $userid . "
	        ORDER BY waktu_transaksi DESC
	       ";

		$result = mysqli_query($db, $sql);
		if (!$result) {
		    echo "Could not successfully run query ($sql) from DB: " . mysql_error();
		    exit;
		}
		if (mysqli_num_rows($result) == 0) {
			echo "<h3 class=\"pagetitle\">You haven't yet purchase any product!</h2>";
exit;
}
function fetch_username($userid, $db) {
$username_query = "SELECT username FROM login WHERE id = " . $userid . ";";
$username_query_result = mysqli_query($db,$username_query);
$fetch = mysqli_fetch_array($username_query_result,MYSQLI_ASSOC);
return $fetch["username"];
}
function fetch_full_name($userid, $db) {
$full_name_query = "SELECT full_name FROM data_pelanggan WHERE id = " . $userid . ";";
$full_name_query_result = mysqli_query($db,$full_name_query);
$fetch = mysqli_fetch_array($full_name_query_result,MYSQLI_ASSOC);
return $fetch["full_name"];
}

while ($row = mysqli_fetch_assoc($result)) {
echo "<div class=\"chunk\">";
    $time = strtotime($row["waktu_transaksi"]);
    echo "<div class=\"username\">" . date('l',$time), ", " . date('d',$time), " " . date('F',$time)," " .date('Y',$time), "</div>" ;
    echo "<div class=\"tanggal\"> at " . date('H',$time), "." . date('i',$time), "</div>" ;
    echo "<hr>";

    echo "<div class=\"container\">";
        //echo gambar berdasarkan source
        echo "<div class=\"divGambar\">";
            echo "<img src=\"" . $row["path_foto"]. "\" class=\"GambarKatalog\">";
            echo "</div>";

        //echo keterangan item
        echo "<div class=\"divDesc\">";
            echo "<span class=\"NamaBarang\">" . $row["nama_barang"], "</span><br>";
            $total_harga = $row["harga_barang"]*$row["quantity"];
            echo "<span class=\"HargaBarang\"> IDR " . number_format($total_harga, 0, ',', '.'), "</span><br>";
            echo "<span class=\"HargaBarang\">" . $row["quantity"] . " pcs</span><br>";
            echo "<span class=\"HargaBarang\"> @IDR " . number_format($row["harga_barang"], 0, ',', '.'), "</span><br>";
            echo "<br>";
            echo "<span class=\"DeskripsiBarang\">bought by <b>" . fetch_full_name($row["id_penjual"], $db), "</b></span><br>";
            echo "</div>";

        //echo invoice
        echo "<div class=\"divInvoice\">";
            echo "<span>Delivery to <b>" . $row["cosignee"], "</b></span><br>";
            echo "<span>" . nl2br($row["full_address"]), "</span><br>";
            echo "<span>" . $row["postal_code"], "</span><br>";
            echo "<span>" . $row["phone_number"], "</span><br>";
            echo "</div>";
        echo "</div>";
    echo "<br><hr>";
    echo "</div>";
}
?>
</body>
</html>