<%-- 
    Document   : login
    Created on : 3 mai 2011, 21:35:05
    Author     : Alexandre Bourdin & Jeremy Gabriele
--%>

<%@page import="javax.annotation.Resource"%>
<%@page import="javax.jms.TextMessage"%>
<%@page import="javax.jms.MessageProducer"%>
<%@page import="javax.jms.Session"%>
<%@page import="javax.jms.Connection"%>
<%@page import="javax.jms.Topic"%>
<%@page import="javax.jms.ConnectionFactory"%>
<%@page import="persistence.Gamer"%>
<%@page import="partie.PartieSessionRemote"%>
<%@page import="partie.PartieSession"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%!

    //@Resource(mappedName = "jms/ConnectionFactory")
    private static ConnectionFactory connectionFactory;
    //@Resource(mappedName = "jms/Topic")
    private static Topic topic;

    Connection connection = null;
    Session jmsSession = null;
    MessageProducer messageProducer = null;
    TextMessage textMessage = null;

   public void jspInit(){
        try {

            InitialContext ic = new InitialContext();
            connectionFactory = (ConnectionFactory) ic.lookup("jms/ConnectionFactory"); // Lookup fail !!!
            topic = (Topic) ic.lookup("jms/Topic");

            connection = connectionFactory.createConnection();
            jmsSession = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
            messageProducer = jmsSession.createProducer(topic);

        } catch(Exception e) {
            e.printStackTrace();
            System.out.println("JMS failure: " + e.toString()); 
        }
   }
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        
        <script type="text/javascript">
            function openWindows() {
                window.open("index.jsp","","height=250,\n\
                width=400,status=no,location=no,\n\
                toolbar=no,directories=no,menubar=no");
            }
        </script>

        
        <h1>Login :</h1>
        
        <form method="post">
            <table>
                <tr>
                    <td><label for="login">Login</label></td>
                    <td><input type="text" name="login"/></td>
                </tr>

                <tr>
                <td><label for="pwd">Password</label></td>
                <td><input type="password" name="pwd"/></td>
                </tr>
            </table>
            <input type="submit" value="Log-in"/>
        </form>
        

            
        <%

        String login = request.getParameter("login");
        String pwd = request.getParameter("pwd");

        if (login != null && !login.equals("")) {
            try {

                InitialContext ic = new InitialContext();

                Object o = ic.lookup("java:global/Game_server/Game_server-ejb/PartieSession!partie.PartieSessionRemote");
                PartieSessionRemote partieSession = (PartieSessionRemote) o;
                //Gamer gamer = partieSession.findGamerByLoginAndPassword(login, pwd);
                
                %>
                <%=topic%>
                <%
                
                textMessage = jmsSession.createTextMessage();
                textMessage.setStringProperty("gamerLogIn", "3");
                textMessage.setText("Lool");
                
                messageProducer.send(textMessage);

            } catch(Exception e) {
                e.printStackTrace();
                out.println("Login Failed : " + e.toString()); 
            } 
        }
        %>

            <hr>
            [<a href="/Game_server-war">Home</a>]
    </body>
</html>
