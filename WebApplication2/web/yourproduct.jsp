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
    <title>Your Product</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
<h2 class="pagetitle">What are you going to sell today?</h2>
<hr>
<br>
<?php
		include("config.php");
		$userid = $_GET["userid"];
		$query = "SELECT * FROM barang WHERE id_penjual = '" . $userid . "' ORDER BY waktu_ditambahkan DESC";
		$result = mysqli_query($db,$query);
		if(mysqli_num_rows($result) > 0){
while ($row = mysqli_fetch_row($result)){
$time = strtotime($row[6]);
echo "<div class=\"username\">" . date('l',$time), ", " . date('d',$time), " " . date('F',$time)," " .date('Y',$time), "</div>" ;
echo "<div class=\"tanggal\"> at " . date('H',$time), "." . date('i',$time), "</div>" ;
echo "<hr>";


echo "<div class=\"container\">";
    //echo gambar berdasarkan source
    echo "<div class=\"divGambar\">";
        echo "<img src=\"" . $row[5], "\" class=\"GambarKatalog\">";
        echo "</div>";

    //echo keterangan item
    echo "<div class=\"divDesc\">";
        echo "<span class=\"NamaBarang\" style=\"font-size:22px\"><b> " . $row[2], "</b></span><br>";
        echo "<span class=\"HargaBarang\">"  . "IDR ".number_format($row[3], 0,',', '.'), "</span><br>";
        echo "<span class=\"DeskripsiBarang\">" . $row[4], "</span><br>";
        echo "</div>";


    //echo like purchase
    echo "<div class=\"divLike\">";
        echo $row[7], " likes<br>";
        echo $row[8], "  purchases<br><br>";
        echo "<span class=\"like\">";
				echo "</span>";
        $idbarang = mysqli_real_escape_string($db,$row[0]) ;
        $namabarang = mysqli_real_escape_string($db,$row[2]) ;
        $deskripsibarang = $row[4] ;
        $hargabarang = mysqli_real_escape_string($db,$row[3]);
        $file = $row[5];
        $dir = dirname(__FILE__) . '\\'.$file;
        echo "<a href=\"editproduct.php?userid=$userid&idbarang=$idbarang&namabarang=$namabarang&deskripsi=$deskripsibarang&harga=$hargabarang&path=$dir\"  class=\"edit\">EDIT</a>";
        echo " &nbsp&nbsp&nbsp&nbsp&nbsp";
        echo "<a href=\"delete.php?userid=$userid&idbarang=$idbarang&namabarang=$namabarang&pathfoto=$dir\" class=\"delete\" onclick=\"return confirm('Apakah Anda yakin untuk menghapus barang?')\">DELETE</a>";
        echo "</div>";
    echo "</div>";

echo "<br><hr>";
}
}
else{
echo "<h2 class=\"pagetitle\">You have no product, please sell something first in add product !</h2>";
}

?>

</body>
</html>