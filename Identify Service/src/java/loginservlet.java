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
import java.util.*;
import java.sql.*;
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
        if(autentikasi(email,pass)){
            JSONObject obj = new JSONObject();
            //buat token secara random
            String token = buatToken();
            obj.put("token", token);
            Date expire = buatExpireTime();
            obj.put("expirytime", expire.toString());
            obj.put("status", "ok");
            out.print(obj);
            response.getWriter().write(obj.toString());
        }
        else{
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Wrong Email or Password !");
        }
        //out.println(buatToken());
    }

    //akses database untuk mengecek (belum di implementasi)
    public boolean autentikasi(String username, String password) {
        
        
        
        /*
        if(username.equals("root") && password.equals("root")){
            return true;
        }
        else{
            return false;
        }
        */
        return true;
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
