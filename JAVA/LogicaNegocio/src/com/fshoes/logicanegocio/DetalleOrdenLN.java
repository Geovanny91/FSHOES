/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.logicanegocio;

import com.fshoes.accesodatos.DetalleOrdenAD;
import com.fshoes.entidades.DetalleOrden;
import java.util.ArrayList;

/**
 *
 * @author flores
 */
public class DetalleOrdenLN {
    // singleton
    public static DetalleOrdenLN _Instancia;
	private DetalleOrdenLN(){};
	public static DetalleOrdenLN Instancia(){
            if(_Instancia==null){			
                    _Instancia = new DetalleOrdenLN();
            }
            return _Instancia;
    }
    // end Singleton
    public ArrayList<DetalleOrden> listarDetalleOrden(String valor, String prm) throws Exception {
        try {
            if(!prm.equals(""))            
                return DetalleOrdenAD.Instancia().listarDetalleOrden(valor, prm);
            else return null;
        } catch (Exception ex) {
            throw ex;
        }
    }
    
    public boolean asignarOrden(DetalleOrden objDetalleOrden, String prm) throws Exception{
        try {
            if(!prm.equals("") && objDetalleOrden != null){                
                if(!objDetalleOrden.getObjOrden().getCodigoorden().equals("") && objDetalleOrden.getObjTrabajador().getIdempleado() > 0)                
                    return DetalleOrdenAD.Instancia().asignarOrden(objDetalleOrden, prm);
                else return false;
            }else return false;
        } catch (Exception e) {
            throw e;
        }
    }
}
