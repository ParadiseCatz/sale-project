<%--
  Created by IntelliJ IDEA.
  User: Joshua
  Date: 11/4/2016
  Time: 3:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="verifytoken.jsp" %>
<html>
<head>
    <title>Catalog</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <script>
        window.onload = function() {
            var likeButtons = document.querySelectorAll(".like, .liked");
            for (var i = 0; i < likeButtons.length; i++) {
                var likeButton = likeButtons[i];
                likeButton.onclick = function () {
                    var productId = this.dataset.productId;
                    if (this.className == "like") {
                        var xhttp = new XMLHttpRequest();
                        xhttp.onreadystatechange = function() {
                            if (this.readyState == 4 && this.status == 200) {
                                if (this.responseText == "SUCCESS") {
                                    var likeNum = document.getElementById("productlikes#".concat(productId));
                                    likeNum.innerHTML++;
                                } else {
                                    alert("Ups! There's Something Wrong :(\n".concat(this.responseText));
                                }

                            }
                        };
                        xhttp.open("GET", "likeaction.php?productid=".concat(productId).concat("&userid=").concat(<?php echo $_GET["userid"]; ?>), true);
                        xhttp.send();
                        this.className = "liked";
                        this.innerHTML = "LIKED";
                    } else {
                        var xhttp = new XMLHttpRequest();
                        xhttp.onreadystatechange = function() {
                            if (this.readyState == 4 && this.status == 200) {
                                if (this.responseText == "SUCCESS") {
                                    var likeNum = document.getElementById("productlikes#".concat(productId));
                                    likeNum.innerHTML--;
                                } else {
                                    alert("Ups! There's Something Wrong :(\n".concat(this.responseText));
                                }

                            }
                        };
                        xhttp.open("GET", "unlikeaction.php?productid=".concat(productId).concat("&userid=").concat(<?php echo $_GET["userid"]; ?>), true);
                        xhttp.send();
                        this.className = "like";
                        this.innerHTML = "LIKE";
                    }

                }
            }
        };
    </script>
</head>
<body>
<h2 class="pagetitle">What are you going to buy today?</h2>
<hr>
<form action="catalog.php" id="search" method="GET">
    <?php
				$userid = $_GET["userid"];
				echo "<input type=\"hidden\" name=\"userid\" value=" .$userid,">";
    ?>
    <input name="searchkey" type="text" placeholder="Search catalog ..." id="Search" autofocus="1">
    <input type="submit" value="GO" id="GO" class="button">
    <br>
    <label for="filter" class="filter">by</label> <br>
    <input type="radio" name="filter" value="product" checked="">Product<br>
    <input type="radio" name="filter" value="store">Store<br>
</form>
<br>
<?php
		$dosearch=FALSE;
		if ((!empty($_GET["searchkey"])) && (!empty($_GET["filter"]))){
			$searchkey=$_GET["searchkey"];
			$filter=$_GET["filter"];
			$dosearch=true;
		}


		include("config.php");
		$userid = $_GET["userid"];
		if ($dosearch===FALSE){
			$query = "SELECT * FROM barang where id_penjual<>" . $userid . " ORDER BY waktu_ditambahkan DESC";
}
elseif ($dosearch===true) {
if ($filter==="product"){
$query = "SELECT * FROM barang where id_penjual<>" . $userid . " AND nama_barang LIKE '%".$searchkey."%' ORDER BY waktu_ditambahkan DESC";
}
elseif ($filter==="store") {
$query = "SELECT * FROM barang,data_pelanggan where id_penjual<>" . $userid . " AND username LIKE '%".$searchkey."%' AND data_pelanggan.id=id_penjual ORDER BY waktu_ditambahkan DESC";
}
}

$result = mysqli_query($db,$query);
if ($result === FALSE){}
else
{
while ($row = mysqli_fetch_row($result)) {
$username_query = "SELECT username FROM login WHERE id = " . $row[1] . ";";
$username_query_result = mysqli_query($db,$username_query);
$fetch = mysqli_fetch_array($username_query_result,MYSQLI_ASSOC);
$username = $fetch["username"];
echo "<div class=\"username\">" . $username, "</div>" ;
$time = strtotime($row[6]);
echo "<div class=\"tanggal\">" ."added this on ". date('l',$time), ", " . date('d',$time), " " . date('F',$time)," " .date('Y',$time) . " at " . date('H',$time), "." . date('i',$time), "</div>" ;
echo "<hr>";

echo "<div class=\"container\">";
    //echo gambar berdasarkan source
    echo "<div class=\"divGambar\">";
        echo "<img src=\"" . $row[5], "\" class=\"GambarKatalog\">";
        echo "</div>";

    //echo keterangan item
    echo "<div class=\"divDesc\">";
        echo "<span class=\"NamaBarang\">" . $row[2], "</span><br>";
        echo "<span class=\"HargaBarang\"> IDR " . number_format($row[3], 0, ',', '.'), "</span><br>";
        echo "<span class=\"DeskripsiBarang\">" . $row[4], "</span><br>";
        echo "</div>";

    //echo like purchase
    echo "<div class=\"divLike\">";
        echo "<span id=\"productlikes#".$row[0]."\">" . $row[7], "</span> likes<br>";
        echo $row[8], "  purchases<br><br>";

        $check_liked_query = "
        SELECT *
        FROM user_liked
        WHERE
        id_user = '".$_GET["userid"]."' AND
        id_barang = '".$row[0]."'
        ";
        $check_liked_result = mysqli_query($db,$check_liked_query);
        $fetch = mysqli_fetch_array($check_liked_result,MYSQLI_ASSOC);
        if ($fetch == NULL) {
        echo "<span class=\"like\" data-product-id=\"$row[0]\">LIKE";
			} else {
				echo "<span class=\"liked\" data-product-id=\"$row[0]\">LIKED";
			}

			echo "</span>";
			$confirmation_purchase_url = "ConfirmationPurchase.php?";
			$confirmation_purchase_url .= "userid_pembeli=" . $_GET["userid"] . "&";
			$confirmation_purchase_url .= "userid_penjual=" . $row[1] . "&";
			$confirmation_purchase_url .= "nama_barang=" . $row[2] . "&";
			$confirmation_purchase_url .= "path_foto=" . $row[5] . "&";
			$confirmation_purchase_url .= "harga_barang=" . $row[3] . "&";
			$confirmation_purchase_url .= "id_barang=" . $row[0];

			echo "<a href=\"".$confirmation_purchase_url."\" class=\"buy\">BUY</a>";
			echo "</div>";
    echo "</div>";

echo "<br><hr>";
}
}
?>

</body>
</html>