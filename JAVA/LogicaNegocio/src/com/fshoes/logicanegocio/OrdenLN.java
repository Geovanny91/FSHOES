/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.logicanegocio;

import com.fshoes.accesodatos.OrdenAD;
import com.fshoes.entidades.Orden;

/**
 *
 * @author flores
 */
public class OrdenLN {
    // singleton
    public static OrdenLN _Instancia;
	private OrdenLN(){};
	public static OrdenLN Instancia(){
            if(_Instancia==null){			
                    _Instancia = new OrdenLN();
            }
            return _Instancia;
    }
    // end Singleton
    
    public boolean registrarOrden(Orden objOrden, String prm) throws Exception{
        try {            
            if(objOrden != null && !(prm.equals(""))){
                if(!objOrden.getCodigoorden().equals("") && objOrden.getTotal()!=0)
                    return OrdenAD.Instancia().registrarOrden(objOrden, prm);
                else return false;                
            }else{
                return false;
            }            
        } catch (Exception e) {
            throw e;
        }
    }
}
