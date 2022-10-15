<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Db.Dbcon"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%!
RequestDispatcher rd;
String sql;
Connection con;
ResultSet rs;
PreparedStatement ps;

%>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>SSSM | Admin - Add / Remove Skills</title>
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
    top: 52%;
    left: 50%;
    transform: translate(-50%,-50%);
    width: 80%;
    height: auto;
    box-sizing: border-box;
    background: rgba(0,0,0,0.8);
    padding-right: 90px;
    padding-left: 90px;
    padding-top: 20px;
    padding-bottom: 20px;
    font-size: 18px;
        
    }
.header_content h3
{
    text-align: center;
    padding-bottom: 10px;
}
    table{
  width:100%;
  table-layout:auto;
}
.tbl-header{
  background-color: rgba(255,255,255,0.3);
 }
.tbl-content{
  height:500px;
  overflow-x:auto;
  margin-top: 0px;
  border: 1px solid rgba(255,255,255,0.3);
}
th{
text-align: center;
padding: 20px 15px;
  font-size: 18px;
  color: #fff;
  text-transform: uppercase;
  overflow-x:auto;
}
tr:hover
{
  text-align: center;
  vertical-align:middle;
  font-size: 16px;
  color:black;
  border-bottom: solid 3px rgba(255,255,255,0.1);
  background-color: rgba(26, 168, 173, 0.8);
  transition: 0.4s ease;
}
td{
    
  padding: 10px;
  text-align: center;
  vertical-align:middle;
  font-size: 16px;
  color: #fff;
  border-bottom: solid 3px rgba(255,255,255,0.1);
}
.tbl-content a

{

  display: block;
 background-color:rgb(235, 131, 46); 
  line-height: 15px;
  width: 90px;
  border-radius: 20px;
  font-size: 15px;
  color: white; 
 padding:5px;
  box-sizing: border-box;
  border: 3px solid white;
 margin-left:20px; 
}
.tbl-content a:hover
{
    
  background-color: white;
  color: rgb(235, 131, 46);
  font-weight: bold;
  text-decoration: none;
  transition: 0.3s;

  
}
form
{
text-align: center;
padding: 15px;
color: whitesmoke;
}
form input[type=text]
{
border: none;
border-bottom: 1px solid #ffffff;
background-color: transparent;
outline: none;
height: 20px;
width: 50%;
color: white;
font-size: 18px ;

}
form button[type=submit]{
        border: none;
        outline: none;
        color:#ffffff;
        width: 89px;
        height: 25px;
        background-color:#e67300;
        cursor: pointer;
        border-radius:20px;
        font-family: cursive;
        font-size: 16px;
        border: 1px solid white;
        margin-left:10px;
       margin-top: 5px;
       }
    form button[type=submit]:hover{
        background-color: #ffffff;
        color:#e67300;
        transition: 0.4s;
        font-size: 18px;
        border: 1px solid #e67300;
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
    <header>Manage Skill</header>
  <ul>
    <li><a href="Adm_home.jsp"><i class="fas fa-qrcode"></i> Dashboard</a></li>
    <li><a href="Adm_std_service.jsp"><i class="fas fa-user-graduate"></i>  Student Control</a></li>
    <li><a href="Adm_show_tea.jsp"><i class="fas fa-chalkboard-teacher"></i>  Faculty Control</a></li>
    <li><a href="Adm_mng_pro.jsp"><i class="fas fa-tools"></i>Project Control</a></li>
    <li><a href="Adm_add_skill.jsp"><i class="far fa-sun"></i> Skill Control</a></li>
    <li><a href="Slogout"><i class="fas fa-power-off"></i>  logout</a></li>
  </ul>
</div>
 <section>


    <div class="header_content">
        <h3>Added Skills </h3>
        <div class="tbl-content">
           
            <table >
                
                    <tr class="tbl-header">
                    <th width="5%">Pro.No.</th><th>Skill Name</th><th width="15%">Action</th>
                  </tr>
       <%
//allow access only if session exists
String usr = null;
if(session.getAttribute("usr") == null)
{
	 rd = request.getRequestDispatcher("/index.html");
	rd.include(request, response);
	out.println("<script>window.alert(\"Login First...!\")</script>");
	
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

try
{
	con=Dbcon.setCon("Adm_add_skill.jsp");
	String sql=new String("select *from skills order by skill_name");
	ps=con.prepareStatement(sql);
	rs=ps.executeQuery();
    if(rs.next())
    {
    	int i=0;
 	
    	do
		{
			++i;
			String skill=rs.getString("skill_name");
			
			%>
			 <tr>
                  <td><%=i %></td><td><%=skill %></td><td><a href="Remove_skill?skill=<%=skill%>"> Remove</a></td>
                </tr>
			<%	
		}while(rs.next());   
    }
    else
    {	
    	%>
		 <tr>
             <td colspan="3"><h3>No Records Found...!</h3> </tr>
		<%	
    }
    Dbcon.closeCon("Adm_add_skill.jsp");
}catch(Exception e)
{
	e.printStackTrace();
}

%>

</table>
</div>
<form action="Add_skill" method="post">
Add Skill: <input type="text" name="skill" required placeholder="" pattern="[A-Za-z]{1,15}"> 
<button type="submit">Add</button>
</form>
</div>
</section>
</body>
</html>