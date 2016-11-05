<%--
  Created by IntelliJ IDEA.
  User: Joshua
  Date: 11/4/2016
  Time: 3:42 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="style.css">
    <script src="validation.js"></script>
    <title>Register</title>
</head>
<body>
<h1 id="title"><span id="Sale">Sale</span><span id="Project">Project</span></h1>
<h2 class="pagetitle">Please register</h2>
<hr>

<form id="registerForm" class="form" action="registeraction.php" method = "post" onsubmit="return validateRegister(this);">
    <label for="fullname">Full Name</label>
    <input type="text" id="fullname" name="fullname" ><br>
    <label for="username">Username</label>
    <input type="text" id="username" name="username" ><br>
    <label for="email">Email</label>
    <input type="text" id="email" name="email" ><br>
    <label for="password">Password</label>
    <input type="password" id="password" name="password" ><br>
    <label for="confirmpassword">Confirm Password</label>
    <input type="password" id="confirmpassword" name="confirmpassword" ><br>
    <label for="fulladdress">Full Address</label>
    <textarea rows="2" name="fulladdress" form="registerForm" class="Text" id="fulladdress"  ></textarea>

    <label for="postalcode">Postal Code</label>
    <input type="text" id="postalcode" name="postalcode" ><br>
    <label for="phonenumber">Phone Number</label>
    <input type="text" id="phonenumber" name="phonenumber" ><br>
    <div id="tombol"><input type="submit" class="button" value="REGISTER" id="Register"></div>
</form>

<p>Already registered? Login <a href="login.jsp">here</a></p>

</body>
</html>