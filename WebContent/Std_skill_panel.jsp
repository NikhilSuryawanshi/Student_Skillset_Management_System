<%@page import="java.sql.Connection"%>
<%@page import="Db.Dbcon"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%!
String usr;
%>

        <%
//allow access only if session exists

        session=request.getSession();
if(session.getAttribute("usr") == null)
{
	response.sendRedirect("index.html");
	out.println("\n <script>window.alert(\"session expired\")</script>");
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
    <title>SSSM | Studnet - Skill panel</title>
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="fontawesome/css/all.css">
 
 <style>
     .header_content
    {
        text-transform: uppercase;
        position: relative;
        color: rgba(255,255,255,0.8);
        font-family: cursive ;
        position: relative;
    top: 45%;
    left: 50%;
    transform: translate(-50%,-50%);
    width: 500px;
    height: auto;
    box-sizing: border-box;
    background: rgba(0,0,0,0.8);
    padding-right: 30px;
    padding-left: 5px;
    padding-top: 10px;
    padding-bottom: 20px;
        
    }


    .header_content table
{
    margin-left: 75px;

}
.header_content h2 
{
  text-align: center;
}
.header_content a

{
    display: block;
  background: linear-gradient(to right, #25c481, #25b7c4);
  margin-left: 25px ;
  padding-top: 40px;
  height: 120px;
  width: 130px;
  text-align: center;
  color: whitesmoke; 
  box-sizing: border-box;
  border-radius: 30px;

}
.header_content a:hover
{
    
    background: -webkit-linear-gradient(left, #58a2c5, #25c4a2);
  color: black;
  text-decoration: none;
  transition: 0.4s ease;
  font-size: 21px;
  height: 111px;
  width: 121px;
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
    <header>Help/Add Skills</header>
  <ul>
    <li><a href="Std_home.jsp"><i class="fas fa-home"></i> Home</a></li>
    <li><a href="Std_update_pro.jsp"><i class="fas fa-user-edit"></i>Edit Profile</a></li>
    <li><a href="Std_select_proj.jsp"><i class="fas fa-users"></i>  Projct Panel</a></li>
    <li><a href="UppassSTd.jsp"><i class="fas fa-user-shield"></i>Reset Password</a></li>
    <li><a href="Slogout"><i class="fas fa-sign-out-alt"></i>  Log Out</a></li>
  </ul>
</div>
 <section>


    <div class="header_content">
        
          
      <h2>Skill</h2>
      <table>
          <tr>
              <td> <h2><a href="Std_skill_select.jsp" >Help</a></h2> </td>
              <td><h2><a  href="Std_add_skill.jsp">Add</a></h2></td>
          </tr>
      </table>

</div>
 </section>

  </body>
</html>
