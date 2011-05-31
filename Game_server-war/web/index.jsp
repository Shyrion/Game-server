<%-- 
    Document   : index
    Created on : 28 avr. 2011, 12:10:24
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
            // Si l'user n'est pas deja log :
            if (session.getAttribute("logged") == null){
        %>
        
        <h1>Welcome to our Game server Webpage !</h1>
        
        <p>Please do not forget to <a href="login.jsp">login</a> first, or
            <a href="register.jsp">register</a> if you didn't do it yet.

        <%
           } else {
                session.setAttribute("FTDisplay", null);
        %>
        
        <p>Hello <%=session.getAttribute("name")%>, feel free to have a look at
            the <a href="club.jsp">club</a> page, or <a href="login.jsp">logout</a>.
            
        <%
           }
        %>

    </body>
</html>
