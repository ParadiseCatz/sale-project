/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.security.SecureRandom;
import java.math.BigInteger;
import java.util.Date;
import org.json.simple.JSONObject;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
//import java.util.Calendar;

/**
 *
 * @author Joshua
 */
public class loginservlet extends HttpServlet {

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
        response.setContentType("application/json;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            //test token
            out.println(buatToken());
            Date expire = buatExpireTime();
            out.println(expire.toString());
            String sql2;
            String username = "root";
            String password = "root";
            sql2 = "SELECT id FROM `login` WHERE (username = \"" +username+ "\" " + "OR email= \"" + username + "\") " + "AND password = \"" +password +"\";" ;
            out.println(sql2);
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
        //processRequest(request, response);
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();        
        String email = request.getParameter("username");
        String pass = request.getParameter("password");
        try {
            if(autentikasi(email,pass)){
                JSONObject obj = new JSONObject();
                //buat token secara random
                String token = buatToken();
                obj.put("token", token);
                Date expire = buatExpireTime();
                obj.put("expirytime", expire.toString());
                obj.put("status", "ok");
                response.getWriter().write(obj.toString());
            }
            else{
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Wrong Email or Password !");
            }
            //out.println(buatToken());
        } catch (SQLException ex) {
            Logger.getLogger(loginservlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    //akses database untuk mengecek (belum di implementasi)
    public boolean autentikasi(String username, String password) throws SQLException {
        // Execute SQL query
         Statement stmt = conn.createStatement();
         String sql;
         sql = "SELECT id FROM `login` WHERE (username = \"" +username+ "\" " + "OR email = \"" + username + "\") " + "AND password = \"" +password +"\";" ;
         ResultSet rs = stmt.executeQuery(sql);
         int jumlah = 0 ;
         // Extract data from result set
         while(rs.next()){
             ++jumlah;
         }
         rs.close();
         stmt.close();
         conn.close();
         if(jumlah == 1){
             return true;
         }
         else{
             return false;
         }
        //return (username.equals("root")) || (password.equals("root"));
    }
    
    
    Connection conn=getConnection();
    

    public static Connection getConnection(){
        Connection conn = null;
        try {
            //membuka koneksi ke database marketplace
            
            String URL="jdbc:mysql://localhost:3306/iton_account?zeroDateTimeBehavior=convertToNull";
            String USER="root";
            String PASS="";
            Class.forName("com.mysql.jdbc.Driver");
            conn=DriverManager.getConnection(URL, USER, PASS);
            
            
            return conn;
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(loginservlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(loginservlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return conn;
    }
    
    //membuat expire time dari sekarang 
    public Date buatExpireTime(){
        Date now = new Date();
        //expire 1 jam 
        Date expire = new Date(now.getTime() + (1000 * 60 * 60 * 1));
        return expire;
    }
    
    //membuat token
    public String buatToken(){
        SecureRandom random = new SecureRandom();
        return new BigInteger(130, random).toString(32);
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
