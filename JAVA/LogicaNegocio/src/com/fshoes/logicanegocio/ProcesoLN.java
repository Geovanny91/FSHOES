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
    
    public ArrayList<Proceso> listarProcesos(String prm) throws Exception{
        try{
            return ProcesoAD.Instancia().listarProcesos(prm);
        }catch(Exception ex){
            throw ex;
        }        
    }
    
    public ArrayList<Proceso> listarProcesos(String valor, String prm) throws Exception{
        try{
            return ProcesoAD.Instancia().listarProcesos(valor, prm);
        }catch(Exception ex){
            throw ex;
        }        
    }
    
    public int evaluarRangoProcesos(String valor, String prm) throws Exception{
        try {
            if (!(prm.equals("")) && !valor.equals(""))
                return ProcesoAD.Instancia().evaluarRangoProcesos(valor, prm);
            else return 0;
        } catch (Exception e) {
            throw e;
        }        
    }
}
