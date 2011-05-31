<%-- 
    Document   : club
    Created on : 21 mai 2011, 18:25:57
    Author     : Alexandre Bourdin & Jeremy Gabriele
--%>

<%@page import="javax.jms.Message"%>
<%@page import="javax.jms.JMSException"%>
<%@page import="javax.jms.MessageListener"%>
<%@page import="partie.PartieSessionLocal"%>
<%@page import="java.util.List"%>
<%@page import="javax.jms.MessageConsumer"%>
<%@page import="javax.jms.TextMessage"%>
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

    Boolean firstTime;

    //@Resource(mappedName = "jms/ConnectionFactory")
    ConnectionFactory connectionFactory;
    //@Resource(mappedName = "jms/Topic")
    Topic topic;

    Connection connection = null;
    Session jmsSession = null;
    MessageConsumer messageConsumer = null;
    TextMessage textMessage = null;

   public void jspInit(){
        try {

            InitialContext ic = new InitialContext();
            connectionFactory = (ConnectionFactory) ic.lookup("jms/ConnectionFactory");
            topic = (Topic) ic.lookup("jms/Topic");

            connection = connectionFactory.createConnection();
            jmsSession = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
            messageConsumer = jmsSession.createConsumer(topic);
            
            
            connection.start();

        } catch(Exception e) {
            e.printStackTrace();
            System.out.println("JMS failure: " + e.toString()); 
        }
   }
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Club</title>
    </head>
    <body>
        
        <h1>List of logged-in players :</h1>
        
        <%
            if (session.getAttribute("logged") == null) {
        %>
        
        <p>You are not logged-in. Please <a href="login.jsp">log-in</a> first.</p>
        
        <%
           } else {
        
                if (session.getAttribute("FTDisplay") == null) {
                    firstTime = true;
                    session.setAttribute("FTDisplay", firstTime);
                } else {
                    firstTime = (Boolean) session.getAttribute("FTDisplay");
                }

                try {

                    if (firstTime) {
                        firstTime = false;
                        session.setAttribute("FTDisplay", firstTime);
                    } else {
                        textMessage = (TextMessage) messageConsumer.receive();
                        String msg = textMessage.getText();
                        if (msg.equals("updateScore")) {
                            %><p>On vient d'update le score</p><%
                        } else {
                        %><p><%=msg%> est le dernier à avoir rejoint le club.</p><%
                       }
                        // On pourrait traiter le message mais ce qui nous interesse
                        // est juste un "signal" d'update.
                   }

                    InitialContext ic = new InitialContext();
                    Object o = ic.lookup("java:global/Game_server/Game_server-ejb/PartieSession!partie.PartieSessionLocal");
                    PartieSessionLocal partieSession = (PartieSessionLocal) o;

                    //List<Gamer> res = null;
                    //res = partieSession.findAllConnectedGamers();

                    // On affiche les joueurs connectes :
                    //for(int i=0; i<res.size(); i++){

                        %>
                        <p><%--=//res.get(i).getLogin()%>, <%=//res.get(i).getScore()--%></p>
                        <%
                   //}
                        %>
                    <!-- Le bouton pour jouer -->
                    <form method="post" action="game.jsp">
                        <input type="submit" value="Play" />
                    </form>

                    <!-- reload de la page, pour retourner dans le receive()-->
                    <script>document.location.href="club.jsp"</script>

                    <%

                } catch(Exception e) {
                    out.println("Display gamer failure: " + e.toString()); 
                }
           }
        %>

            <hr>
            [<a href="/Game_server-war">Home</a>]
    </body>
</html>
