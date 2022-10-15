<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%!
    RequestDispatcher rd;
    String sem;%>
    
    <%
    //allow access only if session exists
String usr = null;
if(session.getAttribute("usr") == null)
{
rd=request.getRequestDispatcher("index.html");
rd.include(request, response);
out.print("<script>window.alert(\"Logn in first...!\");</script>");
}
else 
	usr = (String) session.getAttribute("usr");
	 sem=(String)session.getAttribute("sem");	
String userName = null;
String sessionID = null;
Cookie[] cookies = request.getCookies();
if(cookies !=null)
{
for(Cookie cookie : cookies)
{
	if(cookie.getName().equals("usr")) userName = cookie.getValue();
	if(cookie.getName().equals("JSESSIONID")) sessionID = cookie.getValue();
}
}
%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>SSSM | Student -Reset Password</title>
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
h2{
    margin: 0;
    padding: 10px 0 20px;
    font-weight: bold;
    color: #ffffff;
    text-align: center;
}
h4 
{
  margin-left: 70px;
    padding: 10px 0 20px;
    font-weight: bold;
    color: #ffffff;
    text-align: left;
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


    .header_content input[type=submit]{
        border: none;
        height: 35px;
        width: 50%;
        outline: none;
        color:white;
        background: rgb(255, 94, 0);
        cursor: pointer;
        border-radius: 20px;
        font-family: cursive;
        font-size: 18px;
        border: 1px solid white;
        margin-left: 100px;
       }

       .header_content input[type=submit]:hover{
        background: cornsilk;
        color:rgb(255, 94, 0);;
        font-weight: bold;
        transition: 0.4s;
        font-size: 19px;
        border: 2px solid rgb(255, 94, 0);
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
        text-transform: uppercase;
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
    <li><a href="Std_home.jsp"><i class="fas fa-home"></i> Home</a></li>
    <li><a href="Std_update_pro.jsp"><i class="fas fa-user-edit"></i> Edit Profile</a></li>
    <li><a href="Std_skill_panel.jsp"><i class="fas fa-tools"></i> Skill Panel</a></li>
    <li><a href="Std_select_proj.jsp"><i class="fas fa-users"></i>  Projct Panel</a></li>
    <li><a href="Slogout"><i class="fas fa-sign-out-alt"></i>  Log Out</a></li>
  </ul>
</div>
 <section>


  <div class="header_content">
    <div class="form-area">
      <h2>Reset password</h2>

         <form action="UppassStd" method="post">
          <h4>Roll NO: <input type="hidden" name="roll" value="<%= usr %>" ><%= usr %></h4>
               <p> Old Password</p>
               <input type="password" name="oldpass" required  title="Please enter valid roll number" placeholder="********">
 <br>
 <p>New Password</p>
 <input type="password" id="Password" name="newpass"  pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,16}" required title="Must contain at least 1 lowercase,1 uppercase  alphabetical character ,1 numeric characte & must be 8 to 16 characters " placeholder="********">
 <br>
 <p>Confirm Password</p>
 <input type="password" id="ConfirmPassword" name="confirmpass" required placeholder="********">
 <br>
 <input type="submit" value="UPDATE" onclick="return Validate()"></input>
         </form>
         </div>
 </div>
 </section>

  </body>
  <script>
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