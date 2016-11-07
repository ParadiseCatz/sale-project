/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MarketplaceService;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;

/**
 *
 * @author ASUS
 */
@WebService(serviceName = "Marketplace")
public class Marketplace {

    public static Connection getConnection(){
        //membuka koneksi ke database marketplace
        Connection conn = null;
        String URL="jdbc:mysql://localhost:3306/iton_marketplace";
        String USER="root";
        String PASS="";
        try {
            conn=DriverManager.getConnection(URL, USER, PASS);
        } catch (SQLException ex) {
            Logger.getLogger(Marketplace.class.getName()).log(Level.SEVERE, null, ex);
        }
        return conn;
    }
    
    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "hello")
    public String hello(@WebParam(name = "name") String txt) {
        return "Hello " + txt + " !";
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "getCatalog")
    @WebResult(name="Produk")
    public ArrayList<Produk> getCatalog(@WebParam(name = "userID") String userID) {
        //TODO write your implementation code here:
        return null;
    }
}
