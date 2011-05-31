<%-- 
    Document   : logout
    Created on : 31 mai 2011, 17:02:26
    Author     : Alexandre Bourdin & Jeremy Gabriele
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Game Server</title>
    </head>
    <body>
        
        <%
            session.setAttribute("logged", null);
            session.setAttribute("name", null);
        %>
        
        <p>You are now logged off.</p>
        
        <script>document.location.href="index.jsp"</script>

        <hr>
        [<a href="/Game_server-war">Home</a>]

    </body>
</html>
