
 <%@page import="Db.Dbcon"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>


<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>SSSM | Faculty - list of Projects</title>
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
    top: 53%;
    left: 50%;
    transform: translate(-50%,-50%);
    width: 85%;
    height: 650px;
    box-sizing: border-box;
    background: rgba(0,0,0,0.8);
    padding-right: 30px;
    padding-left: 30px;
    padding-top: 10px;        
    }

    table{
  width:100%;
  table-layout:auto;
}
.tbl-header{
    background: -webkit-linear-gradient(left, #25c481, #25b7c4);
  background: linear-gradient(to right, #25c481, #25b7c4);
  text-align: center;
 }
.tbl-content{
  height:550px;
  overflow-x:auto;
  margin-top: 0px;
  border: 1px solid rgba(255,255,255,0.3);
}
th{
text-align: center;
padding: 10px 10px;
  font-size: 18px;
  color: #fff;
  text-transform: uppercase;
  overflow-x:auto' 
}
tr:hover
{
  text-align: center;
  font-size: 16px;
  background-color: rgba(26, 168, 173, 0.8);
  transition: 0.4s ease;
}
td{
 
   padding: 15px;
  text-align: center;
  vertical-align:middle;
  font-size: 18px;
  color: #fff;
  border-bottom: solid 3px rgba(255,255,255,0.1);
}
.header_content h2
{
text-align: center;
padding: 10px;
}

.tbl-content  a

{
  display: block;
 background-color:rgb(235, 131, 46); 
  line-height: 15px;
  width: 150px;
  border-radius: 20px;
  font-size: 15px;
  color: white; 
  padding: 4px;
  box-sizing: border-box;
border: 1px solid white;
margin-left: 20px;
margin-right: 20px;
}
.tbl-content a:hover
{
    
background-color: white;
  color: rgb(235, 131, 46);
  font-weight: bold;
  text-decoration: none;
  transition: 0.3s;
  border: 2px solid rgb(255, 166, 0);
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
    <header>Projects</header>
  <ul>
    <li><a href="Tea_home.jsp"><i class="fas fa-qrcode"></i>  Dashboard</a></li>
    <li><a href="Tea_proj_assign.jsp"><i class="fas fa-edit"></i>Assign Projects</a></li>   
    <li><a href="Tea_add_project.jsp"><i class="fas fa-caret-square-down"></i>Add Project</a></li>
    <li><a href="Tea_pro_group.jsp"><i class="fas fa-users-cog"></i>Project Filter</a></li>      
    <li><a href="Slogout"><i class="fas fa-power-off"></i>  Log Out</a></li>
  </ul>
</div>
 <section>


    <div class="header_content">
        
          
        <h2>Peojects</h2>

        <div class="tbl-content">


<%!
 
       Connection con;
       PreparedStatement ps;
       ResultSet rs;
       RequestDispatcher rd;
       String sql;
       String pro_no;
       String roll;
    	%>
      <%
//allow access only if session exists
session=request.getSession();
String usr = null;
if(session.getAttribute("usr") == null){
	response.sendRedirect("index.html");
	out.println("\n <script>window.alert(\"session expired\")</script>");
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

con=Dbcon.setCon("Com_group_list.jsp");
String pro="1";
sql=new String("select project_name,project_no,active_status from project where active_status=?");
ps=con.prepareStatement(sql);
ps.setString(1,pro);
rs=ps.executeQuery();
if(rs.next())
{
	%>
	<table>
	<tr class="tbl-header">
                  <th width="7%" >Project No.</th>
                  <th  >Project Name</th>
                  <th width="7%">Action</th>
                </tr>
	<%
	
	do
	{
		String pro_name=rs.getString("project_name");
		String pro_no=rs.getString("project_no");
		String as=rs.getString("active_status");
	
		%>
		<tr><td><%=pro_no %></td><td><%=pro_name %></td> <td><a href="Com_proj_list.jsp?project=<%=pro_no %>">Team Members</a></td></tr>
		<%
		
		
	}
	while(rs.next());

}
else
{
	%>
	
	<tr><td colspan="3"><h3>No Records Found</h3></td></tr>
	
	<%
	
}
Dbcon.closeCon("Com_group_list.jsp");
%>
</table>
</div>
</div>
</section>
</body>
</html>