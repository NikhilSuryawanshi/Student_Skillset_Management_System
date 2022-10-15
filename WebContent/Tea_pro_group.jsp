<%@page import="java.util.Arrays"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
RequestDispatcher rd;
String usr = null;
if(session.getAttribute("usr") == null)
{
	rd=request.getRequestDispatcher("index.html");
	rd.include(request, response);
	out.println("\n <script>window.alert(\"Login first...!\")</script>");
}
else usr = (String) session.getAttribute("usr");
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
    <title>SSSM | Teacher -  Search By:</title>
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="fontawesome/css/all.css">
 
 <style>
     .header_content
    {
        text-transform: uppercase;
        position: relative;
        color: rgba(255,255,255,0.8);
        font-family: cursive ;
    top: 45%;
    left: 50%;
    transform: translate(-50%,-50%);
    width: 450px;
    height: auto;
    box-sizing: border-box;
    background: rgba(0,0,0,0.8);
    padding-top: 5px;
    padding-bottom: 40px;
        
    }
     h2 
{
    text-align: center;
    padding-top :20px;
    padding-bottom :20px;

}
.header_content table
{
    margin-left: 60px;

}
.header_content a

{
    display: block;
  background: linear-gradient(to right, #25c481, #25b7c4);
  margin: 9px;
  padding-top: 40px;
  height: 120px;
  width: 150px;
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
  width: 148px;
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
    <header>Search By :</header>
  <ul>
    <li><a href="Tea_home.jsp"><i class="fas fa-qrcode"></i>  Dashboard</a></li>
    <li><a href="Tea_proj_assign.jsp"><i class="fas fa-edit"></i>Assign Projects</a></li>   
    <li><a href="Tea_add_project.jsp"><i class="fas fa-caret-square-down"></i>Add Project</a></li>   
    <li><a href="Slogout"><i class="fas fa-power-off"></i>  Log Out</a></li>
  </ul>
</div>
 <section>


    <div class="header_content">
        <h2>Search Project by</h2>
        <table>
          <tr>
              <td> <h2><a href="Com_sem_pro.jsp" >Semester</a></h2> </td>
              <td><h2><a  href="Com_group_list.jsp">Project Name</a></h2></td>
          </tr>
      </table>
          
          
          
     
 
     </div>


 </section>

  </body>
</html>
