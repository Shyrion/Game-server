<%-- 
    Document   : login
    Created on : 3 mai 2011, 21:35:05
    Author     : Alexandre Bourdin & Jeremy Gabriele
--%>

<%@page import="persistence.Gamer"%>
<%@page import="partie.PartieSessionRemote"%>
<%@page import="javax.naming.InitialContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        
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
                    
                    Gamer gamer = new Gamer(login, pwd);
                    partieSession.persist(gamer);
            %>
            <p>
                A new gamer has been added : 
                <%=gamer.getLogin()%>.
            </p>
            <%
                } catch(Exception e) {
                    e.printStackTrace();
                    out.println("Create Gamer Failed : " + e.toString()); 
                } 
            }
            %>

            <hr>
            [<a href="/Game_server-war">Home</a>]
    </body>
</html>
