package Db;
import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Dbcon {

	private static Connection con;
	private static PreparedStatement ps;
	private static String sql;
	private static ResultSet rs;
	public static Connection setCon(String file) throws Exception
	 {
			 
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3307/sssm","root","root");
			System.out.println("Conection Established for ---> "+file);
			return con;
			
	 }
	 
	public static void closeCon(String file) throws Exception
	 {
			con.close();
			System.out.println("Connection Closed for <--- "+file);
	 }
	public static String removeLastCharacter(String str) {
		   String result = null;
		   if ((str != null) && (str.length() > 0)) {
		      result = str.substring(0, str.length() - 1);
		   }
		   return result;
		}
	public static String[] checkProjectAssignRoll(String sem,String roll,String file)throws Exception
	{
		String[] pr = new String[countRollPresentProject(sem, roll,file)];
		int co=0;
		con=Dbcon.setCon(file);
	    sql="select * from project where sem=?";
	    ps=con.prepareStatement(sql);
	   	ps.setString(1, sem);
	   	rs = ps.executeQuery();
	   	if(rs.next()){
	   		do
			{
				String st=rs.getString("students");
	   			String nam=rs.getString("project_name");
	   			if(st.contains(roll)) {
	   				pr[co]=nam;
	   				co++;
	   				//System.out.println(nam);
	   			} 
	 	 }while(rs.next());   	
	   	}
	   	Dbcon.closeCon(file);
	   	return pr ;
	   	
	}
	
	public static  int countRollPresentProject(String sem,String roll, String file)throws Exception
	{
		int n=0;
		
		con=Dbcon.setCon(file);
	    sql="select * from project where sem=?";
	    ps=con.prepareStatement(sql);
	   	ps.setString(1, sem);
	   	rs = ps.executeQuery();
	   	if(rs.next()){
	   		do
			{
				String st=rs.getString("students");
	   			if(st.contains(roll)) {
	   				n++;
	   			} 
	 	 }while(rs.next());   	
	   	}
	   	Dbcon.closeCon(file);
		
		return n;
	}
	
	public static String getSkill(String roll,String file) throws Exception
	{
		String skill="No Data Available";
		con=Dbcon.setCon(file);
	    sql="select * from student_skill where roll=?";
	    ps=con.prepareStatement(sql);
	   	ps.setString(1,roll);
	   	rs = ps.executeQuery();
	   	if(rs.next()){
	   		do
			{
				 skill=rs.getString("skill_name");
	   		
	 	 }while(rs.next());   	
	   	}
	   	Dbcon.closeCon(file);
		
		
		return skill;
	}
	
	
	public static String imgLoc(String usr)throws Exception 
	{
		//change this location to your workspace
		String loc="C:\\Users\\Nihal\\eclipse-workspace\\";
		
		//Dont change here
		
		loc+=".metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\sssm\\USR\\";
		
		File temp = new File(loc+usr+".jpg");
		if(temp.exists())
		{
			System.out.println(usr+".jpg   ---------> " +"profile photo exist");
			return "USR\\"+usr+".jpg";
			
		}
		else {
			System.out.println("badge.png  --------->"+"profile photo not-exist");
			return "USR\\"+"badge.png";
		}
		
	}
	
	public static String capitalize(String str)
	{
		if(str==null||str.isEmpty())
		{
			return str;
		}
		return  str.substring(0,1).toUpperCase()+str.substring(1);
	}
	
		
}