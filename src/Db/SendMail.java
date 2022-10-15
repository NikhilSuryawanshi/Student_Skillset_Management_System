package Db;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;
import java.util.Random;

public class SendMail{
	
	    static char[] rand_Password(int len) 
	    { 
	        //System.out.println("Generating password using random() : "); 
	        //System.out.print("Your new password is : "); 
	        String Capital_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"; 
	        String Small_chars = "abcdefghijklmnopqrstuvwxyz"; 
	        String numbers = "0123456789"; 
	        String values = Capital_chars + Small_chars + numbers; 
	        Random rndm_method = new Random(); 
	        char[] password = new char[len];
	        for (int i = 0; i < len; i++) 
	        {
	            password[i]=values.charAt(rndm_method.nextInt(values.length()));
	        } 
	        return password; 
	    }     
    public static String mail(String usr,String reciptant) throws Exception{
    	String t=new String(rand_Password(8));
        final String username = "akashbarange14@gmail.com";
        final String password = "Zxcvbnmm@2003";
        Properties prop = new Properties();
		prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "587");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true"); //TLS
        
        Session session = Session.getInstance(prop,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO,InternetAddress.parse(reciptant));
            message.setSubject("Your Temporary Password-");
            message.setText("Dear "+usr+"\n Your 8 digit Password is: "+t+"  . Use it to access your SSSM account.\n Use this Password to login into your account and change this temporary Password to your new once!\n \n Yours,\nThe SSSM Team.");
            Transport.send(message);
            System.out.println("Mail Sent!");
        return t;
    }
  /* public static void main(String ar[])
    {
    	SendMail s=new SendMail();
    	try {
			System.out.println(s.mail("Yash","yashbarange14@gmail.com"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
*/
}