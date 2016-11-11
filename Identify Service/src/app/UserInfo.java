package app;

import org.json.simple.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Created by anthony on 11/11/16.
 */
public class UserInfo extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String token = request.getParameter("token");
        try {
            Integer id = null;
            if (token != null) {
                id = Auth.authenticate(token);
            } else {
                String userId = request.getParameter("user_id");
                if (userId != null) {
                    id = Integer.valueOf(userId);
                } else {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Bad Request!");
                }
            }
            if (id != null) {
                JSONObject obj = new JSONObject();
                PreparedStatement pstmt = AppDatabase.getConnection().
                        prepareStatement("SELECT username, full_name " +
                                "FROM `data_pelanggan` " +
                                "WHERE id=?;");
                pstmt.setInt(1, id);
                ResultSet resultSet = pstmt.executeQuery();
                obj.put("user_id", id);
                obj.put("username", resultSet.getString("username"));
                obj.put("full_name", resultSet.getString("full_name"));
                obj.put("session_age", AppConfig.get("expired_time"));
                obj.put("status", "ok");
                response.getWriter().write(obj.toString());
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "User Info not found!");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Authenticate User";
    }// </editor-fold>
}
