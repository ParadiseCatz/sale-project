/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "Register", urlPatterns = {"/Register"})
public class Register extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Register</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Register at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    
    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String FullName=request.getParameter("fullname");
        String UserName=request.getParameter("username");
        String Email=request.getParameter("email");
        String Password=request.getParameter("password");
        String ConfirmPassword=request.getParameter("confirmpassword");
        String FullAddress=request.getParameter("fulladdress");
        String PostalCode=request.getParameter("postalcode");
        String PhoneNumber=request.getParameter("phonenumber");
        try {
            Statement stmt = AppDatabase.getConnection().createStatement();
        } catch (SQLException ex) {
            Logger.getLogger(Register.class.getName()).log(Level.SEVERE, null, ex);
        }
        String sql;
        boolean isExist = false;
        sql="SELECT username,email FROM login WHERE username = '" + UserName + "' OR email= '" + Email + "' ";
        try {
            PreparedStatement pstmt2 = AppDatabase.getConnection().prepareStatement(sql);
            ResultSet result=pstmt2.executeQuery();
            if (!result.isBeforeFirst()){
                isExist=false;
            }
            else
            {
                isExist=true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Register.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (isExist){
            response.sendError(HttpServletResponse.SC_NOT_ACCEPTABLE, "Username atau Email telah ada!");
        }
        else
        {
            try {
                //sql="INSERT into data_pelanggan VALUES("+UserName+","+Email+","+Password+","+FullName+","+FullAddress+","+
                //      PostalCode+","+PhoneNumber+",NULL)";
                PreparedStatement pstmt = AppDatabase.getConnection().
                        prepareStatement("INSERT INTO data_pelanggan VALUES (?,?,?,?,?,?,?,NULL)");
                pstmt.setString(1, UserName);
                pstmt.setString(2, Email);
                pstmt.setString(3, Password);
                pstmt.setString(4, FullName);
                pstmt.setString(5, FullAddress);
                pstmt.setInt(6, Integer.parseInt(PostalCode));
                pstmt.setLong(7, Long.parseLong(PhoneNumber));
                pstmt.executeUpdate();
                pstmt = AppDatabase.getConnection().
                        prepareStatement("INSERT INTO login VALUES (?,?,?,NULL)");
                pstmt.setString(1, Email);
                pstmt.setString(2, UserName);
                pstmt.setString(3, Password);
                pstmt.executeUpdate();
                AppDatabase.getConnection().commit();
            } catch (SQLException ex) {
                Logger.getLogger(Register.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                Integer id = Auth.authenticate(UserName, Password);
                if (id != null) {
                    JSONObject obj = new JSONObject();
                    obj.put("token", Auth.addSession(id));
                    obj.put("session_age", AppConfig.get("expired_time"));
                    obj.put("status", "ok");
                    response.getWriter().write(obj.toString());
                } else {
                    response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Wrong Email or Password !");
                }
                //out.println(buatToken());
            } catch (SQLException ex) {
                Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, ex.getSQLState());
            }
        }
        
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
