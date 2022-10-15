<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="Db.Dbcon"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>SSSm | Faculty - Select Skill</title>
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
    width: 500px;
    height: auto;
    box-sizing: border-box;
    background: rgba(0,0,0,0.8);
    padding-right: 40px;
    padding-left: 40px;
    padding-top: 10px;
    padding-bottom: 20px;
        
    }

    .header_content select
        {
          border: none;
            width: 50%;
            outline: none;
            height: 40px;
            color: black;
            font-size: 18px;
            text-align: center;
            overflow:hidden;
           -moz-border-radius: 9px 9px 9px 9px;
          -webkit-border-radius: 9px 9px 9px 9px;
            border-radius: 9px 9px 9px 9px;
            box-shadow: 1px 1px 11px #330033;
             background: linear-gradient(to right, #25acc4, #25c46d);
        
        }
        .header_content option
        {
            
          color: black;
            outline: none;
           text-align: center;
        
        }
        .header_content select:hover
        {
          border: none;
            outline: none;
            height: 43px;
            color:whitesmoke;
            font-size: 20px;
            text-align: center;
            overflow:hidden;
           -moz-border-radius: 9px 9px 9px 9px;
          -webkit-border-radius: 9px 9px 9px 9px;
            border-radius: 9px 9px 9px 9px;
            box-shadow: 1px 1px 11px #330033;
             background: linear-gradient(to right, #25acc4, #25c46d);
        transition: 0.4s;
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
       }

       .header_content input[type=submit]:hover{
        background: cornsilk;
        color:rgb(255, 94, 0);;
        font-weight: bold;
        transition: 0.4s;
        font-size: 19px;
        border: 2px solid rgb(255, 94, 0);
        }
        .header_content p
        {
padding-top: 20px;
padding-bottom: 20px;
text-align: center;
        }
        .header_content h2
        {
text-align: center;
padding-bottom: 20px;
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
    <header>Select Skill</header>
  <ul>
    <li><a href="Tea_home.jsp"><i class="fas fa-qrcode"></i> Dashboard</a></li>
    <li><a href="Com_skill_filter.jsp"><i class="fas fa-pen-alt"></i>Skill Filter</a></li>
    <li><a href="Com_sem_skill_filter.jsp"><i class="fas fa-bezier-curve"></i>Semster filter</a></li>
    <li><a href="Tea_std_search_service.jsp"><i class="fas fa-users-cog"></i>Student filter</a></li>
    <li><a href="Slogout"><i class="fas fa-power-off"></i>  Log Out</a></li>
  </ul>
</div>
 <section>


    <div class="header_content">
    
     <h2>Select Skills to View Students</h2>
    <%
//allow access only if session exists
RequestDispatcher rd;
String usr = null;
if(session.getAttribute("usr") == null){
	response.sendRedirect("index.html");
	out.println("<script>window.alert(\"Login First...!\");</script>");
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
       <%!
       Connection con;
       PreparedStatement ps;
       ResultSet rs;
       RequestDispatcher rd;
       String sql;
    	%>
<%
con=Dbcon.setCon("Com_skill_filter.jsp");
sql=new String("select *from skills");
ps=con.prepareStatement(sql);
rs=ps.executeQuery();
if(rs.next())	
{
	int i=0;
%>

	<form action="Com_skill_show.jsp" method="post">
	<P>
	<select name="skill" required="required" title="plsease select a valid semester">
	<option disabled selected hidden="hidden">Skill</option>
<% 
do
	{
	
	i++;
	String skill= new String(rs.getString("skill_name"));
	
						
%>	<option value="<%= skill %>"><%=i%>.<%= skill.toUpperCase() %></option>
<%	

	}while(rs.next());
%>
          </select>
          </p>
         <p>
        <input type="submit" value="Fetch Students">
      </p>
             
    </form>

     </div>


<%
}
else
{
	rd=request.getRequestDispatcher("Com_skill_filter.jsp");
	rd.include(request, response);
	out.println("<script>window.alert(\"No skill Available...!\");</script>");
}

Dbcon.closeCon("Com_skill_filter.jsp");

%>
 </section>

  </body>
</html>
