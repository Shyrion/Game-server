<%-- 
    Document   : game
    Created on : 22 mai 2011, 14:55:10
    Author     : Alexandre Bourdin & Jeremy Gabriele
--%>

<%@page import="javax.jms.MessageProducer"%>
<%@page import="javax.jms.TextMessage"%>
<%@page import="javax.jms.Connection"%>
<%@page import="javax.jms.Session"%>
<%@page import="javax.jms.Topic"%>
<%@page import="javax.jms.ConnectionFactory"%>
<%@page import="games.PFCLocal"%>
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
        <title>Game</title>
    </head>
    <body>
        
        <h1>Rock / Paper / Scissors :</h1>
        
        <form method="post">
            <input type="radio" name="userChoice" checked="checked" id="rock" value="rock" />
                <label for="rock">Rock</label>
            <input type="radio" name="userChoice" id="paper" value="paper" />
                <label for="paper">Paper</label>
            <input type="radio" name="userChoice" id="scissors" value="scissors" />
                <label for="scissors">Scissors</label>
            <input type="submit" value="Play"/>
        </form>
        
        <%
            try {
                
                String choice = request.getParameter("userChoice");
                PFCLocal pfc;
                
                if (session.getAttribute("sessionBean") == null) {
                    
                    InitialContext ic = new InitialContext();
                    Object o = ic.lookup("java:global/Game_server/Game_server-ejb/PFC!games.PFCLocal");
                    pfc = (PFCLocal) o;
                    
                    session.setAttribute("sessionBean", pfc);
                    
                } else {
                    pfc = (PFCLocal) session.getAttribute("sessionBean");
                }
                
                int choiceValue = pfc.stringToValue(choice);
                
                if (pfc.fight(choiceValue)){
                    %>
                    <p>You won the round.</p>
                    <%
                } else {
                    %>
                    <p>You lost the round.</p>
                    <%
                }
                
                if (!pfc.finished()) {
                %>
                
                <p>Score actuel : <%=pfc.getNbVictories()%> / 
                    <%=pfc.getNbGames()-pfc.getNbVictories()%></p>
                <p><%=pfc.nbRemainingGames()%> games remaining.</p>
                
                <%
               } else {
                    if(pfc.winner()){
                        %>
                            <p>You won the game !</p>
                            <p>
                                Back to the <a href="/Game_server-war/club.jsp">club</a>.
                            </p>
                        <%
                    } else {
                        %>
                            <p>You lost the game</p>
                            <p>
                                Back to the <a href="/Game_server-war/club.jsp">club</a>.
                            </p>
                        <%
                    }
                    session.setAttribute("sessionBean", null);
                    session.setAttribute("FTDisplay", null);
                    
                    textMessage = jmsSession.createTextMessage();
                    textMessage.setText("updateScore");

                    messageProducer.send(textMessage);
               }

            } catch (javax.ejb.NoSuchEJBException e) { // L'EJB qui etait dans la session a ete removed
                session.setAttribute("sessionBean", null);
                %>
                    <script>window.location.reload()</script>
                <%
            }
            
            catch(Exception e) {
                e.printStackTrace();
            }
        %>

            <hr>
            [<a href="/Game_server-war">Home</a>]
    </body>
</html>
