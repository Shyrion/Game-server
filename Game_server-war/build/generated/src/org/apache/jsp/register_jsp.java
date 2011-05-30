package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import persistence.Gamer;
import partie.PartieSessionRemote;
import partie.PartieSession;
import javax.naming.InitialContext;

public final class register_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.Vector _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\"\n");
      out.write("   \"http://www.w3.org/TR/html4/loose.dtd\">\n");
      out.write("\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>Register</title>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        \n");
      out.write("        <h1>Register :</h1>\n");
      out.write("        \n");
      out.write("        <form method=\"post\">\n");
      out.write("            <table>\n");
      out.write("                <tr>\n");
      out.write("                    <td><label for=\"login\">Login</label></td>\n");
      out.write("                    <td><input type=\"text\" name=\"login\"/></td>\n");
      out.write("                </tr>\n");
      out.write("\n");
      out.write("                <tr>\n");
      out.write("                <td><label for=\"pwd\">Password</label></td>\n");
      out.write("                <td><input type=\"password\" name=\"pwd\"/></td>\n");
      out.write("                </tr>\n");
      out.write("                \n");
      out.write("                <tr>\n");
      out.write("                <td><label for=\"confirm_pwd\">Confirm password</label></td>\n");
      out.write("                <td><input type=\"password\" name=\"confirm_pwd\"/></td>\n");
      out.write("                </tr>\n");
      out.write("            </table>\n");
      out.write("            <input type=\"submit\" value=\"Log-in\"/>\n");
      out.write("        </form>\n");
      out.write("        \n");
      out.write("        ");

        
            String login = request.getParameter("login");
            String pwd = request.getParameter("pwd");
            String confirm_pwd = request.getParameter("confirm_pwd");
            String err = "";
            
            if (login != null && !login.equals("")){
                if (pwd != null && !pwd.equals("")) {
                    if(confirm_pwd != null && pwd.equals(confirm_pwd)) {
                        try {

                            InitialContext ic = new InitialContext();
                            Object o = ic.lookup("java:global/Game_server/Game_server-ejb/PartieSession!partie.PartieSessionRemote");
                            PartieSessionRemote partieSession = (PartieSessionRemote) o;
                            
      out.write("\n");
      out.write("                            ");
      out.print( o );
      out.write("\n");
      out.write("                            ");

                            Gamer gamer = new Gamer(login, pwd);
                            partieSession.persist(gamer);
                    
      out.write("\n");
      out.write("                    <p>\n");
      out.write("                        A new gamer has been added : \n");
      out.write("                        ");
      out.print(gamer.getLogin());
      out.write(".\n");
      out.write("                    </p>\n");
      out.write("                    ");

                        } catch(Exception e) {
                            e.printStackTrace();
                            out.println("Create Gamer Failed : " + e.toString()); 
                        }
                  } else {
                    err = "The 'Password' and Confirm Password' fields must match.";
                  }
               } else {
                    err = "Please enter a password to protect your account.";
               }
            } else {
                err = "First, enter a login.";
            }
            if (!err.equals("")) {
            
      out.write("\n");
      out.write("            <p>\n");
      out.write("                Error : ");
      out.print(err);
      out.write("\n");
      out.write("            </p>\n");
      out.write("            ");

            }
            
      out.write("\n");
      out.write("\n");
      out.write("            <hr>\n");
      out.write("            [<a href=\"/Game_server-war\">Home</a>]\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
