/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Market;

import java.util.Date;
import javax.xml.bind.annotation.XmlElement;

/**
 *
 * @author Joshua
 */
public class transaction {
    @XmlElement(name="id", required=true)
    private int id;
    
    @XmlElement(name="id_pembeli", required=true)
    private int id_pembeli;
    
    @XmlElement(name="quantity", required=true)
    private int quantity;
    
    @XmlElement(name="cosignee", required=true)
    private String cosignee;
    
    @XmlElement(name="full_address", required=true)
    private String full_address;
    
    @XmlElement(name="postal_code", required=true)
    private int postal_code;
    
    @XmlElement(name="phone_number", required=true)
    private long phone_number;
    
    @XmlElement(name="creditcard_number", required=true)
    private long creditcard_number;
    
    @XmlElement(name="creditcard_verification", required=true)
    private int creditcard_verification;
    
    @XmlElement(name="nama_barang", required=true)
    private String nama_barang;
    
    @XmlElement(name="harga_barang", required=true)
    private long harga_barang;
    
    @XmlElement(name="foto", required=true)
    private String foto;
    
    @XmlElement(name="id_penjual", required=true)
    private int id_penjual;
    
    @XmlElement(name="waktu_transaksi", required=true)
    private String waktu_transaksi;
    
    public transaction (int id, int id_pembeli, int quantity, String cosignee, String full_address,
    int postal_code, long phone_number, long cc_number, int cc_ver, String namabarang, long harga, String foto,
    int id_penjual, String waktu_transaksi){
        this.id=id;
        this.id_pembeli=id_pembeli;
        this.quantity=quantity;
        this.cosignee=cosignee;
        this.full_address=full_address;
        this.postal_code=postal_code;
        this.phone_number=phone_number;
        this.creditcard_number=cc_number;
        this.creditcard_verification=cc_ver;
        this.nama_barang=namabarang;
        this.harga_barang = harga;
        this.foto = foto;
        this.id_penjual = id_penjual;
        this.waktu_transaksi = waktu_transaksi;
    }
}
