<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>SSSM | Teacher - Edit Project</title>
    <link rel="stylesheet" href="style/style.css">
    <link rel="stylesheet" href="fontawesome/css/all.css">
 
 <style>
     .header_content
    {
        text-transform: uppercase;
        color: rgba(255,255,255,0.8);
        font-family: cursive ;
        position: relative;
    top: 52%;
    left: 50%;
    transform: translate(-50%,-50%);
    width: 450px;
    height: auto;
    box-sizing: border-box;
    background: rgba(0,0,0,0.8);
    padding-right: 30px;
    padding-left: 30px;
    padding-top: 20px;
    padding-bottom: 20px;
        
    }
.header_content h2
{
    text-align: center;
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
    margin: 8px;
    padding-left: 8px;
    font-weight: bold;
    font-size: 20px;
    color: #ffffff;

}
.form-area b 
{
 margin: 0px;
    padding-left: 13px;
}
.form-area b:hover
{
color:red;
}
.form-area input{
    margin-bottom: 20px;
    width: 100%;
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
        margin-left: 89px;
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
font-size: 18px ;
font-family: cursive;
margin-left:20px;

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
    <header>Edit Project Name</header>
  <ul>
    <li><a href="Tea_home.jsp"><i class="fas fa-qrcode"></i>  Dashboard</a></li>
    <li><a href="Tea_add_project.jsp"><i class="fas fa-edit"></i>Add Projects</a></li>
    <li><a href="Tea_proj_assign.jsp"><i class="fas fa-edit"></i>Assign Projects</a></li>
    <li><a href="Tea_pro_group.jsp"><i class="fas fa-edit"></i>Group Filter</a></li> 
    <li><a href="Slogout"><i class="fas fa-power-off"></i>  Log Out</a></li>
  </ul>
</div>
 <section>


    <div class="header_content">
        <div class="form-area">
            <h2>Edit Project Name</h2>
             <%
//allow access only if session exists
String usr = null;
if(session.getAttribute("usr") == null)
{
	RequestDispatcher rd = request.getRequestDispatcher("/index.html");
	rd.include(request, response);
	out.println("<script>window.alert(\"Time out\")</script>");
	
}else usr = (String) session.getAttribute("usr");
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
            
            
<%
String old=request.getParameter("project_name");
%>

<form action="Tea_edit_project" method="post">
<P> old name:</P> <b>  <%= old %></b><br><input name="oldprj" hidden="hidden" type="text" value="<%= old %> ">
<P>new name:</P> <input name="newprj"  type="text" required>

<input type="submit" value="submit">
</form>
</div>
     </div>


 </section>

  </body>
</html>
