/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Market;

import javax.xml.bind.annotation.XmlElement;

/**
 *
 * @author ASUS
 */
class Produk {
    @XmlElement(name="id", required=true)
    private int id;
    
    @XmlElement(name="idPenjual", required=true)
    private int idPenjual;
    
    @XmlElement(name="username", required=true)
    private String username;
    
    @XmlElement(name="namaBarang", required=true)
    private String namaBarang;
    
    @XmlElement(name="harga", required=true)
    private long harga;
    
    @XmlElement(name="deskripsi", required=true)
    private String deskripsi;
    
    @XmlElement(name="namaFoto", required=true)
    private String namaFoto;
    
    @XmlElement(name="waktuDitambahkan", required=true)
    private String waktuDitambahkan;
    
    @XmlElement(name="jumlahLike", required=true)
    private int jumlahLike;
    
    @XmlElement(name="jumlahBeli", required=true)
    private int jumlahBeli;
    
    public Produk(){
        this.id=0;
        this.idPenjual=0;
        this.username=" ";
        this.namaBarang=" ";
        this.harga=0;
        this.deskripsi=" ";
        this.namaFoto=" ";
        this.waktuDitambahkan=" ";
        this.jumlahLike=0;
        this.jumlahBeli=0;
    }
    public Produk (int id, int idPenjual, String username,String namaBarang, long harga,
    String deskripsi, String namaFoto, String waktuDitambahkan, int jumlahLike, int jumlahBeli){
        this.id=id;
        this.idPenjual=idPenjual;
        this.username=username;
        this.namaBarang=namaBarang;
        this.harga=harga;
        this.deskripsi=deskripsi;
        this.namaFoto=namaFoto;
        this.waktuDitambahkan=waktuDitambahkan;
        this.jumlahLike=jumlahLike;
        this.jumlahBeli=jumlahBeli;
    }
}
