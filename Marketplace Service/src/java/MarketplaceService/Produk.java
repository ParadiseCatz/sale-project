/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MarketplaceService;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author ASUS
 */

@XmlRootElement(name="Produk")
//Class untuk output produk pada catalog
class Produk {
    @XmlElement(name="id", required=true)
    private int id;
    
    @XmlElement(name="idPenjual", required=true)
    private int idPenjual;
}
