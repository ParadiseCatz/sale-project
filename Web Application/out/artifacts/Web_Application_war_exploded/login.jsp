<%--
  Created by IntelliJ IDEA.
  User: Joshua
  Date: 11/4/2016
  Time: 3:32 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
<title>Login</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>

<h1 id="title"><span id="Sale">Sale</span><span id="Project">Project</span></h1>
<h2 class="pagetitle">Please login</h2>
<hr>
<form class="form" action="loginaction.php" method = "GET">
<label for="username">Email or Username</label>
<input type="text" name="username" 	id="username"><br>
<label for="password">Password</label>
<input type="password" name="password" id="password"><br>
<div id="tombol"><input type="submit" class="button" value="Login"></div>
</form>

<p>Don't have an account yet? Register <a href="Register.php">here</a></p>


</body>
</html>