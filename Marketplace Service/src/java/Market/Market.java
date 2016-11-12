/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Market;


import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author ASUS
 */
@WebService(serviceName = "Market")
public class Market {
    
    //Connect to database
    Connection conn=getConnection();
    
    public static Connection getConnection(){
        //membuka koneksi ke database marketplace
        Connection conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn=DriverManager.getConnection(AppConfig.get("db_url"), AppConfig.get("db_user"), AppConfig.get("db_password"));
        } catch (SQLException ex) {
            Logger.getLogger(Market.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Market.class.getName()).log(Level.SEVERE, null, ex);
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
     * @param userID
     * @param searchType
     * @param searchKey
     */
    @WebMethod(operationName = "listCatalog")
    @WebResult(name="Produk")
    public ArrayList<Produk> listCatalog(@WebParam(name = "userID") int userID,
            @WebParam(name = "searchType") String searchType,
            @WebParam(name = "searchKey") String searchKey){
        //TODO write your implementation code here:
        //TODO write your implementation code here:
        //TODO write your implementation code here:
        ArrayList<Produk> daftarCatalog=new ArrayList<Produk>();
        try {
            Statement sqlStatement=conn.createStatement();
        } catch (SQLException ex) {
            Logger.getLogger(Market.class.getName()).log(Level.SEVERE, null, ex);
        }
        String query = null;
        if (searchKey==null){
            query="SELECT * FROM barang where id_penjual<>? ORDER BY waktu_ditambahkan DESC";
        }
        else
        {
            if ("product".equals(searchType)){
                query="SELECT * FROM barang where id_penjual<>? AND nama_barang LIKE '%"+searchKey+
                        "%' ORDER BY waktu_ditambahkan DESC";	
            }
            else
            {
                query="SELECT * FROM barang where id_penjual<>? AND username LIKE '%"+searchKey+"%' "
                        + "ORDER BY waktu_ditambahkan DESC";	
            }
        }
        PreparedStatement dbStatement = null;
        try {
            dbStatement = conn.prepareStatement(query);
            dbStatement.setInt(1, userID);
        } catch (SQLException ex) {
            Logger.getLogger(Market.class.getName()).log(Level.SEVERE, null, ex);
        }
        ResultSet result = null;
        try {
            result = dbStatement.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(Market.class.getName()).log(Level.SEVERE, null, ex);
        }
        int i=0;
        try {
            while (result.next()){
                daftarCatalog.add(new Produk(result.getInt("id"),result.getInt("id_penjual"),
                        result.getString("username"), result.getString("nama_barang"),result.getLong("harga"),
                        result.getString("deskripsi"),result.getString("foto"),result.getString("waktu_ditambahkan"),
                        result.getInt("jumlah_like"),result.getInt("jumlah_dibeli")));
                ++i;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Market.class.getName()).log(Level.SEVERE, null, ex);
        }
        return daftarCatalog;
        
    }

    /**
     * Web service operation
     * @param userid
     * @param username
     * @param nama
     * @param description
     * @param price
     * @param foto
     */
    @WebMethod(operationName = "addProduct")
    public Boolean addProduct(@WebParam(name = "userid") int userid, @WebParam(name = "username") 
            String username, @WebParam(name = "nama") String nama, @WebParam(name = "description")
                    String description, @WebParam(name = "price") String price, @WebParam(name = "foto") String foto) {
        //TODO write your implementation code here:
        if ((nama.isEmpty()) || (description.isEmpty()) || (price.isEmpty()) ||
                (foto.isEmpty()) || (userid==0) || (username.isEmpty())){
            return false;
        }
        else
        {
            try {
                Statement sqlStatement=conn.createStatement();
            } catch (SQLException ex) {
                Logger.getLogger(Market.class.getName()).log(Level.SEVERE, null, ex);
            }
            String query = null;
            query="INSERT INTO barang VALUES (NULL,?,?,?,?,?,?,?,?,?)";
            PreparedStatement dbStatement = null;
            try {
                dbStatement = conn.prepareStatement(query);
                dbStatement.setInt(1, userid);
                dbStatement.setString(2, username);
                dbStatement.setString(3, nama);
                long harga;
                harga=Long.parseLong(price);
                dbStatement.setLong(4, harga);
                dbStatement.setString(5, description);
                dbStatement.setTimestamp(6, new java.sql.Timestamp(new java.util.Date().getTime()));
                dbStatement.setInt(7, 0);
                dbStatement.setInt(8, 0);
                dbStatement.setString(9, foto);
                dbStatement.executeUpdate();
                conn.commit();
                
            } catch (SQLException ex) {
                Logger.getLogger(Market.class.getName()).log(Level.SEVERE, null, ex);
            }
            return true;
        }
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "checkLike")
    public Boolean checkLike(@WebParam(name = "id_user") int id_user, @WebParam(name = "id_barang") int id_barang) {
        //TODO write your implementation code here:
        Boolean isLiked = null;
            try {
                Statement sqlStatement=conn.createStatement();
            } catch (SQLException ex) {
                Logger.getLogger(Market.class.getName()).log(Level.SEVERE, null, ex);
            }
        String query="SELECT * FROM user_liked WHERE id_user = '"+id_user+"' AND id_barang = '"+id_barang+"'";
        PreparedStatement dbStatement = null;
        try {
            dbStatement = conn.prepareStatement(query);
        } catch (SQLException ex) {
            Logger.getLogger(Market.class.getName()).log(Level.SEVERE, null, ex);
        }
        ResultSet result = null;
        try {
            result = dbStatement.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(Market.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        try {
            if (!result.isBeforeFirst()){
                isLiked=false;
            }
            else
            {
                isLiked=true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Market.class.getName()).log(Level.SEVERE, null, ex);
        }
        return isLiked;
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "yourproduct")
    public ArrayList<Produk> yourproduct(@WebParam(name = "idpenjual") int idpenjual)  {
        //TODO write your implementation code here:
        ArrayList<Produk> daftarProduk=new ArrayList<Produk>();     
        Statement stmt = null;
        try {
            stmt = conn.createStatement();
        } catch (SQLException ex) {
            Logger.getLogger(Market.class.getName()).log(Level.SEVERE, null, ex);
        }
        String query ;
        query="SELECT * " +
                "FROM `barang` " +
                "WHERE id_penjual = " + idpenjual + ";";
        ResultSet rs = null;
        try {
            rs = stmt.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Market.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            // Extract data from result set
            while (rs.next()) {
                daftarProduk.add(new Produk(rs.getInt("id"),rs.getInt("id_penjual"),
                        rs.getString("username"), rs.getString("nama_barang"),rs.getLong("harga"),
                        rs.getString("deskripsi"),rs.getString("foto"),rs.getString("waktu_ditambahkan"),
                        rs.getInt("jumlah_like"),rs.getInt("jumlah_dibeli")));                                       
            }
        } catch (SQLException ex) {
            Logger.getLogger(Market.class.getName()).log(Level.SEVERE, null, ex);
        }
        return daftarProduk;
    }
    
    @WebMethod(operationName = "sales")
    public ArrayList<transaction> sales(@WebParam(name = "idpenjual") int idpenjual)  {
        //TODO write your implementation code here:
        ArrayList<transaction> daftarSales=new ArrayList<>();     
        Statement stmt = null;
        try {
            stmt = conn.createStatement();
        } catch (SQLException ex) {
            Logger.getLogger(Market.class.getName()).log(Level.SEVERE, null, ex);
        }
        String query ;
        query="SELECT * " +
                "FROM `transaction` " +
                "WHERE id_penjual = " + idpenjual + ";";
        ResultSet rs = null;
        try {
            rs = stmt.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Market.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            // Extract data from result set
            while (rs.next()) {
                daftarSales.add(new transaction(rs.getInt("id"),rs.getInt("id_pembeli"),
                        rs.getInt("quantity"), rs.getString("cosignee"),rs.getString("full_address"),
                        rs.getInt("postal_code"),rs.getLong("phone_number"),rs.getLong("creditcard_number"),
                        rs.getInt("creditcard_verification"),rs.getString("nama_barang"),rs.getLong("harga_barang"),
                        rs.getString("foto"),rs.getInt("id_penjual"),rs.getDate("waktu_transaksi")));                                       
            }
        } catch (SQLException ex) {
            Logger.getLogger(Market.class.getName()).log(Level.SEVERE, null, ex);
        }
        return daftarSales;
    }
    
}