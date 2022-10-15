<%@page import="Db.Dbcon"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
Connection con;
RequestDispatcher rd;
PreparedStatement ps;
ResultSet rs;
String sql;
String roll;
String skill="Not updated Yet!";
%>


<%
//allow access only if session exists

String usr = null;
if(session.getAttribute("usr") == null)
{
	response.sendRedirect("index.html");
}
else usr = (String) session.getAttribute("usr");
String userName = null;
String sessionID = null;
Cookie[] cookies = request.getCookies();
if(cookies !=null)
{
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
    <title>Sider Menu Bar CSS</title>
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
    width: 570px;
    height: 400px;
    box-sizing: border-box;
    background: rgba(0,0,0,0.8);
    padding-left: 10px;
    

   
        
    } 
    
#parent_div_1, #parent_div_2 {
  width: 230px;
  height: 300px;
  border: 1px solid rgb(128, 128, 122);
  margin: 40px 15px 15px 15px;
  padding: 5px;
  float: left;
text-align: center;

}
#parent_div_1 table
{
  width: 100%;
margin: 0px 0px 32px 0px;
text-align: center;

}

#parent_div_1 h3 
{
margin: 60px 0 40px 0;

}

#parent_div_2 table
{
  margin: auto;
}
#parent_div_2 table td 
{
    margin: 2px;
    padding: 0 30px 0 30px;
}

  .header_content input[type=submit]{
        border: none;
        height: 35px;
        outline: none;
        color:black;
        background-color:#ffffff;
        cursor: pointer;
        border-radius: 20px;
        font-family: cursive;
        font-size: 18px;
        margin-top: 15px;
        padding: 0 60px 0 60px;
        border: 2px solid #e67300;
       }

    .header_content input[type=submit]:hover{
        background-color: #e67300;
        color:white;
        transition: 0.3s;
        font-size: 19;
        font-weight: bold;
        border: 2px solid white;
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
    <header>Dashboard</header>
  <ul>
    <li><a href="Std_home.jsp"><i class="fas fa-home"></i> Home</a></li>
    <li><a href="Std_update_pro.jsp"><i class="fas fa-user-edit"></i>Edit Profile</a></li>
    <li><a href="Std_skill_panel.jsp"><i class="fas fa-tools"></i>Skill Panel</a></li>
    <li><a href="Std_select_proj.jsp"><i class="fas fa-users"></i>  Projct Panel</a></li>
    <li><a href="UppassSTd.jsp"><i class="fas fa-user-shield"></i>Reset Password</a></li>
    <li><a href="index.jsp"><i class="fas fa-sign-out-alt"></i>  Log Out</a></li>
  </ul>
</div>
 <section>


    <div class="header_content">

<%
con=Dbcon.setCon("Std_add_skill.jsp");
roll=(String)session.getAttribute("usr");
sql=new String("select * from student_skill where roll=?");
ps=con.prepareStatement(sql);
ps.setString(1,roll);
rs=ps.executeQuery();
%>
     <div id='parent_div_1'>
  <h3>Skills </h3> 
      <table>

<%
if(rs.next())
{	
	
	
	
	do
	{
		
		 skill=rs.getString("skill_name");
		
		%>
		
<tr><td><%=skill %></td></tr>
		
		<%	
	}while(rs.next());    
}
else
{
	%>
	<tr> <td>Not Updated Yet!</td></tr>
	<%
}

%>
</table>
   </div>
  
 <div id='parent_div_2'>
<form action="Std_add_skill" method="post">
        <table>

<%
try
{
	sql= new String("select *from skills");
	ps=con.prepareStatement(sql);
	rs=ps.executeQuery();
	while(rs.next())	
	{
		String skil= new String(rs.getString("skill_name"));
	%>

		<tr><td><%=skil.toUpperCase()%></td><td><input type="checkbox"  name="skill" value="<%=skil %>"><br></td></tr>      
	<%
	}	
	Dbcon.closeCon("Std_add_skill.jsp");
}catch(Exception e)
{
	e.printStackTrace();
}
%>
</table>
    <input type="submit" value=" add ">
    </form>
    
    </div>
    
    
  </div>


 </section>

  </body>
</html>
