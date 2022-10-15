<%@page import="java.sql.ResultSet"%>
<%@page import="Db.Dbcon"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>    
   <%!
   Connection con;
	 ResultSet rs;  
	String first_name;
	String last_name;
	String mobile;
	String sex;
	RequestDispatcher rd;
   %>
        
    <%
   //allow access only if session exists

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
    <title>SSSM | Faculty - Update Profile</title>
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
    top: 50%;
    left: 47%;
    transform: translate(-50%,-50%);
    width: 500px;
    height: auto;
    box-sizing: border-box;
    /* background: rgba(0,0,0,0.8); */
    padding-right: 40px;
    padding-left: 40px;
    padding-top: 10px;
        
    }

    .card {
        font-size: 18px;
        box-shadow: 0 8px 8px 10px rgba(145, 143, 143, 0.4);
        width: 490px;
        padding: 10px;
     padding-bottom: 20px;  
        text-align: center;
        background: rgba(0,0,0,0.8);
      }
      .card input[type=text],
.card input[type=date],
.card input[type=email],
.card input[type=mobile]
{
border: none;
border-bottom: 1px solid #ffffff;
background-color: transparent;
outline: none;
height: 30px;
color: #ffffff;
display: 160px;
font-size: 18px;
font-family: cursive;
}

.card input[type=file]
{
  border: none;
margin-top: 13px;
background-color: transparent;
outline: none;
height: 30px;
color: #ffffff;
font-size: 14px;
font-family: cursive;
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
    
    .card h1{
        color: rgb(121, 121, 121);
        text-align: center;
        padding-bottom: 10px;
    }
    h1:hover{
        color: rgb(255,255,255); 
    }
         img {
        box-shadow: 0 8px 8px 10px rgba(95, 89, 89, 0.4);
        width: 250px;
        height:250px;
        border: 1px solid black;
        border-radius:130px;
        margin-bottom: 30px;
      }
      img:hover
      {
        width: 250px;
        height:250px;
        border: 2px solid black;
        border-radius:70px;
        transition: 0.3s;
      }
 table{color: rgb(176, 173, 173);
     text-align: left;
     margin-bottom: 10px;
     padding-left: 20px ;
 }
 td{
    padding-left: 20px ;
    padding-bottom: 1px;
     padding-right: 30px;
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
    <header>Edit Profile</header>
  <ul>
    <li><a href="Tea_home.jsp"><i class="fas fa-home"></i> Home</a></li>
    <li><a href="Tea_update_pro.jsp"><i class="fas fa-pen-alt"></i>Edit Profile</a></li>
    <li><a href="Tea_std_search_service.jsp"><i class="fas fa-users-cog"></i>Student Panel</a></li>
    <li><a href="Tea_add_project.jsp"><i class="fas fa-drafting-compass"></i>  Project Panel</a></li>
    <li><a href="Tea_update_pass.jsp"><i class="fas fa-lock"></i>Reset Password</a></li>
    <li><a href="Slogout"><i class="fas fa-power-off"></i>  Log Out</a></li>

  </ul>
</div>
 <section>


    <div class="header_content">
            
        
 
            <div class="card">

<%
con=Dbcon.setCon("Tea_update_pro.jsp");
String sql =new String("select * from teacher where email=?");
PreparedStatement ps=con.prepareStatement(sql);
ps.setString(1,usr);
 rs=ps.executeQuery();
 if(rs.next())
 {
	  first_name=rs.getString("first_name");
	  last_name=rs.getString("last_name");
	  sex=rs.getString("sex");
	  mobile=rs.getString("mobile");
	  
 }
 Dbcon.closeCon("Tea_proj_assign1.jsp");
%>
<h1>Update Profile</h1>
	<form action="Tea_update" method="post">
	
	       <img src="<%=Dbcon.imgLoc(usr) %>" alt="<%= usr%>"/>
            
                <table>
                   <tr><th>User</th><td><input type="hidden" name="email" value="<%= usr %>" ><%= usr %></td></tr>
                    <tr><th>Name</th><td><input type="text" name="name" pattern="[A-Za-z]{2,30}" required  title="2 or 30 Uppercase character.Do Not Use Digits & Space" value="<%= first_name %>"></td></tr>
                    <tr><th>Last name</th><td><input type="text" name="last_name" pattern="[A-Za-z]{2,30}" required  title="2 or 30 Uppercase character.Do Not Use Digits & Space" value="<%= last_name %>"></td></tr>
                    <tr><th>Gender</th><td><input type="radio" name="sex" value="m" <% if(sex.equals("m")){ %> checked="checked"<% } %> >
                      Male   <input type="radio" name="sex" value="f" <% if(sex.equals("f")) { %> checked="checked" <% } %> />  Female</td></tr>
                    <tr><th >Mobile </th><td><input type="text" name="mobile"   pattern="[6-9]{1}[0-9]{9}" required  title="without '+91' and 10 digit valid mobile no." value="<%= mobile %>"></td></tr>
                  </table>
		  <input type="submit" value="UPDATE"> 
</form>
		<form method="post" ACTION="Tea_UploadFile.jsp" name="uploadForm" ENCTYPE='multipart/form-data'>
    
    <table> 
                    <tr><th>Profile Photo</th><td><input type="file" required name="uploadForm" accept="image/*" ></td></tr>
    </table>
                <input type="submit" value="Update profile image "> 
              </form>
</div>
    </div>


 </section>

  </body>
</html>
