<%@page import="java.sql.PreparedStatement"%>
<%@page import="Db.Dbcon"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%!
   Connection con;
     RequestDispatcher rd;
	 ResultSet rs;  
	String first_name;
	String last_name;
	String mobile;
	String dob;
	String sem;
	String email;
	String sex;
   %>
        
    <%
   //allow access only if session exists

String usr = null;
if(session.getAttribute("usr") == null)
{
	rd=request.getRequestDispatcher("index.html");
	rd.include(request, response);
	out.println("\n <script>window.alert(\"Login First...!\")</script>");
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
    <title>SSSM | Student Update Profile</title>
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
    left: 44%;
    transform: translate(-50%,-50%);
    width: 450px;
    height: auto;
    box-sizing: border-box;
    /* background: rgba(0,0,0,0.8); */
    padding-right: 30px;
    padding-left: 40px;
    padding-top: 10px;
        
    }

    .card {
        font-size: 15px;
        box-shadow: 0 8px 8px 10px rgba(145, 143, 143, 0.4);
        width: 495px;
        padding: 10px;
      
        text-align: center;
        background: rgba(0,0,0,0.8);
      }
      .header_content select
        {
          border: none;
            width: auto;
            outline: none;
            height: 20px;
            color: black;
            font-size: 15px;
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
            height: 20px;
            color:whitesmoke;
            font-size: 16px;
            text-align: center;
            overflow:hidden;
           -moz-border-radius: 9px 9px 9px 9px;
          -webkit-border-radius: 9px 9px 9px 9px;
            border-radius: 9px 9px 9px 9px;
            box-shadow: 1px 1px 11px #330033;
             background: linear-gradient(to right, #25acc4, #25c46d);
        transition: 0.4s;
        }
.card input[type=text],
.card input[type=email],
.card input[type=mobile]

{
border: none;
border-bottom: 1px solid #ffffff;
background-color: transparent;
outline: none;
height: 25px;
color: #ffffff;
font-size: 15px;
font-family: cursive;
}
.card input[type=date]
{
  border: none;
background-color: transparent;
outline: none;
height: 20px;
color: #ffffff;
font-size: 15px;
font-family: cursive;

}
.card input[type=file]
{
  border: none;
  margin-top: 5px;
background-color: transparent;
outline: none;
height: 20px;
color: #ffffff;
font-size: 14px;
font-family: cursive;

}
.header_content input[type=submit]{
        border: none;
        height: 25px;
        width: 40%;
        outline: none;
        color:white;
        background: rgb(255, 94, 0);
        cursor: pointer;
        border-radius: 20px;
        font-family: cursive;
        font-size: 15px;
        border: 1px solid white;
        margin-bottom: 10px;
       }

       .header_content input[type=submit]:hover{
        background: cornsilk;
        color:rgb(255, 94, 0);
        transition: 0.4s;
        font-size: 16px;
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
 table{

     color: rgb(176, 173, 173);
     margin-bottom: 10px;
     margin-left: 69px;
 }
 td{

        padding-bottom: 8px;  
        text-align: left;
        padding-left: 9px;
 }
 th
 {
  text-align: left;

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
    <li><a href="Std_home.jsp"><i class="fas fa-home"></i> Home</a></li>
    <li><a href="Std_skill_panel.jsp"><i class="fas fa-tools"></i>Skill Panel</a></li>
    <li><a href="Std_select_proj.jsp"><i class="fas fa-users"></i>  Projct Panel</a></li>
    <li><a href="UppassSTd.jsp"><i class="fas fa-user-shield"></i>Reset Password</a></li>
    <li><a href="Slogout"><i class="fas fa-sign-out-alt"></i>  Log Out</a></li>
  </ul>
</div>
 <section>


    <div class="header_content">
            
        
 
            <div class="card">
                <h1>Update Profile</h1>
<%

con=Dbcon.setCon("Std_update_pro.jsp");
String sql =new String("select * from student where roll=?");
PreparedStatement ps=con.prepareStatement(sql);
ps.setString(1,usr);
 rs=ps.executeQuery();
 if(rs.next())
 {
	  first_name=rs.getString("first_name");
	  last_name=rs.getString("last_name");
	  dob=rs.getString("dob");
	  sex=rs.getString("sex");
	  sem=rs.getString("sem");
	  email=rs.getString("email");
	  mobile=rs.getString("mobile");
	  
	 
 }
 Dbcon.closeCon("Std_update_pro.jsp"); 
%>

	          <form action="Std_update" method="post">
                <img src="<%=Dbcon.imgLoc(usr) %>" alt="<%= usr%>"/>
                <table> 
                  <tr><th>Roll No.</th><td><input type="hidden" name="roll" value="<%=usr%>"><%=usr%></td></tr>
                    <tr><th>Name</th><td><input type="text" pattern="[A-Za-z]{2,30}" required  title="2 or 30 character.Do Not Use Digits & Space" name="name" value="<%=first_name%>"></td></tr>
                    <tr><th>Last_name</th><td><input   type="text" name="last_name" pattern="[A-Za-z]{2,30}" required  title="2 or 30 character.Do Not Use Digits & Space" value="<%=last_name%>"></td></tr>
                    <tr><th>Gender</th><td><input type="radio" name="sex" value="m" <% if(sex.equals("m")){ %> checked="checked"<% } %> > Male<input type="radio" name="sex" value="f" <% if(sex.equals("f")) { %> checked="checked" <% } %> >  Female</td></tr>
                    <tr><th>Dob</th><td><input type="date" name="dob" value="<%=dob%>"></td></tr>
                    <tr><th>Semester</th><td>
                      <select name="semester" required="required" title="plsease select a valid semester">
                        <option value="" disabled selected hidden="hidden">Semester</option>
                        <option value="1" <% if(sem.equals("1")){ %> selected <% } %>>I semester</option>
                        <option value="2"<% if(sem.equals("2")){ %> selected <% } %>>II semester</option>
                        <option value="3"<% if(sem.equals("3")){ %> selected <% } %>>III semester</option>
                        <option value="4"<% if(sem.equals("4")){ %> selected <% } %>>IV semester</option>
                        <option value="5"<% if(sem.equals("5")){ %> selected <% } %>>V semester</option>
                        <option value="6"<% if(sem.equals("6")){ %> selected <% } %>>VI semester</option>
                        <option value="7"<% if(sem.equals("7")){ %> selected <% } %>>VII semester</option>
                        <option value="8"<% if(sem.equals("8")){ %> selected <% } %>>VIII semester</option>
                      </select></td></tr>
                    <tr><th>Mobile</th><td><input type="text" name="mobile" value="<%= mobile %>"></td></tr>
                </table>
               <input type="submit" value="Update Profile "> 
              </form>
                
    <form method="post" ACTION="UploadFile.jsp" name="uploadForm" ENCTYPE='multipart/form-data'>
    
    <table> 
                    <tr><th>Profile Photo</th><td><input type="file" name="uploadForm" required  accept="image/*" ></td></tr>
    </table>
                <input type="submit" value="Update profile image "> 
              </form>
            </div>
    </div>


 </section>

  </body>
</html>