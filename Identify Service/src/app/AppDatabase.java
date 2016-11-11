package app;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Created by anthony on 11/11/16.
 */
public class AppDatabase {

    private static Connection conn = initConnection();


    private static Connection initConnection() {
        Connection conn;
        try {
            //membuka koneksi ke database marketplace
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(AppConfig.get("db_url"), AppConfig.get("db_user"), AppConfig.get("db_pass"));
            return conn;
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static Connection getConnection() {
        return conn;
    }
}
