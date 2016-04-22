/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fshoes.logicanegocio;

import com.fshoes.accesodatos.ProcesoAD;
import com.fshoes.entidades.Proceso;
import java.util.ArrayList;

/**
 *
 * @author flores
 */
public class ProcesoLN {
    // singleton
    public static ProcesoLN _Instancia;
	private ProcesoLN(){};
	public static ProcesoLN Instancia(){
            if(_Instancia==null){			
                    _Instancia = new ProcesoLN();
            }
            return _Instancia;
    }
    // end Singleton
    
    public ArrayList<Proceso> listarProcesos() throws Exception{
        try{
            return ProcesoAD.Instancia().listarProcesos();
        }catch(Exception ex){
            throw ex;
        }        
    }
        
}
