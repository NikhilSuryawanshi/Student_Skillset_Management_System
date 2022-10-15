<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
    //allow access only if session exists
String usr = null;
if(session.getAttribute("usr") == null){
	response.sendRedirect("index.html");
}
else 
	usr = (String) session.getAttribute("usr");
String userName = null;
String sessionID = null;
Cookie[] cookies = request.getCookies();
if(cookies !=null){
for(Cookie cookie : cookies){
	if(cookie.getName().equals("usr")) userName = cookie.getValue();
	if(cookie.getName().equals("JSESSIONID")) sessionID = cookie.getValue();
}
}
%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>SSSM | Faculty Password Reset</title>
    <link rel="stylesheet" href="style/style.css">
    <script src="fontawesome/js/all.js"></script>
  <style>
.form-area{
    position: relative;
    top: 45%;
    left: 50%;
    transform: translate(-50%,-50%);
    width: 450px;
    height: auto;
    box-sizing: border-box;
    background: rgba(0,0,0,0.8);
    padding-right: 40px;
    padding-left: 40px;
    padding-top: 10px;
    padding-bottom: 20px;
}
h2,h4{
    margin: 0;
    padding: 10px 0 20px;
    font-weight: bold;
    color: #ffffff;
    text-align: center;
}

.form-area p{
    margin: 0;
    padding-left: 0;
    font-weight: bold;
    font-size: 18px;
    color: #ffffff;

}

.form-area input{
    margin-bottom: 20px;
    width: 100%;
}

.form-area input[type=text],
.form-area input[type=password]{
border: none;
border-bottom: 1px solid #ffffff;
background-color: transparent;
outline: none;
height: 40px;
color: #ffffff;
display: 160px;
}

::placeholder{
    color:#ffff;
    
    }


    .form-area input[type=submit]{
        border: none;
        height: 40px;
        outline: none;
        color:black;
        background: linear-gradient(to right, #25c481, #25b7c4);
        cursor: pointer;
        border-radius: 20px;
        font-family: cursive;
        font-size: 20px;
        width: 180px;
        margin-left: 90px;
        border: 2px solid white;

       }

    .form-area input[type=submit]:hover{
      background: linear-gradient(to right, #25b9c4, #25c482);
        color:black;
        transition: 0.4s;
        font-size: 21px;
        font-weight: bold;
        border: 4px solid white;
        }

    .form-area input[type=text]

{
border: none;
border-bottom: 1px solid #ffffff;
background-color: transparent;
outline: none;
height: 40px;
color: #ffffff;
display: 160px;
font-size: 15px ;
font-family: cursive;
}
.header_content
    {

        width: 100%;
        height: 100px;
        position: relative;
        top: 50%;
        left: 50%;
        color: rgba(255,255,255,0.8);
        transform: translate(-50% ,-50%);
        font-family: cursive ;
        
    }

  </style>
  
  
  </head>
  <body>
    <input type="checkbox" id="check">
    <label for="check">
      <i class="fas fa-bars" id="btn"></i>
      <i class="fas fa-times" id="cancel"></i>
    </label>
    <div class="sidebar">
    <header>Reset Password</header>
  <ul>
    <li><a href="Tea_home.jsp"><i class="fas fa-home"></i> Home</a></li>
    <li><a href="Tea_update_pro.jsp"><i class="fas fa-pen-alt"></i> Edit Profile</a></li>
    <li><a href="Tea_std_search_service.jsp"><i class="fas fa-users-cog"></i> Student Panel</a></li>
    <li><a href="Tea_add_project.js[]"><i class="fas fa-drafting-compass"></i>  Project Panel</a></li>
    <li><a href="Tea_update_pass.jsp"><i class="fas fa-lock"></i> Reset Password</a></li>
    <li><a href="Slogout"><i class="fas fa-power-off"></i>  Log Out</a></li>
  </ul>
</div>
 <section>


  <div class="header_content">
    <div class="form-area">
      <h2>Update password</h2>
<h4>user: <%=usr%></h4>
<form action="Updatepass" method="post">
<input type="hidden" name="email"  value="<%=usr %>"> 
 <p> Old Password</p>
               <input type="password" required  title="Please enter valid password" placeholder="********" name="oldpass">
 <br>
 <p>New Password</p>
 <input type="password" id="Password"  pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,16}" required title="Must contain at least 1 lowercase,1 uppercase  alphabetical character ,1 numeric characte & must be 8 to 16 characters " placeholder="********" name="newpass">
 <br>
 <p>Confirm Password</p>
 <input type="password" id="ConfirmPassword" required placeholder="********" name="confirmpass">
 <br>
 <input type="submit" value="UPDATE" onclick="return Validate()"></input>

</form>
 </div>
 </div>
 </section>

  </body>

<script type="text/javascript">
    function Validate() {
        var password = document.getElementById("Password").value;
        var confirmPassword = document.getElementById("ConfirmPassword").value;
        if (password != confirmPassword) {
            alert("Passwords do not match.");
            return false;
        }
        return true;
    }
</script> 
</html>