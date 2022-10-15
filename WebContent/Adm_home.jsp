<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
   <!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>SSSM | Admin Home</title>
    <link rel="stylesheet" href="style/style.css">
    <script src="fontawesome/js/all.js"></script>
  <style>
    .header_content
    {
        text-transform: uppercase;
        width: 450px;
        height: auto;
        position: relative;
        top: 50%;
        left: 50%;
        color: rgba(255,255,255,0.8);
        transform: translate(-50% ,-50%);
        font-family: cursive ;
        background: rgba(0,0,0,0.8);
        padding-bottom: 25px;
    }
.header_content h2 
{
    text-align: center;
    padding-top :20px;
    padding-bottom :20px;

}
.header_content table
{
    margin-left: 75px;

}
.header_content a

{
    display: block;
  background: linear-gradient(to right, #25c481, #25b7c4);
  margin: 9px;
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
    <header>Admin Home</header>
  <ul>
    <li><a href="Adm_home.jsp"><i class="fas fa-qrcode"></i> Dashboard</a></li>
    <li><a href="Adm_std_service.jsp"><i class="fas fa-user-graduate"></i>  Student Control</a></li>
    <li><a href="Adm_show_tea.jsp"><i class="fas fa-user-cog"></i>  Faculty Control</a></li>
    <li><a href="Adm_mng_pro.jsp"><i class="fas fa-tools"></i> Project Control</a></li>
    <li><a href="Adm_add_skill.jsp"><i class="far fa-sun"></i> Skill Control</a></li>
    <li><a href="Slogout"><i class="fas fa-power-off"></i>  logout</a></li>
  </ul>
</div> 
    
    
    
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

 usr =(String)session.getAttribute("usr");
%> <section>


  <div class="header_content">

          <h2>Control</h2>
        <table>
            <tr>
                <td> <h2><a href="Adm_std_service.jsp" >Student</a></h2> </td>
                <td><h2><a  href="Adm_show_tea.jsp">Faculty</a></h2></td>
            </tr>
        </table>
 </div>
 </section>

  </body>
</html>
