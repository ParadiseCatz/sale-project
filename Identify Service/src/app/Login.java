package app;/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import org.json.simple.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Joshua
 */
public class Login extends HttpServlet {

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
//        response.setContentType("application/json;charset=UTF-8");
//        try (PrintWriter out = response.getWriter()) {
//            //TODO Delete Debug
//            //test token
//            out.println(buatToken());
//            Date expire = buatExpireTime();
//            out.println(expire.toString());
//            String sql2;
//            String username = "root";
//            String password = "root";
//            sql2 = "SELECT id FROM `login` WHERE (username = \"" +username+ "\" " + "OR email= \"" + username + "\") " + "AND password = \"" +password +"\";" ;
//            out.println(sql2);
//            Statement stmt;
//            try {
//                stmt = AppDatabase.getConnection().createStatement();
//                ResultSet rs = stmt.executeQuery(sql2);
//                int jumlah = 0 ;
//                // Extract data from result set
//                while(rs.next()){
//                    ++jumlah;
//                }
//                out.println(jumlah);
//            } catch (SQLException ex) {
//                Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
//                ex.printStackTrace();
//            }
//
//
//        }
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
            Integer id = Auth.authenticate(email, pass);
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
