<%-- 
    Document   : login
    Created on : 3 mai 2011, 21:35:05
    Author     : Alexandre Bourdin & Jeremy Gabriele
--%>

<%@page import="partie.PartieSessionLocal"%>
<%@page import="javax.annotation.Resource"%>
<%@page import="javax.jms.TextMessage"%>
<%@page import="javax.jms.MessageProducer"%>
<%@page import="javax.jms.Session"%>
<%@page import="javax.jms.Connection"%>
<%@page import="javax.jms.Topic"%>
<%@page import="javax.jms.ConnectionFactory"%>
<%@page import="persistence.Gamer"%>
<%@page import="partie.PartieSession"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%!

    private static ConnectionFactory connectionFactory;
    private static Topic topic;

    Connection connection = null;
    Session jmsSession = null;
    MessageProducer messageProducer = null;
    TextMessage textMessage = null;

   public void jspInit(){
        try {

            InitialContext ic = new InitialContext();
            connectionFactory = (ConnectionFactory) ic.lookup("jms/ConnectionFactory");
            topic = (Topic) ic.lookup("jms/Topic");
            

            connection = connectionFactory.createConnection();
            jmsSession = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
            messageProducer = jmsSession.createProducer((Topic) topic);

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
                window.open("club.jsp","","height=5000,\n\
                width=400,status=no,location=no,\n\
                toolbar=no,directories=no,menubar=no");
            }
        </script>
        
        
        <h1>Login page :</h1>
        
        <%
            if (session.getAttribute("logged") == null) {
        %>
        
        <form method="post" onsubmit=openWindows()>
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
           } else {
                %>
                <a href="logout.jsp">logout</a>
                <%
           }

        String login = request.getParameter("login");
        String pwd = request.getParameter("pwd");

        if (login != null && !login.equals("")) {
            try {

                InitialContext ic = new InitialContext();

                Object o = ic.lookup("java:global/Game_server/Game_server-ejb/PartieSession!partie.PartieSessionLocal");
                PartieSessionLocal partieSession = (PartieSessionLocal) o;
                //Gamer gamer = partieSession.findGamerByLoginAndPassword(login, pwd);
                
                session.setAttribute("FTDisplay", null);
                session.setAttribute("logged", true);
                session.setAttribute("name", login);
                
                textMessage = jmsSession.createTextMessage();
                textMessage.setText(login);
                
                messageProducer.send(textMessage);
                
                %>
                
                <script>document.location.href="login.jsp"</script>
                
                <%

            } catch(Exception e) {
                e.printStackTrace();
                out.println("Login Failed : " + e.toString() + " >> " + e.getCause()); 
            }
        }
        %>

            <hr>
            [<a href="/Game_server-war">Home</a>]
    </body>
</html>
